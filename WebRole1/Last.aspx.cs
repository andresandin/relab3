using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

//This is just the last page that shows the customer that the payment is successfully done.
//From here the full Report can be shown by clicking the button "View Reports" where both information from the SQL and NoSQL database will be shown.

namespace WebRole
{
    public partial class Last : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LabelName.Text = "Thank you for your booking!";
        }

        //protected void BtnReport(object sender, EventArgs e)
        //{
        //    Response.Redirect("/Reports.aspx");
        //}
    }
}