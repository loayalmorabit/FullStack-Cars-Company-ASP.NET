using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;
using System;

namespace Z
{
    public partial class EmployeeManagement : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["ProductDBConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadEmployees();
                if (MultiView1.ActiveViewIndex == 4)
                {
                    LoadCandidates();
                }
            }
        }

        protected void Menu1_MenuItemClick(object sender, MenuEventArgs e)
        {
            int viewIndex = int.Parse(e.Item.Value);
            MultiView1.ActiveViewIndex = viewIndex;

            if (viewIndex == 4)
            {
                LoadCandidates();
            }
        }

        private void LoadCandidates()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT first_name, last_name, father, mother, email, mob, address, zip, pii.tid FROM personalinfo pii INNER JOIN personaltype pt ON pii.tid = pt.tid WHERE pii.tid = 1;", conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                GridView1.DataSource = reader;
                GridView1.DataBind();
                reader.Close();
            }
        }

        private void LoadEmployees()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT pid, first_name + ' ' + last_name AS FullName FROM personalinfo", conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                ddlSelectEmployeeEdit.DataSource = reader;
                ddlSelectEmployeeEdit.DataTextField = "FullName";
                ddlSelectEmployeeEdit.DataValueField = "pid";
                ddlSelectEmployeeEdit.DataBind();
                reader.Close();

                // Add the default item at the beginning
                ddlSelectEmployeeEdit.Items.Insert(0, new ListItem("--Select Employee--", "0"));

                cmd.CommandText = "SELECT pid, first_name + ' ' + last_name AS FullName FROM personalinfo";
                reader = cmd.ExecuteReader();

                ddlSelectEmployeeDelete.DataSource = reader;
                ddlSelectEmployeeDelete.DataTextField = "FullName";
                ddlSelectEmployeeDelete.DataValueField = "pid";
                ddlSelectEmployeeDelete.DataBind();
                reader.Close();

                // Add the default item at the beginning
                ddlSelectEmployeeDelete.Items.Insert(0, new ListItem("--Select Employee--", "0"));
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            // Validate the inputs
            if (string.IsNullOrWhiteSpace(txtFirstName.Text))
            {
                lblMessage.Text = "First Name is required.";
                return;
            }
            if (string.IsNullOrWhiteSpace(txtLastName.Text))
            {
                lblMessage.Text = "Last Name is required.";
                return;
            }
            if (string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                lblMessage.Text = "Email is required.";
                return;
            }
            if (string.IsNullOrWhiteSpace(txtPhone.Text))
            {
                lblMessage.Text = "Phone is required.";
                return;
            }
            if (string.IsNullOrWhiteSpace(txtAddress.Text))
            {
                lblMessage.Text = "Address is required.";
                return;
            }
            if (string.IsNullOrWhiteSpace(txtFatherName.Text))
            {
                lblMessage.Text = "Father Name is required.";
                return;
            }
            if (string.IsNullOrWhiteSpace(txtMotherName.Text))
            {
                lblMessage.Text = "Mother Name is required.";
                return;
            }
            if (string.IsNullOrWhiteSpace(txtSSN.Text))
            {
                lblMessage.Text = "SSN is required.";
                return;
            }
            if (string.IsNullOrWhiteSpace(txtEcardNumber.Text))
            {
                lblMessage.Text = "Ecard Number is required.";
                return;
            }
            if (!fileCV.HasFile)
            {
                lblMessage.Text = "CV is required.";
                return;
            }
            if (!filePhoto.HasFile)
            {
                lblMessage.Text = "Photo is required.";
                return;
            }

            // Inputs are valid, proceed with saving
            string firstName = txtFirstName.Text;
            string lastName = txtLastName.Text;
            string email = txtEmail.Text;
            string phone = txtPhone.Text;
            string address = txtAddress.Text;
            string fatherName = txtFatherName.Text;
            string motherName = txtMotherName.Text;
            string ssn = txtSSN.Text;
            string zip = txtEcardNumber.Text;
            string CVPath = SaveCVFile(fileCV);
            string PhotoPath = SavePhotoFile(filePhoto);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO personalinfo (first_name, last_name, father, mother, ssn, cv, mob, address, email, zip, pic, tid) VALUES (@first_name, @last_name, @father, @mother, @ssn, @cv, @mob, @address, @email, @zip, @pic, 1)", conn);
                cmd.Parameters.AddWithValue("@first_name", firstName);
                cmd.Parameters.AddWithValue("@last_name", lastName);
                cmd.Parameters.AddWithValue("@father", fatherName);
                cmd.Parameters.AddWithValue("@mother", motherName);
                cmd.Parameters.AddWithValue("@ssn", ssn);
                cmd.Parameters.AddWithValue("@cv", CVPath);
                cmd.Parameters.AddWithValue("@mob", phone);
                cmd.Parameters.AddWithValue("@address", address);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@zip", zip);
                cmd.Parameters.AddWithValue("@pic", PhotoPath);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            lblMessage.Text = "Candidate saved successfully!";
            LoadEmployees(); // Refresh the employee list
            ClearInsertForm();
        }

        private void ClearInsertForm()
        {
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            txtAddress.Text = "";
            txtFatherName.Text = "";
            txtMotherName.Text = "";
            txtSSN.Text = "";
        }

        private string SaveCVFile(FileUpload fileUpload)
        {
            if (fileUpload.HasFile)
            {
                string folderPath = Server.MapPath("~/CVs/");

                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string fileName = Path.GetFileName(fileUpload.FileName);
                string filePath = folderPath + fileName;
                fileUpload.SaveAs(filePath);
                return "~/CVs/" + fileName;
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

        protected void ddlSelectEmployeeEdit_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlSelectEmployeeEdit.SelectedValue != "0")
            {
                int employeeID = int.Parse(ddlSelectEmployeeEdit.SelectedValue);
                LoadEmployeeData(employeeID);
            }
        }

        private void LoadEmployeeData(int employeeID)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM personalinfo WHERE pid = @EmployeeID", conn);
                cmd.Parameters.AddWithValue("@EmployeeID", employeeID);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtFirstNameEdit.Text = reader["first_name"].ToString();
                    txtLastNameEdit.Text = reader["last_name"].ToString();
                    txtEmailEdit.Text = reader["email"].ToString();
                    txtPhoneEdit.Text = reader["mob"].ToString();
                    txtAddressEdit.Text = reader["address"].ToString();
                    txtFatherNameEdit.Text = reader["father"].ToString();
                    txtMotherNameEdit.Text = reader["mother"].ToString();
                    txtSSNEdit.Text = reader["ssn"].ToString();
                }
                reader.Close();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int personID = int.Parse(ddlSelectEmployeeEdit.SelectedValue);
            string firstName = txtFirstNameEdit.Text;
            string lastName = txtLastNameEdit.Text;
            string email = txtEmailEdit.Text;
            string phone = txtPhoneEdit.Text;
            string address = txtAddressEdit.Text;
            string fatherName = txtFatherNameEdit.Text;
            string motherName = txtMotherNameEdit.Text;
            string ssn = txtSSNEdit.Text;
            string zip = txtEcardNumberEdit.Text;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("UPDATE personalinfo SET first_name = @FirstName, last_name = @LastName, email = @Email, mob = @Phone, address = @Address, father = @FatherName, mother = @MotherName, ssn = @SSN, zip = @Zip WHERE pid = @PersonID", conn);
                cmd.Parameters.AddWithValue("@FirstName", firstName);
                cmd.Parameters.AddWithValue("@LastName", lastName);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Phone", phone);
                cmd.Parameters.AddWithValue("@Address", address);
                cmd.Parameters.AddWithValue("@FatherName", fatherName);
                cmd.Parameters.AddWithValue("@MotherName", motherName);
                cmd.Parameters.AddWithValue("@SSN", ssn);
                cmd.Parameters.AddWithValue("@Zip", zip);
                cmd.Parameters.AddWithValue("@PersonID", personID);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            lblMessageEdit.Text = "Candidate updated successfully!";
            LoadEmployees(); // Refresh the employee lists
            ClearEditForm();
        }

        private void ClearEditForm()
        {
            txtFirstNameEdit.Text = "";
            txtLastNameEdit.Text = "";
            txtEmailEdit.Text = "";
            txtPhoneEdit.Text = "";
            txtAddressEdit.Text = "";
            txtFatherNameEdit.Text = "";
            txtMotherNameEdit.Text = "";
            txtSSNEdit.Text = "";
            txtEcardNumber.Text = "";
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            int personID = int.Parse(ddlSelectEmployeeDelete.SelectedValue);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Delete from dependent table first
                SqlCommand cmdDeleteAssignments = new SqlCommand("DELETE FROM assignment WHERE pid = @PersonID", conn);
                cmdDeleteAssignments.Parameters.AddWithValue("@PersonID", personID);
                cmdDeleteAssignments.ExecuteNonQuery();

                // Delete from personalinfo table
                SqlCommand cmdDeletePersonalInfo = new SqlCommand("DELETE FROM personalinfo WHERE pid = @PersonID", conn);
                cmdDeletePersonalInfo.Parameters.AddWithValue("@PersonID", personID);
                cmdDeletePersonalInfo.ExecuteNonQuery();

                // Resetting identity seed
                SqlCommand cmdResetIdentity = new SqlCommand("DBCC CHECKIDENT ('personalinfo', RESEED, 0)", conn);
                cmdResetIdentity.ExecuteNonQuery();
            }

            lblMessageDelete.Text = "Candidate deleted successfully!";
            LoadEmployees(); // Refresh the employee lists
        }


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchBy = ddlSearchBy.SelectedValue;
            string searchTerm = txtSearchTerm.Text;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM personalinfo WHERE " + searchBy + " LIKE @SearchTerm";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@SearchTerm", "%" + searchTerm + "%");

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                gvSearchResults.DataSource = reader;
                gvSearchResults.DataBind();
                reader.Close();
            }
        }

        protected void lnkDownloadCV_Click(object sender, EventArgs e)
        {
            LinkButton lnkDownloadCV = (LinkButton)sender;
            string filePath = lnkDownloadCV.CommandArgument;

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
