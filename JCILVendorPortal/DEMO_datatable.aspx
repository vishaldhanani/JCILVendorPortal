<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/VMaster.Master" CodeFile="DEMO_datatable.aspx.cs" Inherits="JCILVendorPortal.DEMO_datatable" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        var currentRowId = 0;
        function MarkRow(rowId) {
            if (document.getElementById(rowId) == null)
                return;
            if (document.getElementById(currentRowId) != null)
                document.getElementById(currentRowId).style.backgroundColor = '#ffffff';
            currentRowId = rowId;
            document.getElementById(rowId).style.backgroundColor = '#ff0000';
        }
        function SelectRow() {
            if (event.keyCode == 40)
                MarkRow(currentRowId + 1);
            else if (event.keyCode == 38)
                MarkRow(currentRowId - 1);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
            DataKeyNames="CategoryID" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="CategoryID"
                    InsertVisible="False" ReadOnly="True" SortExpression="CategoryID" />
                <asp:BoundField DataField="VendorCode" HeaderText="CategoryName"
                    SortExpression="CategoryName" />
                <asp:BoundField DataField="Last_date_modified" HeaderText="Description"
                    SortExpression="Description" />
                <asp:BoundField DataField="TypeOfBusiness" HeaderText="CategoryID"
                    InsertVisible="False" ReadOnly="True" SortExpression="CategoryID" />
                <asp:BoundField DataField="VendorName_HO" HeaderText="CategoryName"
                    SortExpression="CategoryName" />
                <asp:BoundField DataField="Title" HeaderText="Description"
                    SortExpression="Description" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
