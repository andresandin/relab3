<%@ Page Title="" Language="C#"  AutoEventWireup="true" CodeBehind="Last.aspx.cs" Inherits="WebRole.Last" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>HRS</title>
</head>
<body style="height: 435px">
    <form id="form1" runat="server">
        <h1>Payment Done!</h1>
        <div style="height: 407px">

        <asp:Label ID="LabelName" runat="server" Text=""></asp:Label>
        <br />
        <br />
        <asp:Label ID="LabelCost" runat="server" Text=""></asp:Label>

        <br />
        <asp:Button ID="ReportButton" runat="server" Text="View Reports" Width="306px" Height="45px" OnClick="BtnReport"></asp:Button> 
       </div>
    </form>
</body>
</html>

