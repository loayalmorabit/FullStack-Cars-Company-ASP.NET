using System;
using System.Web.UI;
using System.Data.SqlClient;

namespace Z
{
    public partial class EmployeeDetails : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string employeeId = Request.QueryString["EmployeeID"];
                if (!string.IsNullOrEmpty(employeeId))
                {
                    LoadEmployeeDetails(employeeId);
                }
            }
        }

        private void LoadEmployeeDetails(string employeeId)
        {
            string connectionString = "your_connection_string_here";
            string query = "SELECT * FROM Employees WHERE EmployeeID = @EmployeeID";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@EmployeeID", employeeId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    txtFirstName.Text = reader["FirstName"].ToString();
                    txtLastName.Text = reader["LastName"].ToString();
                    txtEmail.Text = reader["Email"].ToString();
                    txtPhone.Text = reader["Phone"].ToString();
                    txtEcardNumber.Text = reader["EcardNumber"].ToString();
                    txtSSN.Text = reader["SSN"].ToString();
                    txtMotherName.Text = reader["MotherName"].ToString();
                    txtFatherName.Text = reader["FatherName"].ToString();
                    txtDescription.Text = reader["Description"].ToString();
                    txtAddress.Text = reader["Address"].ToString();

                    // Assuming the photo and CV are stored as file paths
                    string photoPath = reader["Photo"].ToString();
                    if (!string.IsNullOrEmpty(photoPath))
                    {
                        imgPhoto.ImageUrl = photoPath;
                    }

                    string cvPath = reader["CV"].ToString();
                    if (!string.IsNullOrEmpty(cvPath))
                    {
                        linkCV.NavigateUrl = cvPath;
                    }
                }

                reader.Close();
            }
        }
    }
}

