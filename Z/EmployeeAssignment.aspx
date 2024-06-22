<%@ Page Language="C#" MasterPageFile="~/HR.Master" AutoEventWireup="true" CodeBehind="EmployeeAssignment.aspx.cs" Inherits="Z.EmployeeAssignment" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Employee Assignment
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server" class="bg-white p-6 rounded shadow-md">
        <div>
            <h2 class="text-2xl font-bold mb-4">Recruitment Evaluation</h2>

            <asp:Label ID="lblSelectCandidate" runat="server" Text="Select Employee to Assign:" CssClass="block mb-2 font-semibold" />
            <asp:DropDownList ID="ddlCandidates" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlCandidates_SelectedIndexChanged" CssClass="block w-full p-2 mb-4 border rounded">
                <asp:ListItem Text="Select a employee" Value="0" />
            </asp:DropDownList>

            <asp:Label ID="lblDepartment" runat="server" Text="Select Department:" CssClass="block mb-2 font-semibold" />
            <asp:DropDownList ID="ddlDepartment" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged" CssClass="block w-full p-2 mb-4 border rounded">
                <asp:ListItem Text="Select a department" Value="0" />
                <asp:ListItem Text="HR Department" Value="HR" />
                <asp:ListItem Text="Products Department" Value="Production" />
                <asp:ListItem Text="Customer Department" Value="Customer" />
            </asp:DropDownList>

            <asp:Label ID="lblRole" runat="server" Text="Select Role:" CssClass="block mb-2 font-semibold" />
            <asp:DropDownList ID="ddlRole" runat="server" CssClass="block w-full p-2 mb-4 border rounded">
                <asp:ListItem Text="Select a role" Value="0" />
                <asp:ListItem Text="Employee" Value="Employee" />
                <asp:ListItem Text="Manager" Value="Manager" />
            </asp:DropDownList>

            <asp:Label ID="lblPassword" runat="server" Text="Access Password:" CssClass="block mb-2 font-semibold" />
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="block w-full p-2 mb-4 border rounded" />
            <asp:RequiredFieldValidator ID="rfvpassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required" CssClass="text-red-500" Display="Dynamic" />

            <asp:Button ID="btnAssign" runat="server" Text="Assign Role" OnClick="btnAssign_Click" CssClass="bg-green-500 text-white p-2 rounded mb-4" Visible="false" />
            <asp:Label ID="lblMessage" runat="server" CssClass="block mt-4" />

            <asp:GridView ID="gvCandidates" runat="server" CssClass="table-auto w-full mt-4 text-center" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="first_name" HeaderText="First Name" />
                    <asp:BoundField DataField="last_name" HeaderText="Last Name" />
                    <asp:BoundField DataField="email" HeaderText="Email" />
                    <asp:BoundField DataField="mob" HeaderText="Phone" />
                    <asp:BoundField DataField="zip" HeaderText="Bank Account" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</asp:Content>
