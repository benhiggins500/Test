using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EdgeDriverTest1
{

    [TestClass]
    public class AppConfigTest
    {
        [TestMethod]
        public void TestAppConfigSettingDefaultFile()
        {
            // Replace with your own test logic to verify app configuration settings

            #if DEBUG
            string expectedValue = "RepoValue";
            #else
            string expectedValue = "NewValueA";
            #endif

            string actualValue = ConfigurationManager.AppSettings["Test"];
            Assert.AreEqual(expectedValue, actualValue, "The app configuration setting does not match the expected value.");
        }
    }
}
