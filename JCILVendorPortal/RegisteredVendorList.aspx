<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/VMaster.Master" CodeBehind="RegisteredVendorList.aspx.cs" Inherits="JCILVendorPortal.RegisteredVendorList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/bootstrap-responsive.min.css" rel="stylesheet" />

    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet" />
    <link href="css/font-awesome.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
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
        float : right !important;
        width :306PX !important;
        }
        tr {
        background-color:#E6EAF2;
        }
       
    </style>
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="main-inner">
        <div class="container">
            <div class="row">
                <div class="span12">
                    <div class="widget ">
                        <div class="widget-header">
                            <i class="icon-user"></i>
                            <h3>Registered Vendor List</h3>
                        </div>
                        <div class="widget-content">
                            <asp:TextBox ID="txtDate" runat="server" class="span3" MaxLength="10" OnTextChanged ="txtDate_TextChanged" placeholder ="Search by Date(Ex. YYYY-MM-DD) and Press Enter"></asp:TextBox>
                            
                            <table class="table table-bordered">
                                <asp:Repeater runat="server" ID="rpt">
                                    <HeaderTemplate>
                                        <thead>
                                            <tr>
                                                <th>Vendor Code </th>
                                                <th>Vendor Name </th>
                                                <th>Title</th>
                                                <th>Type of Business</th>
                                                <th style ="display : none;">FeedBack</th>
                                                <th>View</th>
                                            </tr>
                                        </thead>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tbody>
                                            <tr id ="trID" runat ="server">
                                                <td style =" background-color:none !important;"><%# Eval("VendorCode") %></td>
                                                <td style =" background-color:none !important;"><%# Eval("VendorName_HO") %></td>
                                                <td style =" background-color:none !important;"><%# Eval("Title") %> </td>
                                                <td style =" background-color:none !important;"><%# Eval("TypeOfBusiness") %> </td>
                                                <td style ="display : none;"><asp:Label ID="lblSr" runat="server" Text ='<%# Eval("FeedBack") %>' /> </td>
                                                <%--<td class="td-actions">
                                                    <a href="javascript:;" class="btn btn-small btn-success"> Approve
                                                        <i class="btn-icon-only icon-ok"></i>
                                                    </a>
                                                   
                                                </td>--%>
                                                <td style =" background-color:none !important;"> 
                                                    <asp:HyperLink ID="hlView" class="btn btn-small btn-warning" runat="server" Text="View" NavigateUrl='<%# "~/ApproveVendor.aspx?ID=" + Eval("ID") +"&VendorCode=" + Eval("VendorCode") %>'></asp:HyperLink>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </table>
                        </div>
                    </div>
                    <!-- /widget -->
                </div>
                <!-- /span8 -->
            </div>
            <!-- /row -->
        </div>
        <!-- /container -->
    </div>
    <!-- /main-inner -->

</asp:Content>

