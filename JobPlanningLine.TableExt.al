TableExtension 50034 tableextension50034 extends "Job Planning Line"
{
    fields
    {
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                // G-ERP+
                IF Type = Type::Item THEN
                    IF Quantity <> 0 THEN
                        ExplodeBOM();
                // G-ERP-
            end;
        }
        field(50000; "Vendor Item No."; Text[20])
        {
            Caption = 'Vendor Item No.';
            Description = 'G-ERP';
        }
        field(50010; Delivery; Code[30])
        {
            Description = 'G-ERP';
        }
        field(50020; "Stückpreis EUR"; Decimal)
        {
            Description = 'G-ERP';

            trigger OnValidate()
            begin
                BerechneVKPreis();
            end;
        }
        field(50030; "Einkaufsrabatt %"; Decimal)
        {
            Description = 'G-ERP';
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                BerechneVKPreis();
            end;
        }
        field(50040; "Einkaufsrabatt EUR"; Decimal)
        {
            Description = 'G-ERP';

            trigger OnValidate()
            begin
                BerechneVKPreis();
            end;
        }
        field(50045; "Einkaufsrabatt Währung"; Decimal)
        {
            Description = 'G-ERP';
        }
        field(50050; "Aufschlag %"; Decimal)
        {
            Description = 'G-ERP';
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                BerechneVKPreis();
            end;
        }
        field(50060; "Aufschlag EUR"; Decimal)
        {
            Description = 'G-ERP';

            trigger OnValidate()
            begin
                BerechneVKPreis();
            end;
        }
        field(50065; "Aufschlag Währung"; Decimal)
        {
            Description = 'G-ERP';
        }
        field(50070; "Stückpreis in Währungscode"; Decimal)
        {
            Description = 'G-ERP';

            trigger OnValidate()
            begin
                if Währungscode <> '' then begin
                    Currency.Get(Währungscode);
                    Currency.TestField("Unit-Amount Rounding Precision");
                    // "Stückpreis EUR" :=
                    //   ROUND(
                    //     CurrExchRate.ExchangeAmtFCYToLCY(
                    //       Today, Währungscode,
                    //       "Stückpreis in Währungscode", Währungskurs),
                    //     Currency."Unit-Amount Rounding Precision")
                end else
                    "Stückpreis EUR" := "Stückpreis in Währungscode";

                BerechneVKPreis();
            end;
        }
        field(50080; "Währungscode"; Code[10])
        {
            Description = 'G-ERP';

            trigger OnValidate()
            begin
                if Währungscode <> '' then begin
                    Currency.Get(Währungscode);
                    Currency.TestField("Unit-Amount Rounding Precision");
                    "Currency Code" := Währungscode;
                    // "Stückpreis EUR" :=
                    //   ROUND(
                    //     CurrExchRate.ExchangeAmtFCYToLCY(
                    //       Today, Währungscode,
                    //       "Stückpreis in Währungscode", Währungskurs),
                    //     Currency."Unit-Amount Rounding Precision")
                end else
                    "Stückpreis EUR" := "Stückpreis in Währungscode";

                BerechneVKPreis();
            end;
        }
        field(50090; "Währungskurs"; Decimal)
        {
            DecimalPlaces = 0 : 15;
            Description = 'G-ERP';

            trigger OnValidate()
            begin

                if Währungscode <> '' then begin
                    Currency.Get(Währungscode);
                    Currency.TestField("Unit-Amount Rounding Precision");
                    "Currency Factor" := Währungskurs;
                    // "Stückpreis EUR" :=
                    //   ROUND(
                    //     CurrExchRate.exchangeAmtFCYToLCY(
                    //       Today, Währungscode,
                    //       "Stückpreis in Währungscode", Währungskurs),
                    //     Currency."Unit-Amount Rounding Precision")
                end else
                    "Stückpreis EUR" := "Stückpreis in Währungscode";

                BerechneVKPreis();
            end;
        }
        field(50100; Baugruppe; Code[20])
        {
        }
        field(50101; "Baugruppe Tree"; Integer)
        {
        }
        field(50110; Lohnkosten; Decimal)
        {
        }
        field(50120; Materialkosten; Decimal)
        {
        }
        field(50130; Fremdarbeitenkosten; Decimal)
        {
        }
        field(50140; Fremdlieferungskosten; Decimal)
        {
        }
        field(50142; Transportkosten; Decimal)
        {
        }
        field(50143; Hotelkosten; Decimal)
        {
        }
        field(50144; Flugkosten; Decimal)
        {
        }
        field(50145; "Auslöse"; Decimal)
        {
        }
        field(50150; "EK-Lohnkosten"; Decimal)
        {
        }
        field(50160; "EK-Materialkosten"; Decimal)
        {
        }
        field(50170; "EK-Fremdarbeitenkosten"; Decimal)
        {
        }
        field(50175; "EK-Fremdlieferungkosten"; Decimal)
        {
        }
        field(50180; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
            Editable = false;
            TableRelation = "Job Planning Line"."Line No." where("Job No." = field("Job No."));
        }
        field(50190; Pos; Code[20])
        {
            Description = 'G-ERP';
        }
        field(50200; "EK-Transport"; Decimal)
        {
        }
        field(50210; "EK-Hotelkosten"; Decimal)
        {
        }
        field(50220; "EK-Reisekosten"; Decimal)
        {
        }
        field(50230; "EK-Auslöse"; Decimal)
        {
        }
        field(50500; "Anzeige Lohnkosten"; Decimal)
        {
            Description = 'G-ERP';
        }
        field(50510; "Anzeige Materialkosten"; Decimal)
        {
            Description = 'G-ERP';
        }
        field(50520; "Anzeige Fremdarbeitenkosten"; Decimal)
        {
            Description = 'G-ERP';
        }
        field(50530; "Anzeige Menge"; Decimal)
        {
            Description = 'G-ERP';
        }
        field(50540; "Anzeige Fremdlieferungskosten"; Decimal)
        {
            Description = 'G-ERP';
        }
    }
    var
        CurrExchRate: Record "Currency Exchange Rate";
    //keys
    // {
    //     key(Key50000; "Job No.", Type, Baugruppe)
    //     {
    //     }
    // }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: *****G-ERP*****)()
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ValidateModification(TRUE);
    CheckRelatedJobPlanningLineInvoice;

    IF "Usage Link" THEN BEGIN
      JobUsageLink.SETRANGE("Job No.","Job No.");
      JobUsageLink.SETRANGE("Job Task No.","Job Task No.");
      JobUsageLink.SETRANGE("Line No.","Line No.");
      IF NOT JobUsageLink.ISEMPTY THEN
        ERROR(JobUsageLinkErr,TABLECAPTION);
    END;

    IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
      JobPlanningLineReserve.DeleteLine(Rec);
      CALCFIELDS("Reserved Qty. (Base)");
      TESTFIELD("Reserved Qty. (Base)",0);
    END;

    IF "Schedule Line" THEN
      Job.UpdateOverBudgetValue("Job No.",FALSE,"Total Cost (LCY)");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ValidateModification(TRUE);
    CheckRelatedJobPlanningLineInvoice;
    {
    #4..10
    }
    #12..19


    // G-ERP+
    CLEAR(l_JobPlanningLine);
    l_JobPlanningLine.SETRANGE("Job No.","Job No.");
    l_JobPlanningLine.SETRANGE("Attached to Line No.","Line No.");
    IF l_JobPlanningLine.FINDFIRST THEN
      l_JobPlanningLine.DELETEALL;
    // G-ERP-
    */
    //end;


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    LOCKTABLE;
    GetJob;
    IF Job.Blocked = Job.Blocked::All THEN
      Job.TestBlocked;
    JobTask.GET("Job No.","Job Task No.");
    JobTask.TESTFIELD("Job Task Type",JobTask."Job Task Type"::Posting);
    InitJobPlanningLine;
    IF Quantity <> 0 THEN
      UpdateReservation(0);

    IF "Schedule Line" THEN
      Job.UpdateOverBudgetValue("Job No.",FALSE,"Total Cost (LCY)");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    // G-ERP JobTask.GET("Job No.","Job Task No.");
    // G-ERP JobTask.TESTFIELD("Job Task Type",JobTask."Job Task Type"::Posting);
    #7..12
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: *******G-ERP*******) (VariableCollection) on "UpdateCurrencyFactor(PROCEDURE 17)".


    //Unsupported feature: Variable Insertion (Variable: JobAufschlag) (VariableCollection) on "UpdateCurrencyFactor(PROCEDURE 17)".



    //Unsupported feature: Code Modification on "UpdateCurrencyFactor(PROCEDURE 17)".

    //procedure UpdateCurrencyFactor();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Currency Code" <> '' THEN BEGIN
      IF "Currency Date" = 0D THEN
        CurrencyDate := WORKDATE
      ELSE
        CurrencyDate := "Currency Date";
      "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate,"Currency Code");
    END ELSE
      "Currency Factor" := 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF "Currency Code" <> '' THEN BEGIN
      // G-ERP+
      IF "Currency Date" = 0D THEN
        "Currency Date" := WORKDATE;
      // G-ERP-
    #2..8
    // G-ERP+
    IF JobAufschlag.GET('ZUSCHLAG',"Job No.") THEN
      "Currency Factor" := JobAufschlag.Währungskurs;
    // G-ERP-
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateAllAmounts(PROCEDURE 11)".

    //procedure UpdateAllAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeUpdateAllAmounts(Rec);

    InitRoundingPrecisions;

    #5..11
    UpdateRemainingCostsAndAmounts;
    IF Type = Type::Text THEN
      FIELDERROR(Type);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // G-ERP+
    IF "Currency Date" = 0D THEN
      "Currency Date" := WORKDATE;
    IF "Planning Date" = 0D THEN
      "Planning Date" := WORKDATE;
    // G-ERP-

    #2..14
    */
    //end;

    procedure "****G-ERP****"()
    begin
    end;

    procedure MakePurchaseQuote()
    var
        L_Vendor: Record Vendor;
        L_PurchaseHeader: Record "Purchase Header";
        L_PurchaseLine: Record "Purchase Line";
        L_JobPlanningLine: Record "Job Planning Line";
    begin
        if not Confirm('Möchte Sie für die Planungszeilen eine Einkaufsanfrage erstellen?', false) then
            exit;

        if Page.RunModal(0, L_Vendor) = Action::LookupOK then begin
            // Kopf erstellen
            Clear(L_PurchaseHeader);
            L_PurchaseHeader."Document Type" := L_PurchaseHeader."document type"::Quote;
            L_PurchaseHeader."No." := '';
            L_PurchaseHeader.Insert(true);
            L_PurchaseHeader.Validate("Buy-from Vendor No.", L_Vendor."No.");
            L_PurchaseHeader."Job No." := "Job No.";
            L_PurchaseHeader.Modify(true);

            // Zeilen erstellen
            Clear(L_JobPlanningLine);
            L_JobPlanningLine.SetRange("Job No.", "Job No.");
            if L_JobPlanningLine.FindSet then
                repeat
                    Clear(L_PurchaseLine);
                    L_PurchaseLine.Validate("Document Type", L_PurchaseLine."document type"::Quote);
                    L_PurchaseLine.Validate("Document No.", L_PurchaseHeader."No.");
                    L_PurchaseLine.Validate("Line No.", L_JobPlanningLine."Line No.");
                    L_PurchaseLine.Validate(Type, L_PurchaseLine.Type::Item);
                    L_PurchaseLine.Validate("No.", L_JobPlanningLine."No.");
                    L_PurchaseLine.Validate(Description, L_JobPlanningLine.Description);
                    L_PurchaseLine.Validate("Description 2", L_JobPlanningLine."Description 2");
                    L_PurchaseLine.Validate("Unit of Measure", L_JobPlanningLine."Unit of Measure Code");
                    L_PurchaseLine.Validate(Quantity, L_JobPlanningLine.Quantity);
                    L_PurchaseLine."Vendor Item No." := L_JobPlanningLine."Vendor Item No.";
                    L_PurchaseLine."Job No." := L_JobPlanningLine."Job No.";
                    L_PurchaseLine.Insert(true);
                until L_JobPlanningLine.Next = 0;
            Commit;
            Page.RunModal(49, L_PurchaseHeader);
        end;
    end;

    procedure MakePurchaseOrder()
    var
        L_Vendor: Record Vendor;
        L_PurchaseHeader: Record "Purchase Header";
        L_PurchaseLine: Record "Purchase Line";
        L_JobPlanningLine: Record "Job Planning Line";
    begin
        if not Confirm('Möchte Sie für die Planungszeilen eine Einkaufsbestellung erstellen?', false) then
            exit;

        if Page.RunModal(0, L_Vendor) = Action::LookupOK then begin
            // Kopf erstellen
            Clear(L_PurchaseHeader);
            L_PurchaseHeader."Document Type" := L_PurchaseHeader."document type"::Order;
            L_PurchaseHeader."No." := '';
            L_PurchaseHeader.Insert(true);
            L_PurchaseHeader.Validate("Buy-from Vendor No.", L_Vendor."No.");
            L_PurchaseHeader."Job No." := "Job No.";
            L_PurchaseHeader.Modify(true);

            // Zeilen erstellen
            Clear(L_JobPlanningLine);
            L_JobPlanningLine.SetRange("Job No.", "Job No.");
            if L_JobPlanningLine.FindSet then
                repeat
                    Clear(L_PurchaseLine);
                    L_PurchaseLine.Validate("Document Type", L_PurchaseLine."document type"::Order);
                    L_PurchaseLine.Validate("Document No.", L_PurchaseHeader."No.");
                    L_PurchaseLine.Validate("Line No.", L_JobPlanningLine."Line No.");
                    L_PurchaseLine.Validate(Type, L_PurchaseLine.Type::Item);
                    L_PurchaseLine.Validate("No.", L_JobPlanningLine."No.");
                    L_PurchaseLine.Validate(Description, L_JobPlanningLine.Description);
                    L_PurchaseLine.Validate("Description 2", L_JobPlanningLine."Description 2");
                    L_PurchaseLine.Validate("Unit of Measure", L_JobPlanningLine."Unit of Measure Code");
                    L_PurchaseLine.Validate(Quantity, L_JobPlanningLine.Quantity);
                    L_PurchaseLine."Vendor Item No." := L_JobPlanningLine."Vendor Item No.";
                    L_PurchaseLine."Job No." := L_JobPlanningLine."Job No.";
                    L_PurchaseLine.Validate("Direct Unit Cost", L_JobPlanningLine."Stückpreis in Währungscode");
                    L_PurchaseLine.Validate("Line Discount %", L_JobPlanningLine."Einkaufsrabatt %");
                    L_PurchaseLine.Insert(true);
                until L_JobPlanningLine.Next = 0;
            Commit;
            Page.RunModal(50, L_PurchaseHeader);
        end;
    end;

    procedure MakeSalesQuote()
    var
        L_Customer: Record Customer;
        L_SalesHeader: Record "Sales Header";
        L_SalesLine: Record "Sales Line";
        L_JobPlanningLine: Record "Job Planning Line";
        L_Job: Record Job;
        JobAufschlag: Record "Multi Table";
    begin
        if not Confirm('Möchte Sie für die Planungszeilen ein Verkaufsangebot erstellen?', false) then
            exit;

        L_Job.Get("Job No.");
        L_Customer.Get(L_Job."Bill-to Customer No.");

        // Kopf erstellen
        Clear(L_SalesHeader);
        L_SalesHeader."Document Type" := L_SalesHeader."document type"::Quote;
        L_SalesHeader."No." := '';
        L_SalesHeader.Insert(true);
        L_SalesHeader.Validate("Sell-to Customer No.", L_Customer."No.");
        L_SalesHeader."Bill-to Name" := L_Job."Bill-to Name";
        L_SalesHeader."Bill-to Name 2" := L_Job."Bill-to Name 2";
        L_SalesHeader."Bill-to Address" := L_Job."Bill-to Address";
        L_SalesHeader."Bill-to Address 2" := L_Job."Bill-to Address 2";
        L_SalesHeader."Bill-to City" := L_Job."Bill-to City";
        L_SalesHeader."Bill-to Contact" := L_Job."Bill-to Contact";
        L_SalesHeader."Bill-to Post Code" := L_Job."Bill-to Post Code";
        L_SalesHeader."Bill-to County" := '';
        L_SalesHeader."Bill-to Country/Region Code" := L_Job."Bill-to Country/Region Code";
        L_SalesHeader."Sell-to Customer Name" := L_Job."Bill-to Name";
        L_SalesHeader."Sell-to Customer Name 2" := L_Job."Bill-to Name 2";
        L_SalesHeader."Sell-to Address" := L_Job."Bill-to Address";
        L_SalesHeader."Sell-to Address 2" := L_Job."Bill-to Address 2";
        L_SalesHeader."Sell-to City" := L_Job."Bill-to City";
        L_SalesHeader."Sell-to Contact" := L_Job."Bill-to Contact";
        L_SalesHeader."Sell-to Post Code" := L_Job."Bill-to Post Code";
        L_SalesHeader."Sell-to County" := '';
        L_SalesHeader."Sell-to Country/Region Code" := L_Job."Bill-to Country/Region Code";
        L_SalesHeader."Job No." := "Job No.";
        L_SalesHeader.Preisstellung := L_Job.Preisstellung;
        L_SalesHeader."Validity (DAYS)" := L_Job."Validity (DAYS)";
        // G-ERP+
        if JobAufschlag.Get('ZUSCHLAG', L_Job."No.") then begin
            L_SalesHeader."Currency Code" := JobAufschlag."Currency Code";
            L_SalesHeader."Currency Factor" := JobAufschlag.Währungskurs;
        end;
        // G-ERP-

        L_SalesHeader.Modify(true);

        // Zeilen erstellen
        Clear(L_JobPlanningLine);
        L_JobPlanningLine.SetRange("Job No.", "Job No.");
        if L_JobPlanningLine.FindSet then
            repeat
                Clear(L_SalesLine);
                L_SalesLine.Validate("Document Type", L_SalesLine."document type"::Quote);
                L_SalesLine.Validate("Document No.", L_SalesHeader."No.");
                L_SalesLine.Validate("Line No.", L_JobPlanningLine."Line No.");
                L_SalesLine.Insert(true);
                L_SalesLine.Validate(Type, L_SalesLine.Type::Item);
                L_SalesLine.Validate("No.", L_JobPlanningLine."No.");
                L_SalesLine.Validate("Unit of Measure Code", L_JobPlanningLine."Unit of Measure Code");
                L_SalesLine.Validate("Unit of Measure", L_JobPlanningLine."Unit of Measure Code");
                L_SalesLine.Validate(Description, L_JobPlanningLine.Description);
                L_SalesLine.Validate("Description 2", L_JobPlanningLine."Description 2");
                L_SalesLine.Validate(Quantity, L_JobPlanningLine.Quantity);
                L_SalesLine."Part No." := L_JobPlanningLine."Vendor Item No.";
                L_SalesLine."Job No." := L_JobPlanningLine."Job No.";
                L_SalesLine.Delivery := L_JobPlanningLine.Delivery;
                L_SalesLine.Validate("Unit Price", L_JobPlanningLine."Unit Price");
                L_SalesLine."Unit of Measure Code" := L_JobPlanningLine."Unit of Measure Code";
                L_SalesLine.Modify(true);
            until L_JobPlanningLine.Next = 0;
        Commit;
        Page.RunModal(41, L_SalesHeader);
    end;

    procedure MakeSalesOrder()
    var
        L_Customer: Record Customer;
        L_SalesHeader: Record "Sales Header";
        L_SalesLine: Record "Sales Line";
        L_JobPlanningLine: Record "Job Planning Line";
        L_Job: Record Job;
    begin
        if not Confirm('Möchte Sie für die Planungszeilen ein Verkaufsauftrag erstellen?', false) then
            exit;

        L_Job.Get("Job No.");
        L_Customer.Get(L_Job."Bill-to Customer No.");

        // Kopf erstellen
        Clear(L_SalesHeader);
        L_SalesHeader."Document Type" := L_SalesHeader."document type"::Order;
        L_SalesHeader."No." := '';
        L_SalesHeader.Insert(true);
        L_SalesHeader.Validate("Sell-to Customer No.", L_Customer."No.");
        L_SalesHeader."Bill-to Name" := L_Job."Bill-to Name";
        L_SalesHeader."Bill-to Name 2" := L_Job."Bill-to Name 2";
        L_SalesHeader."Bill-to Address" := L_Job."Bill-to Address";
        L_SalesHeader."Bill-to Address 2" := L_Job."Bill-to Address 2";
        L_SalesHeader."Bill-to City" := L_Job."Bill-to City";
        L_SalesHeader."Bill-to Contact" := L_Job."Bill-to Contact";
        L_SalesHeader."Bill-to Post Code" := L_Job."Bill-to Post Code";
        L_SalesHeader."Bill-to County" := '';
        L_SalesHeader."Bill-to Country/Region Code" := L_Job."Bill-to Country/Region Code";
        L_SalesHeader."Sell-to Customer Name" := L_Job."Bill-to Name";
        L_SalesHeader."Sell-to Customer Name 2" := L_Job."Bill-to Name 2";
        L_SalesHeader."Sell-to Address" := L_Job."Bill-to Address";
        L_SalesHeader."Sell-to Address 2" := L_Job."Bill-to Address 2";
        L_SalesHeader."Sell-to City" := L_Job."Bill-to City";
        L_SalesHeader."Sell-to Contact" := L_Job."Bill-to Contact";
        L_SalesHeader."Sell-to Post Code" := L_Job."Bill-to Post Code";
        L_SalesHeader."Sell-to County" := '';
        L_SalesHeader."Sell-to Country/Region Code" := L_Job."Bill-to Country/Region Code";
        L_SalesHeader."Job No." := "Job No.";
        L_SalesHeader.Preisstellung := L_Job.Preisstellung;
        L_SalesHeader."Validity (DAYS)" := L_Job."Validity (DAYS)";
        L_SalesHeader.Modify(true);

        // Zeilen erstellen
        Clear(L_JobPlanningLine);
        L_JobPlanningLine.SetRange("Job No.", "Job No.");
        if L_JobPlanningLine.FindSet then
            repeat
                Clear(L_SalesLine);
                L_SalesLine.Validate("Document Type", L_SalesLine."document type"::Order);
                L_SalesLine.Validate("Document No.", L_SalesHeader."No.");
                L_SalesLine.Validate("Line No.", L_JobPlanningLine."Line No.");
                L_SalesLine.Validate(Type, L_SalesLine.Type::Item);
                L_SalesLine.Validate("No.", L_JobPlanningLine."No.");
                L_SalesLine.Validate(Description, L_JobPlanningLine.Description);
                L_SalesLine.Validate("Description 2", L_JobPlanningLine."Description 2");
                L_SalesLine.Validate("Unit of Measure", L_JobPlanningLine."Unit of Measure Code");
                L_SalesLine.Validate("Unit of Measure Code", L_JobPlanningLine."Unit of Measure Code");
                L_SalesLine.Validate(Quantity, L_JobPlanningLine.Quantity);
                L_SalesLine."Part No." := L_JobPlanningLine."Vendor Item No.";
                L_SalesLine."Job No." := L_JobPlanningLine."Job No.";
                L_SalesLine.Delivery := L_JobPlanningLine.Delivery;
                L_SalesLine.Validate("Unit Price", L_JobPlanningLine."Unit Price");
                L_SalesLine.Insert(true);
            until L_JobPlanningLine.Next = 0;
        Commit;
        Page.RunModal(42, L_SalesHeader);
    end;

    procedure BerechneVKPreis()
    begin
        if "Einkaufsrabatt %" <> 0 then
            "Einkaufsrabatt EUR" := ("Stückpreis EUR" / 100 * "Einkaufsrabatt %");
        if "Einkaufsrabatt %" <> 0 then
            "Einkaufsrabatt Währung" := ("Stückpreis in Währungscode" / 100 * "Einkaufsrabatt %");
        if "Aufschlag %" <> 0 then
            "Aufschlag EUR" := (("Stückpreis EUR" - "Einkaufsrabatt EUR") / 100 * "Aufschlag %");
        if "Aufschlag %" <> 0 then
            "Aufschlag Währung" := (("Stückpreis in Währungscode" - "Einkaufsrabatt Währung") / 100 * "Aufschlag %");
        Validate("Unit Price (LCY)", ROUND(("Stückpreis EUR" - "Einkaufsrabatt EUR" + "Aufschlag EUR"), 0.01));
        if "Currency Code" <> '' then
            Validate("Unit Price", ROUND(("Stückpreis in Währungscode" - "Einkaufsrabatt Währung" + "Aufschlag Währung"), 0.01));
    end;

    procedure ExplodeBOM()
    var
        FromBOMComp: Record "BOM Component";
        l_JobPlanningLine: Record "Job Planning Line";
    begin
        Clear(l_JobPlanningLine);
        l_JobPlanningLine.SetRange("Job No.", "Job No.");
        l_JobPlanningLine.SetRange("Attached to Line No.", "Line No.");
        if l_JobPlanningLine.FindFirst then
            l_JobPlanningLine.DeleteAll;

        FromBOMComp.SetRange(Type, FromBOMComp.Type::Item);
        FromBOMComp.SetRange("Parent Item No.", "No.");
        if FromBOMComp.FindSet then
            repeat
                FromBOMComp.TestField(Type, FromBOMComp.Type::Item);
                Clear(l_JobPlanningLine);
                l_JobPlanningLine."Job No." := "Job No.";
                l_JobPlanningLine."Job Task No." := "Job Task No.";
                l_JobPlanningLine."Line No." := "Line No." + (FromBOMComp."Line No." / 1000);
                l_JobPlanningLine.Insert(true);
                l_JobPlanningLine.Validate(Type, l_JobPlanningLine.Type::Item);
                l_JobPlanningLine.Validate("No.", FromBOMComp."No.");
                l_JobPlanningLine.Validate(Quantity, ROUND(Quantity * FromBOMComp."Quantity per", 0.00001));
                l_JobPlanningLine."Attached to Line No." := "Line No.";
                l_JobPlanningLine.Modify(true);
            until FromBOMComp.Next = 0;
    end;

    var
        "*****G-ERP*****": Integer;
        l_JobPlanningLine: Record "Job Planning Line";

    var
        "*G-ERP*": Integer;
        Currency: Record Currency;
}

