using System;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace Z
{
    public partial class Landing : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               // LoadFeaturedCars();
                // Check if the user is already logged in
                if (Session["UserEmail"] != null)
                {
                    // Display the logged-in user's username
                    UsernameLabel.Text = Session["UserName"].ToString();
                }
                else
                {
                    // If not logged in, hide the logout button and redirect to login page
                    LogoutButton.Visible = false;
                    Response.Redirect("Signup.aspx");
                }
            }
        }



        protected void AddToCart_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string[] arguments = btn.CommandArgument.Split(',');

            string model = arguments[0];
            string price = arguments[1];
            string color = arguments[2];

            // Get the current user's ID (assuming you have user session info)
            string userId = Session["UserID"].ToString();

            // Assuming you have a method to insert the cart item into the database
            using (SqlConnection con = new SqlConnection("your_connection_string"))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("INSERT INTO cart (UserID, product_name, model, price, color, quantity) VALUES (@UserID, @ProductName, @Model, @Price, @Color, @Quantity)", con);
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.Parameters.AddWithValue("@ProductName", model); // Assuming ProductName is the model
                cmd.Parameters.AddWithValue("@Model", model);
                cmd.Parameters.AddWithValue("@Price", price);
                cmd.Parameters.AddWithValue("@Color", color);
                cmd.Parameters.AddWithValue("@Quantity", 1); // Default quantity to 1 for now
                cmd.ExecuteNonQuery();
            }
        }
        protected void LogoutButton_Click(object sender, EventArgs e)
        {
            // Clear the session
            Session.Clear();
            // Redirect to the login page or home page
            if (Session["UserEmail"] != null)
            {
                // Display the logged-in user's username
                Response.Redirect("Signup.aspx");
            }
               
        }
    }
}