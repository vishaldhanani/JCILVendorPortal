<%@ Page Language="C#" MasterPageFile="~/VMaster.Master" AutoEventWireup="true" CodeBehind="VendorRegiProcess.aspx.cs" Inherits="JCILVendorPortal.VendorRegiProcess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/bootstrap-responsive.min.css" rel="stylesheet" />

    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet" />
    <link href="css/font-awesome.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" />
    <style>
         .nav-tabs > li > a {
            background: #3b5998 ;
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

        .boldfontLeft {
            font-weight: 600;
            padding-right: 25px;
        }

        .boldfontRight {
            font-weight: 600;
            padding-right: 60px;
        }

        .boldfontleft {
            padding-left: 25px;
            font-weight: 600;
            padding-right: 25px;
        }

        .txtcenter {
            text-align: center;
        }
    </style>

    <script type="text/javascript">
        function PhoneAvailability() {
            if ($("#<%=txtLine3Office.ClientID%>").val != '') {
                $.ajax({
                    type: "POST",
                    url: "/VendorRegiProcess.aspx/GetMobile",
                    data: '{mobileNo: "' + $("#<%=txtLine3Office.ClientID%>")[0].value + '" }',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    cache: false,
                    error: function (response) {
                        alert("Unauthorized!!");
                    },
                    success: OnSuccess
                });
            }
        }
        function EmailAvailability() {
            if ($("#<%=txtEmailIDOffice.ClientID%>").val != '') {
                $.ajax({
                    type: "POST",
                    url: "/VendorRegiProcess.aspx/GetEmail",
                    data: '{Email: "' + $("#<%=txtEmailIDOffice.ClientID%>")[0].value + '" }',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    cache: false,
                    error: function (response) {
                        alert("Unauthorized!!");
                    },
                    success: OnSuccess
                });
            }
        }
        function WebsiteAvailability() {
            if ($("#<%=txtURL.ClientID%>").val != '') {
                $.ajax({
                    type: "POST",
                    url: "/VendorRegiProcess.aspx/GetWebsite",
                    data: '{URL: "' + $("#<%=txtURL.ClientID%>")[0].value + '" }',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    cache: false,
                    error: function (response) {
                        alert("Unauthorized!!");
                    },
                    success: OnSuccess
                });
            }
        }
        function PANAvailability() {
            if ($("#<%=txtPAN.ClientID%>").val != '') {
                $.ajax({
                    type: "POST",
                    url: "/VendorRegiProcess.aspx/GetPAN",
                    data: '{PAN: "' + $("#<%=txtPAN.ClientID%>")[0].value + '" }',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    cache: false,
                    error: function (response) {
                        alert("Unauthorized!!");
                    },
                    success: OnSuccess
                });
            }
        }
        function BankAcntAvailability() {
            if ($("#<%=txtAcntNo.ClientID%>").val != '') {
                $.ajax({
                    type: "POST",
                    url: "/VendorRegiProcess.aspx/GetBankAcnt",
                    data: '{AcntNo: "' + $("#<%=txtAcntNo.ClientID%>")[0].value + '" }',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    cache: false,
                    error: function (response) {
                        alert("Unauthorized!!");
                    },
                    success: OnSuccess
                });
            }
        }
        function OnSuccess(response,data) {
            switch (response.d) {
                
                case "false":
                    break;
                default:
                    alert(response.d + ' - Vendor already Registered!!');
                    //window.location.href = "frmDashboard.aspx";
                    break;
            }
        }
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
                                <div class="tabbable">
                                    <ul class="nav nav-tabs">
                                        <li class="active">
                                            <a id="lnk1" href="#GeneralDetails" data-toggle="tab">General Details</a>
                                        </li>
                                        <li><a id="lnk2" href="#ContactDetails" data-toggle="tab">Contact Details</a></li>
                                        <li><a id="lnk3" href="#BusinessDetails" data-toggle="tab">Business Details</a></li>
                                        <li><a id="lnk4" href="#TaxDetails" data-toggle="tab">Tax Details</a></li>
                                        <li><a id="lnk5" href="#BankDetails" data-toggle="tab">Bank Details</a></li>
                                        <li><a id="lnk6" href="#NavSetupFields" data-toggle="tab">NAV Setup</a></li>
                                        <%--<li><a id="lnk7" href="#NavNODNOCFields" data-toggle="tab">NOD / NOC Setup</a></li>--%>
                                    </ul>

                                    <div class="tab-content">
                                        <div class="tab-pane active" id="GeneralDetails">
                                            <div class="control-group">
                                                <asp:Label ID="lblSoRef" class="control-label" runat="server" Text="*" ForeColor="OrangeRed"></asp:Label>
                                                <div class="controls">
                                                   <table>
                                                       <tr>
                                                           <td>
                                                               <asp:Label ID="lblSourceRef" class="control-label  boldfontLeft " runat="server" Text="Source Reference:"></asp:Label>
                                                           </td>
                                                           <td>
                                                               <asp:CheckBox ID="chk_Self" class="checkbox inline boldfontLeft" runat="server" Text="Self Introduction" AutoPostBack="false" onclick="selfChecked(this)" />
                                                           </td>
                                                           <td>
                                                               <asp:CheckBox ID="chk_InquiryByJCIL" class="checkbox inline boldfontLeft" runat="server" Text="Inquiry By JCIL" AutoPostBack="false" onclick="InquiryJCILChecked(this)" />
                                                          
                                                           </td>
                                                           <td>
                                                               <asp:CheckBox ID="chk_AnRef" class="checkbox inline boldfontLeft" runat="server" Text="Any External Reference," AutoPostBack="false" onclick="AnRefChecked(this)" />
                                                           </td>
                                                       </tr>
                                                       <tr>
                                                           <td colspan="5">
                                                               <div id="dvInquiry" style="display: none;">
                                                        <asp:Label ID="Label5" class="control-label" runat="server" Text="Inquiry made by Mr./Ms."></asp:Label>
                                                        <asp:TextBox ID="txtInquiry" runat="server" class="span6" MaxLength="50" Width="20%"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txt_TypeofService" runat="server" Display="Dynamic" Text="This Field is Required!!" ForeColor="OrangeRed" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                        <asp:Label ID="Label6" class="control-label" runat="server" Text="of Jay Chemical Ind. Ltd."></asp:Label>
                                                    </div>

                                                           </td>
                                                               </tr>
                                                               <tr>
                                                                   <td colspan="5">                                                               <div id="dvExternal" style="display: none;">
                                                        <asp:Label ID="Label7" class="control-label" runat="server" Text=",Refer by Mr./Ms."></asp:Label>
                                                        <asp:TextBox ID="txtExtrnName" runat="server" class="span6" MaxLength="50" Width="18%"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtExtrnName" runat="server" Display="Dynamic" Text="This Field is Required!!" ForeColor="OrangeRed" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                        <asp:Label ID="Label8" class="control-label" runat="server" Text="of"></asp:Label>
                                                        <asp:TextBox ID="txtExtrnOrg" runat="server" class="span6" MaxLength="50" Width="18%"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtExtrnOrg" runat="server" Display="Dynamic" Text="This Field is Required!!" ForeColor="OrangeRed" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                        <asp:Label ID="Label9" class="control-label" runat="server" Text="Contact No."></asp:Label>
                                                        <asp:TextBox ID="txtExtrnCnct" runat="server" class="span6" MaxLength="10" Width="10%"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="txtExtrnCnct" runat="server" Display="Dynamic" SetFocusOnError="true" Text="This Field is Required!!" ForeColor="OrangeRed"></asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator36" runat="server" ControlToValidate="txtExtrnCnct" SetFocusOnError="true"
                                                            ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d{10}$" Display="Dynamic" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                    </div>
                                                           </td>
                                                                
                                                                                                               
                                                       </tr>
                                                       <tr>

                                                           <td>
                                                               <asp:Label ID="lblBusiness" class="control-label" runat="server" Text="*" ForeColor="OrangeRed"></asp:Label>
                                                               <asp:Label ID="lbl_TypeOfBusiness" class="control-label boldfontLeft" runat="server" Text="Type of Business:"></asp:Label>
                                                           </td>
                                                           <td>
                                                               <asp:CheckBox ID="chk_Manufac" class="checkbox inline boldfontLeft" runat="server" Text="Manufacturer" AutoPostBack="false" onclick="ManufactureChk(this)" />
                                                           </td>
                                                           <td>
                                                               <asp:CheckBox ID="chk_AgentDT" runat="server" class="checkbox inline boldfontLeft" Text="Agent/Dealer/Trader" AutoPostBack="false" onclick="AgentDtChk(this)" />
                                                           </td>
                                                           <td>
                                                               <asp:CheckBox ID="chk_Stockist" runat="server" class="checkbox inline boldfontLeft" Text="Stockist" AutoPostBack="false" onclick="StockistChk(this)" />
                                                           </td>
                                                           <td>
                                                               <asp:CheckBox ID="chk_ServiceProvider" runat="server" class="checkbox inline boldfontLeft" Text="Service Provider" AutoPostBack="false" onclick="ServiceChk(this)" />
                                                           </td>
                                                           <td>
                                                               <asp:CheckBox ID="chk_Supply" runat="server" class="checkbox inline boldfontLeft" Text="Supply & Service Provider" AutoPostBack="false" onclick="SupplyChk(this)" />
                                                           </td>
                                                       </tr>
                                                       <tr>
                                                           <td colspan="6">
                                                    <div class="control-group" id="dvService" style="display: none;">
                                                <asp:Label ID="lbl_ForServiceProvider" class="control-label boldfontLeft" runat="server" Text="For Service Provider:"></asp:Label>
                                                <asp:Label ID="lblTypeofService" class="control-label boldfontLeft" runat="server" Text="Type Of Service"></asp:Label>
                                                <asp:TextBox ID="txt_TypeofService" runat="server" class="span6 boldfontLeft" MaxLength="50"></asp:TextBox>
                                                                                                
                                            </div>
                                                           </td>
                                                   
                                                       </tr>
                                                       <tr>
                                                           <td>
                                                               <asp:Label ID="lblTitle" class="control-label " runat="server" Text="*" ForeColor="OrangeRed"></asp:Label>
                                                               <asp:Label ID="lbl_Title" class="control-label boldfontLeft" runat="server" Text="Title:"></asp:Label>
                                                           </td>
                                                           <td>
                                                               <asp:CheckBox ID="chk_Public" runat="server" class="checkbox inline boldfontLeft" Text="Company" onclick="PublicChk(this)" AutoPostBack="false" />
                                                           </td>
                                                           <td>
                                                               <asp:CheckBox ID="chk_Part" runat="server" class="checkbox inline boldfontLeft" Text="Partnership Firm" onclick="PartnerChk(this)" AutoPostBack="false" />
                                                           </td>
                                                           <td>
                                                               <asp:CheckBox ID="chk_Prop" runat="server" class="checkbox inline boldfontLeft" Text="Proprietorship Firm / Individual" onclick="ProprietorChk(this)" AutoPostBack="false" />
                                                           </td>
                                                           <td>
                                                               <asp:CheckBox ID="chk_LLP" runat="server" class="checkbox inline boldfontLeft" Text="LLP" onclick="LLP(this)" AutoPostBack="false" />
                                                           </td>
                                                       </tr>
                                                   </table>
                                                    
                                                            
                                                    
                                                    
                                                    
                                                    

                                                </div>
                                                <!-- /controls -->
                                            </div>






                                            <div style="width: 100%; float: left; padding-top: 16px;">
                                                <div style="float: left; margin-right: 22px; margin-left: 7px;">

                                                    <table class="table table-striped table-bordered">
                                                       <%-- <thead>
                                                            <tr>
                                                                <th style="text-align: center; font-size: 12px; vertical-align: middle;">Particulars </th>
                                                                <th colspan ="3" style="text-align: center; font-size: 12px; vertical-align: middle;">Address of WorkShop* (For Manufacturer) /<br />
                                                                    Name & Address of Principal (For Agent/Dealer/Stockist) </th>


                                                            </tr>
                                                        </thead>--%>
                                                        <tbody>
                                                            <tr>
                                                                <td>Name of Vendor </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtNameOffice" runat="server" class="span5" MaxLength="80"></asp:TextBox>
                                                                </td>
                                                                <%--<td>Premises No. </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtPremiseOffice" runat="server" class="span5" MaxLength="10"></asp:TextBox>
                                                                </td>--%>
                                                                <td>Address Line -1  </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtLine1Office" runat="server" class="span5" MaxLength="50"></asp:TextBox>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                
                                                                <td>Address Line -2 </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtLine2Office" runat="server" class="span5" MaxLength="50"></asp:TextBox>
                                                                </td>
                                                                <td>Pin Code </td>
                                                                <td>

                                                                    <asp:DropDownList ID="drpPinCode" runat="server" class="span3"></asp:DropDownList>
                                                                </td>
                                                            </tr>

                                                                                                                        <tr>
                                                                
                                                                                                                                <td>State / Region</td>
                                                                <td>

                                                                    <asp:DropDownList ID="drpStateOffice" runat="server" class="span3"></asp:DropDownList>
                                                                </td>
                                                    <td>Country</td>
                                                                <td>

                                                                    <asp:DropDownList ID="drpCountryOffice" runat="server" class="span3"></asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                           
                                                            <tr>


                                                                                                                                <td>Phone No. </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtLine3Office" runat="server" onkeypress="return validateQty2(event);" onchange="PhoneAvailability()" class="span3" MaxLength="12"></asp:TextBox>
                                                                </td>
                                                                                                                                <td>FAX No. </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtFaxNoOffice" runat="server" onkeypress="return validateQty2(event);" class="span3" MaxLength="12"></asp:TextBox>
                                                                </td>
                                                            </tr>

                                                            <tr>


                                                                                                                                <td>Moble No. </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtMobileNoOffice" runat="server" onkeypress="return validateQty2(event);" class="span3" MaxLength="10"></asp:TextBox>
                                                                </td>
                                                                                                                                 <td>Email Id </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtEmailIDOffice" runat="server" class="span5" MaxLength="200" onchange ="EmailAvailability()"></asp:TextBox>
                                                                </td>
                                                            </tr>



                                                           

                                                           

                                                            <%--                                                    <tr>
                                                        <td>Other Address ?</td>
                                                        <td>
                                                            <asp:CheckBox ID="HoAddressSameIsYes"  runat="server" AutoPostBack="false" onclick="IsSameAddressChecked(this)" />
                                                            
                                                            
                                                        </td>

                                                    </tr>--%>
                                                        </tbody>
                                                    </table>
                                                </div>
                                                <%--<div style="width: 41%; float: left; ">
                                            <div id="dvOtherOffice" style="display: none;">
                                            <table class="table table-striped table-bordered">
                                                <thead>
                                                    <tr>


                                                        <th style="text-align: center; font-size: 12px; height:37px; vertical-align: middle;">Other Office Address / H.O.</th>
                                                        
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>

                                                        
                                                        <td>
                                                            <asp:TextBox ID="txtNameWorkshop" runat="server"   class="span4" MaxLength="80"></asp:TextBox></td>
                                                    </tr>
                                                    <tr>

                                                        <td>
                                                            <asp:TextBox ID="txtPremiseWorkshop" runat="server"  class="span4" MaxLength="10"></asp:TextBox></td>
                                                    </tr>
                                                    <tr>
                                                       
                                                        <td>
                                                            <asp:TextBox ID="txtLine1Workshop" runat="server"  class="span4" MaxLength="200"></asp:TextBox></td>
                                                    </tr>
                                                    <tr>
                                                        
                                                        <td>
                                                            <asp:TextBox ID="txtLine2Workshop" runat="server" class="span4"  MaxLength="200"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                     <tr>
                                                                
                                                                <td>
                                                                    <asp:TextBox ID="txtLine3Workshop" runat="server" class="span4"  onkeypress="return validateQty2(event);" MaxLength="12"></asp:TextBox></td>
                                                            </tr>
                                                    
                                                        <tr>
                                                                
                                                                <td>
                                                                    <asp:TextBox ID="txtFaxNoWorkshop" runat="server" class="span4"  onkeypress="return validateQty2(event);" MaxLength="12"></asp:TextBox></td>
                                                            </tr>
                                                     <tr>
                                                                
                                                                <td>
                                                                    <asp:TextBox ID="txtMobileNoWorkshop" runat="server" onkeypress="return validateQty2(event);" class="span4"  MaxLength="10"></asp:TextBox></td>
                                                            </tr>
                                                    <tr>
                                                                
                                                                <td>
                                                                    <asp:TextBox ID="txtEmailIDWorkShop" runat="server" class="span4" MaxLength="200" ></asp:TextBox></td>
                                                            </tr>
                                                    <tr>
                                                        
                                                        <td>

                                                            <asp:DropDownList ID="drpCityWorkshop" runat="server" class="span4" ></asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                       
                                                        <td>

                                                            <asp:DropDownList ID="drpStateWorkshop" runat="server" class="span4" ></asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                     <tr>
                                                      
                                                        <td>

                                                            <asp:DropDownList ID="drpCountryWorkshop" runat="server" class="span4" ></asp:DropDownList>
                                                        </td>
                                                    </tr>

                                                   
                                                </tbody>
                                            </table>
                                                </div>
                                                    </div>--%>
                                            </div>
                                            <div class="form-actions">
                                                <button id="Button1" onclick="$('#lnk2').trigger('click');" class="btn btn-primary" style="float: right;" type="button">Next</button>
                                            </div>
                                            <!-- /form-actions -->

                                        </div>

                                        <div class="tab-pane" id="ContactDetails">

                                            <div class="control-group">
                                                <asp:Label ID="Label1" class="control-label boldfontLeft" runat="server" Text="Web Site:"></asp:Label>
                                                <asp:TextBox ID="txtURL" runat="server" class="span3" onchange ="WebsiteAvailability()" MaxLength="60"></asp:TextBox>
                                                <%--    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtURL" SetFocusOnError="true"
                                                    ErrorMessage="Invalid web URL!!" ForeColor="Red" ValidationExpression="(http(s)?://)?([\w-]+\.)+[\w-]+[.com]+(/[/?%&=]*)?" Display="None" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>--%>

                                                <asp:Label ID="Label2" class="control-label boldfontleft" runat="server" Text="Payment Term:"></asp:Label>
                                                <asp:DropDownList ID="drp_PaymentTerm" runat="server" class="span3 "></asp:DropDownList>
                                                <asp:Label ID="Label3" class="control-label boldfontleft" runat="server" Text="Total Strength of Manpower:"></asp:Label>
                                                <asp:TextBox ID="txt_TotalStrengthofManpower" runat="server" class="span1" onkeypress="return validateQty2(event);" MaxLength="4"></asp:TextBox>
                                                <div class="controls">
                                                </div>
                                                <!-- /controls -->
                                            </div>
                                            <!-- /control-group -->


                                            <!-- /control-group -->
                                            <!-- /control-group -->
                                            <div class="control-group">

                                                <div class="controls">
                                                    <asp:Label ID="Label4" class="control-label boldfontLeft" runat="server" Text="Shipment Term:"></asp:Label>
                                                    <asp:DropDownList ID="drpShipmentTerm" runat="server">
                                                        <asp:ListItem Text="--Select Any one--" Value="0"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <!-- /controls -->
                                            </div>

                                            <table class="table table-striped table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th style="text-align: center; font-size: 12px; text-align: center;">Designation </th>
                                                        <th style="text-align: center; font-size: 12px; text-align: center;">Name</th>
                                                        <th style="text-align: center; font-size: 12px; text-align: center;">Phone No ( with STD Code) </th>
                                                        <th style="text-align: center; font-size: 12px; text-align: center;">Mobile No</th>
                                                        <th style="text-align: center; font-size: 12px; text-align: center;">Email ID</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>Proprietor / Director / Partner </td>
                                                        <td>
                                                            <asp:TextBox ID="txtDirectName" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                        <td >
                                                            <asp:TextBox ID="txtDirectPhone" runat="server" class="span2" MaxLength="12" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                            <%--  <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" ControlToValidate="txtDirectPhone" SetFocusOnError="true"
                                                                ErrorMessage="Invalid Proprietor / Director / Partner Phone No." ForeColor="Red" ValidationExpression="^\d+$" Display="None" ValidationGroup="FormValidate2">  </asp:RegularExpressionValidator>--%>
                                                        </td>
                                                        <td >
                                                            <asp:TextBox ID="txtDirectMobile" runat="server" class="span2" MaxLength="10" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                            <%--  <asp:RegularExpressionValidator ID="RegularExpressionValidator11" runat="server" ControlToValidate="txtDirectMobile" SetFocusOnError="true"
                                                                ErrorMessage="Invalid Proprietor / Director / Partner Mobile No." ForeColor="Red" ValidationExpression="^\d{10}$" Display="None" ValidationGroup="FormValidate2">  </asp:RegularExpressionValidator>--%>
                                                        </td>
                                                        <td >
                                                            <asp:TextBox ID="txtDirectEmail" runat="server" class="span2" MaxLength="50"></asp:TextBox>
                                                            <%-- <asp:RegularExpressionValidator
                                                                ID="RegularExpressionValidator6"
                                                                ControlToValidate="txtDirectEmail"
                                                                Text="Invalid Proprietor / Director / Partner Email." Display="None"
                                                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                                runat="server" ValidationGroup="FormValidate2" ForeColor="OrangeRed" SetFocusOnError="true" />--%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Sales Department </td>
                                                        <td>
                                                            <asp:TextBox ID="txtSaleName" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                        <td>
                                                            <asp:TextBox ID="txtSalePhone" runat="server" class="span2" MaxLength="12" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                            <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server" ControlToValidate="txtSalePhone" SetFocusOnError="true"
                                                                ErrorMessage="Invalid Sales Department Phone No." ForeColor="Red" ValidationExpression="^\d+$" Display="None" ValidationGroup="FormValidate2">  </asp:RegularExpressionValidator>--%>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtSaleMobile" runat="server" class="span2" MaxLength="10" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                            <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtSaleMobile" SetFocusOnError="true"
                                                                ErrorMessage="Invalid Sales Department Mobile No." ForeColor="Red" ValidationExpression="^\d{10}$" Display="None" ValidationGroup="FormValidate2">  </asp:RegularExpressionValidator>--%>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtSaleEmail" runat="server" class="span2" MaxLength="50"></asp:TextBox>
                                                            <%--  <asp:RegularExpressionValidator
                                                                ID="RegularExpressionValidator7"
                                                                ControlToValidate="txtSaleEmail" SetFocusOnError="true"
                                                                Text="Invalid Sales Department Email." Display="None"
                                                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                                runat="server" ValidationGroup="FormValidate2" ForeColor="OrangeRed" />--%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Account Department  </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAccountName" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                        <td>
                                                            <asp:TextBox ID="txtAccountPhone" runat="server" class="span2" MaxLength="12" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                            <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator12" runat="server" ControlToValidate="txtAccountPhone" SetFocusOnError="true"
                                                                ErrorMessage="Invalid Account Department Phone No." ForeColor="Red" ValidationExpression="^\d+$" Display="None" ValidationGroup="FormValidate2">  </asp:RegularExpressionValidator>--%>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAccountMobile" runat="server" class="span2" MaxLength="10" onkeypress="return validateQty2(event);" onkeyup="sync(this)"></asp:TextBox>
                                                            <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtAccountMobile" SetFocusOnError="true"
                                                                ErrorMessage="Invalid Account Department Mobile No." ForeColor="Red" ValidationExpression="^\d{10}$" Display="None" ValidationGroup="FormValidate2">  </asp:RegularExpressionValidator>--%>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAccountEmail" runat="server" class="span2" MaxLength="50"></asp:TextBox>
                                                            <%--  <asp:RegularExpressionValidator
                                                                ID="RegularExpressionValidator8"
                                                                ControlToValidate="txtAccountEmail" SetFocusOnError="true"
                                                                Text="Invalid Account Department Email." Display="None"
                                                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                                runat="server" ValidationGroup="FormValidate2" ForeColor="OrangeRed" />--%>
                                                        </td>
                                                    </tr>


                                                </tbody>
                                            </table>

                                            <div class="form-actions">
                                                <button id="Button2" onclick="$('#lnk1').trigger('click');" class="btn btn-primary" style="float: left;" type="button">Previous</button>
                                                <button id="Button8" onclick="$('#lnk3').trigger('click');" class="btn btn-primary" style="float: right;" type="button">Next</button>
                                            </div>

                                            <div style="height: 50px; float: left;"></div>



                                        </div>

                                        <div class="tab-pane" id="BusinessDetails">


                                            <table class="table table-striped table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th style="text-align: center;">Last 3 years Annual Turnover:Year </th>
                                                        <th style="text-align: center;">Amount</th>

                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>

                                                        <td style="text-align: center;">
                                                            <%--<asp:TextBox ID="txtYear1" runat="server" class="span2" MaxLength="4" onkeypress="return validateQty2(event);"></asp:TextBox>--%>
                                                            <asp:DropDownList ID="drpYear1" runat="server"></asp:DropDownList>

                                                        </td>
                                                        <td style="text-align: center;">
                                                            <asp:TextBox ID="txtAmount1" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator16" runat="server" ControlToValidate="txtAmount1" SetFocusOnError="true"
                                                                ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d+$" Display="None" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                        </td>

                                                    </tr>
                                                    <tr>

                                                        <td style="text-align: center;">
                                                            <asp:DropDownList ID="drpYear2" runat="server"></asp:DropDownList>

                                                        </td>
                                                        <td style="text-align: center;">
                                                            <asp:TextBox ID="txtAmount2" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator17" runat="server" ControlToValidate="txtAmount2" SetFocusOnError="true"
                                                                ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d+$" Display="None" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>

                                                        <td style="text-align: center;">
                                                            <asp:DropDownList ID="drpYear3" runat="server"></asp:DropDownList>

                                                        </td>
                                                        <td style="text-align: center;">
                                                            <asp:TextBox ID="txtAmount3" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator18" runat="server" ControlToValidate="txtAmount3" SetFocusOnError="true"
                                                                ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d+$" Display="None" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                        </td>
                                                    </tr>


                                                </tbody>
                                            </table>
                                            <%--    <div class="widget-header">
                                                        <i class="icon-th-list"></i>
                                                        <h3>Reference Customer Details: ( preferably from Top 10 Customers )</h3>
                                                    </div>--%>
                                            <%--<table class="table table-striped table-bordered">
                                                        <thead>
                                                            <tr>
                                                                <th style="text-align: center;">No </th>
                                                                <th style="text-align: center;">Customer Name</th>
                                                                <th style="text-align: center;">Location</th>
                                                                <th style="text-align: center;">Contact Person
                                                                    <br />
                                                                    Name</th>
                                                                <th style="text-align: center;">Contact
                                                                    <br />
                                                                    Number</th>

                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>

                                                                <td>1 </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustName1" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustLocation1" runat="server" class="span2" MaxLength="20"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustCnct1" runat="server" class="span2" MaxLength="30"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustNo1" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator19" runat="server" ControlToValidate="txtCustNo1" SetFocusOnError="true"
                                                                        ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d{10,15}$" Display="Dynamic" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>2 </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustName2" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustLocation2" runat="server" class="span2" MaxLength="20"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustCnct2" runat="server" class="span2" MaxLength="30"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustNo2" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator20" runat="server" ControlToValidate="txtCustNo2" SetFocusOnError="true"
                                                                        ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d{10,15}$" Display="Dynamic" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>

                                                                <td>3 </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustName3" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustLocation3" runat="server" class="span2" MaxLength="20"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustCnct3" runat="server" class="span2" MaxLength="30"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustNo3" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator21" runat="server" ControlToValidate="txtCustNo3" SetFocusOnError="true"
                                                                        ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d{10,15}$" Display="Dynamic" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>

                                                                <td>4 </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustName4" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustLocation4" runat="server" class="span2" MaxLength="20"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustCnct4" runat="server" class="span2" MaxLength="30"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustNo4" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator22" runat="server" ControlToValidate="txtCustNo4" SetFocusOnError="true"
                                                                        ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d{10,15}$" Display="Dynamic" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>

                                                                <td>5 </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustName5" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustLocation5" runat="server" class="span2" MaxLength="20"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustCnct5" runat="server" class="span2" MaxLength="30"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustNo5" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator23" runat="server" ControlToValidate="txtCustNo5" SetFocusOnError="true"
                                                                        ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d{10,15}$" Display="Dynamic" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>

                                                                <td>6 </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustName6" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustLocation6" runat="server" class="span2" MaxLength="20"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustCnct6" runat="server" class="span2" MaxLength="30"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustNo6" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator24" runat="server" ControlToValidate="txtCustNo6" SetFocusOnError="true"
                                                                        ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d{10,15}$" Display="Dynamic" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>

                                                                <td>7 </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustName7" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustLocation7" runat="server" class="span2" MaxLength="20"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustCnct7" runat="server" class="span2" MaxLength="30"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustNo7" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator25" runat="server" ControlToValidate="txtCustNo7" SetFocusOnError="true"
                                                                        ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d{10,15}$" Display="Dynamic" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>

                                                                <td>8 </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustName8" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustLocation8" runat="server" class="span2" MaxLength="20"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustCnct8" runat="server" class="span2" MaxLength="30"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustNo8" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator26" runat="server" ControlToValidate="txtCustNo8" SetFocusOnError="true"
                                                                        ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d{10,15}$" Display="Dynamic" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>

                                                                <td>9 </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustName9" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustLocation9" runat="server" class="span2" MaxLength="20"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustCnct9" runat="server" class="span2" MaxLength="30"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustNo9" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator27" runat="server" ControlToValidate="txtCustNo9" SetFocusOnError="true"
                                                                        ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d{10,15}$" Display="Dynamic" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>

                                                                <td>10 </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustName10" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustLocation10" runat="server" class="span2" MaxLength="20"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustCnct10" runat="server" class="span2" MaxLength="30"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCustNo10" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator28" runat="server" ControlToValidate="txtCustNo10" SetFocusOnError="true"
                                                                        ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d{10,15}$" Display="Dynamic" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                                </td>
                                                            </tr>


                                                        </tbody>
                                                    </table>--%>

                                            <asp:GridView ID="grd_CustomerDetails" runat="server" ShowFooter="true" CssClass="table table-striped table-bordered" AutoGenerateColumns="false">
                                                <Columns>
                                                    <asp:BoundField DataField="RowNumber" HeaderText="No." HeaderStyle-HorizontalAlign="Center" />
                                                    <asp:TemplateField HeaderText="Customer Name">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtCustomerName" MaxLength="100" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Location">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtLocationName" MaxLength="100" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Contact Person Name">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtContactPersonName" MaxLength="100" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Contact Person Number">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtContactPersonNumber" MaxLength="15" onkeypress="return validateQty2(event);" runat="server"></asp:TextBox>
                                                        </ItemTemplate>

                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>



                                            <div class="form-actions">
                                                <button id="Button3" onclick="$('#lnk2').trigger('click');" class="btn btn-primary" style="float: left;" type="button">Previous</button>
                                                <button id="Button7" onclick="$('#lnk4').trigger('click');" class="btn btn-primary" style="float: right;" type="button">Next</button>
                                            </div>
                                            <!-- /control-group -->

                                        </div>

                                        <div class="tab-pane" id="TaxDetails">

                                            
                                                <div style="width: 100%; float: left;">
                                                    
                                                    <table class="table table-striped table-bordered">

                                                        <tbody>
                                                            <tr>

                                                                <td>C.S.T. No. </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCST" runat="server" class="span2" onkeypress="return validateQty2(event);" MaxLength="15"></asp:TextBox></td>
                                                                <td>Vat / TIN No.</td>
                                                                <td>
                                                                    <asp:TextBox ID="txtVAT" runat="server" onkeypress="return validateQty2(event);" class="span2" MaxLength="11"></asp:TextBox></td>
                                                            </tr>

                                                            <tr>

                                                                <td>PAN No.</td>
                                                                <td>
                                                                    <asp:TextBox ID="txtPAN" onchange ="PANAvailability()" runat="server" class="span2" MaxLength="10"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator29" runat="server" ControlToValidate="txtPAN" ViewStateMode="Disabled" SetFocusOnError="true"
                                                                        ErrorMessage="*" ForeColor="Red" ValidationExpression="[A-Z]{5}\d{4}[A-Z]{1}" Display="None" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                                </td>
                                                                <td>TAN No.</td>
                                                                <td>
                                                                    <asp:TextBox ID="txtTAN" runat="server" class="span2" MaxLength="10"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator30" runat="server" ControlToValidate="txtTAN" ViewStateMode="Disabled" SetFocusOnError="true"
                                                                        ErrorMessage="*" ForeColor="Red" ValidationExpression="[A-Z]{5}\d{4}[A-Z]{1}" Display="None" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                                </td>
                                                            </tr>


                                                            <tr>

                                                                <td>Micro, Small & Medium
                                                                    <br />
                                                                    Enterprise:</td>
                                                                <td>
                                                                    <asp:CheckBox ID="chk_Yes" runat="server" class="checkbox inline" Text="Yes" onclick="YesChk(this)" AutoPostBack="false" />
                                                                    <asp:CheckBox ID="chk_No" runat="server" class="checkbox inline" Text="No" onclick="NoChk(this)" AutoPostBack="false" />
                                                                </td>
                                                                <td>MSME Reg. No.</td>
                                                                <td>
                                                                    <asp:TextBox ID="TextBox100" runat="server" class="span2" MaxLength="30"></asp:TextBox></td>
                                                            </tr>

                                                            <tr>

                                                                <td>Registered With Excise?</td>
                                                                <td>
                                                                    <asp:CheckBox ID="chk_reg_Yes" runat="server" class="checkbox inline" Text="Yes" onclick="RegYesChk(this)" AutoPostBack="false" />
                                                                    <asp:CheckBox ID="chk_reg_No" runat="server" class="checkbox inline" Text="No" onclick="RegNoChk(this)" AutoPostBack="false" />
                                                                </td>
                                                                <td>ECC No</td>
                                                                <td>
                                                                    <asp:TextBox ID="txt_ECCNo" runat="server" MaxLength="20" class="span2"></asp:TextBox></td>
                                                            </tr>

                                                            <tr>

                                                                <td>Excise Range</td>
                                                                <td>
                                                                    <asp:TextBox ID="txt_ExciseRange" runat="server" MaxLength="20" class="span2"></asp:TextBox></td>
                                                                <td>Excise Division</td>
                                                                <td>
                                                                    <asp:TextBox ID="txt_ExciseDivision" runat="server" MaxLength="20" class="span2"></asp:TextBox></td>


                                                            </tr>
                                                            <tr>
                                                                <td>Excise Collectorate</td>
                                                                <td >
                                                                    <asp:TextBox ID="txt_ExciseCollectorate" runat="server" MaxLength="20" class="span2"></asp:TextBox></td>
                                                                <td>Service Tax Reg. No.</td>
                                                                <td>
                                                                    <asp:TextBox ID="txt_ServiceTaxRegNo" runat="server" class="span2" MaxLength="15"></asp:TextBox></td>
                                                            </tr>
                                                                                                                        <tr>

                                                                <td>P.F.Reg. No.</td>
                                                                <td>
                                                                    <asp:TextBox ID="txt_PFRegNo" runat="server" class="span2" MaxLength="15"></asp:TextBox></td>
                                                                                                                                <td>ESI Reg. No.</td>
                                                                <td>
                                                                    <asp:TextBox ID="txt_ESIRegNo" runat="server" class="span2" MaxLength="20"></asp:TextBox></td>
                                                            </tr>
                                                            <tr>

                                                                <td>Contact License No.</td>
                                                                <td>
                                                                    <asp:TextBox ID="txtContractLicenseNo" runat="server" class="span2" MaxLength="13"></asp:TextBox></td>
                                                                                                                                <td>TDS Applicability</td>
                                                                <td>
                                                                    <asp:CheckBox ID="chk_TDS_yes" runat="server" class="checkbox inline" Text="Yes" onclick="TDSYesChk(this)" AutoPostBack="false" />
                                                                    <asp:CheckBox ID="chk_TDS_No" runat="server" class="checkbox inline" Text="No" onclick="TDSNoChk(this)" AutoPostBack="false" />
                                                                    <asp:CheckBox ID="chk_TDS_Lower" runat="server" class="checkbox inline" Text="Lower Deduction" onclick="TDSLowerChk(this)" AutoPostBack="false" />
                                                                </td>
                                                            </tr>
                                                             <tr>
                                                                 <td colspan="2"></td>
                                                                <td>Lower Deduction Certi. No.</td>
                                                                <td>
                                                                    <asp:TextBox ID="txt_LowerDeductionCertiNo" runat="server" class="span2" MaxLength="15"></asp:TextBox></td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                                
                                            
                                            <div class="form-actions" style="float: left; width: 96.5%;">
                                                <button id="Button4" onclick="$('#lnk3').trigger('click');" class="btn btn-primary" style="float: left;" type="button">Previous</button>
                                                <button id="Button6" onclick=" $('#lnk5').trigger('click');" class="btn btn-primary" style="float: right;" type="button">Next</button>
                                            </div>

                                        </div>

                                        <div class="tab-pane" id="BankDetails">

                                            <table class="table table-striped table-bordered">

                                                <tbody>
                                                    <tr>

                                                        <td>Bank Name </td>
                                                        <td>
                                                            <asp:TextBox ID="txtBankName" runat="server" class="span4" MaxLength="60"></asp:TextBox></td>

                                                    </tr>
                                                    <tr>

                                                        <td>Bank Branch Name</td>
                                                        <td>
                                                            <asp:TextBox ID="txtBAnkBrnch" runat="server" class="span4" MaxLength="20"></asp:TextBox></td>
                                                    </tr>
                                                    <tr>

                                                        <td>Bank A/c No</td>
                                                        <td>
                                                            <asp:TextBox ID="txtAcntNo" runat="server" class="span4" MaxLength="20" onkeypress="return validateQty2(event);" onchange ="BankAcntAvailability()"></asp:TextBox>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator35" runat="server" ControlToValidate="txtAcntNo" SetFocusOnError="true"
                                                                ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d+$" Display="None" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>

                                                        <td>Type of A/c</td>
                                                        <td>
                                                            <asp:CheckBox ID="chk_TypeofSa" runat="server" class="checkbox inline" Text="Savings" />
                                                            <asp:CheckBox ID="chk_TypeofCur" runat="server" class="checkbox inline" Text="Current" />
                                                            <asp:CheckBox ID="chk_TypeofCC" runat="server" class="checkbox inline" Text="C.C." />
                                                        </td>
                                                    </tr>
                                                    <tr>

                                                        <td>IFSC Code (11 Digit)</td>
                                                        <td>
                                                            <asp:TextBox ID="txtIFSC" runat="server" class="span4" MaxLength="11"></asp:TextBox>
                                                            
                                                        </td>
                                                    </tr>

                                                    <tr>

                                                        <td>Email ID (For Mailing payment UTR No Details)</td>
                                                        <td>
                                                            <asp:TextBox ID="txtEmailUTR" runat="server" class="span4"></asp:TextBox>
                                                            <asp:RegularExpressionValidator
                                                                ID="RegularExpressionValidator33"
                                                                ControlToValidate="txtEmailUTR"
                                                                Text="*" Display="None"
                                                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" SetFocusOnError="true"
                                                                runat="server" ValidationGroup="FormValidate" ForeColor="OrangeRed" />
                                                        </td>
                                                    </tr>
                                                    <tr>

                                                        <td>Mobile No.</td>
                                                        <td>
                                                            <asp:TextBox ID="txtMobileUTR" runat="server" class="span4" MaxLength="10" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator34" runat="server" ControlToValidate="txtMobileUTR" SetFocusOnError="true"
                                                                ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d{10}$" Display="Dynamic" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>

                                            <div class="form-actions">
                                                <button id="Button5" onclick=" $('#lnk4').trigger('click');" class="btn btn-primary" style="float: left;" type="button">Previous</button>
                                                <button id="Button10" onclick=" $('#lnk6').trigger('click');" class="btn btn-primary" style="float: right;" type="button">Next</button>
                                            </div>
                                            <div style="height: 300px; float: left;"></div>

                                        </div>

                                        <div class="tab-pane" id="NavSetupFields">

                                            <table class="table table-striped table-bordered">

                                                <tbody>
                                                    <tr>
                                                        <td>
                                                             <asp:Label ID="Label10" class="control-label boldfontLeft" runat="server" Text="Vendor No. Series:"></asp:Label>
                                                    
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="VendorNoSeries" runat="server"></asp:DropDownList>
                                                        </td>
                                                         <td>Tax Liable </td>
                                                        <td>
                                                            <asp:CheckBox ID="chk_TaxLiable" runat="server" Checked="true" />
                                                        </td>
                                                    </tr>
                                                    
                                                    <tr>
                                                        <td>Gen. Bus. Posting Group</td>
                                                        <td>
                                                            <asp:DropDownList ID="drpGenBusPostingGroup" runat="server"></asp:DropDownList>
                                                        </td>
                                                        <td>Vendor Posting Group
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="drpVendorPostingGroup" runat="server"></asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>VAT Bus. Posting Group</td>
                                                        <td>
                                                            <asp:DropDownList ID="drpVATBusPostingGroup" runat="server"></asp:DropDownList>
                                                        </td>
                                                        <td>Currency Code:</td>
                                                        <td>
                                                            <asp:DropDownList ID="drpCurrencyCode" runat="server"></asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>

                                                        <td>Service Entity Type</td>
                                                        <td>
                                                            <asp:DropDownList ID="drpServiceEntityType" runat="server"></asp:DropDownList>
                                                        </td>
                                                        <td>Authorised by:</td>
                                                        <td>
                                                            <asp:DropDownList ID="drpAuthorisedby" runat="server"></asp:DropDownList>
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                       
                                                        <td>Excise Bus. Posting Group
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="drpExcisePostingGroup" runat="server"></asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <div class="form-actions">
                                                <button id="Button9" onclick=" $('#lnk5').trigger('click');" class="btn btn-primary" style="float: left;" type="button">Previous</button>
                                                <asp:Button ID="btn_Cancel" runat="server" class="btn header-btn" Text="Cancel"></asp:Button>
                                                <asp:Button ID="btnSave" Text="Save" CssClass="btn btn-primary header-btn" OnClientClick="return validate();" runat="server" CausesValidation="false" OnClick="btnSave_Click" />

                                            </div>
                                            <div style="height: 300px; float: left;"></div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <!-- /widget-content -->
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
    </div>
    <!-- /main -->

    <%--    <script src="js/jquery-1.7.2.min.js"></script>

    <script src="js/bootstrap.js"></script>
    <script src="js/base.js"></script>--%>



    <script type="text/javascript">
        function selfChecked(cbchck) {
            $('#<%= chk_AnRef.ClientID%>').prop('checked', false);
            $('#<%= chk_InquiryByJCIL.ClientID%>').prop('checked', false);
            $("#dvExternal").css({ "display": "none" });
            $('#dvInquiry').css({ "display": "none" });
        }

        function IsSameAddressChecked(HoAddressSameIsYes) {
            if (HoAddressSameIsYes.checked == true) {
                $("#dvOtherOffice").show();

            }
            else {
                $("#dvOtherOffice").hide();
            }
        }

        function InquiryJCILChecked(cbchck) {
            if (cbchck.checked == true) {
               $('#dvInquiry').css({ "display": "block" });
            //   $("#dvExternal").css({ "display": "none" });
                $('#<% = txtExtrnCnct.ClientID%>').val('');
                $('#<% = txtExtrnOrg.ClientID%>').val('');
                $('#<% = txtExtrnName.ClientID%>').val('');
            }
            else if (cbchck.checked == false) {
                $('#dvInquiry').css({ "display": "none" });
                ValidatorEnable(document.getElementById('<%=RequiredFieldValidator1.ClientID %>'), false);
                $('#<% = txtInquiry.ClientID%>').val('');
            }
                    //$('#<%= chk_AnRef.ClientID%>').prop('checked', false);
            $('#<%= chk_Self.ClientID%>').prop('checked', false);
        }
        function AnRefChecked(cbchck) {
            if (cbchck.checked == true) {
                $("#dvExternal").css({ "display": "block" });
              //  $('#dvInquiry').css({ "display": "none" });
                $('#<% = txtInquiry.ClientID%>').val('');
            }
            else if (cbchck.checked == false) {
                $("#dvExternal").css({ "display": "none" });
                $('#<% = txtExtrnCnct.ClientID%>').val('');
                $('#<% = txtExtrnOrg.ClientID%>').val('');
                $('#<% = txtExtrnName.ClientID%>').val('');
                ValidatorEnable(document.getElementById('<%=RequiredFieldValidator2.ClientID %>'), false);
                ValidatorEnable(document.getElementById('<%=RequiredFieldValidator3.ClientID %>'), false);
                ValidatorEnable(document.getElementById('<%=RequiredFieldValidator4.ClientID %>'), false);
            }
        $('#<%= chk_Self.ClientID%>').prop('checked', false);
            //$('#<%= chk_InquiryByJCIL.ClientID%>').prop('checked', false);
        }
        function ManufactureChk(cbchck) {
            $("#dvService").hide();
            $('#<% =txt_TypeofService.ClientID%>').val('');
            $('#<%= chk_AgentDT.ClientID%>').prop('checked', false);
            $('#<%= chk_Stockist.ClientID%>').prop('checked', false);
            $('#<%= chk_ServiceProvider.ClientID%>').prop('checked', false);
            $('#<%= chk_Supply.ClientID%>').prop('checked', false);
        }
        function AgentDtChk(cbchck) {
            $("#dvService").hide();
            $('#<% =txt_TypeofService.ClientID%>').val('');
            $('#<%= chk_Manufac.ClientID%>').prop('checked', false);
            $('#<%= chk_Stockist.ClientID%>').prop('checked', false);
            $('#<%= chk_ServiceProvider.ClientID%>').prop('checked', false);
            $('#<%= chk_Supply.ClientID%>').prop('checked', false);
        }
        function StockistChk(cbchck) {
            $("#dvService").hide();
            $('#<% =txt_TypeofService.ClientID%>').val('');
            $('#<%= chk_AgentDT.ClientID%>').prop('checked', false);
            $('#<%= chk_Manufac.ClientID%>').prop('checked', false);
            $('#<%= chk_ServiceProvider.ClientID%>').prop('checked', false);
            $('#<%= chk_Supply.ClientID%>').prop('checked', false);
        }
        function ServiceChk(cbchck) {
            if (cbchck.checked == true) {
                $("#dvService").show();
            }
            else if (cbchck.checked == false) {
                $("#dvService").hide();

            }
            $('#<% =txt_TypeofService.ClientID%>').val('');
            $('#<%= chk_AgentDT.ClientID%>').prop('checked', false);
            $('#<%= chk_Stockist.ClientID%>').prop('checked', false);
            $('#<%= chk_Manufac.ClientID%>').prop('checked', false);
            $('#<%= chk_Supply.ClientID%>').prop('checked', false);
        }
        function SupplyChk(cbchck) {
            if (cbchck.checked == true) {
                $("#dvService").show();
            }
            else if (cbchck.checked == false) {
                $("#dvService").hide();

            }
            $('#<% =txt_TypeofService.ClientID%>').val('');
            $('#<%= chk_AgentDT.ClientID%>').prop('checked', false);
            $('#<%= chk_Stockist.ClientID%>').prop('checked', false);
            $('#<%= chk_ServiceProvider.ClientID%>').prop('checked', false);
            $('#<%= chk_Manufac.ClientID%>').prop('checked', false);
        }
    </script>
    <!-- Source ref. & type of Business -->

    <script type="text/javascript">
        function PublicChk(cbchck) {
            
            $('#<%= chk_Part.ClientID%>').prop('checked', false);
            $('#<%= chk_Prop.ClientID%>').prop('checked', false);
            $('#<%= chk_LLP.ClientID%>').prop('checked', false);
            
        }
        function PrivateChk(cbchck) {
            $('#<%= chk_Public.ClientID%>').prop('checked', false);
            $('#<%= chk_Part.ClientID%>').prop('checked', false);
            $('#<%= chk_Prop.ClientID%>').prop('checked', false);
            $('#<%= chk_LLP.ClientID%>').prop('checked', false);
            
        }
        function PartnerChk(cbchck) {
            $('#<%= chk_Public.ClientID%>').prop('checked', false);
            
            $('#<%= chk_Prop.ClientID%>').prop('checked', false);
            $('#<%= chk_LLP.ClientID%>').prop('checked', false);
            
        }
        function ProprietorChk(cbchck) {
            $('#<%= chk_Public.ClientID%>').prop('checked', false);
            
            $('#<%= chk_Part.ClientID%>').prop('checked', false);
            $('#<%= chk_LLP.ClientID%>').prop('checked', false);
            
        }
        function LLP(cbchck) {
            $('#<%= chk_Public.ClientID%>').prop('checked', false);
            
            $('#<%= chk_Part.ClientID%>').prop('checked', false);
            $('#<%= chk_Prop.ClientID%>').prop('checked', false);
            
        }
        function IndividualChk(cbchck) {
            $('#<%= chk_Public.ClientID%>').prop('checked', false);
            
            $('#<%= chk_Part.ClientID%>').prop('checked', false);
            $('#<%= chk_Prop.ClientID%>').prop('checked', false);
            $('#<%= chk_LLP.ClientID%>').prop('checked', false);
        }
    </script>
    <!--Title-->

    <%--<script type="text/javascript">
        function CIFChk(cbchck) {
            $('#<%= chk_CNF.ClientID%>').prop('checked', false);
            $('#<%= chk_FOB.ClientID%>').prop('checked', false);
            $('#<%= chk_FOR.ClientID%>').prop('checked', false);
            $('#<%= chk_Exworks.ClientID%>').prop('checked', false);
        }
        function CNFChk(cbchck) {
            $('#<%= chk_CIF.ClientID%>').prop('checked', false);
            $('#<%= chk_FOB.ClientID%>').prop('checked', false);
            $('#<%= chk_FOR.ClientID%>').prop('checked', false);
            $('#<%= chk_Exworks.ClientID%>').prop('checked', false);
        }
        function FOBChk(cbchck) {
            $('#<%= chk_CIF.ClientID%>').prop('checked', false);
            $('#<%= chk_CNF.ClientID%>').prop('checked', false);
            $('#<%= chk_FOR.ClientID%>').prop('checked', false);
            $('#<%= chk_Exworks.ClientID%>').prop('checked', false);
        }
        function FORChk(cbchck) {
            $('#<%= chk_CIF.ClientID%>').prop('checked', false);
            $('#<%= chk_CNF.ClientID%>').prop('checked', false);
            $('#<%= chk_FOB.ClientID%>').prop('checked', false);
            $('#<%= chk_Exworks.ClientID%>').prop('checked', false);
        }
        function EXChk(cbchck) {
            $('#<%= chk_CIF.ClientID%>').prop('checked', false);
            $('#<%= chk_CNF.ClientID%>').prop('checked', false);
            $('#<%= chk_FOB.ClientID%>').prop('checked', false);
            $('#<%= chk_FOR.ClientID%>').prop('checked', false);
        }
    </script>--%>

    <script type="text/javascript">
        function validateQty2(event) {
            var key = window.event ? event.keyCode : event.which;

            if (event.keyCode < 48 || event.keyCode > 57) {
                return false;
            }
            else return true;
        };
    </script>

    <script type="text/javascript">




        function YesChk(cbchck) {
            $('#<%= chk_No.ClientID%>').prop('checked', false);
        }
        function NoChk(cbchck) {
            $('#<%= chk_Yes.ClientID%>').prop('checked', false);
        }
        function RegYesChk(cbchck) {
            $('#<%= chk_reg_No.ClientID%>').prop('checked', false);
        }
        function RegNoChk(cbchck) {
            $('#<%= chk_reg_Yes.ClientID%>').prop('checked', false);
        }
        function TDSYesChk(cbchck) {
            $('#<%= chk_TDS_No.ClientID%>').prop('checked', false);
            $('#<%= chk_TDS_Lower.ClientID%>').prop('checked', false);
        }
        function TDSNoChk(cbchck) {
            $('#<%= chk_TDS_yes.ClientID%>').prop('checked', false);
            $('#<%= chk_TDS_Lower.ClientID%>').prop('checked', false);
        }
        function TDSLowerChk(cbchck) {
            $('#<%= chk_TDS_yes.ClientID%>').prop('checked', false);
            $('#<%= chk_TDS_No.ClientID%>').prop('checked', false);
        }
        
       
    </script>
    <script type="text/javascript">
       
        $('input[id$=txtAccountMobile]').on('keyup', function () {
            $('input[id$=txtMobileUTR]').val($(this).val());
        });
        $('input[id$=txtAccountEmail]').on('keyup', function () {
            $('input[id$=txtEmailUTR]').val($(this).val());
        });
</script>
    <script type="text/javascript">
        function validate() {
            //code here....
            var BankName = document.getElementById('<%=txtBankName.ClientID %>').value;
            var BAnkBrnch = document.getElementById('<%=txtBAnkBrnch.ClientID %>').value;
            var AcntNo = document.getElementById('<%=txtAcntNo.ClientID %>').value;
            var IFSC = document.getElementById('<%=txtIFSC.ClientID %>').value;
            var MobileUTR = document.getElementById('<%=txtMobileUTR.ClientID %>').value;
            var EmailUTR = document.getElementById('<%=txtEmailUTR.ClientID %>').value;

            var NameOffice = document.getElementById('<%=txtNameOffice.ClientID %>').value;

            

            var Line1Office = document.getElementById('<%=txtLine1Office.ClientID %>').value;

            var Line2Office = document.getElementById('<%=txtLine2Office.ClientID %>').value;


            //            var TotalStrengthofManpower = document.getElementById('<%=txt_TotalStrengthofManpower.ClientID %>').value;


            var OfficeEmail = document.getElementById('<%=txtEmailIDOffice.ClientID %>').value;



            var CST = document.getElementById('<%=txtCST.ClientID %>').value;
            var VAT = document.getElementById('<%=txtVAT.ClientID %>').value;
            var PAN = document.getElementById('<%=txtPAN.ClientID %>').value;
            var TAN = document.getElementById('<%=txtTAN.ClientID %>').value;
            var ServiceTaxRegNo = document.getElementById('<%=txt_ServiceTaxRegNo.ClientID %>').value;
            var PFRegNo = document.getElementById('<%=txt_PFRegNo.ClientID %>').value;
            var ESIRegNo = document.getElementById('<%=txt_ESIRegNo.ClientID %>').value;


            var enterAmt1 = document.getElementById('<%=txtAmount1.ClientID %>').value;
            var enterAmt2 = document.getElementById('<%=txtAmount2.ClientID %>').value;
            var enterAmt3 = document.getElementById('<%=txtAmount3.ClientID %>').value;



            var emailPat = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

            var Url = /^(http[s]?:\/\/){0,1}(www\.){0,1}[a-zA-Z0-9\.\-]+\.[a-zA-Z]{2,5}[\.]{0,1}/;
            var tempURL = document.getElementById("<%=txtURL.ClientID%>").value;

            var digits = /^\d+$/;

            var digitsmobile = /^\d{10}$/;

            var digitsYear = /^\d{4}$/;

            var IFSCCode = /^[A-Za-z]{4}\d{7}$/;

            var PANNo = /^([a-zA-Z]{5})(\d{4})([a-zA-Z]{1})$/;

            var TANNo = /^([A-Z]{4})(\d{5})([A-Z]{1})$/;


            if (NameOffice == "") {
                alert("Please enter Vendor Name(H.O.).");
                return false;
            }
            if (PAN == "") {
                alert("Please enter PAN No.");
                return false;
            }
            
            //if (PremiseWorkshop == "") {
            //    alert("Please enter Premise(WorkShop) information.");
            //    return false;
            //}
            if (Line1Office == "") {
                alert("Please enter Address 1 ( H.O.).");
                return false;
            }

            if (BankName == "") {
                alert("Please enter Bank Name in bank details section.");
                return false;
            }

            if (BAnkBrnch == "") {
                alert("Please Enter Branch Name in bank details section.");
                return false;
            }
            if (AcntNo == "") {
                alert("Please enter Branch Name in bank details section.");
                return false;
            }
            if (IFSC == "") {
                alert("Please enter IFSC Code in bank details section.");
                return false;
            }
            if (MobileUTR == "") {
                alert("Please enter Mobile UTR in bank details section.");
                return false;
            }
            if (EmailUTR == "") {
                alert("Please enter Email UTR details in bank details section.");
                return false;
            }
            if (!digits.test(AcntNo)) {
                alert("Your Account no seems incorrect. Please try again.");
                return false;
            }
            if (!IFSCCode.test(IFSC)) {
                alert("Your IFSC Code seems incorrect. Please try again.");
                return false;
            }
            //if (NameWorkshop == "") {
            //    alert("Please enter Vendor Name(Work Shop).");
            //    return false;
            //}

            //if (Line1Workshop == "") {
            //    alert("Please enter Address 1 (Workshop).");
            //    return false;
            //}

            if (Line2Office == "") {
                alert("Please enter Address 2 ( H.O.).");
                return false;
            }
            //if (Line2Workshop == "") {
            //    alert("Please enter Address 2 (Workshop).");
            //    return false;
            //}

            //if (TotalStrengthofManpower == "") {
            //    alert("Please enter Total Strength of Manpower.");
            //    return false;
            //}
            if (tempURL != "") {
                if (!Url.test(tempURL)) {
                    alert("Web URL does not look valid");
                    document.getElementById("<%=txtURL.ClientID %>").focus();
                return false;
            }
        }


        if (!emailPat.test(DirectEmail)) {
            alert("Your Director email seems incorrect. Please try again.");
            document.getElementById("<%=txtDirectEmail.ClientID %>").focus();
                return false;
            }


            if (!emailPat.test(SaleEmail)) {
                alert("Your Sales email seems incorrect. Please try again.");
                document.getElementById("<%=txtSaleEmail.ClientID %>").focus();
                return false;
            }
            if (!emailPat.test(AccountEmail)) {
                alert("Your Account email seems incorrect. Please try again.");
                document.getElementById("<%=txtAccountEmail.ClientID %>").focus();
                return false;
            }
            if (!digits.test(DirectPhone)) {
                alert("Your Director phone seems incorrect. Please try again.");
                document.getElementById("<%=txtDirectPhone.ClientID %>").focus();
                return false;
            }
            if (!digits.test(SalePhone)) {
                alert("Your  Sales phone seems incorrect. Please try again.");
                document.getElementById("<%=txtSalePhone.ClientID %>").focus();
                return false;
            }
            if (!digits.test(AccountPhone)) {
                alert("Your  Account phone seems incorrect. Please try again.");
                document.getElementById("<%=txtSalePhone.ClientID %>").focus();
                return false;
            }
            if (!digitsmobile.test(DirectMobile)) {
                alert("Your Director Mobile seems incorrect. Please try again.");
                document.getElementById("<%=txtDirectMobile.ClientID %>").focus();
                return false;
            }
            if (!digitsmobile.test(SaleMobile)) {
                alert("Your Sales Mobile seems incorrect. Please try again.");
                document.getElementById("<%=txtSaleMobile.ClientID %>").focus();
                return false;
            }
            if (!digitsmobile.test(AccountMobile)) {
                alert("Your Account Mobile seems incorrect. Please try again.");
                document.getElementById("<%=txtAccountMobile.ClientID %>").focus();
                return false;
            }

            if (CST == "") {
                alert("Please enter CST.");
                return false;
            }
            if (VAT == "") {
                alert("Please enter VAT.");
                return false;
            }
            if (PAN == "") {
                alert("Please enter PAN .");
                PAN.focus();
                return false;
            }

            //if (TAN == "") {
            //    alert("Please enter TAN .");
            //    return false;
            //}
            if (PANOthr == "") {
                alert("Please enter PAN .");
                return false;
            }
            if (!PANNo.test(PAN)) {
                alert("Your PAN no seems incorrect. Please try again.");
                return false;
            }

            //if (!TANNo.test(TAN)) {
            //    alert("Your TAN Code seems incorrect. Please try again.");
            //    return false;
            //}
            if (!PANNo.test(PANOthr)) {
                alert("Your Other PAN No seems incorrect. Please try again.");
                return false;
            }




        }
    </script>
    <%--  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">
        function ShowProgress() {
            setTimeout(function () {
                var modal = $('<div />');
                modal.addClass("modal");
                $('body').append(modal);
                var loading = $(".loading");
                loading.show();
                var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
                var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
                loading.css({ top: top, left: left });
            }, 200);
        }
        $('form').live("submit", function () {
            ShowProgress();
        });
    </script>--%>
</asp:Content>
