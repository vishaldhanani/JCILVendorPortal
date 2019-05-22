<%@ Page Title="" Language="C#" MasterPageFile="~/JCILItemTracking/mstBlank_.master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="JCILVendorPortal.JCILItemTracking.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="mstBlankHead" runat="server">
    <link href="assets/css/Custom.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mstBlankBody" runat="server">
    <div class="loginPage">
        <div class="row">
            <div class="col offset-s2 s12 offset-m4 m4 loginArea">
                <div class="card-avatar transparent">
                    <div class="waves-effect waves-block waves-light">
                        <img src="assets/Images/logo.png" class="activator" />
                    </div>
                    <div class="card-content">
                        <div class="input-field">
                            <i class="mdi-action-account-circle prefix white-text"></i>
                            <asp:TextBox ID="txtUserID" runat="server" CssClass="validate white-text" AutoCompleteType="None"></asp:TextBox>
                        </div>
                        <div class="input-field">
                            <i class="mdi-action-lock prefix white-text"></i>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="validate white-text" TextMode="Password"></asp:TextBox>
                        </div>
                        <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-large blue darken-4" OnClick="btnLogin_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
