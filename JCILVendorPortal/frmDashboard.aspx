    <%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/VMaster.Master" CodeBehind="frmDashboard.aspx.cs" Inherits="JCILVendorPortal.frmDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/bootstrap-responsive.min.css" rel="stylesheet" />

    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet" />
    <link href="css/font-awesome.css" rel="stylesheet" />
    <link href="css/pages/dashboard1.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" />
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <style>
        .header-btn {
            float: right;
            margin-right: 12px;
            margin-top: 8px;
        }

        .widget-content {
            padding: 20px 15px 15px !important;
            -moz-border-radius: 5px !important;
            -webkit-border-radius: 5px !important;
            border-radius: 5px !important;
            background :inherit !important;
            border :none !important;
        }
        .icon-large {
        width:39px !important;
        }
    </style>

   

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="main-inner">
        <div class="container">
            <div class="row">
                <div class="span12">
                    <div class="widget ">
                        <br />
                        <br />

                        <div class="widget-content" style="">
                            <div class="shortcuts">
                                <asp:Repeater runat="server" ID="rpt_Dashboard" OnItemDataBound="rpt_Dashboard_ItemDataBound">
                                    <HeaderTemplate>
                                        <ul>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <a runat="server" class="shortcut" id="a_link">
                                            <i class="<%# Eval("Class")%>"  aria-hidden="true" style =" font-size:70px;"></i>
                                       
                                            <span class="shortcut-label"><%# Eval("DashboardLabel") %> </span>
                                         
                                        </a>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </ul>
                </div>
                                    </FooterTemplate>
                                </asp:Repeater>
                                <%--<a href="javascript:;" class="shortcut">
                                    <i class="shortcut-icon icon-list-alt"></i>
                                    <span class="shortcut-label">Quotes</span> </a>

                                <a href="javascript:;" class="shortcut">
                                    <i class="shortcut-icon icon-bookmark"></i>
                                    <span class="shortcut-label">Quick Summary</span> </a>

                                <a href="javascript:;" class="shortcut">
                                    <i class="shortcut-icon icon-signal"></i>
                                    <span class="shortcut-label">Reports</span> </a>

                                <a href="javascript:;" class="shortcut">
                                    <i class="shortcut-icon icon-comment"></i>
                                    <span class="shortcut-label">Comments</span> </a>

                                <a href="VendorRegiProcess.aspx" class="shortcut">
                                    <i class="shortcut-icon icon-user"></i><span
                                        class="shortcut-label">Registration</span> </a>

                                <a href="javascript:;" class="shortcut">
                                    <i class="shortcut-icon icon-file"></i>
                                    <span class="shortcut-label">Notes</span> </a>

                                <a href="javascript:;" class="shortcut">
                                    <i class="shortcut-icon icon-picture"></i>
                                    <span class="shortcut-label">Samples</span> </a>

                                <a href="javascript:;" class="shortcut">
                                    <i class="shortcut-icon icon-tag"></i>
                                    <span class="shortcut-label">Notifications</span> </a>--%>
                            </div>
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
