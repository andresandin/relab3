using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.WindowsAzure;
using Microsoft.WindowsAzure.Diagnostics;
using Microsoft.WindowsAzure.ServiceRuntime;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Auth;
using Microsoft.WindowsAzure.Storage.Queue;
using System.Data.SqlClient;
using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Driver;

//This is the WorkerRole for Flight Reservation Service, here everything is included such as queues and both databases.
//It is mostly SQL but at the bottom there is a insert for MongoDB 

namespace WorkerFRS
{
    public class WorkerRoleFRS : RoleEntryPoint
    {
        private readonly CancellationTokenSource cancellationTokenSource = new CancellationTokenSource();
        private readonly ManualResetEvent runCompleteEvent = new ManualResetEvent(false);

        private string accountName = "andrelabb";
        private string accountKey = "imhUePXWW0g1J301jU4clmbMbglQ/BvcSGUmBMtzI3HuwcMQnnogxMnhiHVOvKxgObr4Le5PYPHkhT7n7vCg4g==";
        private string connectionString = "mongodb+srv://andreuser:andrepw@andrecluster-fboow.azure.mongodb.net/test";
        private StorageCredentials creds;
        private CloudStorageAccount storageAccount;
        private CloudQueueClient queueClient;
        private CloudQueue inqueue, outqueue;
        private CloudQueueMessage inMessage, outMessage;
        private SqlConnection conn;
        SqlCommand sqlCommand;
        SqlDataReader sqlReader;
        //the following method is called at the start of the worker role to get instances of incoming and outgoing queues 
        private void initQueue()
        {
            creds = new StorageCredentials(accountName, accountKey);
            storageAccount = new CloudStorageAccount(creds, useHttps: true);
            conn = new SqlConnection("Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=andreDB;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False");


            // Create the queue client
            queueClient = storageAccount.CreateCloudQueueClient();

            // Retrieve a reference to a queue
            inqueue = queueClient.GetQueueReference("frsqueue");

            // Create the queue if it doesn't already exist
            inqueue.CreateIfNotExists();

            // Retrieve a reference to a queue
            outqueue = queueClient.GetQueueReference("calculate1");

            // Create the queue if it doesn't already exist
            outqueue.CreateIfNotExists();
        }

        public override void Run()
        {
            Trace.TraceInformation("WorkerFRS is running");

            try
            {
                this.RunAsync(this.cancellationTokenSource.Token).Wait();
            }
            finally
            {
                this.runCompleteEvent.Set();
            }
        }

        public override bool OnStart()
        {
            ServicePointManager.DefaultConnectionLimit = 12;

            bool result = base.OnStart();

            Trace.TraceInformation("WorkerFRS has been started");

            return result;
        }

        public override void OnStop()
        {
            Trace.TraceInformation("WorkerFRS is stopping");

            this.cancellationTokenSource.Cancel();
            this.runCompleteEvent.WaitOne();

            base.OnStop();

            Trace.TraceInformation("WorkerFRS has stopped");
        }

        private async Task RunAsync(CancellationToken cancellationToken)
        {
            initQueue();
            while (!cancellationToken.IsCancellationRequested)
            {

                inMessage = null;
                inMessage = await inqueue.GetMessageAsync();

                if (inMessage != null)
                {

                    string input = inMessage.AsString;
                    string pattern = @"\s-\s?[+*]?\s?-\s";
                    string[] elements = System.Text.RegularExpressions.Regex.Split(input, pattern);

                    //Variables from Frs Queue here:
                    string desFrom = elements[0];
                    string desTo = elements[1];
                    int passport = int.Parse(elements[2]);
                    int infants = int.Parse(elements[2]);
                    int children = int.Parse(elements[3]);
                    int adults = int.Parse(elements[4]);
                    int seniors = int.Parse(elements[5]);
                    string name = elements[6];
                    
                    conn.Open();

                    sqlCommand = new SqlCommand(@"SELECT Latitude FROM dbo.Airports WHERE AirportCode = '" + desFrom + "'", conn);
                    sqlReader = sqlCommand.ExecuteReader();
                    double fromLatSql = 0;
                    if (sqlReader.HasRows)
                    {
                        while (sqlReader.Read())
                        {
                           fromLatSql = Convert.ToDouble(sqlReader.GetString(0));
                           Debug.WriteLine("RDR: " + sqlReader.GetString(0));

                        }
                    }

                    conn.Close();

                    conn.Open();
                    sqlCommand = new SqlCommand(@"SELECT Longitude FROM dbo.Airports WHERE AirportCode = '" + desFrom + "'", conn);
                    sqlReader = sqlCommand.ExecuteReader();
                    double fromLongSql = 0;
                    if (sqlReader.HasRows)
                    {
                        while (sqlReader.Read())
                        {
                            fromLongSql = Convert.ToDouble(sqlReader.GetString(0));
                            Debug.WriteLine("RDR: " + sqlReader.GetString(0));

                        }
                    }

                    conn.Close();

                    conn.Open();
                    sqlCommand = new SqlCommand(@"SELECT Latitude FROM dbo.Airports WHERE AirportCode = '" + desTo + "'", conn);
                    sqlReader = sqlCommand.ExecuteReader();
                    double toLatSql = 0;
                    if (sqlReader.HasRows)
                    {
                        while (sqlReader.Read())
                        {
                            toLatSql = Convert.ToDouble(sqlReader.GetString(0));
                            Debug.WriteLine("RDR: " + sqlReader.GetString(0));
                        }
                    }


                    conn.Close();

                    conn.Open();
                    sqlCommand = new SqlCommand("SELECT longitude FROM dbo.Airports WHERE airportCode = '" + desTo + "'", conn);
                    sqlReader = sqlCommand.ExecuteReader();
                    double toLongSql = 0;
                    if (sqlReader.HasRows)
                    {
                        while (sqlReader.Read())
                        {
                            toLongSql = Convert.ToDouble(sqlReader.GetString(0));
                            Debug.WriteLine("RDR: " + sqlReader.GetString(0));

                        }
                    }

                    conn.Close();
 
                    //This is where the business logic starts

                    double latFrom = fromLatSql;
                    double latTo = toLatSql;
                    double longFrom = fromLongSql;
                    double longTo = toLongSql;
                    double latFromRad = 0;
                    double longFromRad = 0;
                    double latToRad = 0;
                    double longToRad = 0;
                    double baseRate = 0;
                    int airlinecode = 0;

                    
                    if (desFrom.Equals("sto"))
                    {
                        baseRate = 0.234;
                        airlinecode = 1;
                    }
                    else if (desFrom.Equals("cph"))
                    {

                        baseRate = 0.2554;
                        airlinecode = 2;
                    }
                    else if (desFrom.Equals("cdg"))
                    {

                        baseRate = 0.2255;
                        airlinecode = 3;
                    }
                    else if (desFrom.Equals("lhr"))
                    {
                        baseRate = 0.2300;
                        airlinecode = 4;
                    }
                    else if (desFrom.Equals("fra"))
                    {
                        baseRate = 0.2400;
                        airlinecode = 5;
                    }

                    latFromRad = (latFrom * Math.PI) / 180;
                    longFromRad = (longFrom * Math.PI) / 180;
                    latToRad = (latTo * Math.PI) / 180;
                    longToRad = (longTo * Math.PI) / 180;

                    double dlon = longFromRad - longToRad;
                    double dlat = latFromRad - latToRad;
                    double a = Math.Pow(Math.Sin(dlat / 2), 2) + Math.Cos(latToRad) * Math.Cos(latFromRad) * Math.Pow(Math.Sin(dlon / 2), 2);
                    double c = 2 * Math.Asin(Math.Sqrt(a));
                    //Kilometers
                    double km = 6371;
                    //Distance
                    double distance = (c * km);

                    double initialFare = baseRate * distance; 
                    double totalFare = 0;
                    for (int i = 0; i < infants; i++) { 
                        totalFare += initialFare * (1 - 0.90); 
                    }
                    for (int i = 0; i < children; i++) { 
                        totalFare += initialFare * (1 - 0.33);
                    }
                    for (int i = 0; i < seniors; i++) { 
                        totalFare += initialFare * (1 - 0.25); 
                    }
                    for (int i = 0; i < adults; i++) { 
                        totalFare += initialFare * 1; 
                    }
                 
                    await inqueue.DeleteMessageAsync(inMessage);

                    string sendFare = totalFare.ToString();
                    string date = DateTime.Now.ToString();

                    //Insert to SQL database
                    conn.Open();
                    sqlCommand = new SqlCommand(@"INSERT INTO dbo.Flights (PassengerName, PassportNumber, FlightNumber, DepartureDate, AirFare)
                                  VALUES (@PassengerName, @PassportNumber, @FlightNumber, @DepartureDate, @AirFare)", conn);
                    sqlCommand.Parameters.Add(new SqlParameter("PassengerName", name));
                    sqlCommand.Parameters.Add(new SqlParameter("PassportNumber", passport));
                    sqlCommand.Parameters.Add(new SqlParameter("FlightNumber", airlinecode));
                    sqlCommand.Parameters.Add(new SqlParameter("DepartureDate", date));
                    sqlCommand.Parameters.Add(new SqlParameter("AirFare", sendFare));
               
                    sqlCommand.ExecuteNonQuery();
                    conn.Close();

                    //Insert to MongoDB(NoSQL)
                    MongoClient dbClient = new MongoClient(connectionString);
                    var database = dbClient.GetDatabase("andreMongo");
                    var flightsTable = database.GetCollection<BsonDocument>("Flights");
                    var flightDoc = new BsonDocument
           
                    {
                        {"PassengerName", name },
                        {"PassportNumber", passport },
                        {"FlightNumber", airlinecode },
                        {"DepartureDate", date },
                        {"AirFare", sendFare }
                    };
                    flightsTable.InsertOneAsync(flightDoc);

                    outMessage = new CloudQueueMessage(sendFare);
                    outqueue.AddMessage(outMessage);
                }

                Trace.TraceInformation("Working");
                await Task.Delay(1000);

            }
        }
    }
}

