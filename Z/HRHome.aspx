<%@ Page Language="C#" MasterPageFile="~/HR.Master" AutoEventWireup="true" CodeBehind="HRHome.aspx.cs" Inherits="Z.HRHome" %>
<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Home
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="bg-white p-6 rounded shadow-md">
        <h2 class="text-2xl font-bold mb-4">Welcome to the Human Resources Management System</h2>
        <p class="mb-4">Use the navigation links above to manage employees or perform other administrative tasks.</p>
        <p class="mb-4">This system allows you to add, update, delete, search for employees, and evaluate potential candidates for recruitment.</p>
    </div>
</asp:Content>
