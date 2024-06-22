<%@ Page Language="C#" MasterPageFile="~/HR.Master" AutoEventWireup="true" CodeBehind="EmployeeEvaluation.aspx.cs" Inherits="Z.EmployeeEvaluation" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Recruitment Evaluation
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server" class="bg-white p-6 rounded shadow-md">
        <div>
            <h2 class="text-2xl font-bold mb-4">Recruitment Evaluation</h2>
            
            <asp:Label ID="lblSelectCandidate" runat="server" Text="Select Candidate to Evaluate:" CssClass="block mb-2 font-semibold" />
            <asp:DropDownList ID="ddlCandidates" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlCandidates_SelectedIndexChanged" CssClass="block w-full p-2 mb-4 border rounded">
                <asp:ListItem Text="Select a candidate" Value="0" />
            </asp:DropDownList>
            
            <!-- Evaluation Details -->
            <asp:Label ID="lblEvaluation" runat="server" Text="Evaluation Score (0-100):" CssClass="block mb-2 font-semibold" />
            <asp:TextBox ID="txtEvaluationScore" runat="server" CssClass="block w-full p-2 mb-4 border rounded" OnTextChanged="txtEvaluationScore_TextChanged" AutoPostBack="true" />

            <asp:Label ID="lblDescription" runat="server" Text="Description:" CssClass="block mb-2 font-semibold" />
            <asp:TextBox ID="txtDescription" runat="server" CssClass="block w-full p-2 mb-4 border rounded" TextMode="MultiLine"></asp:TextBox>

            <asp:Button ID="btnApprove" runat="server" Text="Employment" OnClick="btnApprove_Click" CssClass="bg-green-500 text-white p-2 rounded mb-4" Visible="false" />
            <asp:Button ID="btnReject" runat="server" Text="Refuse to Employment" OnClick="btnReject_Click" CssClass="bg-red-500 text-white p-2 rounded mb-4" Visible="false" />
            <asp:Label ID="lblMessage" runat="server" CssClass="block mt-4" />
        </div>
    </form>
</asp:Content>
