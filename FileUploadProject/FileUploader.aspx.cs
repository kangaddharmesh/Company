using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;

namespace FileUploadProject
{
    public partial class About : Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["AppConnectionStrings"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnFileUpload_Click(object sender, EventArgs e)
        {
            if (companyFileUpload.HasFiles)
            {
                foreach (HttpPostedFile uploadedFile in companyFileUpload.PostedFiles)
                {
                    using (Stream fs = uploadedFile.InputStream)
                    {
                        using (BinaryReader br = new BinaryReader(fs))
                        {
                            string contentType = uploadedFile.ContentType;
                            byte[] bytes = br.ReadBytes((Int32)fs.Length);
                            SqlConnection con = new SqlConnection(conStr);
                            SqlCommand cmd = new SqlCommand("insertCompanyAndFileMaster", con);
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@fileName", Path.GetFileNameWithoutExtension(uploadedFile.FileName) );
                            cmd.Parameters.AddWithValue("@fileNameWithExtension", uploadedFile.FileName);
                            cmd.Parameters.AddWithValue("@File", bytes);
                            cmd.Parameters.AddWithValue("@FileContentType", contentType);

                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                        }
                    }
                }
                //Response.Write("<script>alert('File Uploaded successfully')</script>");
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('File Uploaded successfully');", true);
            }
        }
    }
}