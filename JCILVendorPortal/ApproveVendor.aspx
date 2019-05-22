<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/VMaster.Master" CodeBehind="ApproveVendor.aspx.cs" Inherits="JCILVendorPortal.ApproveVendor" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/bootstrap-responsive.min.css" rel="stylesheet" />

    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet" />
    <link href="css/font-awesome.css" rel="stylesheet" />
    
    <link href="css/style.css" rel="stylesheet" />
    <style>
        .nav-tabs > li > a {
            background:#3b5998;
            color: #fff;
        }
            .nav-tabs > li > a:hover {
            color:#555555;
            }
        .header-btn {
        float:right;
        margin-right:12px;
        margin-top:8px;
        }
        .boldfont {
            font-weight:600;
            padding-right:25px;
        }
        .boldfontWebSite {
            font-weight:600;
            padding-right:60px;
        }
        .boldleft {
            padding-left:60px;
        }
        .fontHeader {
        font-size:14px;
        }
        .apprv {
        float: right; background-color : #5cb85c;
        }
        .apprv:hover {
        background-color : #5cb85c;
        }
    </style>
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="main">
        <div class="main-inner">
            <div class="container">
                <div class="row">
                    <div class="span12">
                        <div class="widget ">
                            <div class="widget-header">
                                <i class="icon-user"></i>
                                <h3>Vendor Confirmation</h3>
                                
                           
                            <%--<asp:Button ID="btnSave" Text="Update" CssClass="btn btn-primary header-btn" OnClientClick="return validate();" runat="server"  CausesValidation="false" OnClick="btnSave_Click" />--%>
                                                            
                            </div>
                            <!-- /widget-header -->
           
                            <div class="widget-content">
                                <div class="tabbable">
                                    
                                    <ul class="nav nav-tabs">
                                        <li class="active">
                                            <a id ="lnk1" href="#GeneralDetails" data-toggle="tab">General Details</a>
                                        </li>
                                        <li><a id ="lnk2" href="#ContactDetails" data-toggle="tab" onclick="$('#<%=hf2.ClientID%>').val('1');$('#<%=hf1.ClientID%>').val('1');">Contact Details</a></li>
                                        <li><a id ="lnk3" href="#BusinessDetails" data-toggle="tab" onclick="$('#<%=hf3.ClientID%>').val('1');">Business Details</a></li>
                                        <li><a id ="lnk4" href="#TaxDetails" data-toggle="tab" onclick="$('#<%=hf4.ClientID%>').val('1');">Tax Details</a></li>
                                        <li><a id ="lnk5" href="#BankDetails" data-toggle="tab" onclick="$('#<%=hf5.ClientID%>').val('1');">Bank Details</a></li>
                                         <li><a id="lnk6" href="#NavSetupFields" data-toggle="tab">NAV Setup</a></li>
                                        <%--<li  ><a href="#Attachments" data-toggle="tab">Attachments</a></li>--%>
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
                                                               <asp:CheckBox   Enabled ="false" ID="chk_Self" CssClass="checkbox inline boldfontLeft" runat="server" Text="Self Introduction" AutoPostBack="false" onclick="selfChecked(this)" />
                                                           </td>
                                                           <td>
                                                               <asp:CheckBox   Enabled ="false" ID="chk_InquiryByJCIL" CssClass="checkbox inline boldfontLeft" runat="server" Text="Inquiry By JCIL" AutoPostBack="false" onclick="InquiryJCILChecked(this)" />
                                                          
                                                           </td>
                                                           <td>
                                                               <asp:CheckBox   Enabled ="false" ID="chk_AnRef" CssClass="checkbox inline boldfontLeft" runat="server" Text="Any External Reference," AutoPostBack="false" onclick="AnRefChecked(this)" />
                                                           </td>
                                                       </tr>
                                                       <tr>
                                                           <td colspan="5">
                                                               <div id="dvInquiry" style="display: none;">
                                                        <asp:Label ID="Label5" class="control-label" runat="server" Text="Inquiry made by Mr./Ms."></asp:Label>
                                                        <asp:TextBox  Enabled ="false" ID="txtInquiry" runat="server" class="span6" MaxLength="50" Width="20%"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txt_TypeofService" runat="server" Display="Dynamic" Text="This Field is Required!!" ForeColor="OrangeRed" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                        <asp:Label ID="Label6" class="control-label" runat="server" Text="of Jay Chemical Ind. Ltd."></asp:Label>
                                                    </div>

                                                           </td>
                                                               </tr>
                                                               <tr>
                                                                   <td colspan="5">                                                               <div id="dvExternal" style="display: none;">
                                                        <asp:Label ID="Label7" class="control-label" runat="server" Text=",Refer by Mr./Ms."></asp:Label>
                                                        <asp:TextBox  Enabled ="false" ID="txtExtrnName" runat="server" class="span6" MaxLength="50" Width="18%"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtExtrnName" runat="server" Display="Dynamic" Text="This Field is Required!!" ForeColor="OrangeRed" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                        <asp:Label ID="Label8" class="control-label" runat="server" Text="of"></asp:Label>
                                                        <asp:TextBox  Enabled ="false" ID="txtExtrnOrg" runat="server" class="span6" MaxLength="50" Width="18%"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtExtrnOrg" runat="server" Display="Dynamic" Text="This Field is Required!!" ForeColor="OrangeRed" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                        <asp:Label ID="Label9" class="control-label" runat="server" Text="Contact No."></asp:Label>
                                                        <asp:TextBox  Enabled ="false" ID="txtExtrnCnct" runat="server" class="span6" MaxLength="10" Width="10%"></asp:TextBox>
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
                                                               <asp:CheckBox   Enabled ="false" ID="chk_Manufac" CssClass="checkbox inline boldfontLeft" runat="server" Text="Manufacturer" AutoPostBack="false" onclick="ManufactureChk(this)" />
                                                           </td>
                                                           <td>
                                                               <asp:CheckBox   Enabled ="false" ID="chk_AgentDT" runat="server" CssClass="checkbox inline boldfontLeft" Text="Agent/Dealer/Trader" AutoPostBack="false" onclick="AgentDtChk(this)" />
                                                           </td>
                                                           <td>
                                                               <asp:CheckBox  Enabled ="false" ID="chk_Stockist" runat="server" CssClass="checkbox inline boldfontLeft" Text="Stockist" AutoPostBack="false" onclick="StockistChk(this)" />
                                                           </td>
                                                           <td>
                                                               <asp:CheckBox   Enabled ="false" ID="chk_ServiceProvider" runat="server" CssClass="checkbox inline boldfontLeft" Text="Service Provider" AutoPostBack="false" onclick="ServiceChk(this)" />
                                                           </td>
                                                           <td>
                                                               <asp:CheckBox   Enabled ="false" ID="chk_Supply" runat="server" CssClass="checkbox inline boldfontLeft" Text="Supply & Service Provider" AutoPostBack="false" onclick="SupplyChk(this)" />
                                                           </td>
                                                       </tr>
                                                       <tr>
                                                           <td colspan="6">
                                                    <div class="control-group" id="dvService" style="display: none;">
                                                <asp:Label ID="lbl_ForServiceProvider" class="control-label boldfontLeft" runat="server" Text="For Service Provider:"></asp:Label>
                                                <asp:Label ID="lblTypeofService" class="control-label boldfontLeft" runat="server" Text="Type Of Service"></asp:Label>
                                                <asp:TextBox  Enabled ="false" ID="txt_TypeofService" runat="server" class="span6 boldfontLeft" MaxLength="50"></asp:TextBox>
                                                                                                
                                            </div>
                                                           </td>
                                                   
                                                       </tr>
                                                       <tr>
                                                           <td>
                                                               <asp:Label ID="lblTitle" class="control-label " runat="server" Text="*" ForeColor="OrangeRed"></asp:Label>
                                                               <asp:Label ID="lbl_Title" class="control-label boldfontLeft" runat="server" Text="Title:"></asp:Label>
                                                           </td>
                                                           <td>
                                                               <asp:CheckBox   Enabled ="false" ID="chk_Public" runat="server" CssClass="checkbox inline boldfontLeft" Text="Company" onclick="PublicChk(this)" AutoPostBack="false" />
                                                           </td>
                                                           <td>
                                                               <asp:CheckBox   Enabled ="false" ID="chk_Part" runat="server" CssClass="checkbox inline boldfontLeft" Text="Partnership Firm" onclick="PartnerChk(this)" AutoPostBack="false" />
                                                           </td>
                                                           <td>
                                                               <asp:CheckBox   Enabled ="false" ID="chk_Prop" runat="server" CssClass="checkbox inline boldfontLeft" Text="Proprietorship Firm / Individual" onclick="ProprietorChk(this)" AutoPostBack="false" />
                                                           </td>
                                                           <td>
                                                               <asp:CheckBox   Enabled ="false" ID="chk_LLP" runat="server" CssClass="checkbox inline boldfontLeft" Text="LLP" onclick="LLP(this)" AutoPostBack="false" />
                                                           </td>
                                                       </tr>
                                                   </table>
                                                    
                                                            
                                                    
                                                    
                                                    
                                                    

                                                </div>
                                                <!-- /controls -->
                                            </div>
                                            <asp:HiddenField ID ="hf1" runat ="server" Value ="0"/>





                                            <div style="width: 100%; float: left; padding-top: 16px;">
                                                <div style="float: left; margin-right: 22px; margin-left: 7px; width :98.7%;">

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
                                                                    <asp:TextBox  Enabled ="false" ID="txtNameOffice" runat="server" class="span5" MaxLength="80"></asp:TextBox>
                                                                </td>
                                                                <%--<td>Premises No. </td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtPremiseOffice" runat="server" class="span5" MaxLength="10"></asp:TextBox>
                                                                </td>--%>
                                                                <td>Address Line -1  </td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtLine1Office" runat="server" class="span5" MaxLength="50"></asp:TextBox>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                
                                                                <td>Address Line -2 </td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtLine2Office" runat="server" class="span5" MaxLength="50"></asp:TextBox>
                                                                </td>
                                                                <td>Pin Code </td>
                                                                <td>

                                                                    <asp:DropDownList  Enabled ="false" ID="drpPinCode" runat="server" CssClass="span3"></asp:DropDownList>
                                                                </td>
                                                            </tr>

                                                                                                                        <tr>
                                                                
                                                                                                                                <td>State / Region</td>
                                                                <td>

                                                                    <asp:DropDownList  Enabled ="false" ID="drpStateOffice" runat="server" CssClass="span3"></asp:DropDownList>
                                                                </td>
                                                    <td>Country</td>
                                                                <td>

                                                                    <asp:DropDownList  Enabled ="false" ID="drpCountryOffice" runat="server" CssClass="span3"></asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                           
                                                            <tr>


                                                                                                                                <td>Phone No. </td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtLine3Office" runat="server" onkeypress="return validateQty2(event);" class="span3" MaxLength="12"></asp:TextBox>
                                                                </td>
                                                                                                                                <td>FAX No. </td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtFaxNoOffice" runat="server" onkeypress="return validateQty2(event);" class="span3" MaxLength="12"></asp:TextBox>
                                                                </td>
                                                            </tr>

                                                            <tr>


                                                                                                                                <td>Moble No. </td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtMobileNoOffice" runat="server" onkeypress="return validateQty2(event);" class="span3" MaxLength="10"></asp:TextBox>
                                                                </td>
                                                                                                                                 <td>Email Id </td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtEmailIDOffice" runat="server" class="span5" MaxLength="200"></asp:TextBox>
                                                                </td>
                                                            </tr>



                                                           

                                                           

                                                            <%--                                                    <tr>
                                                        <td>Other Address ?</td>
                                                        <td>
                                                            <asp:CheckBox   Enabled ="false" ID="HoAddressSameIsYes"  runat="server" AutoPostBack="false" onclick="IsSameAddressChecked(this)" />
                                                            
                                                            
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
                                                            <asp:TextBox  Enabled ="false" ID="txtNameWorkshop" runat="server"   class="span4" MaxLength="80"></asp:TextBox></td>
                                                    </tr>
                                                    <tr>

                                                        <td>
                                                            <asp:TextBox  Enabled ="false" ID="txtPremiseWorkshop" runat="server"  class="span4" MaxLength="10"></asp:TextBox></td>
                                                    </tr>
                                                    <tr>
                                                       
                                                        <td>
                                                            <asp:TextBox  Enabled ="false" ID="txtLine1Workshop" runat="server"  class="span4" MaxLength="200"></asp:TextBox></td>
                                                    </tr>
                                                    <tr>
                                                        
                                                        <td>
                                                            <asp:TextBox  Enabled ="false" ID="txtLine2Workshop" runat="server" class="span4"  MaxLength="200"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                     <tr>
                                                                
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtLine3Workshop" runat="server" class="span4"  onkeypress="return validateQty2(event);" MaxLength="12"></asp:TextBox></td>
                                                            </tr>
                                                    
                                                        <tr>
                                                                
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtFaxNoWorkshop" runat="server" class="span4"  onkeypress="return validateQty2(event);" MaxLength="12"></asp:TextBox></td>
                                                            </tr>
                                                     <tr>
                                                                
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtMobileNoWorkshop" runat="server" onkeypress="return validateQty2(event);" class="span4"  MaxLength="10"></asp:TextBox></td>
                                                            </tr>
                                                    <tr>
                                                                
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtEmailIDWorkShop" runat="server" class="span4" MaxLength="200" ></asp:TextBox></td>
                                                            </tr>
                                                    <tr>
                                                        
                                                        <td>

                                                            <asp:DropDownList  Enabled ="false" ID="drpCityWorkshop" runat="server" class="span4" ></asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                       
                                                        <td>

                                                            <asp:DropDownList  Enabled ="false" ID="drpStateWorkshop" runat="server" class="span4" ></asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                     <tr>
                                                      
                                                        <td>

                                                            <asp:DropDownList  Enabled ="false" ID="drpCountryWorkshop" runat="server" class="span4" ></asp:DropDownList>
                                                        </td>
                                                    </tr>

                                                   
                                                </tbody>
                                            </table>
                                                </div>
                                                    </div>--%>
                                            </div>
                                            <div class="form-actions">
                                                <button id="Button1" onclick="$('#<%=hf1.ClientID%>').val('1');  $('#lnk2').trigger('click'); " class="btn btn-primary" style="float: right;" type="button">Next</button>
                                            </div>
                                            <!-- /form-actions -->

                                        </div>

                                        <div class="tab-pane" id="ContactDetails">

                                            <div class="control-group">
                                                <asp:Label ID="Label1" class="control-label boldfontLeft" runat="server" Text="Web Site:"></asp:Label>
                                                <asp:TextBox  Enabled ="false" ID="txtURL" runat="server" class="span3" MaxLength="60"></asp:TextBox>
                                                <%--    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtURL" SetFocusOnError="true"
                                                    ErrorMessage="Invalid web URL!!" ForeColor="Red" ValidationExpression="(http(s)?://)?([\w-]+\.)+[\w-]+[.com]+(/[/?%&=]*)?" Display="None" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>--%>

                                                <asp:Label ID="Label2" class="control-label boldfontleft" runat="server" Text="Payment Term:"></asp:Label>
                                                <asp:DropDownList  Enabled ="false" ID="drp_PaymentTerm" runat="server" CssClass="span3 "></asp:DropDownList>
                                                <asp:Label ID="Label3" class="control-label boldfontleft" runat="server" Text="Total Strength of Manpower:"></asp:Label>
                                                <asp:TextBox  Enabled ="false" ID="txt_TotalStrengthofManpower" runat="server" class="span1" onkeypress="return validateQty2(event);" MaxLength="4"></asp:TextBox>
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
                                                    <asp:DropDownList  Enabled ="false" ID="drpShipmentTerm" runat="server">
                                                        <asp:ListItem Text="--Select Any one--" Value="0"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <!-- /controls -->
                                            </div>
                                             <asp:HiddenField ID ="hf2" runat ="server" Value ="0"/>
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
                                                            <asp:TextBox  Enabled ="false" ID="txtDirectName" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                        <td >
                                                            <asp:TextBox  Enabled ="false" ID="txtDirectPhone" runat="server" class="span2" MaxLength="12" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                            <%--  <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" ControlToValidate="txtDirectPhone" SetFocusOnError="true"
                                                                ErrorMessage="Invalid Proprietor / Director / Partner Phone No." ForeColor="Red" ValidationExpression="^\d+$" Display="None" ValidationGroup="FormValidate2">  </asp:RegularExpressionValidator>--%>
                                                        </td>
                                                        <td >
                                                            <asp:TextBox  Enabled ="false" ID="txtDirectMobile" runat="server" class="span2" MaxLength="10" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                            <%--  <asp:RegularExpressionValidator ID="RegularExpressionValidator11" runat="server" ControlToValidate="txtDirectMobile" SetFocusOnError="true"
                                                                ErrorMessage="Invalid Proprietor / Director / Partner Mobile No." ForeColor="Red" ValidationExpression="^\d{10}$" Display="None" ValidationGroup="FormValidate2">  </asp:RegularExpressionValidator>--%>
                                                        </td>
                                                        <td >
                                                            <asp:TextBox  Enabled ="false" ID="txtDirectEmail" runat="server" class="span2" MaxLength="50"></asp:TextBox>
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
                                                            <asp:TextBox  Enabled ="false" ID="txtSaleName" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                        <td>
                                                            <asp:TextBox  Enabled ="false" ID="txtSalePhone" runat="server" class="span2" MaxLength="12" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                            <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server" ControlToValidate="txtSalePhone" SetFocusOnError="true"
                                                                ErrorMessage="Invalid Sales Department Phone No." ForeColor="Red" ValidationExpression="^\d+$" Display="None" ValidationGroup="FormValidate2">  </asp:RegularExpressionValidator>--%>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox  Enabled ="false" ID="txtSaleMobile" runat="server" class="span2" MaxLength="10" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                            <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtSaleMobile" SetFocusOnError="true"
                                                                ErrorMessage="Invalid Sales Department Mobile No." ForeColor="Red" ValidationExpression="^\d{10}$" Display="None" ValidationGroup="FormValidate2">  </asp:RegularExpressionValidator>--%>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox  Enabled ="false" ID="txtSaleEmail" runat="server" class="span2" MaxLength="50"></asp:TextBox>
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
                                                            <asp:TextBox  Enabled ="false" ID="txtAccountName" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                        <td>
                                                            <asp:TextBox  Enabled ="false" ID="txtAccountPhone" runat="server" class="span2" MaxLength="12" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                            <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator12" runat="server" ControlToValidate="txtAccountPhone" SetFocusOnError="true"
                                                                ErrorMessage="Invalid Account Department Phone No." ForeColor="Red" ValidationExpression="^\d+$" Display="None" ValidationGroup="FormValidate2">  </asp:RegularExpressionValidator>--%>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox  Enabled ="false" ID="txtAccountMobile" runat="server" class="span2" MaxLength="10" onkeypress="return validateQty2(event);" onkeyup="sync(this)"></asp:TextBox>
                                                            <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtAccountMobile" SetFocusOnError="true"
                                                                ErrorMessage="Invalid Account Department Mobile No." ForeColor="Red" ValidationExpression="^\d{10}$" Display="None" ValidationGroup="FormValidate2">  </asp:RegularExpressionValidator>--%>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox  Enabled ="false" ID="txtAccountEmail" runat="server" class="span2" MaxLength="50"></asp:TextBox>
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
                                                <button id="Button8" onclick="$('#<%=hf2.ClientID%>').val('1');$('#lnk3').trigger('click');" class="btn btn-primary" style="float: right;" type="button">Next</button>
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
                                                            <%--<asp:TextBox  Enabled ="false" ID="txtYear1" runat="server" class="span2" MaxLength="4" onkeypress="return validateQty2(event);"></asp:TextBox>--%>
                                                            <asp:DropDownList  Enabled ="false" ID="drpYear1" runat="server"></asp:DropDownList>

                                                        </td>
                                                        <td style="text-align: center;">
                                                            <asp:TextBox  Enabled ="false" ID="txtAmount1" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator16" runat="server" ControlToValidate="txtAmount1" SetFocusOnError="true"
                                                                ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d+$" Display="None" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                        </td>

                                                    </tr>
                                                    <tr>

                                                        <td style="text-align: center;">
                                                            <asp:DropDownList  Enabled ="false" ID="drpYear2" runat="server"></asp:DropDownList>

                                                        </td>
                                                        <td style="text-align: center;">
                                                            <asp:TextBox  Enabled ="false" ID="txtAmount2" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator17" runat="server" ControlToValidate="txtAmount2" SetFocusOnError="true"
                                                                ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d+$" Display="None" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>

                                                        <td style="text-align: center;">
                                                            <asp:DropDownList  Enabled ="false" ID="drpYear3" runat="server"></asp:DropDownList>

                                                        </td>
                                                        <td style="text-align: center;">
                                                            <asp:TextBox  Enabled ="false" ID="txtAmount3" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
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
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustName1" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustLocation1" runat="server" class="span2" MaxLength="20"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustCnct1" runat="server" class="span2" MaxLength="30"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustNo1" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator19" runat="server" ControlToValidate="txtCustNo1" SetFocusOnError="true"
                                                                        ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d{10,15}$" Display="Dynamic" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>2 </td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustName2" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustLocation2" runat="server" class="span2" MaxLength="20"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustCnct2" runat="server" class="span2" MaxLength="30"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustNo2" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator20" runat="server" ControlToValidate="txtCustNo2" SetFocusOnError="true"
                                                                        ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d{10,15}$" Display="Dynamic" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>

                                                                <td>3 </td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustName3" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustLocation3" runat="server" class="span2" MaxLength="20"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustCnct3" runat="server" class="span2" MaxLength="30"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustNo3" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator21" runat="server" ControlToValidate="txtCustNo3" SetFocusOnError="true"
                                                                        ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d{10,15}$" Display="Dynamic" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>

                                                                <td>4 </td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustName4" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustLocation4" runat="server" class="span2" MaxLength="20"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustCnct4" runat="server" class="span2" MaxLength="30"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustNo4" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator22" runat="server" ControlToValidate="txtCustNo4" SetFocusOnError="true"
                                                                        ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d{10,15}$" Display="Dynamic" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>

                                                                <td>5 </td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustName5" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustLocation5" runat="server" class="span2" MaxLength="20"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustCnct5" runat="server" class="span2" MaxLength="30"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustNo5" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator23" runat="server" ControlToValidate="txtCustNo5" SetFocusOnError="true"
                                                                        ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d{10,15}$" Display="Dynamic" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>

                                                                <td>6 </td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustName6" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustLocation6" runat="server" class="span2" MaxLength="20"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustCnct6" runat="server" class="span2" MaxLength="30"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustNo6" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator24" runat="server" ControlToValidate="txtCustNo6" SetFocusOnError="true"
                                                                        ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d{10,15}$" Display="Dynamic" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>

                                                                <td>7 </td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustName7" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustLocation7" runat="server" class="span2" MaxLength="20"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustCnct7" runat="server" class="span2" MaxLength="30"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustNo7" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator25" runat="server" ControlToValidate="txtCustNo7" SetFocusOnError="true"
                                                                        ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d{10,15}$" Display="Dynamic" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>

                                                                <td>8 </td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustName8" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustLocation8" runat="server" class="span2" MaxLength="20"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustCnct8" runat="server" class="span2" MaxLength="30"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustNo8" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator26" runat="server" ControlToValidate="txtCustNo8" SetFocusOnError="true"
                                                                        ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d{10,15}$" Display="Dynamic" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>

                                                                <td>9 </td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustName9" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustLocation9" runat="server" class="span2" MaxLength="20"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustCnct9" runat="server" class="span2" MaxLength="30"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustNo9" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator27" runat="server" ControlToValidate="txtCustNo9" SetFocusOnError="true"
                                                                        ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d{10,15}$" Display="Dynamic" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>

                                                                <td>10 </td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustName10" runat="server" class="span2" MaxLength="50"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustLocation10" runat="server" class="span2" MaxLength="20"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustCnct10" runat="server" class="span2" MaxLength="30"></asp:TextBox></td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtCustNo10" runat="server" class="span2" MaxLength="15" onkeypress="return validateQty2(event);"></asp:TextBox>
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
                                                            <asp:TextBox  Enabled ="false" ID="txtCustomerName" MaxLength="100" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Location">
                                                        <ItemTemplate>
                                                            <asp:TextBox  Enabled ="false" ID="txtLocationName" MaxLength="100" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Contact Person Name">
                                                        <ItemTemplate>
                                                            <asp:TextBox  Enabled ="false" ID="txtContactPersonName" MaxLength="100" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Contact Person Number">
                                                        <ItemTemplate>
                                                            <asp:TextBox  Enabled ="false" ID="txtContactPersonNumber" MaxLength="15" onkeypress="return validateQty2(event);" runat="server"></asp:TextBox>
                                                        </ItemTemplate>

                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                             <asp:HiddenField ID ="hf3" runat ="server" Value ="0"/>


                                            <div class="form-actions">
                                                <button id="Button3" onclick="$('#lnk2').trigger('click');" class="btn btn-primary" style="float: left;" type="button">Previous</button>
                                                <button id="Button7" onclick="$('#<%=hf3.ClientID%>').val('1');$('#lnk4').trigger('click');" class="btn btn-primary" style="float: right;" type="button">Next</button>
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
                                                                    <asp:TextBox  Enabled ="false" ID="txtCST" runat="server" class="span2" onkeypress="return validateQty2(event);" MaxLength="15"></asp:TextBox></td>
                                                                <td>Vat / TIN No.</td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtVAT" runat="server" onkeypress="return validateQty2(event);" class="span2" MaxLength="11"></asp:TextBox></td>
                                                            </tr>

                                                            <tr>

                                                                <td>PAN No.</td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtPAN" runat="server" class="span2" MaxLength="10"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator29" runat="server" ControlToValidate="txtPAN" ViewStateMode="Disabled" SetFocusOnError="true"
                                                                        ErrorMessage="*" ForeColor="Red" ValidationExpression="[A-Z]{5}\d{4}[A-Z]{1}" Display="None" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                                </td>
                                                                <td>TAN No.</td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtTAN" runat="server" class="span2" MaxLength="10"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator30" runat="server" ControlToValidate="txtTAN" ViewStateMode="Disabled" SetFocusOnError="true"
                                                                        ErrorMessage="*" ForeColor="Red" ValidationExpression="[A-Z]{5}\d{4}[A-Z]{1}" Display="None" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                                </td>
                                                            </tr>


                                                            <tr>

                                                                <td>Micro, Small & Medium
                                                                    <br />
                                                                    Enterprise:</td>
                                                                <td>
                                                                    <asp:CheckBox   Enabled ="false" ID="chk_Yes" runat="server" CssClass="checkbox inline" Text="Yes" onclick="YesChk(this)" AutoPostBack="false" />
                                                                    <asp:CheckBox   Enabled ="false" ID="chk_No" runat="server" CssClass="checkbox inline" Text="No" onclick="NoChk(this)" AutoPostBack="false" />
                                                                </td>
                                                                <td>MSME Reg. No.</td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="TextBox100" runat="server" class="span2" MaxLength="30"></asp:TextBox></td>
                                                            </tr>

                                                            <tr>

                                                                <td>Registered With Excise?</td>
                                                                <td>
                                                                    <asp:CheckBox   Enabled ="false" ID="chk_reg_Yes" runat="server" CssClass="checkbox inline" Text="Yes" onclick="RegYesChk(this)" AutoPostBack="false" />
                                                                    <asp:CheckBox   Enabled ="false" ID="chk_reg_No" runat="server" CssClass="checkbox inline" Text="No" onclick="RegNoChk(this)" AutoPostBack="false" />
                                                                </td>
                                                                <td>ECC No</td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txt_ECCNo" runat="server" MaxLength="20" class="span2"></asp:TextBox></td>
                                                            </tr>

                                                            <tr>

                                                                <td>Excise Range</td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txt_ExciseRange" runat="server" MaxLength="20" class="span2"></asp:TextBox></td>
                                                                <td>Excise Division</td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txt_ExciseDivision" runat="server" MaxLength="20" class="span2"></asp:TextBox></td>


                                                            </tr>
                                                            <tr>
                                                                <td>Excise Collectorate</td>
                                                                <td >
                                                                    <asp:TextBox  Enabled ="false" ID="txt_ExciseCollectorate" runat="server" MaxLength="20" class="span2"></asp:TextBox></td>
                                                                <td>Service Tax Reg. No.</td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txt_ServiceTaxRegNo" runat="server" class="span2" MaxLength="15"></asp:TextBox></td>
                                                            </tr>
                                                                                                                        <tr>

                                                                <td>P.F.Reg. No.</td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txt_PFRegNo" runat="server" class="span2" MaxLength="15"></asp:TextBox></td>
                                                                                                                                <td>ESI Reg. No.</td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txt_ESIRegNo" runat="server" class="span2" MaxLength="20"></asp:TextBox></td>
                                                            </tr>
                                                            <tr>

                                                                <td>Contact License No.</td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txtContractLicenseNo" runat="server" class="span2" MaxLength="13"></asp:TextBox></td>
                                                                                                                                <td>TDS Applicability</td>
                                                                <td>
                                                                    <asp:CheckBox   Enabled ="false" ID="chk_TDS_yes" runat="server" CssClass="checkbox inline" Text="Yes" onclick="TDSYesChk(this)" AutoPostBack="false" />
                                                                    <asp:CheckBox   Enabled ="false" ID="chk_TDS_No" runat="server" CssClass="checkbox inline" Text="No" onclick="TDSNoChk(this)" AutoPostBack="false" />
                                                                    <asp:CheckBox   Enabled ="false" ID="chk_TDS_Lower" runat="server" CssClass="checkbox inline" Text="Lower Deduction" onclick="TDSLowerChk(this)" AutoPostBack="false" />
                                                                </td>
                                                            </tr>
                                                             <tr>
                                                                 <td colspan="2"></td>
                                                                <td>Lower Deduction Certi. No.</td>
                                                                <td>
                                                                    <asp:TextBox  Enabled ="false" ID="txt_LowerDeductionCertiNo" runat="server" class="span2" MaxLength="15"></asp:TextBox></td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                                 <asp:HiddenField ID ="hf4" runat ="server" Value ="0"/>
                                            
                                            <div class="form-actions" style="float: left; width: 96.5%;">
                                                <button id="Button4" onclick="$('#lnk3').trigger('click');" class="btn btn-primary" style="float: left;" type="button">Previous</button>
                                                <button id="Button6" onclick="$('#<%=hf4.ClientID%>').val('1'); $('#lnk5').trigger('click');" class="btn btn-primary" style="float: right;" type="button">Next</button>
                                            </div>

                                        </div>

                                        <div class="tab-pane" id="BankDetails">

                                            <table class="table table-striped table-bordered">

                                                <tbody>
                                                    <tr>

                                                        <td>Bank Name </td>
                                                        <td>
                                                            <asp:TextBox  Enabled ="false" ID="txtBankName" runat="server" class="span4" MaxLength="60"></asp:TextBox></td>

                                                    </tr>
                                                    <tr>

                                                        <td>Bank Branch Name</td>
                                                        <td>
                                                            <asp:TextBox  Enabled ="false" ID="txtBAnkBrnch" runat="server" class="span4" MaxLength="20"></asp:TextBox></td>
                                                    </tr>
                                                    <tr>

                                                        <td>Bank A/c No</td>
                                                        <td>
                                                            <asp:TextBox  Enabled ="false" ID="txtAcntNo" runat="server" class="span4" MaxLength="20" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator35" runat="server" ControlToValidate="txtAcntNo" SetFocusOnError="true"
                                                                ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d+$" Display="None" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>

                                                        <td>Type of A/c</td>
                                                        <td>
                                                            <asp:CheckBox   Enabled ="false" ID="chk_TypeofSa" runat="server" CssClass="checkbox inline" Text="Savings" />
                                                            <asp:CheckBox   Enabled ="false" ID="chk_TypeofCur" runat="server" CssClass="checkbox inline" Text="Current" />
                                                            <asp:CheckBox   Enabled ="false" ID="chk_TypeofCC" runat="server" CssClass="checkbox inline" Text="C.C." />
                                                        </td>
                                                    </tr>
                                                    <tr>

                                                        <td>IFSC Code (11 Digit)</td>
                                                        <td>
                                                            <asp:TextBox  Enabled ="false" ID="txtIFSC" runat="server" class="span4" MaxLength="11"></asp:TextBox>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator32" runat="server" ControlToValidate="txtIFSC" ViewStateMode="Disabled" SetFocusOnError="true"
                                                                ErrorMessage="*" ForeColor="Red" ValidationExpression="[A-Z]{4}[0]{1}\d{6}" Display="None" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                        </td>
                                                    </tr>

                                                    <tr>

                                                        <td>Email ID (For Mailing payment UTR No Details)</td>
                                                        <td>
                                                            <asp:TextBox  Enabled ="false" ID="txtEmailUTR" runat="server" class="span4"></asp:TextBox>
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
                                                            <asp:TextBox  Enabled ="false" ID="txtMobileUTR" runat="server" class="span4" MaxLength="10" onkeypress="return validateQty2(event);"></asp:TextBox>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator34" runat="server" ControlToValidate="txtMobileUTR" SetFocusOnError="true"
                                                                ErrorMessage="*" ForeColor="Red" ValidationExpression="^\d{10}$" Display="Dynamic" ValidationGroup="FormValidate">  </asp:RegularExpressionValidator>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                             <asp:HiddenField ID ="hf5" runat ="server" Value ="0"/>

                                            <div class="form-actions">
                                                <button id="Button5" onclick=" $('#lnk4').trigger('click');" class="btn btn-primary" style="float: left;" type="button">Previous</button>
                                                <button id="Button10" onclick="$('#<%=hf5.ClientID%>').val('1'); $('#lnk6').trigger('click');" class="btn btn-primary" style="float: right;" type="button">Next</button>
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
                                                            <asp:DropDownList  Enabled ="false" ID="VendorNoSeries" runat="server"></asp:DropDownList>
                                                        </td>
                                                         <td>Tax Liable </td>
                                                        <td>
                                                            <asp:CheckBox   Enabled ="false" ID="chk_TaxLiable" runat="server" Checked="true" />
                                                        </td>
                                                    </tr>
                                                    
                                                    <tr>
                                                        <td>Gen. Bus. Posting Group</td>
                                                        <td>
                                                            <asp:DropDownList  Enabled ="false" ID="drpGenBusPostingGroup" runat="server"></asp:DropDownList>
                                                        </td>
                                                        <td>Vendor Posting Group
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList  Enabled ="false" ID="drpVendorPostingGroup" runat="server"></asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>VAT Bus. Posting Group</td>
                                                        <td>
                                                            <asp:DropDownList  Enabled ="false" ID="drpVATBusPostingGroup" runat="server"></asp:DropDownList>
                                                        </td>
                                                        <td>Currency Code:</td>
                                                        <td>
                                                            <asp:DropDownList  Enabled ="false" ID="drpCurrencyCode" runat="server"></asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>

                                                        <td>Service Entity Type</td>
                                                        <td>
                                                            <asp:DropDownList  Enabled ="false" ID="drpServiceEntityType" runat="server"></asp:DropDownList>
                                                        </td>
                                                        <td>Authorised by:</td>
                                                        <td>
                                                            <asp:DropDownList  Enabled ="false" ID="drpAuthorisedby" runat="server"></asp:DropDownList>
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                       
                                                        <td>Excise Bus. Posting Group
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList  Enabled ="false" ID="drpExcisePostingGroup" runat="server"></asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                           
                                            <div class="form-actions">
                                                <button id="Button9" onclick=" $('#lnk5').trigger('click');" class="btn btn-primary" style="float: left;" type="button">Previous</button>
                                               <%--<asp:Button  ID ="btnFeedback" runat ="server" CssClass ="btn btn-warning" style ="float: right;margin-left: 9px;" Text ="Feedback" CausesValidation ="false" OnClick ="btnFeedback_Click"/>--%>
                                                <asp:Button  ID ="btnapprv" runat ="server" CssClass ="btn btn-success apprv" Text ="Approve" CausesValidation ="false" OnClick ="btnapprv_Click"/>
                                                <%--<button id="Buttonnew" class="btn btn-success apprv"  runat="server" onserverclick ="Buttonnew_ServerClick" >Approve<i class="btn-icon-only icon-ok"></i></button>--%>

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
         

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
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
</script>

</asp:Content>

