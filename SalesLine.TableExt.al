#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
TableExtension 50007 tableextension50007 extends "Sales Line" 
{
    fields
    {

        //Unsupported feature: Code Modification on ""No."(Field 6).OnValidate".

        //trigger "(Field 6)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            GetSalesSetup;
            IF SalesSetup."Create Item from Item No." THEN
              "No." := FindRecordMgt.FindNoFromTypedValue(Type,"No.",NOT "System-Created Entry");
            #4..57

            OnValidateNoOnBeforeUpdateDates(Rec,xRec,SalesHeader,CurrFieldNo);
            UpdateDates;

            OnAfterAssignHeaderValues(Rec,SalesHeader);

            CASE Type OF
            #65..119
            PostingSetupMgt.CheckGenPostingSetupSalesAccount("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
            PostingSetupMgt.CheckGenPostingSetupCOGSAccount("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
            PostingSetupMgt.CheckVATPostingSetupSalesAccount("VAT Bus. Posting Group","VAT Prod. Posting Group");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..60
            //G-ERP+
            Delivery := SalesHeader.Delivery;
            "Job No." := SalesHeader."Job No.";
            //G-ERP-
            #62..122
            */
        //end;
        field(50000;"Part No.";Code[20])
        {
        }
        field(50006;Delivery;Code[30])
        {
            Description = 'G-ERP';
        }
        field(82000;"Outstanding Amt.Excl.VAT (LCY)";Decimal)
        {
            Caption = 'Outstanding Amount Excl. VAT (LCY)';
        }
        field(83701;"EinstandspreisGes (MW)";Decimal)
        {
        }
        field(83712;"Betrag (MW)";Decimal)
        {
        }
    }
}

