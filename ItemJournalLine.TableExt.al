#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
TableExtension 50011 tableextension50011 extends "Item Journal Line"
{
    fields
    {

        //Unsupported feature: Code Modification on ""Item No."(Field 3).OnValidate".

        //trigger "(Field 3)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Item No." <> xRec."Item No." THEN BEGIN
          "Variant Code" := '';
          "Bin Code" := '';
        #4..30
        IF "Value Entry Type" = "Value Entry Type"::Revaluation THEN
          Item.TESTFIELD("Inventory Value Zero",FALSE);
        Description := Item.Description;
        "Inventory Posting Group" := Item."Inventory Posting Group";
        "Item Category Code" := Item."Item Category Code";

        IF ("Value Entry Type" <> "Value Entry Type"::"Direct Cost") OR
           ("Item Charge No." <> '')
        THEN BEGIN
          IF "Item No." <> xRec."Item No." THEN BEGIN
            TESTFIELD("Partial Revaluation",FALSE);
        #42..75
            SalesPriceCalcMgt.FindItemJnlLinePrice(Rec,FIELDNO("Item No."));
          "Entry Type"::Transfer:
            BEGIN
              "Unit Amount" := 0;
              "Unit Cost" := 0;
              Amount := 0;
            END;
        END;

        #85..140

        OnBeforeVerifyReservedQty(Rec,xRec,FIELDNO("Item No."));
        ReserveItemJnlLine.VerifyChange(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..33

        "Beschreibung 2" := Item."Description 2";                          // G-ERP

        "Inventory Posting Group" := Item."Inventory Posting Group";
        "Item Category Code" := Item."Item Category Code";
        "Product Group Code" := Item."Product Group Code";

        {// G-ERP.AG 2020-12-11
        IF ("Value Entry Type" <> "Value Entry Type"::"Direct Cost") OR
           ("Item Charge No." <> '')
        }// G-ERP.AG 2020-12-11
        IF ("Value Entry Type" <> "Value Entry Type"::"Direct Cost")     // G-ERP.AG 2020-12-11
        #39..78
            "Unit Amount" := UnitCost;      // G-ERP.AG 2020-12-11
        // G-ERP.AG 2020-12-11      "Unit Amount" := 0;
        // G-ERP.AG 2020-12-11      "Unit Cost" := 0;
        // G-ERP.AG 2020-12-11      Amount := 0;
        #82..143
        */
        //end;


        //Unsupported feature: Code Modification on ""Applies-to Entry"(Field 29).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Applies-to Entry" <> 0 THEN BEGIN
          ItemLedgEntry.GET("Applies-to Entry");

        #4..18
              IF Quantity < 0 THEN
                FIELDERROR(Quantity,Text029);
            END;
            IF ItemLedgEntry.TrackingExists THEN
              ERROR(Text033,FIELDCAPTION("Applies-to Entry"),ItemTrackingLines.CAPTION);

            IF NOT ItemLedgEntry.Open THEN
              MESSAGE(Text032,"Applies-to Entry");
        #27..44
            "Variant Code" := '';
            "Bin Code" := '';
          END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..21
        // 20180518    IF ItemLedgEntry.TrackingExists THEN
        // 20180518      ERROR(Text033,FIELDCAPTION("Applies-to Entry"),ItemTrackingLines.CAPTION);
        #24..47
        */
        //end;
        field(50000; "InventurKz setzen"; Boolean)
        {
        }
        field(50010; "Beschreibung 2"; Text[50])
        {
        }
        field(50300; "Goods Receiving Date"; Date)
        {
            Caption = 'Goods Receiving Date';
            Description = 'G-ERP';
        }
        field(50301; Employee; Text[50])
        {
            Caption = 'Employee';
            Description = 'G-ERP';
        }
        field(50302; "Employee No."; Code[20])
        {
            Caption = 'Mitarberiter Nr.';
            Description = 'G-ERP';
            TableRelation = Employee."No.";

            trigger OnValidate()
            var
                Employee_l: Record Employee;
            begin
            end;
        }
    }


    //Unsupported feature: Code Modification on "GetUnitAmount(PROCEDURE 6)".

    //procedure GetUnitAmount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RetrieveCosts;
    IF ("Value Entry Type" <> "Value Entry Type"::"Direct Cost") OR
       ("Item Charge No." <> '')
    #4..21
            GLSetup."Unit-Amount Rounding Precision");
      "Entry Type"::"Negative Adjmt.":
        "Unit Amount" := UnitCostValue * "Qty. per Unit of Measure";
      "Entry Type"::Transfer:
        "Unit Amount" := 0;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..24
    // G-ERP.AG 2020-12-11  "Entry Type"::Transfer:
    // G-ERP.AG 2020-12-11    "Unit Amount" := 0;

    END;
    */
    //end;


    //Unsupported feature: Code Modification on "OpenItemTrackingLines(PROCEDURE 6500)".

    //procedure OpenItemTrackingLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ReserveItemJnlLine.CallItemTracking(Rec,IsReclass);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //+ETISCAN002
    IF "Phys. Inventory" THEN BEGIN
      TESTFIELD("Serial/Lot. No. per Line", FALSE);
    END;
    //+ETISCAN002

    ReserveItemJnlLine.CallItemTracking(Rec,IsReclass);
    */
    //end;


    //Unsupported feature: Code Modification on "RetrieveCosts(PROCEDURE 5803)".

    //procedure RetrieveCosts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := FALSE;
    OnBeforeRetrieveCosts(Rec,UnitCost,IsHandled);
    IF IsHandled THEN
      EXIT;

    IF ("Value Entry Type" <> "Value Entry Type"::"Direct Cost") OR
       ("Item Charge No." <> '')
    THEN
      EXIT;

    ReadGLSetup;
    GetItem;
    #13..19
      ELSE
        UnitCost := Item."Unit Cost";

    IF "Entry Type" = "Entry Type"::Transfer THEN
      UnitCost := 0
    ELSE
      IF Item."Costing Method" <> Item."Costing Method"::Standard THEN
        UnitCost := ROUND(UnitCost,GLSetup."Unit-Amount Rounding Precision");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    { // G-ERP.AG 2020-12-11
    #6..9
    } // G-ERP.AG 2020-12-11
    // G-ERP.AG 2020-12-11+
    IF ("Value Entry Type" <> "Value Entry Type"::"Direct Cost")
    THEN
      EXIT;
    // G-ERP.AG 2020-12-11-
    #10..22
    // G-ERP.RS 2020-12-02 +++
    // IF "Entry Type" = "Entry Type"::Transfer THEN
    //  UnitCost := 0
    // ELSE
    // G-ERP.RS 2020-12-02 ---
      IF Item."Costing Method" <> Item."Costing Method"::Standard THEN
        UnitCost := ROUND(UnitCost,GLSetup."Unit-Amount Rounding Precision");
    */
    //end;


    //Unsupported feature: Code Modification on "TrackingExists(PROCEDURE 47)".

    //procedure TrackingExists();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    EXIT(("Serial No." <> '') OR ("Lot No." <> ''));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // EXIT(FALSE);            // 20180517  //G-ERP.RS 2020-11-12 Anfrage#237961
    EXIT(("Serial No." <> '') OR ("Lot No." <> ''));
    */
    //end;
}

