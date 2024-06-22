<%@ Page Language="C#" MasterPageFile="~/HR.Master" AutoEventWireup="true" CodeBehind="EmployeeDetails.aspx.cs" Inherits="Z.EmployeeDetails" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Employee Details
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server" class="bg-white p-6 rounded shadow-md">
        <div>
            <h2 class="text-2xl font-bold mb-4">Employee Details</h2>
            
            <!-- Employee Details -->
            <asp:Label ID="lblFirstName" runat="server" Text="First Name:" CssClass="block mb-2 font-semibold" />
            <asp:Label ID="txtFirstName" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />
            
            <asp:Label ID="lblLastName" runat="server" Text="Last Name:" CssClass="block mb-2 font-semibold" />
            <asp:Label ID="txtLastName" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />
            
            <asp:Label ID="lblEmail" runat="server" Text="Email:" CssClass="block mb-2 font-semibold" />
            <asp:Label ID="txtEmail" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />
            
            <asp:Label ID="lblPhone" runat="server" Text="Phone:" CssClass="block mb-2 font-semibold" />
            <asp:Label ID="txtPhone" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />
            
            <asp:Label ID="lblEcardNumber" runat="server" Text="Ecard Number:" CssClass="block mb-2 font-semibold" />
            <asp:Label ID="txtEcardNumber" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />
            
            <asp:Label ID="lblSSN" runat="server" Text="SSN:" CssClass="block mb-2 font-semibold" />
            <asp:Label ID="txtSSN" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />
            
            <asp:Label ID="lblMotherName" runat="server" Text="Mother Name:" CssClass="block mb-2 font-semibold" />
            <asp:Label ID="txtMotherName" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />
            
            <asp:Label ID="lblFatherName" runat="server" Text="Father Name:" CssClass="block mb-2 font-semibold" />
            <asp:Label ID="txtFatherName" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />
            
            <asp:Label ID="lblPhoto" runat="server" Text="Photo:" CssClass="block mb-2 font-semibold" />
            <asp:Image ID="imgPhoto" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />
            
            <asp:Label ID="lblCV" runat="server" Text="CV:" CssClass="block mb-2 font-semibold" />
            <asp:HyperLink ID="linkCV" runat="server" CssClass="block w-full p-2 mb-4 border rounded" Text="View CV" Target="_blank" />
            
            <asp:Label ID="lblDescription" runat="server" Text="Description:" CssClass="block mb-2 font-semibold" />
            <asp:Label ID="txtDescription" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />
            
            <asp:Label ID="lblAddress" runat="server" Text="Address:" CssClass="block mb-2 font-semibold" />
            <asp:Label ID="txtAddress" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />
        </div>
    </form>
</asp:Content>
