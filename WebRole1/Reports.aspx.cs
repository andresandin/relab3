using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Driver;

//This is the report page that shows the information saved in the databases, both the SQL and NoSQL.
//The SQL part can be seen in the Reports.aspx.

namespace WebRole
{
    public partial class Reports : System.Web.UI.Page
    {
        private readonly string connectionString = "mongodb+srv://andreuser:andrepw@andrecluster-fboow.azure.mongodb.net/test";

        protected void Page_Load(object sender, EventArgs e)
        {
            MongoClient dbClient = new MongoClient(connectionString);
            var database = dbClient.GetDatabase("andreMongo");
            var getCustomer = database.GetCollection<BsonDocument>("Customer");
            var getTransactions = database.GetCollection<BsonDocument>("Transactions");
            var customerDoc = getCustomer.Find(new BsonDocument()).FirstOrDefault();
            var transactionDoc = getTransactions.Find(new BsonDocument()).FirstOrDefault();

            CustomerLabel.Text = customerDoc.ToString();
            TransactionLabel.Text = transactionDoc.ToString();
        }


    }
}