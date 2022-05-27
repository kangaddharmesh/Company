<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FileUploader.aspx.cs" Inherits="FileUploadProject.About" %>

<asp:Content ID="BodyContent"  ContentPlaceHolderID="MainContent" runat="server">
    <h1>Upload your File Here.</h1>
    <br />
    <br />
    <br />
    <br />
    <table>
        <tr>
            <td style="width:100px"> File Upload :</td>
            <td style="width:150px"> <asp:FileUpload ID="companyFileUpload" runat="server" AllowMultiple="true"  /></td>
            <td style="width:250px"><asp:Button ID="btnFileUpload"  Text="Upload" runat="server" OnClick="btnFileUpload_Click" /></td>
        </tr>
    </table>
    
            
        </div>
</asp:Content>
