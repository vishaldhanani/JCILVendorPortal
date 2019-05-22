<%@ Page Language="C#" MasterPageFile="~/VMaster.Master" AutoEventWireup="true" CodeBehind="ShowElectricityPosNegEntries.aspx.cs" Inherits="JCILVendorPortal.ShowElectricityPosNegEntries" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/bootstrap-responsive.min.css" rel="stylesheet" />

    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet" />
    <link href="css/font-awesome.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <style>
        .nav-tabs > li > a {
            background: #3b5998;
            color: #fff;
        }

            .nav-tabs > li > a:hover {
                color: #555555;
            }

        #pnlHide {
            text-align: center;
        }

        .span3 {
            margin-top: 7px;
        }

        .dvButton {
            margin-top: 0px;
            width: 7%;
            display: inline-table;
        }

        .dvPanelInside {
            width: 30%;
            display: inline-table;
        }
    </style>
    <script>
        function validateQty(event) {
            var key = window.event ? event.keyCode : event.which;

            if (event.keyCode === 8 || event.keyCode == 46
             || event.keyCode == 37 || event.keyCode == 39 || key < 48 || key > 57 || key > 48 || key < 57) {
                return false;
            }

            var charStr = String.fromCharCode(key);
            if (/\d/.test(charStr)) {
                return false;
            }
            else return false;
        };
        function validateQty1(event) {
            var key = window.event ? event.keyCode : event.which;

            if (event.keyCode === 8 || event.keyCode == 46
             || event.keyCode == 37 || event.keyCode == 39 || key < 48 || key > 57 || key > 48 || key < 57) {
                return false;
            }

            var charStr = String.fromCharCode(key);
            if (/\d/.test(charStr)) {
                return false;
            }
            else return false;
        };
        
    </script>
    <script type="text/javascript">
        function validateQty2(event) {
            var key = window.event ? event.keyCode : event.which;

            if (event.keyCode < 48 || event.keyCode > 57) {
                return false;
            }
            else return true;
        };
        
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="main">
        <div class="main-inner">
            <div class="container">
                <div class="row">
                    <div class="span12">
                        <div class="widget ">
                            
                            <div class="widget-content">
                                
                                



                                
                                    <div>
                                        <div class="widget-header">
                                            <i class="icon-pushpin"></i>
                                            
                                           <h3> Electricity : <asp:Label ID="lblProductionOrderNo" runat="server" Text="" ForeColor="Blue"></asp:Label> -
                                            Posted Entries</h3>
                                        </div>
                                        <asp:GridView ID="gvCons" runat="server" ShowFooter="true" CssClass="table table-bordered" AutoGenerateColumns="false" OnDataBound = "OnDataBound" OnRowCreated = "OnRowCreated">
                                            <Columns>
<%--                                                <asp:TemplateField HeaderText="Dimension">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDimName2" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>--%>
                                              <asp:BoundField DataField="PostingDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Posting Date" />
                                                <asp:BoundField DataField="DocumentDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Document Date" />
                                                <asp:BoundField DataField="Name"   HeaderText="Department" />
                                                <asp:BoundField DataField="EntryType"  HeaderText="Type" />
                                                <asp:BoundField DataField="ItemNo"  HeaderText="IteM + Descripton" />
                                                <asp:BoundField DataField="Qty"  HeaderText="Qty." ControlStyle-BackColor="Red" />
                                            </Columns>
                                        </asp:GridView>
                                        
                                    </div>
                                

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
