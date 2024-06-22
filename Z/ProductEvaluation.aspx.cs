using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Z
{
    public partial class ProductEvaluation : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["ProductDBConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProducts();
            }
        }

        private void LoadProducts()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT pid, product_name + ' ' + model AS FullName FROM products", conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                ddlProducts.DataSource = reader;
                ddlProducts.DataTextField = "FullName";
                ddlProducts.DataValueField = "pid";
                ddlProducts.DataBind();

                reader.Close();
            }
        }

        protected void ddlProducts_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClearFields();
        }

        protected void txtEvaluationScore_TextChanged(object sender, EventArgs e)
        {
            UpdateButtonsVisibility();
        }
        protected void btnApprove_Click(object sender, EventArgs e)
        {
            UpdateProductsStatus();
        }

        protected void btnReject_Click(object sender, EventArgs e)
        {
            UpdateProductsStatus();
        }
        private void UpdateProductsStatus()
        {
            if (ddlProducts.SelectedValue != "0")
            {
                int tid = 0; // Variable to store the tid value

                // Determine the tid based on the score
                if (int.TryParse(txtEvaluationScore.Text, out int score))
                {
                    tid = score >= 80 ? 2 : 1; // If score is >= 80, set tid to 2 (Employed), else set to 1 (Rejected)
                }

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "UPDATE products SET tid = @TID, quantity = @Quantity, price = @Price WHERE pid = @ProductID";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@TID", tid);
                    command.Parameters.AddWithValue("@Quantity", txtQuantity.Text);
                    command.Parameters.AddWithValue("@Price", txtPrice.Text);
                    command.Parameters.AddWithValue("@ProductID", ddlProducts.SelectedValue);

                    connection.Open();
                    command.ExecuteNonQuery();
                    connection.Close();

                    lblMessage.Text = "Procuts " + (tid == 2 ? "Displayed In Lounge." : "Rejected.");
                    LoadProducts();
                    ClearFields();
                }
            }
        }

        private void UpdateButtonsVisibility()
        {
            if (int.TryParse(txtEvaluationScore.Text, out int score))
            {
                btnApprove.Visible = score >= 80;
                btnReject.Visible = score < 80;
            }
            else
            {
                ClearFields();
            }
        }

        private void ClearFields()
        {
            txtEvaluationScore.Text = string.Empty;
            txtQuantity.Text = string.Empty;
            txtPrice.Text = string.Empty;
            btnApprove.Visible = false;
            btnReject.Visible = false;
            lblMessage.Text = string.Empty;
        }
    }
}