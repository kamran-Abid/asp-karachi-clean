using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for GlobalVariables
/// </summary>
public class  GlobalVariables
{

    public static int MyGlobalVariable = 0;
    public  int SlipNo()
    {
        MyGlobalVariable=+1;
        return MyGlobalVariable;
    }

}