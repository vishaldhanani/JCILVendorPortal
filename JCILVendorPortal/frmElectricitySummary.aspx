<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/VMaster.Master" CodeBehind="frmElectricitySummary.aspx.cs" Inherits="JCILVendorPortal.frmElectricitySummary" %>

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
    </style>
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="main-inner">
        <div class="container">
            <div class="row">
                <div class="span12">
                    <div class="control-group">
                        
                                
                            </div>
                    <table style="width:100%;height:100%;">
                        <tr>
                            <td style="width:50%">
                                <asp:TextBox ID="txtPostingDate" runat="server" Width="80px" CssClass="span2" MaxLength="15" TabIndex="1" placeholder="dd/mm/yyyy" ToolTip="DD/MM/YYYY" onchange="return validateQty(event);" onkeypress="return validateQty(event);" onkeydown="return validateQty1(event);" Visible="false"  ></asp:TextBox>    

                                <asp:Button ID ="btnSearch" runat ="server" Text ="Search" class="btn btn-primary" OnClick="btnSearch_Click" Visible="false" />
                            </td>
                            <td style="width:50%">
                                <asp:Button ID ="btnNew" runat ="server" Text ="New" class="btn btn-primary header-btn" OnClick="btnNew_Click" />
                            </td>
                        </tr>
                    </table>
                    
                        <br />
                        
                        
                            
                            <table class="table table-bordered">
                                <asp:Repeater runat="server" ID="rpt"  >
                                    <HeaderTemplate>
                                        <thead>
                                            <tr>
                                                <th>Document No </th>
                                                <th>Source No</th>
                                                <th>Description</th>
                                                <th>Creation Date</th>
                                                
                                                <th>View</th>
                                            </tr>
                                        </thead>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tbody>
                                            <tr>
                                                <td><%# Eval("no") %></td>
                                                <td><%# Eval("Sourceno") %></td>
                                                <td><%# Eval("Desc") %> </td>
                                                <td><%# Eval("CreationDate", "{0:dd/MM/yyyy}") %> </td>
                                                
                                                <td style="text-align:center;">
                                                    <asp:HyperLink ID="hlView"  CssClass="btn-danger"  runat="server" Text="View" NavigateUrl='<%# "~/ShowElectricityPosNegEntries.aspx?No=" + Eval("no") +"&ItemNo=" + Eval("Sourceno") %>'></asp:HyperLink>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </table>
                        
                    
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

