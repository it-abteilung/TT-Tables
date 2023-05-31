#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
TableExtension 50033 tableextension50033 extends "Tracking Specification" 
{

    //Unsupported feature: Code Insertion on "OnInsert".

    //trigger OnInsert()
    //var
        //"** TMA **": Integer;
        //TrackingSpecification: Record "Tracking Specification" temporary;
        //NewEntryNo: Integer;
        //"** TMA ***": ;
        //Text72000: Label '''''';
    //begin
        /*
        //-ETISCAN001
        // Get next "Entry No."
        IF "Entry No." = 0 THEN BEGIN
          TrackingSpecification.COPY(Rec);
          //-ETISCAN002
          RESET;
          //+ETISCAN002
          SETCURRENTKEY("Entry No.");
          IF FIND('+') THEN BEGIN
            NewEntryNo := "Entry No." + 1;
          END ELSE BEGIN
            NewEntryNo := 1;
          END;
          Rec.COPY(TrackingSpecification);
          "Entry No." := NewEntryNo;
        END;
        // PopulateAllFields reproduction
        FILTERGROUP(2);
        IF (GETFILTER("Item No.") <> Text72000) AND
           ("Item No." = '')
        THEN BEGIN
          EVALUATE("Item No.", GETFILTER("Item No."))
        END;
        IF (GETFILTER("Variant Code") <> Text72000) AND
           ("Variant Code" = '')
        THEN BEGIN
          EVALUATE("Variant Code", GETFILTER("Variant Code"));
        END;
        IF (GETFILTER("Location Code") <> Text72000) AND
           ("Location Code" = '')
        THEN BEGIN
          EVALUATE("Location Code", GETFILTER("Location Code"));
        END;
        IF (GETFILTER("Source Type") <> '') AND
           ("Source Type" = 0)
        THEN BEGIN
          EVALUATE("Source Type", GETFILTER("Source Type"));
        END;
        IF (GETFILTER("Source Subtype") <> '') AND
           ("Source Subtype" = 0 )
        THEN BEGIN
          EVALUATE("Source Subtype", GETFILTER("Source Subtype"));
        END;
        IF (GETFILTER("Source ID") <> Text72000) AND
           ("Source ID" = '')
        THEN BEGIN
          EVALUATE("Source ID", GETFILTER("Source ID"));
        END;
        IF (GETFILTER("Source Batch Name") <> Text72000) AND
           ("Source Batch Name" = '')
        THEN BEGIN
          EVALUATE("Source Batch Name", GETFILTER("Source Batch Name"));
        END;
        IF (GETFILTER("Source Prod. Order Line") <> '') AND
           ("Source Prod. Order Line" = 0)
        THEN BEGIN
          EVALUATE("Source Prod. Order Line", GETFILTER("Source Prod. Order Line"));
        END;
        IF (GETFILTER("Source Ref. No.") <> '') AND
           ("Source Ref. No." = 0)
        THEN BEGIN
          EVALUATE("Source Ref. No.", GETFILTER("Source Ref. No."));
        END;
        FILTERGROUP(0);
        //+ETISCAN001
        */
    //end;
}

