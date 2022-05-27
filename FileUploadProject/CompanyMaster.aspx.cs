using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
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
            int rowIndex = Convert.ToInt32(e.CommandArgument);

            //Reference the GridView Row.
            GridViewRow row = companyMasterGridview.Rows[rowIndex];

            //Fetch value of Name.
            string CompanyID = (row.FindControl("LblCompanyId") as Label).Text;
            string CompanyName = (row.FindControl("LblCompanyName") as Label).Text;
            string Action = (row.FindControl("btnApprove") as Button).Text;
            if (e.CommandName == "Show")
            {
                ShowFile(CompanyID);
                //Implementation in Progress
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Implementation in Progress');", true);
            } else if (e.CommandName == "Approve")
            {
                //Determine the RowIndex of the Row whose Button was clicked.
                

                //Fetch value of Country

                SqlConnection con = new SqlConnection(conStr);
                SqlCommand cmd = new SqlCommand("UpdateStatus", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", CompanyID);
                cmd.Parameters.AddWithValue("@Active", Action == "Approve" ? 1 :0);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Approved successfully');", true);
                DisplayCompanyRecord();
            }
        }

        protected void ShowFile(string companyID) //object sender, EventArgs e
        {
            //int id = int.Parse((sender as LinkButton).CommandArgument);
            byte[] bytes;
            string  contentType, fileName;
            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "select * from FileMaster where companyId=@Id";
                    cmd.Parameters.AddWithValue("@Id", companyID);
                    cmd.Connection = con;
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        sdr.Read();
                        bytes = (byte[])sdr["FileContent"];
                        contentType = sdr["FileContentType"].ToString();
                        fileName = sdr["FileName"].ToString();
                    }
                    con.Close();
                }
            }
            Response.Clear();
            Response.Buffer = true;
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = contentType;
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);
            Response.BinaryWrite(bytes);
            Response.Flush();
            Response.End();
        }
    }
}