using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;
using System;

namespace Z
{
    public partial class ProductManagement : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["ProductDBConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCars();
                if (MultiView1.ActiveViewIndex == 4)
                {
                    LoadProducts();
                }
            }
        }

        protected void Menu1_MenuItemClick(object sender, MenuEventArgs e)
        {
            int viewIndex = int.Parse(e.Item.Value);
            MultiView1.ActiveViewIndex = viewIndex;

            if (viewIndex == 4)
            {
                LoadProducts();
            }
        }

        private void LoadProducts()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT product_name, model, color, description FROM products;", conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                GridView1.DataSource = reader;
                GridView1.DataBind();
                reader.Close();
            }
        }

        private void LoadCars()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT pid, product_name + ' ' + model AS FullName FROM products", conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                ddlSelectProductEdit.DataSource = reader;
                ddlSelectProductEdit.DataTextField = "FullName";
                ddlSelectProductEdit.DataValueField = "pid";
                ddlSelectProductEdit.DataBind();
                reader.Close();

                // Add the default item at the beginning
                ddlSelectProductEdit.Items.Insert(0, new ListItem("--Select Product--", "0"));

                cmd.CommandText = "SELECT pid, product_name + ' ' + model AS FullName FROM products";
                reader = cmd.ExecuteReader();

                ddlSelectProductDelete.DataSource = reader;
                ddlSelectProductDelete.DataTextField = "FullName";
                ddlSelectProductDelete.DataValueField = "pid";
                ddlSelectProductDelete.DataBind();
                reader.Close();

                // Add the default item at the beginning
                ddlSelectProductDelete.Items.Insert(0, new ListItem("--Select Product--", "0"));
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string productName = txtProductName.Text;
            string model = txtModel.Text;
            string color = txtColor.Text;
            string description = txtDescription.Text;
            string catalog = SaveCatalogFile(fileCatalog);
            string photoCar = SavePhotoFile(carPhoto);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO products (product_name, model, color, description, catalog, pic, tid) VALUES (@product_name, @model, @color, @description, @catalog, @pic, 1)", conn);
                cmd.Parameters.AddWithValue("@product_name", productName);
                cmd.Parameters.AddWithValue("@model", model);
                cmd.Parameters.AddWithValue("@color", color);
                cmd.Parameters.AddWithValue("@description", description);
                cmd.Parameters.AddWithValue("@catalog", catalog);
                cmd.Parameters.AddWithValue("@pic", photoCar);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            lblMessage.Text = "Product saved successfully!";
            LoadCars(); // Refresh the product lists
            ClearInsertForm();
        }

        private void ClearInsertForm()
        {
            txtProductName.Text = "";
            txtModel.Text = "";
            txtColor.Text = "";
            txtDescription.Text = "";
        }

        private string SaveCatalogFile(FileUpload fileUpload)
        {
            if (fileUpload.HasFile)
            {
                string folderPath = Server.MapPath("~/CATALOGs/");

                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string fileName = Path.GetFileName(fileUpload.FileName);
                string filePath = folderPath + fileName;
                fileUpload.SaveAs(filePath);
                return "~/CATALOGs/" + fileName;
            }
            return string.Empty;
        }

        private string SavePhotoFile(FileUpload fileUpload)
        {
            if (fileUpload.HasFile)
            {
                string folderPath = Server.MapPath("~/Photos/");

                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string fileName = Path.GetFileName(fileUpload.FileName);
                string filePath = folderPath + fileName;
                fileUpload.SaveAs(filePath);
                return "~/Photos/" + fileName;
            }
            return string.Empty;
        }

        protected void ddlSelectProductEdit_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlSelectProductEdit.SelectedValue != "0")
            {
                int carID = int.Parse(ddlSelectProductEdit.SelectedValue);
                LoadCarData(carID);
            }
        }

        private void LoadCarData(int carID)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM products WHERE pid = @CarID", conn);
                cmd.Parameters.AddWithValue("@CarID", carID);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtProductNameEdit.Text = reader["product_name"].ToString();
                    txtModelEdit.Text = reader["model"].ToString();
                    txtColorEdit.Text = reader["color"].ToString();
                    txtDescriptionEdit.Text = reader["description"].ToString();
                }
                reader.Close();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int productID = int.Parse(ddlSelectProductEdit.SelectedValue);
            string productName = txtProductNameEdit.Text;
            string Model = txtModelEdit.Text;
            string color = txtColorEdit.Text;
            string description = txtDescriptionEdit.Text;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("UPDATE products SET product_name = @ProductName, model = @Model, color = @Color, description = @Description WHERE pid = @ProductID", conn);
                cmd.Parameters.AddWithValue("@ProductID", productID);
                cmd.Parameters.AddWithValue("@ProductName", productName);
                cmd.Parameters.AddWithValue("@Model", Model);
                cmd.Parameters.AddWithValue("@Color", color);
                cmd.Parameters.AddWithValue("@Description", description);


                conn.Open();
                cmd.ExecuteNonQuery();
            }

            lblMessageEdit.Text = "Product updated successfully!";
            LoadCars(); // Refresh the product lists
            ClearEditForm();
        }

        private void ClearEditForm()
        {
            txtProductNameEdit.Text = "";
            txtModelEdit.Text = "";
            txtColorEdit.Text = "";
            txtDescriptionEdit.Text = "";
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            int productID = int.Parse(ddlSelectProductDelete.SelectedValue);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM products WHERE pid = @ProductID", conn);
                cmd.Parameters.AddWithValue("@ProductID", productID);

                conn.Open();
                cmd.ExecuteNonQuery();

                // Resetting identity seed
                cmd.CommandText = "DBCC CHECKIDENT ('products', RESEED, 0)";
                cmd.ExecuteNonQuery();
            }

            lblMessageDelete.Text = "Product deleted successfully!";
            LoadCars(); // Refresh the product lists
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchBy = ddlSearchBy.SelectedValue;
            string searchTerm = txtSearchTerm.Text;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM products WHERE " + searchBy + " LIKE @SearchTerm";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@SearchTerm", "%" + searchTerm + "%");

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                gvSearchResults.DataSource = reader;
                gvSearchResults.DataBind();
                reader.Close();
            }
        }

        protected void lnkDownloadCatalog_Click(object sender, EventArgs e)
        {
            LinkButton lnkDownloadCatalog = (LinkButton)sender;
            string filePath = lnkDownloadCatalog.CommandArgument;

            // Ensure the file path is within the allowed directory
            string fullPath = Server.MapPath(filePath);
            if (File.Exists(fullPath))
            {
                Response.ContentType = "application/octet-stream";
                Response.AppendHeader("Content-Disposition", $"attachment; filename={Path.GetFileName(fullPath)}");
                Response.TransmitFile(fullPath);
                Response.End();
            }
            else
            {
                // Handle the case when the file does not exist
                lblDownloadMessage.Text = "File not found.";
            }
        }
    }
}
