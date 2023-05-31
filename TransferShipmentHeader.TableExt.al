#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
TableExtension 50041 tableextension50041 extends "Transfer Shipment Header" 
{
    fields
    {
        field(60000;"Job No";Code[20])
        {
            Caption = 'Projekt Nr.';
            Description = 'G-ERP';
        }
        field(60010;Ressource;Code[20])
        {
            Caption = 'Mitarbeiter';
            Description = 'G-ERP';
            TableRelation = Employee;
        }
    }


    //Unsupported feature: Code Modification on "CopyFromTransferHeader(PROCEDURE 4)".

    //procedure CopyFromTransferHeader();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Transfer-from Code" := TransHeader."Transfer-from Code";
        "Transfer-from Name" := TransHeader."Transfer-from Name";
        "Transfer-from Name 2" := TransHeader."Transfer-from Name 2";
        #4..36
        Area := TransHeader.Area;
        "Transaction Specification" := TransHeader."Transaction Specification";
        "Direct Transfer" := TransHeader."Direct Transfer";

        OnAfterCopyFromTransferHeader(Rec,TransHeader);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..39
        "Job No" := TransHeader."Job No";   //G-ERP.RS 2019-10-21 Anfrage#233369
        Ressource := TransHeader.Ressource; //G-ERP.RS 2019-10-21 Anfrage#233369

        OnAfterCopyFromTransferHeader(Rec,TransHeader);
        */
    //end;
}

