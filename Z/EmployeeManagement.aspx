<%@ Page Language="C#" MasterPageFile="~/HR.Master" AutoEventWireup="true" CodeBehind="EmployeeManagement.aspx.cs" Inherits="Z.EmployeeManagement" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Employee Management
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server" class="bg-white p-6 rounded shadow-md">
        <div>
            <h2 class="text-2xl font-bold mb-4">Employee Management</h2>
            <div class="flex justify-center">
                <asp:Menu ID="Menu1" runat="server" CssClass="tab-menu p-2 bg-green-500 text-white" Orientation="Horizontal" OnMenuItemClick="Menu1_MenuItemClick">
                 <Items>
                    <asp:MenuItem Text="Insert" Value="0" />
                    <asp:MenuItem Text="Edit"   Value="1" />
                    <asp:MenuItem Text="Delete" Value="2" />
                    <asp:MenuItem Text="Search" Value="3" />
                    <asp:MenuItem Text="Candidates" Value="4" />
                 </Items>
                </asp:Menu>
            </div>
            <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
                <asp:View ID="ViewInsert" runat="server">
                    <h2>Insert Employee</h2>
                    <asp:Label ID="lblFirstName" runat="server" Text="First Name:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtFirstName" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />
                    <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="txtFirstName" ErrorMessage="First Name is required" CssClass="text-red-500" Display="Dynamic" /> 

                    <asp:Label ID="lblLastName" runat="server" Text="Last Name:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtLastName" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />
                    <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ControlToValidate="txtLastName" ErrorMessage="Last Name is required" CssClass="text-red-500" Display="Dynamic" />


                    <asp:Label ID="lblEmail" runat="server" Text="Email:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required" CssClass="text-red-500" Display="Dynamic" />

                    <asp:Label ID="lblPhone" runat="server" Text="Phone:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />
                    <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Phone is required" CssClass="text-red-500" Display="Dynamic" />

                    <asp:Label ID="lblEcardNumber" runat="server" Text="Ecard Number:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtEcardNumber" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />
                    <asp:RequiredFieldValidator ID="rfvEcardNumber" runat="server" ControlToValidate="txtEcardNumber" ErrorMessage="Ecard Number is required" CssClass="text-red-500" Display="Dynamic" />

                    <asp:Label ID="lblSSN" runat="server" Text="SSN:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtSSN" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />
                    <asp:RequiredFieldValidator ID="rfvSSN" runat="server" ControlToValidate="txtSSN" ErrorMessage="SSN is required" CssClass="text-red-500" Display="Dynamic" />

                    <asp:Label ID="lblMotherName" runat="server" Text="Mother Name:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtMotherName" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />
                    <asp:RequiredFieldValidator ID="rfvMotherName" runat="server" ControlToValidate="txtMotherName" ErrorMessage="Mother Name is required" CssClass="text-red-500" Display="Dynamic" />

                    <asp:Label ID="lblFatherName" runat="server" Text="Father Name:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtFatherName" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />
                    <asp:RequiredFieldValidator ID="rfvFatherName" runat="server" ControlToValidate="txtFatherName" ErrorMessage="Father Name is required" CssClass="text-red-500" Display="Dynamic" />

                    <asp:Label ID="lblPhoto" runat="server" Text="Photo:" CssClass="block mb-2 font-semibold" />
                    <asp:FileUpload ID="filePhoto" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />
                    <asp:RequiredFieldValidator ID="rfvPhoto" runat="server" ControlToValidate="filePhoto" ErrorMessage="Photo is required" CssClass="text-red-500" Display="Dynamic" />

                    <asp:Label ID="lblCV" runat="server" Text="CV:" CssClass="block mb-2 font-semibold" />
                    <asp:FileUpload ID="fileCV" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />
                    <asp:RequiredFieldValidator ID="rfvCV" runat="server" ControlToValidate="fileCV" ErrorMessage="CV is required" CssClass="text-red-500" Display="Dynamic" />

                    <asp:Label ID="lblAddress" runat="server" Text="Address:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="block w-full p-2 mb-4 border rounded" TextMode="MultiLine" />
                    <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txtAddress" ErrorMessage="Address is required" CssClass="text-red-500" Display="Dynamic" />

                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" CssClass="bg-green-500 text-white p-2 rounded mb-4" />
                    <asp:Label ID="lblMessage" runat="server" CssClass="block mt-4" />
                </asp:View>

                <asp:View ID="ViewEdit" runat="server">
                    <h2>Edit Employee</h2>
                    <asp:Label ID="lblSelectEmployeeEdit" runat="server" Text="Select Employee:" CssClass="block mb-2 font-semibold" />
                    <asp:DropDownList ID="ddlSelectEmployeeEdit" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSelectEmployeeEdit_SelectedIndexChanged" CssClass="block w-full p-2 mb-4 border rounded">
                    </asp:DropDownList>

                    <asp:Label ID="lblFirstNameEdit" runat="server" Text="First Name:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtFirstNameEdit" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />

                    <asp:Label ID="lblLastNameEdit" runat="server" Text="Last Name:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtLastNameEdit" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />

                    <asp:Label ID="lblEmailEdit" runat="server" Text="Email:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtEmailEdit" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />

                    <asp:Label ID="lblPhoneEdit" runat="server" Text="Phone:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtPhoneEdit" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />

                    <asp:Label ID="lblEcardNumberEdit" runat="server" Text="Ecard Number:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtEcardNumberEdit" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />

                    <asp:Label ID="lblSSNEdit" runat="server" Text="SSN:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtSSNEdit" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />

                    <asp:Label ID="lblMotherNameEdit" runat="server" Text="Mother Name:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtMotherNameEdit" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />

                    <asp:Label ID="lblFatherNameEdit" runat="server" Text="Father Name:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtFatherNameEdit" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />

                    <asp:Label ID="lblPhotoEdit" runat="server" Text="Photo:" CssClass="block mb-2 font-semibold" />
                    <asp:FileUpload ID="filePhotoEdit" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />

                    <asp:Label ID="lblCVEdit" runat="server" Text="CV:" CssClass="block mb-2 font-semibold" />
                    <asp:FileUpload ID="fileCVEdit" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />

                    <asp:Label ID="lblAddressEdit" runat="server" Text="Address:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtAddressEdit" runat="server" CssClass="block w-full p-2 mb-4 border rounded" TextMode="MultiLine" />

                    <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" CssClass="bg-blue-500 text-white p-2 rounded mb-4" />
                    <asp:Label ID="lblMessageEdit" runat="server" CssClass="block mt-4" />
                </asp:View>

                <asp:View ID="ViewDelete" runat="server">
                    <h2>Delete Employee</h2>
                    <asp:Label ID="lblSelectEmployeeDelete" runat="server" Text="Select Employee:" CssClass="block mb-2 font-semibold" />
                    <asp:DropDownList ID="ddlSelectEmployeeDelete" runat="server" CssClass="block w-full p-2 mb-4 border rounded">
                    </asp:DropDownList>

                    <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" CssClass="bg-red-500 text-white p-2 rounded mb-4" />
                    <asp:Label ID="lblMessageDelete" runat="server" CssClass="block mt-4" />
                </asp:View>

                <asp:View ID="ViewSearch" runat="server">
                    <h3>Search Employees</h3>
                    <asp:Label ID="lblSearchBy" runat="server" Text="Search by:" CssClass="block mb-2 font-semibold" />
                    <asp:DropDownList ID="ddlSearchBy" runat="server" CssClass="block w-full p-2 mb-4 border rounded">
                        <asp:ListItem Text="First Name" Value="first_name" />
                        <asp:ListItem Text="Last Name" Value="last_name" />
                        <asp:ListItem Text="Email" Value="email" />
                        <asp:ListItem Text="Phone" Value="mob" />
                    </asp:DropDownList>

                    <asp:Label ID="lblSearchTerm" runat="server" Text="Search term:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtSearchTerm" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />

                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="bg-gray-500 text-white p-2 rounded mb-4" />
                    <asp:Label ID="lblDownloadMessage" runat="server" CssClass="text-red-500" Visible="false"></asp:Label>
                    <asp:GridView ID="gvSearchResults" runat="server" CssClass="table-auto w-full mt-4 text-center" AutoGenerateColumns="false">
                        <Columns>
                            <asp:BoundField DataField="first_name" HeaderText="First Name" />
                            <asp:BoundField DataField="last_name" HeaderText="Last Name" />
                            <asp:BoundField DataField="email" HeaderText="Email" />
                            <asp:BoundField DataField="mob" HeaderText="Phone" />
                            <asp:TemplateField HeaderText="CV">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkDownloadCV" runat="server" Text="Download" CommandArgument='<%# Eval("cv") %>' OnClick="lnkDownloadCV_Click" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </asp:View>

                    <asp:View ID="ViewCandidates" runat="server">
                        <h2>All Candidates</h2>
                 <asp:GridView ID="GridView1" runat="server" CssClass="table-auto w-full mt-4 text-center" AutoGenerateColumns="false">
                     <Columns>
                         <asp:BoundField DataField="first_name" HeaderText="First Name" />
                         <asp:BoundField DataField="last_name" HeaderText="Last Name" />
                         <asp:BoundField DataField="father" HeaderText="Father" />
                         <asp:BoundField DataField="mother" HeaderText="Mother" />
                         <asp:BoundField DataField="email" HeaderText="Email" />
                         <asp:BoundField DataField="mob" HeaderText="Mobile" />
                         <asp:BoundField DataField="address" HeaderText="Address" />
                         <asp:BoundField DataField="zip" HeaderText="card" />
                         <asp:BoundField DataField="mob" HeaderText="Phone" />
                     </Columns>
                 </asp:GridView>
                </asp:View>
            </asp:MultiView>
        </div>
    </form>
</asp:Content>