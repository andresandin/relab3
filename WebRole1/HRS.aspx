<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HRS.aspx.cs" Inherits="WebRole.HRS" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>HRS</title>
</head>
<body style="height: 435px">
    <form id="form1" runat="server">
        <h1>Hotel Reservation Service</h1>
        <div style="height: 407px">
            <asp:Label ID="Label1" runat="server" Text="Number of Travellers: "></asp:Label> 
            <asp:Textbox ID="TxtTravellers" runat="server" Text="" Width="95px"></asp:Textbox>
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" Text="Number of Nights: "></asp:Label> 
            <asp:Textbox ID="TxtNights" runat="server" Text="" Width="75px" Height="21px"></asp:Textbox>
            <br />
            <br />
            <asp:Label ID="Label3" runat="server" Text="Number of Seniors: "></asp:Label> 
            <asp:Textbox ID="TxtSeniors" runat="server" Text="" Width="75px"  Height="21px"></asp:Textbox>
            <br />
            <br />
            <asp:Label ID="Label4" runat="server" Text="Name of primary guest: "></asp:Label> 
            <asp:Textbox ID="TxtPrimaryGuest" runat="server" Text="" Width="75px"  Height="21px"></asp:Textbox>
            <br />
            <br />
            <asp:Checkbox ID="CheckSingle" Text="Single" runat="server" />
            <asp:Checkbox ID="CheckDouble" Text="Double" runat="server" />
            
            <br />
            <asp:Button ID="BtnCalc" runat="server" Text="Continue" Width="154px" Height="48px" OnClick="BtnCalculate"></asp:Button>
            <asp:Button ID="BtnCanc" runat="server" Text="Cancel" Width="154px" Height="48px" OnClick="BtnCancel"></asp:Button>
            <br />
            <br />
            <asp:Button ID="ReportButton" runat="server" Text="View Reports" Width="306px" Height="45px" OnClick="BtnReport"></asp:Button>
            <%--<asp:Label ID="Label5" runat="server" Text="Calculated price: "></asp:Label> 
            <asp:Textbox ID="TxtPrice" runat="server" Text="" Width="306px" ></asp:Textbox>--%>
            <br />
            <br />
            <%--<asp:Button ID="BtnCont" runat="server" Text="Continue" Width="154px" BackColor="#CCFFFF" ForeColor="#FF3300" Height="48px" OnClick="BtnContinue"></asp:Button>
            <asp:Button ID="BtnCanc" runat="server" Text="Cancel" Width="154px" BackColor="#CCFFFF" ForeColor="#FF3300" Height="48px" OnClick="BtnCancel"></asp:Button>--%>
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp&nbsp&nbsp

            <br />
            
            </div>
    </form>
</body>
</html>
