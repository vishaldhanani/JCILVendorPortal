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
    
    public partial class VendorLogin
    {
        public VendorLogin()
        {
            this.LogHistories = new HashSet<LogHistory>();
            this.VendorAccessLogs = new HashSet<VendorAccessLog>();
        }
    
        public int ID { get; set; }
        public string UserName { get; set; }
        public int Password { get; set; }
        public string NavUserName { get; set; }
        public string NavPassword { get; set; }
        public int TypeOfUser { get; set; }
        public Nullable<bool> ActiveUser { get; set; }
    
        public virtual ICollection<LogHistory> LogHistories { get; set; }
        public virtual ICollection<VendorAccessLog> VendorAccessLogs { get; set; }
    }
}
