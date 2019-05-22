<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/VMaster.Master" CodeBehind="NAVRegisteredVendorList.aspx.cs" Inherits="JCILVendorPortal.NAVRegisteredVendorList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <meta charset="utf-8"/>
  
    <script type="text/javascript" charset="utf-8"  src="http://myestoretemplates.com/tts/jquery.dataTables.js"></script>
    <script type="text/javascript" charset="utf-8"  src="http://myestoretemplates.com/tts/DT_bootstrap.js"></script>
    <link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="http://myestoretemplates.com/tts/DT_bootstrap.css"/>

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
       .span6 { width :554px !important;
    }
        .inner-logo {
        width:71px  !important;
        }
    </style>

      <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/bootstrap-responsive.min.css" rel="stylesheet" />
  
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet" />
    <link href="css/font-awesome.css" rel="stylesheet" />

    <link href="css/style.css" rel="stylesheet" />
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
                            <div id="example_wrapper" class="dataTables_wrapper form-inline" role="grid">
                              

                                 <table border="0" class="table table-striped table-bordered dataTable" id="example" aria-describedby="example_info">
                                    <asp:Repeater runat="server" ID="rpt">
                                        <HeaderTemplate>
                                            <thead>
                                                <tr role="row">
                                                   <th class="sorting_desc" role="columnheader" tabindex="0" aria-controls="example" aria-sort="descending" rowspan="1" colspan="1" aria-label="Last Updated: activate to sort column ascending">Last Updated</th>
                                                    <th class="sorting" role="columnheader" tabindex="0" aria-controls="example" aria-label="Vendor Code: activate to sort column ascending">Vendor Code </th>
                                                    <th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" aria-label="Name: activate to sort column ascending">Name</th>
                                                    
                                                    <th>Edit</th>
                                                </tr>
                                            </thead>
                                            <tbody role="alert" aria-live="polite" aria-relevant="all">
                                        </HeaderTemplate>
                                        
                                        <ItemTemplate>
                                            
                                                <tr class="gradeA">
                                                  <td class=" sorting_1"><%# Eval("Last_date_modified", "{0:dd MMM yyyy}") %></td>
                                                    <td class=""><%# Eval("VendorCode") %></td>
                                                    <td class=""><%# Eval("VendorName_HO") %></td>
                                                     
                                                    <td>
                                                        <asp:HyperLink ID="hlView" class="icon-edit icon-white\" runat="server" Text="View" NavigateUrl='<%# "~/ReRegistrationVendor.aspx?ID=" + Eval("ID") +"&VendorCode=" + Eval("VendorCode") %>'></asp:HyperLink>
                                                    </td>
                                                </tr>
                                           
                                        </ItemTemplate>
                                           
                                        <FooterTemplate>
                                              </tbody>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </table>

                                
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

