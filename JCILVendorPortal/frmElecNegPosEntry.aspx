<%@ Page Language="C#" MasterPageFile="~/VMaster.Master" AutoEventWireup="true" CodeBehind="frmElecNegPosEntry.aspx.cs" Inherits="JCILVendorPortal.frmElecNegPosEntry" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/bootstrap-responsive.min.css" rel="stylesheet" />

    <%--<link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet" />--%>
    <link href="css/font-awesome.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" />
    <%--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />--%>
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
       
        function validateDates() {
            if (document.getElementById('<%=txtPostingDate.ClientID%>').value == '') {
                alert("Please enter Posting Date.");
                return false;
            }
            if (document.getElementById('<%=txtDocumentDate.ClientID%>').value == '') {
                alert("Please enter Document Date.");
                return false;
            }
        }
    </script>
    <script type="text/javascript">
        function DisableBackButton() {
            window.history.forward()
        }
        DisableBackButton();
        window.onload = DisableBackButton;
        window.onpageshow = function (evt) { if (evt.persisted) DisableBackButton() }
        window.onunload = function () { void (0) }
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
                            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                            <div class="widget-content">
                                
                                <table runat="server" id="tblID"   class="table table-bordered" style="margin-bottom: 8px;">
                                    <tr>

                                    </tr>
                                    <tr>



                                             
                                                                                
                                                                           <td>
                                            <asp:Label ID="Label1" class="control-label  boldfontLeft " runat="server" Text="Item No." Style="color:green;"></asp:Label>
                                        </td>
                                             
                                        <td>
                                            <asp:DropDownList ID="drpItem" runat="server"  ></asp:DropDownList>
                                            <asp:Label ID="lblItemDescription" runat="server" Style="color:blue;"></asp:Label>
                                        </td>
                                        <td>
                                           <asp:Label runat="server" Text="Posting <br/> Date" ID="lblPostingDate"  ></asp:Label>                                         

                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPostingDate" runat="server" Width="80px" MaxLength="15" TabIndex="1" placeholder="dd/mm/yyyy" ToolTip="DD/MM/YYYY" onchange="return validateQty(event);" onkeyup="var v = this.value;if (v.match(/^\d{2}$/) !== null) {this.value = v + '/';} else if (v.match(/^\d{2}\/\d{2}$/) !== null) {this.value = v + '/';}"  ></asp:TextBox>    <%--onkeypress="return validateQty(event);" onkeydown="return validateQty1(event);"--%>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ForeColor="Red"  ControlToValidate="txtPostingDate" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
    ErrorMessage="*" ValidationGroup="Group1" />
                                            <%--<ajax:CalendarExtender ID="CalendarExtender1" TargetControlID="txtPostingDate" Format="dd/MM/yyyy" runat="server"></ajax:CalendarExtender>--%>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" Text="Document <br/>Date" ID="Label2"  ></asp:Label>                                         
                                        </td>
                                        <td>
                                                                                        <asp:TextBox ID="txtDocumentDate" runat="server" placeholder="dd/mm/yyyy" ToolTip="DD/MM/YYYY" Width="80px" MaxLength="15" TabIndex="1" onkeyup="var v = this.value;if (v.match(/^\d{2}$/) !== null) {this.value = v + '/';} else if (v.match(/^\d{2}\/\d{2}$/) !== null) {this.value = v + '/';}"></asp:TextBox>  <%--autocomplete="off" onkeypress="return validateQty(event);" onkeydown="return validateQty1(event);"--%>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ForeColor="Red" ControlToValidate="txtDocumentDate" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
    ErrorMessage="*" ValidationGroup="Group1" />
                                            <%--<ajax:CalendarExtender ID="CalendarExtender3" TargetControlID="txtDocumentDate" Format="dd/MM/yyyy" runat="server"></ajax:CalendarExtender>--%>

                                        </td>
                                                                                <td  style="text-align:right;">
                                            <asp:Button ID="btnTotalOutput" runat="server"  Text="Calculate" CssClass="btn btn-primary header-btn"  TabIndex="9" OnClick="btnTotalOutput_Click"    />
                                            
                                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary header-btn"  TabIndex="7" ValidationGroup="Group1" OnClientClick="return validateDates();" OnClick="btnSave_Click" />
                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-primary header-btn" TabIndex="8"  OnClick="btnCancel_Click" />
                                        </td>
                                        </tr>
                                    
                                </table>



                                <asp:Panel ID="pnlShow" runat="server" >
                                    <div style="width: 48%; float: left;">
                                        <div class="widget-header" >
                                            <i class="icon-pushpin"></i>
                                            <h3>Generate </h3>
                                            <asp:Label ID="lblOutputSum" runat="server" CssClass="header-btn" Text="0.00" style="color:red;float: right;"></asp:Label>
                                            
                                        </div>
                                        <asp:GridView ID="gvOutput" runat="server" ShowFooter="true" CssClass="table table-bordered" AutoGenerateColumns="false">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Dimension">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDimName1" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                     <FooterTemplate>
            <asp:Label ID="lblnameForSum" runat="server" Text="Total Output" Visible="false" />
         </FooterTemplate> 
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Dimension" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDimCode1" runat="server" Text='<%# Eval("Code") %>' Visible="false"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Qty in (Kg.)">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtOut" MaxLength="30" runat="server" TabIndex="3" onkeypress="return validateQty2(event);" onkeyup="calculateTotal1(event)"></asp:TextBox>
                                                    </ItemTemplate>
                                                                              <FooterTemplate>
            <asp:TextBox ID="txtOpSum" runat="server" Text ="0" Visible="false" Enabled ="false"></asp:TextBox>
                                                </FooterTemplate> 
                                                </asp:TemplateField>
                                                
                                            </Columns>
                                            
                                        </asp:GridView>
                                        
                                        
                                               
                                    </div>
                                    <div style="width: 48%; float: right;">
                                        <div class="widget-header">
                                            <i class="icon-pushpin"></i>
                                            <h3> Used</h3>
                                            <asp:Label ID="lblConsumptionTotal" runat="server" Text="0.00" style="color:red;float: right;"></asp:Label>
                                            
                                        </div>
                                        <asp:GridView ID="gvCons" runat="server" ShowFooter="true" CssClass="table table-striped table-bordered" AutoGenerateColumns="false">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Dimension">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDimName2" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                                              <FooterTemplate>
            <asp:Label ID="lblnameForSum" runat="server" Text="Total Consumption" Visible="false" />
         </FooterTemplate> 
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Dimension" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDimCode2" runat="server" Text='<%# Eval("Code") %>' Visible="false"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Qty in (Kg.)">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtCons" MaxLength="30" runat="server" TabIndex="4" onkeypress="return validateQty2(event);" onkeyup="calculateTotal2(event)"></asp:TextBox>
                                                    </ItemTemplate>
                                                                                                       <FooterTemplate>
            <asp:TextBox ID="txtConsumption" runat="server" TabIndex="4" Text ="0" Visible="false" Enabled ="false"></asp:TextBox>
         </FooterTemplate> 
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        
                                      <%--  <div class="dvButton" style="float: right;">
                                            
                                        </div>--%>
                                    </div>

                                </asp:Panel>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
