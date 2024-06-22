using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Z
{
    public partial class EmployeeEvaluation : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["ProductDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCandidates();
            }
        }

        private void LoadCandidates()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT pid, first_name + ' ' + last_name AS FullName FROM personalinfo WHERE tid = 1", conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                ddlCandidates.DataSource = reader;
                ddlCandidates.DataTextField = "FullName";
                ddlCandidates.DataValueField = "pid";
                ddlCandidates.DataBind();

                reader.Close();
            }
        }

        protected void ddlCandidates_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClearFields();
        }

        protected void txtEvaluationScore_TextChanged(object sender, EventArgs e)
        {
            UpdateButtonsVisibility();
        }
        protected void btnApprove_Click(object sender, EventArgs e)
        {
            UpdateCandidateStatus();
        }

        protected void btnReject_Click(object sender, EventArgs e)
        {
            UpdateCandidateStatus();
        }
        private void UpdateCandidateStatus()
        {
            if (ddlCandidates.SelectedValue != "0")
            {
                int tid = 0; // Variable to store the tid value

                // Determine the tid based on the score
                if (int.TryParse(txtEvaluationScore.Text, out int score))
                {
                    tid = score >= 70 ? 2 : 1; // If score is >= 70, set tid to 2 (Employed), else set to 1 (Rejected)
                }

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "UPDATE personalinfo SET tid = @TID, Description = @Description WHERE pid = @PersonID";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@TID", tid);
                    command.Parameters.AddWithValue("@Description", txtDescription.Text);
                    command.Parameters.AddWithValue("@PersonID", ddlCandidates.SelectedValue);

                    connection.Open();
                    command.ExecuteNonQuery();
                    connection.Close();

                    lblMessage.Text = "Candidate " + (tid == 2 ? "approved and employed." : "rejected.");
                    LoadCandidates();
                    ClearFields();
                }
            }
        }

        private void UpdateButtonsVisibility()
        {
            if (int.TryParse(txtEvaluationScore.Text, out int score))
            {
                btnApprove.Visible = score >= 70;
                btnReject.Visible = score < 70;
            }
            else
            {
                ClearFields();
            }
        }

        private void ClearFields()
        {
            txtEvaluationScore.Text = string.Empty;
            txtDescription.Text = string.Empty;
            btnApprove.Visible = false;
            btnReject.Visible = false;
            lblMessage.Text = string.Empty;
        }
    }
}
