using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EdgeDriverTest1
{
    [TestClass]
    public class MathTests
    {
        [TestMethod]
        [DataRow(1, 2, 3, DisplayName = "Sum of 1 + 2 = 3")]
        [DataRow(3, 3, 6, DisplayName = "Sum of 3 + 3 = 6")]
        [DataRow(4, 5, 9, DisplayName = "Sum of 4 + 5 = 9")]
        public void SumTest(int sumA, int sumB, int expectedTotal)
        {
            Assert.AreEqual(expectedTotal, ClassLibrary1.Math.Sum(sumA, sumB));
        }
    }
}
