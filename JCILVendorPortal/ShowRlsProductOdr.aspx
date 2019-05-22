<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/VMaster.Master" CodeBehind="ShowRlsProductOdr.aspx.cs" Inherits="JCILVendorPortal.ShowRlsProductOdr" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%-- <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/bootstrap-responsive.min.css" rel="stylesheet" />
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet" />
    <link href="css/font-awesome.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link href="css/style.css" rel="stylesheet" />
    <style>
        .nav-tabs > li > a {
            background: #3b5998;
            color: #fff;
        }

            .nav-tabs > li > a:hover {
                color: #555555;
            }

        .header-btn {
            float: right;
            margin-right: 12px;
            margin-top: 8px;
        }

        .span3 {
            float: right !important;
            width: 306PX !important;
        }
    </style>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="main-inner">
        <div class="container">
            <div class="row">
                <div class="span12">
                    <div class="control-group">
                    </div>
                    <table class="table-of-contents">
                        <tr>
                            <td style="width: 50%">
                                <asp:TextBox ID="txtPostingDate" runat="server" Width="80px" CssClass="span2" MaxLength="15" TabIndex="1" placeholder="dd/mm/yyyy" ToolTip="DD/MM/YYYY" onchange="return validateQty(event);" onkeypress="return validateQty(event);" onkeydown="return validateQty1(event);" Visible="false"></asp:TextBox>
                                <asp:Button ID="btnSearch" runat="server" Text="Search" class="btn btn-primary" OnClick="btnSearch_Click" Visible="false" />
                            </td>
                            <td style="width: 50%">
                                <asp:Button ID="btnNew" runat="server" Text="Create New Production Orders" class="btn btn-primary" OnClick="btnNew_Click" />
                            </td>
                        </tr>
                    </table>
                    <br />
                    <table class="table table-border">
                        <asp:Repeater runat="server" ID="rpt">
                            <HeaderTemplate>
                                <thead>
                                    <tr>
                                        <th class="center-align">No </th>
                                        <th class="center-align">Source No</th>
                                        <th class="center-align">Description</th>
                                        <th class="center-align">Creation Date</th>
                                        <th class="center-align">Add</th>
                                        <th class="center-align">View</th>
                                        <th class="center-align">Create Coal Entry</th>
                                    </tr>
                                </thead>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tbody>
                                    <tr>
                                        <td class="center-align">
                                            <%# Eval("no") %>
                                        </td>
                                        <td class="center-align">
                                            <%# Eval("Sourceno") %>
                                        </td>
                                        <td class="center-align">
                                            <%# Eval("Desc") %>
                                        </td>
                                        <td class="center-align">
                                            <%# Eval("CreationDate", "{0:dd/MM/yyyy}") %>
                                        </td>
                                        <td class="center-align">
                                            <asp:HyperLink ID="hlpInsert"  runat="server" NavigateUrl='<%# "~/CreateOrder?No=" + Eval("no") +"&Desc=" + Eval("Desc") +"&ItemNo=" + Eval("Sourceno") %>' Text="Add" >
                                            
                                            </asp:HyperLink>
                                        </td>
                                        <td class="center-align">
                                            <asp:HyperLink ID="hlView"  runat="server" Text="View" NavigateUrl='<%# "~/JCILItemTracking/EditProdConsuption.aspx?No=" + Eval("no") +"&ItemNo=" + Eval("Sourceno") %>'></asp:HyperLink>
                                        </td>
                                        <td class="center-align">
                                            <asp:HyperLink ID="hplinkCoal"  runat="server" Text="Generate" NavigateUrl='<%# "~/frmProdBOM.aspx?No=" + Eval("no") +"&ItemNo=" + Eval("Sourceno")+"&BOMNo=" + Eval("BOMNo") +"&LocationCode=" + HttpUtility.UrlEncode(Convert.ToString((Eval("LocationCode"))))%>'></asp:HyperLink>
                                        </td>
                                    </tr>
                                </tbody>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

