<%@ Page Title="" Language="C#"  AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="WebRole.Payment" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>HRS</title>
</head>
<body style="height: 435px">
    <form id="form1" runat="server">
        <h1>Payment Service</h1>
        <div style="height: 407px">
        <asp:Label ID="LabelCreditCard" runat="server" Text="Your credit card: "></asp:Label>
        <br />
        <asp:Textbox ID="TxtCreditCard" runat="server" Text="" Width="306px"></asp:Textbox>

        <br />

        <asp:Label ID="LabelHolderName" runat="server" Text="Your name: "></asp:Label>
        <br />
        <asp:Textbox ID="TxtHolderName" runat="server" Text="" Width="306px"></asp:Textbox>

        <br />

        <asp:Label ID="LabelTotalCost" runat="server" Text=""></asp:Label>
        <br />

        <br />
        <br />

        <asp:Button ID="offerButton" runat="server" Text="Get Offer" Width="306px" Height="45px" OnClick="BtnOffer"></asp:Button> 
        <asp:Button ID="payButton" runat="server" Text="Pay" Width="306px" Height="45px" OnClick="BtnPay"></asp:Button> 



    </div>

 </form>
</body>
</html>