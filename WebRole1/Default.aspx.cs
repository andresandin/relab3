using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

//This is the default page where everything starts, check the box to include a hotel reservation or continue without it

namespace WebRole
{
    public partial class Default : Page
    {

        bool HotelBox = false;
        List<string> listValues = new List<string>();

        protected void BtnContinue(object sender, EventArgs e)
        {
            foreach (ListItem Item in CheckAdditionalBox.Items)
            {
                if (Item.Selected)
                {
                    listValues.Add(Item.Value);
                }
            }

            if (listValues.Contains("hrsbox"))
            {
                HotelBox = true;
            }
            Response.Redirect("/FRS.aspx?hrsbox=" + this.HotelBox, false);
        }
        protected void BtnReport(object sender, EventArgs e)
        {
            Response.Redirect("/Reports.aspx");
        }
    }
}