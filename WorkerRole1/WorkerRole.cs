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

//In this WorkerRole there isn't a lot of database functionality but there is at the bottom to save everything for bookings to the NoSQL database.
//I know it wasn't mandatory for grade 3 but I felt that I had a lot of SQL in the other WorkerRole and that's why I wanted to add some NoSQL in this one.

namespace WorkerHRS
{
    public class WorkerRoleHRS : RoleEntryPoint
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
        private double price;

        


        //the following method is called at the start of the worker role to get instances of incoming and outgoing queues 
        private void initQueue()
        {
            creds = new StorageCredentials(accountName, accountKey);
            storageAccount = new CloudStorageAccount(creds, useHttps: true);
            //conn = new SqlConnection("Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=andreDB;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False");

            // Create the queue client
            queueClient = storageAccount.CreateCloudQueueClient();

            // Retrieve a reference to a queue
            inqueue = queueClient.GetQueueReference("crsqueue");

            // Create the queue if it doesn't already exist
            inqueue.CreateIfNotExists();

            // Retrieve a reference to a queue
            outqueue = queueClient.GetQueueReference("calculate2");

            // Create the queue if it doesn't already exist
            outqueue.CreateIfNotExists();
        }

        public override void Run()
        {
            Trace.TraceInformation("WorkerCRS is running");

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

            Trace.TraceInformation("WorkerCRS has been started");

            return result;
        }

        public override void OnStop()
        {
            Trace.TraceInformation("WorkerCRS is stopping");

            this.cancellationTokenSource.Cancel();
            this.runCompleteEvent.WaitOne();

            base.OnStop();

            Trace.TraceInformation("WorkerCRS has stopped");
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

                    Console.WriteLine("Retrieved message with content '{0}'", inMessage.AsString);

                    string s = inMessage.AsString;

                    Trace.TraceInformation("***** Worker Received " + s);

                    applicationLogic(s);

                    await inqueue.DeleteMessageAsync(inMessage);

                    outMessage = new CloudQueueMessage(price.ToString());
                    outqueue.AddMessage(outMessage);
                }

                Trace.TraceInformation("Working");
                await Task.Delay(1000);
            }
        }
        private void applicationLogic(string s)
        {
            string[] info = s.Split('*');
            int travellers = int.Parse(info[0]);
            int nights = int.Parse(info[1]);
            int seniors = int.Parse(info[2]);
            bool singleRoom, doubleRoom;

            

            if (info[4] == "True")
            {
                singleRoom = true;
            }
            else
            {
                singleRoom = false;
            }
            if (info[5] == "True")
            {
                doubleRoom = true;
            }
            else
            {
                doubleRoom = false;
            }
            calPrice(travellers, nights, seniors, singleRoom, doubleRoom);
        }

        private void calPrice(int travellers, int nights, int seniors, bool singleRoom, bool doubleRoom)
        {
            MongoClient dbClient = new MongoClient(connectionString);
            var database = dbClient.GetDatabase("andreMongo");
            var bookingsTable = database.GetCollection<BsonDocument>("Bookings");
            var bookDoc = new BsonDocument
            {
                {"travellers", travellers },
                {"nights", nights },
                {"seniors", seniors },
                {"singleRoom", singleRoom },
                {"doubleRoom", doubleRoom }
            };

            bookingsTable.InsertOneAsync(bookDoc);

            price = 0.0;
            double srPrice = 0.0;

            if (singleRoom == true)
            {
                price = 600 * nights;
            }
            else if (doubleRoom == true)
            {
                price = 900 * nights;
            }
            else
            {
                price = 0;
            }

            srPrice = srPrice + price;
            travellers = travellers - seniors;
            price = price * travellers;
            srPrice = (srPrice * seniors) * 0.5;
            price = price + srPrice;
        }
    }
}

