<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="FRS.aspx.cs" Inherits="WebRole.FRS" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reports</title>
    </head>
    <body style="height: 435px">
    <form id="form1" runat="server">
        <h1>Flight Reservation</h1>
    <div>

        
         <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" DataKeyNames="AirportCode">
                <Columns>
                    <asp:BoundField DataField="AirportCode" HeaderText="AirportCode" SortExpression="AirportCode" ReadOnly="True" />
                    <asp:BoundField DataField="AirportCity" HeaderText="AirportCity" SortExpression="AirportCity" />
                    <asp:BoundField DataField="Latitude" HeaderText="Latitude" SortExpression="Latitude" />
                    <asp:BoundField DataField="Longitude" HeaderText="Longitude" SortExpression="Longitude" />
                </Columns>
            </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:andreDBConnectionString1 %>" SelectCommand="SELECT [AirportCode], [AirportCity], [Latitude], [Longitude] FROM [Airports]"></asp:SqlDataSource>
        <br />
        <asp:Label ID="LabelFrom" runat="server" Text="From: "></asp:Label>
        <asp:RadioButtonList ID="RadioFrom" runat="server">
            <asp:ListItem Text="sto" value="sto"></asp:ListItem>
            <asp:ListItem Text="cph" Value="cph" ></asp:ListItem>
            <asp:ListItem Text="cdg" Value="cdg" ></asp:ListItem>
            <asp:ListItem Text="lhr" Value="lhr" ></asp:ListItem>
            <asp:ListItem Text="fra" Value="fra" ></asp:ListItem>
        </asp:RadioButtonList>
        <asp:Label ID="LabelTo" runat="server" Text="To: "></asp:Label>
        <asp:RadioButtonList ID="RadioTo" runat="server">
            <asp:ListItem Text="sto" Value="sto"></asp:ListItem>
            <asp:ListItem Text="cph" Value="cph" ></asp:ListItem>
            <asp:ListItem Text="cdg" Value="cdg" ></asp:ListItem>
            <asp:ListItem Text="lhr" Value="lhr" ></asp:ListItem>
            <asp:ListItem Text="fra" Value="fra" ></asp:ListItem>
        </asp:RadioButtonList>
        <br />

        <p>Enter number of passengers below: </p>

        Infant(&lt;2)&nbsp;&nbsp;&nbsp; Children(&lt;13)&nbsp;&nbsp; Adults&nbsp;&nbsp;&nbsp;&nbsp; Seniors(&gt;65)<br />
            <asp:Textbox ID="TxtInfants" runat="server" Text="" Width="66px" ></asp:Textbox>
             <asp:Textbox ID="TxtChildren" runat="server" Text="" Width="84px" ></asp:Textbox>
             <asp:Textbox ID="TxtAdults" runat="server" Text="" Width="57px" ></asp:Textbox>
             <asp:Textbox ID="TxtSeniors" runat="server" Text="" Width="78px" ></asp:Textbox>

        <br />
        <br />
        Name:
        <br />
        <asp:Textbox ID="TxtCustomer" runat="server" Text="" Width="78px" ></asp:Textbox>

        <br />
        <br />

        <asp:Button ID="FrsBttnContinue" runat="server" Text="Continue" Width="306px" Height="45px" OnClick="BtnContinue"></asp:Button> 
       
        <asp:Button ID="FrsBtnCancel" runat="server" Text="Cancel" Width="306px" Height="45px" OnClick="BtnCancel"></asp:Button>
        <br />
        <asp:Button ID="ReportButton" runat="server" Text="View Reports" Width="306px" Height="45px" OnClick="BtnReport"></asp:Button>
        
    </div>
 </form>
</body>
</html>
