<%@ Page Language="C#" MasterPageFile="~/Product.Master" AutoEventWireup="true" CodeBehind="ProductManagement.aspx.cs" Inherits="Z.ProductManagement" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Product Management
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server" class="bg-white p-6 rounded shadow-md">
        <div>
            <h2 class="text-2xl font-bold mb-4">Products Management</h2>
            <div class="flex justify-center">
                <asp:Menu ID="Menu1" runat="server" CssClass="tab-menu p-2 bg-blue-500 text-white" Orientation="Horizontal" OnMenuItemClick="Menu1_MenuItemClick">
                 <Items>
                    <asp:MenuItem Text="Insert" Value="0" />
                    <asp:MenuItem Text="Edit"   Value="1" />
                    <asp:MenuItem Text="Delete" Value="2" />
                    <asp:MenuItem Text="Search" Value="3" />
                    <asp:MenuItem Text="Products" Value="4" />
                 </Items>
                </asp:Menu>
            </div>
            <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
                <asp:View ID="ViewInsert" runat="server">
                    <h2>Insert Product</h2>
                    <asp:Label ID="lblProductName" runat="server" Text="Product Name:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtProductName" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />

                    <asp:Label ID="lblModel" runat="server" Text="Model:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtModel" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />

                    <asp:Label ID="lblColor" runat="server" Text="Color:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtColor" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />

                    <asp:Label ID="lblDescription" runat="server" Text="Description:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />

                    <asp:Label ID="lblCatalog" runat="server" Text="Catalog:" CssClass="block mb-2 font-semibold" />
                    <asp:FileUpload ID="fileCatalog" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />

                    <asp:Label ID="lblPhoto" runat="server" Text="Photo:" CssClass="block mb-2 font-semibold" />
                    <asp:FileUpload ID="carPhoto" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />

                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" CssClass="bg-green-500 text-white p-2 rounded mb-4" />
                    <asp:Label ID="lblMessage" runat="server" CssClass="block mt-4" />
                </asp:View>

                <asp:View ID="ViewEdit" runat="server">
                    <h2>Edit Product</h2>
                    <asp:Label ID="lblSelectProductEdit" runat="server" Text="Select Product:" CssClass="block mb-2 font-semibold" />
                    <asp:DropDownList ID="ddlSelectProductEdit" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSelectProductEdit_SelectedIndexChanged" CssClass="block w-full p-2 mb-4 border rounded">
                    </asp:DropDownList>

                    <asp:Label ID="lblProductNameEdit" runat="server" Text="Product Name:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtProductNameEdit" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />

                    <asp:Label ID="lblModelEdit" runat="server" Text="Model:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtModelEdit" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />

                    <asp:Label ID="lblColorEdit" runat="server" Text="Color:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtColorEdit" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />

                    <asp:Label ID="lblDescriptionEdit" runat="server" Text="Description:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtDescriptionEdit" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />

                    <asp:Label ID="lblCatalogEdit" runat="server" Text="Catalog:" CssClass="block mb-2 font-semibold" />
                    <asp:FileUpload ID="fileCatalogEdit" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />

                    <asp:Label ID="lblPhotoEdit" runat="server" Text="Photo:" CssClass="block mb-2 font-semibold" />
                    <asp:FileUpload ID="filePhotoEdit" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />

                    <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" CssClass="bg-blue-500 text-white p-2 rounded mb-4" />
                    <asp:Label ID="lblMessageEdit" runat="server" CssClass="block mt-4" />
                </asp:View>

                <asp:View ID="ViewDelete" runat="server">
                    <h2>Delete Product</h2>
                    <asp:Label ID="lblSelectProductDelete" runat="server" Text="Select Employee:" CssClass="block mb-2 font-semibold" />
                    <asp:DropDownList ID="ddlSelectProductDelete" runat="server" CssClass="block w-full p-2 mb-4 border rounded">
                    </asp:DropDownList>

                    <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" CssClass="bg-red-500 text-white p-2 rounded mb-4" />
                    <asp:Label ID="lblMessageDelete" runat="server" CssClass="block mt-4" />
                </asp:View>

                <asp:View ID="ViewSearch" runat="server">
                    <h3>Search Employees</h3>
                    <asp:Label ID="lblSearchBy" runat="server" Text="Search by:" CssClass="block mb-2 font-semibold" />
                    <asp:DropDownList ID="ddlSearchBy" runat="server" CssClass="block w-full p-2 mb-4 border rounded">
                        <asp:ListItem Text="Product Name" Value="product_name" />
                        <asp:ListItem Text="Model" Value="model" />
                    </asp:DropDownList>

                    <asp:Label ID="lblSearchTerm" runat="server" Text="Search term:" CssClass="block mb-2 font-semibold" />
                    <asp:TextBox ID="txtSearchTerm" runat="server" CssClass="block w-full p-2 mb-4 border rounded" />

                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="bg-gray-500 text-white p-2 rounded mb-4" />
                    <asp:Label ID="lblDownloadMessage" runat="server" CssClass="text-red-500" Visible="false"></asp:Label>
                    <asp:GridView ID="gvSearchResults" runat="server" CssClass="table-auto w-full mt-4 text-center" AutoGenerateColumns="false">
                        <Columns>
                            <asp:BoundField DataField="product_name" HeaderText="Product Name" />
                            <asp:BoundField DataField="model" HeaderText="Model" />
                            <asp:BoundField DataField="color" HeaderText="Color" />
                            <asp:TemplateField HeaderText="Catalog">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkDownloadCatalog" runat="server" Text="Download" CommandArgument='<%# Eval("catalog") %>' OnClick="lnkDownloadCatalog_Click" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </asp:View>

                    <asp:View ID="ViewCars" runat="server">
                        <h2>All Products</h2>
                 <asp:GridView ID="GridView1" runat="server" CssClass="table-auto w-full mt-4 text-center" AutoGenerateColumns="false">
                     <Columns>
                         <asp:BoundField DataField="product_name" HeaderText="Product Name" />
                         <asp:BoundField DataField="model" HeaderText="Model" />
                         <asp:BoundField DataField="color" HeaderText="Color" />
                     </Columns>
                 </asp:GridView>
                </asp:View>
            </asp:MultiView>
        </div>
    </form>
</asp:Content>
