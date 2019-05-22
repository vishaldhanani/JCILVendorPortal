<%@ Page Language="C#" MasterPageFile="~/VMaster.Master" AutoEventWireup="true" CodeBehind="frmProdBOM.aspx.cs" Inherits="JCILVendorPortal.frmProdBOM" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style>
        /*--------------------*/
        /*for Item Tracking Show*/
        .DialogView {
            position: fixed;
            height: 100%;
            width: 100%;
            top: 0;
            right: 0;
            left: 0;
            z-index: 9999999;
            background-color: rgba(245, 245, 245, 0.69);
        }

        .ModalPanel-lg {
            width: 80% !important;
            right: 10%;
            left: 10%;
            height: 550px;
        }

        .ModalPanel-sm {
            width: 40% !important;
            right: 30%;
            left: 30%;
        }

        .ModalPanel-md {
            width: 60% !important;
            right: 20%;
            left: 20%;
            height: 450px;
        }

        .ModalPanel {
            position: fixed;
            top: 5%;
            background-color: #ffffff;
            border: 1px solid #3b5998;
            -webkit-box-shadow: 0px 0px 10px 0px rgba(94,94,94,1);
            -moz-box-shadow: 0px 0px 10px 0px rgba(94,94,94,1);
            box-shadow: 0px 0px 10px 0px rgba(94,94,94,1);
            padding: 5px;
            overflow-y: auto;
        }

        .ModalPanelContent {
            margin-top: 2%;
            padding: 20px;
        }

        .ModalPanelHeader {
            padding: 10px;
        }

        .ModalPanelFooter {
            padding: 20px;
            margin-top: 15px;
            text-align: right;
            background-color: #f5f5f5;
        }
        /*------------------------------*/
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
            else {
                return true;
            }
        };
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <table runat="server" id="tblID" class="responsive-table">
            <tr>
                <td>
                    <asp:TextBox ID="txtPostingDate" runat="server" Width="80px" MaxLength="15" TabIndex="1" placeholder="dd/mm/yyyy" ToolTip="DD/MM/YYYY" onchange="return validateQty(event);" onkeyup="var v = this.value;if (v.match(/^\d{2}$/) !== null) {this.value = v + '/';} else if (v.match(/^\d{2}\/\d{2}$/) !== null) {this.value = v + '/';}"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ForeColor="Red" ControlToValidate="txtPostingDate" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$" ErrorMessage="*" ValidationGroup="Group1" />
                </td>
                <td>
                    <asp:Label runat="server" Text="Document <br/>Date" ID="Label2"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtDocumentDate" runat="server" placeholder="dd/mm/yyyy" ToolTip="DD/MM/YYYY" Width="80px" MaxLength="15" TabIndex="1" onkeyup="var v = this.value;if (v.match(/^\d{2}$/) !== null) {this.value = v + '/';} else if (v.match(/^\d{2}\/\d{2}$/) !== null) {this.value = v + '/';}"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ForeColor="Red" ControlToValidate="txtDocumentDate" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$" ErrorMessage="*" ValidationGroup="Group1" />
                </td>
                <td style="text-align: right;">
                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary header-btn" TabIndex="7" ValidationGroup="Group1" OnClientClick="return validateDates();" OnClick="btnSave_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-primary header-btn" TabIndex="8" OnClick="btnCancel_Click" />
                </td>
            </tr>
        </table>
        <asp:Panel ID="pnlShow" runat="server">
            <div class="widget-header">
                <i class="icon-pushpin"></i>
                <h3>Coal </h3>
            </div>
            <%--  <asp:GridView ID="gvOutput" runat="server" ShowFooter="true" CssClass="bordered" AutoGenerateColumns="false">
                    <Columns>
                        <asp:TemplateField HeaderText="Item Description">
                            <ItemTemplate>
                                <asp:Label ID="lblDimName1" runat="server" Text='<%# Eval("Desc") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblnameForSum" runat="server" Text="Total Output" Visible="false" />
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Dimension" Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblDimCode1" runat="server" Text='<%# Eval("No") %>' Visible="false"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Qty in (Kg.)">
                            <ItemTemplate>
                                <asp:TextBox ID="txtOut" MaxLength="30" runat="server" TabIndex="3" onkeyup="calculateTotal1(event)"></asp:TextBox>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtOpSum" runat="server" Text="0" Visible="false" Enabled="false"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="btnItemTrack" runat="server" CssClass="btn blue darken-3" OnClick="btnItemTrack_Click" Text="Item Tracking">                                    
                                </asp:LinkButton>
                                <asp:LinkButton ID="lnkRemove" runat="server" Text="Remove" CssClass="btn red darken-4" OnClick="lnkRemove_Click" OnClientClick="return confirm('Are you sure to remove Item Track Details?');">
                                    <i class="material-icons">
                                        delete
                                    </i>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>--%>
            <div class="row">
                <table class="">
                    <thead>
                        <tr class="row" style="margin-bottom: 10px !important;">
                            <td class="col l6">
                                <asp:Label ID="lblCol1" runat="server" Text="Item Description">                            
                                </asp:Label>
                            </td>
                            <td class="col l3">
                                <asp:Label ID="lblCol2" runat="server" Text="Qty in (Kg.)">
                                </asp:Label>
                            </td>
                            <td class="col l3"></td>
                        </tr>
                    </thead>
                    <asp:Repeater ID="rptOutput" runat="server">
                        <ItemTemplate>
                            <tr class="row">
                                <td class="col l6">
                                    <asp:Label ID="lblDimName1" runat="server" Text='<%# Eval("Desc") %>'></asp:Label>
                                    <asp:Label ID="lblDimCode1" runat="server" Text='<%# Eval("No") %>' Visible="false"></asp:Label>
                                </td>
                                <td class="col l3">
                                    <asp:TextBox ID="txtOut" MaxLength="30" runat="server" TabIndex="3" onkeyup="calculateTotal1(event)"></asp:TextBox>
                                </td>
                                <td class="col l3">
                                    <asp:LinkButton ID="btnItemTrack" runat="server" CssClass=" btn-floating btn-large blue darken-3" OnClick="btnItemTrack_Click" ToolTip="Item Tracking">
                                            <i class="material-icons">
                                                send
                                            </i>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="lnkRemove" runat="server" CssClass="btn-floating btn-large red darken-4" OnClick="lnkRemove_Click" OnClientClick="return confirm('Are you sure to remove Item Track Details?');" ToolTip="Remove">  
                                            <i class="material-icons">
                                                remove
                                            </i>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="lnkShow" runat="server" CssClass=" btn-floating btn-large blue darken-3" OnClick="lnkShow_Click" ToolTip="Show" Visible="false">
                                            <i class="material-icons">
                                                list
                                            </i>
                                    </asp:LinkButton>
                                    <asp:Literal ID="ltrShowDetails" runat="server"></asp:Literal>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>

                </table>
            </div>
            <asp:Panel ID="pnlTrackingDetails" runat="server" CssClass="DialogView" Visible="false">
                <div class="ModalPanel ModalPanel-sm card">
                    <div class="card-content white-text">
                        <h3 class="card-title black-text">Item Tracking </h3>
                        <table>
                            <thead>
                                <tr>
                                    <th>
                                        <h5 class="card-title black-text">Item Tracking No
                                        </h5>
                                    </th>
                                    <th>
                                        <h5 class="card-title black-text">Quantity</h5>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="ItemTrackDetails" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="black-text">
                                                <asp:Label ID="lblLotNo" runat="server" Text='<% #Eval("LotNo")%>'></asp:Label>
                                            </td>
                                            <td class="black-text">
                                                <asp:Label ID="lblQty" runat="server" Text='<% #Eval("Quanity")%>'></asp:Label>
                                            </td>
                                            <td class="black-text">
                                                <asp:Label ID="lblDimenItem" runat="server" Visible="false" Text='<% #Eval("TrackItemCode")%>'></asp:Label>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="2">
                                        <asp:LinkButton ID="lnkCloseDetails" runat="server" Text="Close" CssClass="btn red darken-3 white-text right-align" OnClick="lnkCloseDetails_Click"></asp:LinkButton>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </asp:Panel>
            <div>
                <table class="table table-border">

                
                <asp:GridView ID="gvCons" runat="server" ShowFooter="true" AutoGenerateColumns="false"  >
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
                                <asp:TextBox ID="txtConsumption" runat="server" TabIndex="4" Text="0" Visible="false" Enabled="false"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                    </table>
            </div>
        </asp:Panel>
        <asp:Panel ID="pnlItemTracking" runat="server" CssClass="DialogView" Visible="false">
            <div class="ModalPanel ModalPanel-lg card">
                <div class="card-content white-text">
                    <div class="row">
                        <h3 class="card-title black-text">Item Tracking </h3>
                        <div class="input-field col s6 l3">
                            <span class="title black-text">Quntity</span>
                            <asp:TextBox ID="txtQuantityList" runat="server" ReadOnly="true"></asp:TextBox>
                            <asp:HiddenField ID="hfItemTrackRowQty" runat="server" />
                        </div>
                    </div>
                    <table>
                        <thead>
                            <tr>
                                <th colspan="3">
                                    <span class="title black-text">Quntity Utilize</span>
                                </th>
                                <th>
                                    <asp:Label ID="lblQtyUntilizeSum" runat="server" CssClass="right-align"></asp:Label>
                                    <asp:HiddenField ID="hfQtyUntilizeSum" runat="server" />
                                    <asp:HiddenField ID="hdnFieldItemNo" runat="server" />
                                </th>
                            </tr>
                            <tr>
                                <th></th>
                                <th>
                                    <span class="title black-text">Lot No</span>
                                </th>
                                <th>
                                    <span class="title black-text">Quantity
                                    </span>
                                </th>
                                <th>
                                    <span class="title black-text">Quantity Utilize
                                    </span>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptLotList" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <asp:CheckBox ID="chkLotSelect" runat="server" OnCheckedChanged="chkLotSelect_CheckedChanged" AutoPostBack="true" />
                                            <asp:Literal ID="lables" runat="server"></asp:Literal>
                                        </td>
                                        <td>
                                            <asp:Label ID="LotNo" runat="server" Text='<% #Eval("LotNo")%>' CssClass="black-text"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="RemainingQty" runat="server" Text='<% #Eval("RemainingQty", "{0:F}")%>' CssClass="black-text"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtUsingQty" runat="server" ReadOnly="true" AutoPostBack="true" CssClass="black-text" OnTextChanged="txtUsingQty_TextChanged"></asp:TextBox>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                    <div class="card-action">
                        <asp:LinkButton ID="lnkUpdate" runat="server" Text="Done" CssClass="btn green white-text" OnClick="lnkUpdate_Click"></asp:LinkButton>
                        <asp:LinkButton ID="lnkClear" runat="server" Text="Clear" CssClass="btn green white-text" OnClick="lnkClear_Click"></asp:LinkButton>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
