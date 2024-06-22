using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Z
{
    public partial class EmployeeAssignment : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["ProductDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCandidates();
                LoadDepartments();
                LoadRoles();
                LoadCandidateGrid();
            }
        }

        private void LoadCandidates()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT pid, first_name + ' ' + last_name AS FullName FROM personalinfo WHERE tid = 2", conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                ddlCandidates.DataSource = reader;
                ddlCandidates.DataTextField = "FullName";
                ddlCandidates.DataValueField = "pid";
                ddlCandidates.DataBind();
                reader.Close();

                ddlCandidates.Items.Insert(0, new ListItem("Select a candidate", "0"));
            }
        }

        private void LoadDepartments()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT dept_id, dept_name FROM department", conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                ddlDepartment.DataSource = reader;
                ddlDepartment.DataTextField = "dept_name";
                ddlDepartment.DataValueField = "dept_id";
                ddlDepartment.DataBind();
                reader.Close();

                ddlDepartment.Items.Insert(0, new ListItem("Select a department", "0"));
            }
        }

        private void LoadRoles()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT role_id, role_name FROM role", conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                ddlRole.DataSource = reader;
                ddlRole.DataTextField = "role_name";
                ddlRole.DataValueField = "role_id";
                ddlRole.DataBind();
                reader.Close();

                ddlRole.Items.Insert(0, new ListItem("Select a role", "0"));
            }
        }

        protected void ddlCandidates_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCandidates.SelectedValue != "0")
            {
                ddlDepartment.Enabled = true;
                ddlRole.Enabled = true;
                btnAssign.Visible = true;
            }
            else
            {
                ddlDepartment.Enabled = false;
                ddlRole.Enabled = false;
                btnAssign.Visible = false;
            }
        }

        protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlDepartment.SelectedValue != "0")
            {
                ddlRole.Enabled = true;
            }
            else
            {
                ddlRole.Enabled = false;
            }
        }

        protected void ddlRole_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlRole.SelectedValue != "0")
            {
                btnAssign.Visible = true;
            }
            else
            {
                btnAssign.Visible = false;
            }
        }

        protected void btnAssign_Click(object sender, EventArgs e)
        {
            // Validate the inputs
            if (string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                lblMessage.Text = "First Name is required.";
                return;
            }

            int candidateID = int.Parse(ddlCandidates.SelectedValue);
            int departmentID = int.Parse(ddlDepartment.SelectedValue);
            int roleID = int.Parse(ddlRole.SelectedValue);
            string password = txtPassword.Text;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO assignment (pid, dept_id, role_id) VALUES (@pid, @dept_id, @role_id)", conn);
                cmd.Parameters.AddWithValue("@pid", candidateID);
                cmd.Parameters.AddWithValue("@dept_id", departmentID);
                cmd.Parameters.AddWithValue("@role_id", roleID);

                conn.Open();
                cmd.ExecuteNonQuery();

                // Update the personalinfo table with the password
                SqlCommand updateCmd = new SqlCommand("UPDATE personalinfo SET password = @password WHERE pid = @pid", conn);
                updateCmd.Parameters.AddWithValue("@password", password);
                updateCmd.Parameters.AddWithValue("@pid", candidateID);
                updateCmd.ExecuteNonQuery();
            }

            lblMessage.Text = "Role and password assigned successfully!";
            LoadCandidateGrid();
        }

        private void LoadCandidateGrid()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT pii.first_name, pii.last_name, pii.email, pii.mob, pii.zip, pt.type_name FROM personalinfo pii INNER JOIN personaltype pt ON pii.tid = pt.tid WHERE pii.tid = 2;", conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                gvCandidates.DataSource = reader;
                gvCandidates.DataBind();
                reader.Close();
            }
        }
    }
}
