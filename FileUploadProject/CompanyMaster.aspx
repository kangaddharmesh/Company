<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CompanyMaster.aspx.cs" Inherits="FileUploadProject.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Company Master.</h1>
    <asp:GridView ID="companyMasterGridview" AutoGenerateColumns="False" runat="server" OnRowCommand="companyMasterGridview_SelectedIndexChanged1">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:TemplateField HeaderText="ID" ItemStyle-Width="150" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <asp:Label ID="LblCompanyId" runat="server" Text='<%#Bind("Id") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Company Name" ItemStyle-Width="250" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <asp:Label ID="LblCompanyName" runat="server" Text='<%#Bind("Name") %>' CommandName="Select" CommandArgument="<%# Container.DataItemIndex %>" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Available Actions" ItemStyle-Width="250" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <asp:Button ID="btnShow" runat="server" Text="Show" CommandName="Show" CommandArgument="<%# Container.DataItemIndex %>" />
                    | 
                    <asp:Button ID="btnApprove" runat="server" Text='<%#Bind("status") %>' CommandName="Approve" CommandArgument="<%# Container.DataItemIndex %>" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
