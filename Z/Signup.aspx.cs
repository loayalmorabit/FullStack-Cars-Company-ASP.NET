using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Z
{
    public partial class Signup : Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["ProductDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if the user is already logged in
                if (Session["Email"] != null)
                {
                    // Redirect to another page or display a message
                    Response.Redirect("Landing.aspx"); // Change to your home page
                }
            }
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            if (Page.IsValid) // Ensure the page is valid before proceeding
            {
                string email = LoginEmail.Text;
                string password = LoginPassword.Text;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // First check if the user is a normal user in userdata table
                    string queryUserdata = "SELECT Username FROM userdata WHERE Email = @Email AND Password = @Password";
                    SqlCommand cmdUserdata = new SqlCommand(queryUserdata, conn);
                    cmdUserdata.Parameters.AddWithValue("@Email", email);
                    cmdUserdata.Parameters.AddWithValue("@Password", password);

                    SqlDataReader readerUserdata = cmdUserdata.ExecuteReader();

                    if (readerUserdata.Read())
                    {
                        // Normal user login successful
                        string username = readerUserdata.GetString(0);

                        // Store the user's info in a session
                        Session["UserEmail"] = email;
                        Session["UserName"] = username;

                        readerUserdata.Close();
                        // Redirect to user landing page
                        Response.Redirect("Landing.aspx");
                    }
                    else
                    {
                        readerUserdata.Close();
                        // Check if the user is an employee in personalinfo and assignment tables
                        string queryEmployee = "SELECT pii.pid, ea.dept_id, ea.role_id FROM personalinfo pii INNER JOIN assignment ea ON pii.pid = ea.pid WHERE pii.email = @Email AND pii.password = @Password";
                        SqlCommand cmdEmployee = new SqlCommand(queryEmployee, conn);
                        cmdEmployee.Parameters.AddWithValue("@Email", email);
                        cmdEmployee.Parameters.AddWithValue("@Password", password);

                        SqlDataReader readerEmployee = cmdEmployee.ExecuteReader();

                        if (readerEmployee.Read())
                        {
                            int pid = readerEmployee.GetInt32(0);
                            int deptId = readerEmployee.GetInt32(1);
                            int roleId = readerEmployee.GetInt32(2);

                            // Store the user's info in a session
                            Session["pid"] = pid;
                            Session["deptId"] = deptId;
                            Session["roleId"] = roleId;

                            readerEmployee.Close();

                            // Redirect based on the department and role
                            switch (deptId)
                            {
                                case 1: // Example department ID for HR
                                    Response.Redirect("HRHome.aspx");
                                    break;
                                case 2: // Example department ID for Production
                                    Response.Redirect("ProductHome.aspx");
                                    break;
                                case 3: // Example department ID for Customer
                                    Response.Redirect("CustomerHome.aspx");
                                    break;
                                default:
                                    Response.Redirect("Landing.aspx"); // Fallback or default home page
                                    break;
                            }
                        }
                        else
                        {
                            ErrorMessage.Text = "Invalid email or password!";
                        }
                    }
                }
            }
        }

        protected void SignupButton_Click(object sender, EventArgs e)
        {
            if (Page.IsValid) // Ensure the page is valid before proceeding
            {
                string username = SignupUsername.Text;
                string email = SignupEmail.Text;
                string password = SignupPassword.Text;
                string confirmPassword = SignupPasswordConfirm.Text;
                string country = SignupCountry.Text;

                if (password != confirmPassword)
                {
                    ErrorMessageSignup.Text = "Passwords do not match.";
                    return;
                }

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string checkUserQuery = "SELECT COUNT(*) FROM userdata WHERE Email = @Email";
                    using (SqlCommand checkUserCommand = new SqlCommand(checkUserQuery, connection))
                    {
                        checkUserCommand.Parameters.AddWithValue("@Email", email);
                        int userExists = (int)checkUserCommand.ExecuteScalar();

                        if (userExists > 0)
                        {
                            ErrorMessageSignup.Text = "Email already exists.";
                            return;
                        }
                    }

                    string insertUserQuery = "INSERT INTO userdata (Username, Email, Password, Country) VALUES (@Username, @Email, @Password, @Country)";
                    using (SqlCommand insertUserCommand = new SqlCommand(insertUserQuery, connection))
                    {
                        insertUserCommand.Parameters.AddWithValue("@Username", username);
                        insertUserCommand.Parameters.AddWithValue("@Email", email);
                        insertUserCommand.Parameters.AddWithValue("@Password", password);
                        insertUserCommand.Parameters.AddWithValue("@Country", country);

                        int result = insertUserCommand.ExecuteNonQuery();

                        if (result > 0)
                        {
                            // Store user details in session
                            Session["UserEmail"] = email;
                            Session["UserName"] = username;

                            // Redirect to a different page after successful signup
                            Response.Redirect("Landing.aspx"); // Change to your home page
                        }
                        else
                        {
                            ErrorMessageSignup.Text = "Signup failed. Please try again.";
                        }
                    }
                }
            }
        }
    }
}
