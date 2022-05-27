using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FileUploadProject
{
    public partial class Contact : Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["AppConnectionStrings"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DisplayCompanyRecord();
            }
        }
        public DataTable DisplayCompanyRecord()
        {
            SqlConnection con = new SqlConnection(conStr);
            SqlDataAdapter Adp = new SqlDataAdapter("getCompanyMasterDetails", con);
            DataTable Dt = new DataTable();
            Adp.Fill(Dt);
            companyMasterGridview.DataSource = Dt;
            companyMasterGridview.DataBind();
            return Dt;
        }

        protected void companyMasterGridview_SelectedIndexChanged1(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Show")
            {
                //Determine the RowIndex of the Row whose Button was clicked.
                int rowIndex = Convert.ToInt32(e.CommandArgument);

                //Reference the GridView Row.
                GridViewRow row = companyMasterGridview.Rows[rowIndex];

                //Fetch value of Name.
                string name = (row.FindControl("LblCompanyId") as Label).Text;

                //Fetch value of Country
                string country = row.Cells[1].Text;

                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Name: " + name + "\\nCountry: " + country + "');", true);
            } else if (e.CommandName == "Approve")
            {
                //Determine the RowIndex of the Row whose Button was clicked.
                int rowIndex = Convert.ToInt32(e.CommandArgument);

                //Reference the GridView Row.
                GridViewRow row = companyMasterGridview.Rows[rowIndex];

                //Fetch value of Name.
                string CompanyID = (row.FindControl("LblCompanyId") as Label).Text;
                string Action = (row.FindControl("btnApprove") as Button).Text;

                //Fetch value of Country

                SqlConnection con = new SqlConnection(conStr);
                SqlCommand cmd = new SqlCommand("UpdateStatus", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", CompanyID);
                cmd.Parameters.AddWithValue("@Active", Action == "Approve" ? 1 :0);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
               // ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Approved successfully');", true);
                DisplayCompanyRecord();
            }
        }
    }
}