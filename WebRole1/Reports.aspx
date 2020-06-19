<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="WebRole.Reports" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reports</title>
    </head>
    <body style="height: 435px">
    <form id="form1" runat="server">
        <h1>Reports</h1>
    <div>

        <asp:GridView ID="GridAirport" runat="server" AutoGenerateColumns="False" DataSourceID="AirportsSource">
                <Columns>
                    <asp:BoundField DataField="AirportCode" HeaderText="Airport Code" SortExpression="AirportCode" />
                    <asp:BoundField DataField="AirportCity" HeaderText="Airport City" SortExpression="AirportCity" />
                    <asp:BoundField DataField="Latitude" HeaderText="Latitude" SortExpression="Latitude" />
                    <asp:BoundField DataField="Longitude" HeaderText="Longitude" SortExpression="Longitude" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="AirportsSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectAirports %>" SelectCommand="SELECT * FROM [Airports]"></asp:SqlDataSource>
        
        <asp:GridView ID="GridAirlines" runat="server" AutoGenerateColumns="False" DataSourceID="AirlinesSource" DataKeyNames="airlineCode">
                <Columns>
                    <asp:BoundField DataField="airlineCode" HeaderText="Airline Code" SortExpression="airlineCode" ReadOnly="True" />
                    <asp:BoundField DataField="airlineName" HeaderText="Airline Name" SortExpression="airlineName" />
                </Columns>
            </asp:GridView>
            
        <asp:SqlDataSource ID="AirlinesSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectAirlines %>" SelectCommand="SELECT * FROM [Airlines]"></asp:SqlDataSource>
        <asp:GridView ID="GridRoutes" runat="server" AutoGenerateColumns="False" DataSourceID="RoutesSource" DataKeyNames="flightNumber">
                <Columns>
                    <asp:BoundField DataField="flightNumber" HeaderText="Flight Number" SortExpression="flightNumber" ReadOnly="True" />
                    <asp:BoundField DataField="airlineCarrier" HeaderText="Airline Carrier" SortExpression="airlineCarrier" />
                    <asp:BoundField DataField="departureAirport" HeaderText="Departure Airport" SortExpression="departureAirport" />
                    <asp:BoundField DataField="arrivalAirport" HeaderText="Arrival Airport" SortExpression="arrivalAirport" />
                </Columns>
            </asp:GridView>
          
        <asp:SqlDataSource ID="RoutesSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectRoutes %>" SelectCommand="SELECT * FROM [Routes]"></asp:SqlDataSource>

        <asp:GridView ID="GridFlights" runat="server" AutoGenerateColumns="False" DataSourceID="FlightsSource" DataKeyNames="passengerName">
                <Columns>
                    <asp:BoundField DataField="passengerName" HeaderText="Passenger Name" SortExpression="passengerName" ReadOnly="True" />
                    <asp:BoundField DataField="passportNumber" HeaderText="Passport Number" SortExpression="passportNumber" />
                    <asp:BoundField DataField="flightNumber" HeaderText="Flight Number" SortExpression="flightNumber" />
                    <asp:BoundField DataField="departureDate" HeaderText="Departure Date" SortExpression="departureDate" />
                    <asp:BoundField DataField="airFare" HeaderText="Airfare" SortExpression="airFare" />
                    
                </Columns>
            </asp:GridView>
     
        <asp:SqlDataSource ID="FlightsSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectFlights %>" SelectCommand="SELECT * FROM [Flights]"></asp:SqlDataSource>
            
        <asp:Label ID="CustomerLabel" runat="server" Text=""></asp:Label>
        <asp:Label ID="TransactionLabel" runat="server" Text=""></asp:Label>

    </div>
          </form>
</body>
</html>
