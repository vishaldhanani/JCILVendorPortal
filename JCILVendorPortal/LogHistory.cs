//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace JCILVendorPortal
{
    using System;
    using System.Collections.Generic;
    
    public partial class LogHistory
    {
        public int ID { get; set; }
        public int LoginUserID { get; set; }
        public Nullable<System.DateTime> LoginInTime { get; set; }
        public Nullable<int> AccessActivity { get; set; }
        public Nullable<System.DateTime> LogOutTime { get; set; }
    
        public virtual VendorLogin VendorLogin { get; set; }
    }
}