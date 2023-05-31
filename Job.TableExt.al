TableExtension 50028 tableextension50028 extends Job
{
    fields
    {
        modify(Status)
        {
            trigger OnAfterValidate()
            begin
                IF xRec.Status <> Status THEN BEGIN
                    IF Status = Status::Completed THEN BEGIN
                        VALIDATE(Complete, TRUE);
                        GET("No.");
                        Status := Status::Completed;
                        Complete := TRUE;
                        MODIFY;
                    END;
                    IF xRec.Status = xRec.Status::Completed THEN BEGIN
                    END;

                    MODIFY;
                END;

                //G-ERP+
                IF Status = Status::Quote THEN BEGIN
                    "Nächste Nachfrage" := CALCDATE('<+2W>', TODAY);
                END;
                //G-ERP-
            end;
        }

        field(50000; "Object"; Code[20])
        {
            Caption = 'Object';
            Description = 'G-ERP';
            TableRelation = "Multi Table".Code where(Kennzeichen = const('SCHIFF'));

            trigger OnValidate()
            var
                ObjectRec: Record "Multi Table";
            begin
                Objektname := '';
                if ObjectRec.Get('SCHIFF', Object) then
                    Objektname := ObjectRec.Description;
            end;
        }
        field(50001; "Anfrage von"; Text[50])
        {
            Caption = 'Request from';
            Description = 'G-ERP';
        }
        field(50002; "Anfrage am"; Date)
        {
            Caption = 'Request at';
            Description = 'G-ERP';
        }
        field(50003; "Anfrage per"; Text[30])
        {
            Caption = 'Request per';
            Description = 'G-ERP';
        }
        field(50004; "Angebotsabgabe bis"; Date)
        {
            Caption = 'Submission until';
            Description = 'G-ERP';
        }
        field(50005; "Angebotsabgabe durch"; Code[20])
        {
            Caption = 'Submission by';
            Description = 'G-ERP';
            TableRelation = Resource;
        }
        field(50006; Reparaturort; Text[30])
        {
            Caption = 'Repair location';
            Description = 'G-ERP';
        }
        field(50007; Agentur; Code[20])
        {
            Caption = 'Agency';
            Description = 'G-ERP';
            TableRelation = Contact."No." where(Type = const(Company));
        }
        field(50008; "Agentur Name"; Text[100])
        {
            CalcFormula = lookup(Contact.Name where("No." = field(Agentur)));
            Caption = 'Agency Name';
            Description = 'G-ERP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50009; Agenturperson; Code[20])
        {
            Caption = 'Agency Person';
            Description = 'G-ERP';
            TableRelation = Contact."No." where(Type = const(Person),
                                                 "Company No." = field(Agentur));
        }
        field(50010; "Agenturperson Name"; Text[100])
        {
            CalcFormula = lookup(Contact.Name where("No." = field(Agenturperson)));
            Caption = 'Agency Person Name';
            Description = 'G-ERP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "Auftragseingang erfolgte"; Text[30])
        {
            Caption = 'Order received';
            Description = 'G-ERP';
        }
        field(50012; "Auftragseingang erfolgte am"; Date)
        {
            Caption = 'Order received on';
            Description = 'G-ERP';
        }
        field(50013; Planungsprojektnummer; Code[20])
        {
            Description = 'G-ERP';
            Editable = false;
        }
        field(50014; "Letzte Notiz"; Text[250])
        {
            Caption = 'Last note';
            Description = 'G-ERP';
        }
        field(50020; Verfasser; Code[20])
        {
            Caption = 'Person Author';
            Description = 'G-ERP';
            TableRelation = Resource;
        }
        field(50022; Objektname; Text[100])
        {
            Caption = 'Object name';
            Description = 'G-ERP';
            Editable = false;
        }
        field(50025; Reparaturleiter; Code[20])
        {
            Caption = 'Repair manager';
            Description = 'G-ERP';
            TableRelation = Resource;
        }
        field(50030; "Betriebsstätte Rotterdam"; Boolean)
        {
            Description = 'G-ERP';
        }
        field(50040; "Job Type"; Code[10])
        {
            Caption = 'Projekttyp';
            Description = 'G-ERP';
            TableRelation = "Job Type";
        }
        field(50050; "Contact Person No."; Code[20])
        {
            Caption = 'Kontakt Person Nr.';
            Description = 'G-ERP';
            TableRelation = Contact where(Type = const(Person));

            trigger OnLookup()
            var
                Contact: Record Contact;
            begin
                Contact."Company Name" := "Contact Company Name";
                Contact."Company No." := "Contact Company No.";
                Contact.Type := Contact.Type::Person;
                Contact.Name := "Contact Person Name";

                Contact.Reset;
                Contact.SetCurrentkey("Company Name", "Company No.", Type, Name);
                Contact.SetRange("Company No.", "Contact Company No.");
                Contact.SetRange(Type, Contact.Type::Person);
                Contact."No." := "Contact Person No.";
                if Page.RunModal(5052, Contact) = Action::LookupOK then
                    Validate("Contact Person No.", Contact."No.");
            end;

            trigger OnValidate()
            begin
                CalcFields("Contact Person Name");
            end;
        }
        field(50060; "Contact Person Name"; Text[100])
        {
            CalcFormula = lookup(Contact.Name where("No." = field("Contact Person No.")));
            Caption = 'Kontakt Person Name';
            Description = 'G-ERP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50070; "Contact Company No."; Code[20])
        {
            Caption = 'Kontakt Unternehmen Nr.';
            Description = 'G-ERP';
            TableRelation = Contact."No." where(Type = const(Company));

            trigger OnLookup()
            var
                Contact: Record Contact;
            begin
                Contact."Company Name" := "Contact Company Name";
                Contact."Company No." := "Contact Company No.";
                Contact.Type := Contact.Type::Company;
                Contact.Name := "Contact Company Name";

                Contact.Reset;
                Contact.SetCurrentkey("Company Name", "Company No.", Type, Name);
                Contact.SetRange(Type, Contact.Type::Company);
                if Page.RunModal(5052, Contact) = Action::LookupOK then
                    Validate("Contact Company No.", Contact."No.");
            end;

            trigger OnValidate()
            var
                Contact: Record Contact;
                ContactBusinessRelation: Record "Contact Business Relation";
                Cust: Record Customer;
                Found: Boolean;
                Text5108001: label 'Wollen Sie Debitor "%1, %2" übernehmen ?';
            begin
                CalcFields("Contact Company Name");
                Validate("Contact Person No.", '');
                if Contact.Get("Contact Company No.") then
                    "Language Code" := Contact."Language Code";

                if CurrFieldNo = FieldNo("Contact Company No.") then begin
                    ContactBusinessRelation.Reset;
                    ContactBusinessRelation.SetRange("Contact No.", "Contact Company No.");
                    ContactBusinessRelation.SetRange("Link to Table", ContactBusinessRelation."link to table"::Customer);
                    ContactBusinessRelation.SetFilter("No.", '<>''''');
                    Found := ContactBusinessRelation.FindFirst;
                    if ContactBusinessRelation.Count > 1 then
                        //if Page.RunModal(Page::"Contact Business Relations", ContactBusinessRelation) <> Action::LookupOK then
                        //  Found := false;
                        if Found then
                            if Cust.Get(ContactBusinessRelation."No.") then
                                if Confirm(StrSubstNo(Text5108001, Cust."No.", Cust.Name)) then;
                    //Validate("Sell-to Customer No.", Cust."No.");
                end;
            end;
        }
        field(50080; "Contact Company Name"; Text[100])
        {
            CalcFormula = lookup(Contact.Name where("No." = field("Contact Company No.")));
            Caption = 'Kontakt Unternehmen Name';
            Description = 'G-ERP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50090; "Your Order No."; Code[20])
        {
            Caption = 'Your Order No.';
            Description = 'G-ERP';
        }
        field(50100; ASME; Boolean)
        {
            Description = 'G-ERP';
        }
        // modify(50200; "Sell-to Customer No."; Code[20])
        // {
        //     Caption = 'Sell-to Customer No.';
        //     Description = 'G-ERP';
        //     TableRelation = Customer;

        //     trigger OnValidate()
        //     var
        //         Cust: Record Customer;
        //         ContBusRel: Record "Contact Business Relation";
        //     begin
        //         if Cust.Get("Sell-to Customer No.") then begin
        //             //FEHLER BEIM KOMPILIEREN G-ERP.FL 2011-12-19 +
        //             /*
        //             IF "Contact Company No." = '' THEN BEGIN
        //               ContBusRel.SETCURRENTKEY("Link to Table","No.");
        //               ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Customer);
        //               ContBusRel.SETRANGE("No.",Cust."No.");
        //               IF ContBusRel.FINDFIRST THEN BEGIN
        //                 "Contact Company No." := ContBusRel."Contact No.";
        //                 CALCFIELDS("Contact Company Name");
        //               END;
        //             END;
        //             */
        //             //FEHLER BEIM KOMPILIEREN G-ERP.FL 2011-12-19 -
        //             if Cust."Bill-to Customer No." <> '' then
        //                 Validate("Bill-to Customer No.", Cust."Bill-to Customer No.")
        //             else
        //                 Validate("Bill-to Customer No.", Cust."No.");
        //             //FEHLER BEIM KOMPILIEREN G-ERP.FL 2011-12-19 +
        //             /*
        //             "Responsibility Center" := UserMgt.GetRespCenter(0,Cust."Responsibility Center");
        //             VALIDATE("Responsibility Center");
        //             IF Cust."Location Code" <> '' THEN
        //               VALIDATE("Location for Inv. Requests",Cust."Location Code");
        //             "Language Code" := Cust."Language Code";
        //             */
        //             //FEHLER BEIM KOMPILIEREN G-ERP.FL 2011-12-19 -
        //         end else begin
        //             Validate("Bill-to Customer No.", '');
        //         end;

        //         CalcFields(
        //           "Sell-to Customer Name", "Sell-to Customer Name 2",
        //           "Sell-to Address", "Sell-to Address 2",
        //           "Sell-to Contact",
        //           "Sell-to Post Code", "Sell-to City", "Sell-to Country/Region Code");

        //     end;
        // }
        field(50220; "Parts for"; Text[50])
        {
            Description = 'G-ERP';
        }
        field(50230; Maker; Text[50])
        {
            Description = 'G-ERP';
        }
        field(50240; Type; Text[50])
        {
            Description = 'G-ERP';
        }
        field(50250; "We Quote for"; Text[50])
        {
            Description = 'G-ERP';
        }
        field(50260; "Serial Number"; Text[50])
        {
            Description = 'G-ERP';
        }
        field(50270; Specification; Text[50])
        {
            Description = 'G-ERP';
        }
        field(50280; "Ship Owner"; Text[100])
        {
            Description = 'G-ERP';
            TableRelation = Contact.Name where(Type = const(Company));
            ValidateTableRelation = false;
        }
        field(50290; "Bareboat Charterer"; Text[100])
        {
            Description = 'G-ERP';
            TableRelation = Contact.Name where(Type = const(Company));
            ValidateTableRelation = false;
        }
        field(50300; Preisstellung; Option)
        {
            Caption = 'Pricing';
            Description = 'G-ERP';
            OptionCaption = 'unpacked,packed';
            OptionMembers = unpacked,packed;
        }
        field(50310; "Validity (DAYS)"; Integer)
        {
            Description = 'G-ERP';
        }
        field(50320; IMO; Code[20])
        {
            CalcFormula = lookup("Multi Table"."LLoyds No." where(Kennzeichen = const('SCHIFF'),
                                                                   Code = field(Object)));
            Description = 'G-ERP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50330; Summe; Decimal)
        {
            Caption = 'Total';
            Description = 'G-ERP';
        }
        field(50340; "Ship Owner Bearbeiter"; Text[100])
        {
            Description = 'G-ERP';
            TableRelation = Contact.Name where(Type = const(Person),
                                                "Company Name" = field("Ship Owner"));
            ValidateTableRelation = false;
        }
        field(50350; "Person Responsible Name"; Text[100])
        {
            CalcFormula = lookup(Resource.Name where("No." = field("Person Responsible")));
            Caption = 'Verantwortlich Name';
            Description = 'G-ERP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50500; "Anfrage über"; Blob)
        {
            Caption = 'Anfrage über';
            Description = 'G-ERP';
        }
        field(50510; "Zu beachten"; Blob)
        {
            Description = 'G-ERP';
        }
        field(50520; Montagegruppe; Blob)
        {
            Description = 'G-ERP';
        }
        field(50530; "keine Verbrauchsbuchung"; Boolean)
        {
            Caption = 'no consumption booking';
            Description = 'G-ERP';
        }
        field(51000; "Reparatur  in Euro"; Decimal)
        {
            Caption = 'Repair  in Euro';
            DecimalPlaces = 2 : 2;
        }
        field(51010; "Gütesicherung  in Euro"; Decimal)
        {
            Caption = 'Gütesicherung  in Euro';
            DecimalPlaces = 2 : 2;
        }
        field(51020; "Brandwache  in Euro"; Decimal)
        {
            Caption = 'Brandwache  in Euro';
            DecimalPlaces = 2 : 2;
        }
        field(51030; "Maschinenstunden  in Euro"; Decimal)
        {
            Caption = 'Maschinenstunden  in Euro';
        }
        field(51035; "Job d  in Euro"; Decimal)
        {
        }
        field(51040; "Job e  in Euro"; Decimal)
        {
        }
        field(51042; "Job f  in Euro"; Decimal)
        {
        }
        field(51045; "Job g  in Euro"; Decimal)
        {
        }
        field(51050; "Lagermaterialzuschlag %"; Decimal)
        {
            Caption = 'Lagermaterialzuschlag %';
            MaxValue = 100;
            MinValue = 0;
        }
        field(51060; "Fremdzuschlag %"; Decimal)
        {
            Caption = 'Fremdzuschlag %';
            MaxValue = 100;
            MinValue = 0;
        }
        field(51070; "Fremdlieferungzuschlag %"; Decimal)
        {
            Caption = 'Fremdlieferungzuschlag %';
            MaxValue = 100;
            MinValue = 0;
        }
        field(51080; "Transportezuschlag %"; Decimal)
        {
        }
        field(51090; "Hotelkostenzuschlag %"; Decimal)
        {
        }
        field(51100; "Flugkostenzuschlag %"; Decimal)
        {
        }
        field(51110; "Auslösezuschlag %"; Decimal)
        {
        }
        field(51500; "Nachlass in Euro"; Decimal)
        {
        }
        field(52000; "EK-Anfragen"; Integer)
        {
            CalcFormula = count("Purchase Header" where("Document Type" = const(Quote),
                                                         "Job No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(52005; "EK-Fremdlieferung Soll"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Job Planning Line"."EK-Fremdlieferungkosten" where("Job No." = field("No."), "EK-Fremdlieferungkosten" = filter(<> 0)));
        }
        field(52006; "EK-Materialkosten Soll"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Job Planning Line"."EK-Materialkosten" where("Job No." = field("No."), "EK-Materialkosten" = filter(<> 0)));
        }
        field(52007; "EK-Fremdarbeitenkosten Soll"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Job Planning Line"."EK-Fremdarbeitenkosten" where("Job No." = field("No."), "EK-Fremdarbeitenkosten" = filter(<> 0)));
        }
        field(52008; "EK-Transportkosten Soll"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Job Planning Line"."EK-Transport" where("Job No." = field("No."), "EK-Transport" = filter(<> 0)));
        }
        field(52009; "EK-Hotelkosten Soll"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Job Planning Line"."EK-Hotelkosten" where("Job No." = field("No."), "EK-Hotelkosten" = filter(<> 0)));
        }
        field(52010; "EK-Bestellungen"; Integer)
        {
            CalcFormula = count("Purchase Header" where("Document Type" = const(Order),
                                                         "Job No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(52011; "EK-Flugkosten Soll"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Job Planning Line"."EK-Reisekosten" where("Job No." = field("No."), "EK-Reisekosten" = filter(<> 0)));
        }
        field(52012; "EK-Auslöse Soll"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Job Planning Line"."EK-Auslöse" where("Job No." = field("No."), "EK-Auslöse" = filter(<> 0)));
        }
        field(52020; "EK-Rechnungen"; Integer)
        {
            CalcFormula = count("Purch. Inv. Header" where("Job No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(52030; "EK-Gutschrift"; Integer)
        {
            CalcFormula = count("Purch. Cr. Memo Hdr." where("Job No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(55000; "Arbeitsstd. Gesamt Ist"; Decimal)
        {
            CalcFormula = sum("Job Ledger Entry".Quantity where("Job No." = field("No."),
                                                                 Type = const(Resource)));
            Description = 'G-ERP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(55001; "EK Arbeitsstd. Gesamt Ist"; Decimal)
        {
            CalcFormula = sum("Job Ledger Entry"."Direct Unit Cost (LCY)" where("Job No." = field("No."),
                                                                                 Type = const(Resource)));
            Description = 'G-ERP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(55002; "EK Material Ist"; Decimal)
        {
            CalcFormula = sum("Purch. Inv. Line".Amount where("Job No." = field("No."),
                                                               Leistungsart = filter(" ")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(55003; "EK Fremdlieferung Ist"; Decimal)
        {
            CalcFormula = sum("Purch. Inv. Line".Amount where("Job No." = field("No."),
                                                               Leistungsart = const(Fremdlieferung)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(55004; "EK Fremdleistung Ist"; Decimal)
        {
            CalcFormula = sum("Purch. Inv. Line".Amount where("Job No." = field("No."),
                                                               Leistungsart = filter(Fremdleistung | Personal | " ")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(55005; "Lagermaterial Ist"; Decimal)
        {
            CalcFormula = sum("Job Ledger Entry"."Total Cost (LCY)" where("Job No." = field("No."),
                                                                           "Source Code" = filter('')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(55006; "EK Transporte Ist"; Decimal)
        {
            CalcFormula = sum("Purch. Inv. Line".Amount where("Job No." = field("No."),
                                                               Leistungsart = const(Transport)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(55007; "EK Hotelkosten Ist"; Decimal)
        {
            CalcFormula = sum("Purch. Inv. Line".Amount where("Job No." = field("No."),
                                                               Leistungsart = const(Hotelkosten)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(55008; "EK Flugkosten Ist"; Decimal)
        {
            CalcFormula = sum("Purch. Inv. Line".Amount where("Job No." = field("No."),
                                                               Leistungsart = const(Flugkosten)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(55009; "EK Auslöse Ist"; Decimal)
        {
            CalcFormula = sum("Purch. Inv. Line".Amount where("Job No." = field("No."),
                                                               Leistungsart = const(Auslöse)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(55010; "Nächste Nachfrage"; Date)
        {
        }
        field(55020; "EK Fremdlieferung Ist Gut"; Decimal)
        {
            CalcFormula = sum("Purch. Cr. Memo Line".Amount where("Job No." = field("No."),
                                                                   Leistungsart = const(Fremdlieferung)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(55021; "EK Fremdleistung Ist Gut"; Decimal)
        {
            CalcFormula = sum("Purch. Cr. Memo Line".Amount where("Job No." = field("No."),
                                                                   Leistungsart = filter(Fremdleistung | Personal | " ")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(55022; "EK Transporte Ist Gut"; Decimal)
        {
            CalcFormula = sum("Purch. Cr. Memo Line".Amount where("Job No." = field("No."),
                                                                   Leistungsart = const(Transport)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(55023; "EK Hotelkosten Ist Gut"; Decimal)
        {
            CalcFormula = sum("Purch. Cr. Memo Line".Amount where("Job No." = field("No."),
                                                                   Leistungsart = const(Hotelkosten)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(55024; "EK Flugkosten Ist Gut"; Decimal)
        {
            CalcFormula = sum("Purch. Cr. Memo Line".Amount where("Job No." = field("No."),
                                                                   Leistungsart = const(Flugkosten)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(55025; "EK Auslöse Ist Gut"; Decimal)
        {
            CalcFormula = sum("Purch. Cr. Memo Line".Amount where("Job No." = field("No."),
                                                                   Leistungsart = const(Auslöse)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(56000; Leistungszeitraum; Code[250])
        {
            Caption = 'Period of performance';
            FieldClass = FlowFilter;
        }
        field(56010; "Leistungsfortschritt %"; Integer)
        {
            Caption = 'Performance progress %';
            Description = 'G-ERP';
        }
        field(60000; "Folder Created"; Boolean)
        {
            Description = 'G-ERP';
        }
        field(60001; Subproject; Boolean)
        {
            Caption = 'Unterprojekt';
            Description = 'G-ERP';
            InitValue = false;
        }
        field(60002; MainProjektNo; Code[20])
        {
            Caption = 'Hauptprojekt Nr.';
            Description = 'G-ERP';
        }
        field(60100; SumProject; Boolean)
        {
            Caption = 'Summen Projekt';
            Description = 'G-ERP';
            InitValue = false;
        }
    }

    // trigger OnInsert()
    // var
    //     JobTypePage: Page "Job Type";
    //     JobsSetup: Record "Jobs Setup";
    //     NoSeriesMgt: Codeunit NoSeriesManagement;
    // begin
    //     IF "No." = '' THEN BEGIN
    //         //G-ERP+
    //         FILTERGROUP(2);
    //         Clear(JobTypePage);
    //         JobTypePage.SetTableView(JobType);
    //         JobTypePage.SetRecord(JobType);
    //         IF JobTypePage.RUNMODAL = ACTION::LookupOK THEN BEGIN
    //             JobsSetup.TESTFIELD("Job Nos.");
    //             NoSeriesMgt.InitSeries(JobsSetup."Job Nos.", xRec."No. Series", 0D, "No.", "No. Series");
    //             "No." := "No." + '.' + COPYSTR(JobType.Code, 1, 1);
    //             "Job Type" := JobType.Code;
    //             FILTERGROUP(0);
    //         END
    //         ELSE BEGIN
    //             FILTERGROUP(0);
    //             ERROR('Verarbeitung abgebrochen!');
    //         END;
    //         // G-ERP-
    //     end;
    // end;

    trigger OnModify()
    begin
        CreateFolder(); //G-ERP.RS 2019-01-24
    end;

    procedure SalesQuoteCreate(): Code[20]
    var
        l_SalesHeader: Record "Sales Header";
    begin
        TestField("Bill-to Customer No.");
        Clear(l_SalesHeader);
        l_SalesHeader.Validate("Document Type", l_SalesHeader."document type"::Quote);
        l_SalesHeader."No." := '';
        l_SalesHeader.Insert(true);
        l_SalesHeader.Validate("Sell-to Customer No.", "Bill-to Customer No.");
        l_SalesHeader.Validate("Posting Date", Today);
        l_SalesHeader.Validate("Job No.", "No.");
        if "Currency Code" <> '' then
            l_SalesHeader.Validate("Currency Code", "Currency Code");
        l_SalesHeader.Modify;
        exit(l_SalesHeader."No.");
    end;

    procedure SalesOrderCreate(): Code[20]
    var
        l_SalesHeader: Record "Sales Header";
        l_SalesHeader2: Record "Sales Header";
        l_SalesLine: Record "Sales Line";
        //SalesQuotetoOrder: Codeunit "Sales-Quote to Order";
        Angebotsnr: Code[10];
    begin
        // if Status = Status::Order then begin
        //     l_SalesHeader.SetRange("Document Type", l_SalesHeader."document type"::Quote);
        //     l_SalesHeader.SetRange("Job No.", Planungsprojektnummer);
        //     if l_SalesHeader.FindLast then begin
        //         Angebotsnr := l_SalesHeader."No.";
        //         // SalesQuotetoOrder.SetHideValidationDialog := true;
        //         // SalesQuotetoOrder.Run(l_SalesHeader);
        //         l_SalesHeader2.SetRange("Quote No.", Angebotsnr);
        //         if l_SalesHeader2.FindSet then begin
        //             l_SalesHeader2."Job No." := "No.";
        //             l_SalesHeader2.Unterschriftscode := '';
        //             l_SalesHeader2."Unterschriftscode 2" := '';
        //             l_SalesHeader2.Modify;
        //             l_SalesLine.SetRange("Document Type", l_SalesHeader2."Document Type");
        //             l_SalesLine.SetRange("Document No.", l_SalesHeader2."No.");
        //             if l_SalesLine.FindSet then
        //                 repeat
        //                     l_SalesLine."Job No." := l_SalesHeader2."Job No.";
        //                     l_SalesLine.Modify;
        //                 until l_SalesLine.Next = 0;
        //         end;
        //         exit(l_SalesHeader2."No.");
        //     end
        //     else begin
        //         TestField("Bill-to Customer No.");
        //         Clear(l_SalesHeader);
        //         l_SalesHeader.Validate("Document Type", l_SalesHeader."document type"::Order);
        //         l_SalesHeader."No." := '';
        //         l_SalesHeader.Insert(true);
        //         l_SalesHeader.Validate("Sell-to Customer No.", "Bill-to Customer No.");
        //         l_SalesHeader.Validate("Posting Date", Today);
        //         l_SalesHeader.Validate("Job No.", "No.");
        //         l_SalesHeader.Modify;
        //         exit(l_SalesHeader."No.");
        //     end;
        // end;
    end;

    procedure CreateFolder()
    var
        // FileManagement: Codeunit "File Management";
        JobsSetup: Record "Jobs Setup";
        Job_DefaultFolder: Record Job_DefaultFolder;
        CompanyInformation: Record "Company Information";
        Subproject_b: Boolean;
        Folder: Text[100];
    begin
        //G-ERP.RS 2019-01-23 +++
        if UpperCase(UserId) = 'TURBO-TECHNIK\GERWING-ERP' then begin

            JobsSetup.Get();
            if not ("Folder Created") then begin
                if ("No." <> '') and (Description <> '') then begin
                    Folder := JobsSetup.Folder + Format(Date2dmy(Today, 3)) + '\';

                    if Subproject then begin
                        Job_DefaultFolder.SetRange(Code, Job_DefaultFolder.Code::Subproject);
                        Folder := Folder + MainProjektNo + ' ' + Description + '\';
                    end else
                        Job_DefaultFolder.SetRange(Code, Job_DefaultFolder.Code::Project);

                    // Folder := Folder + "No." + ' ' + Description;
                    // FileManagement.CreateClientDirectory(Folder);

                    // if Job_DefaultFolder.FindSet() then begin
                    //     repeat
                    //         FileManagement.CreateClientDirectory(Folder + '\' + Job_DefaultFolder."Folder Name");
                    //     until (Job_DefaultFolder.Next = 0);
                    // end;
                    // "Folder Created" := true;
                end;
            end;

        end;
        //G-ERP.RS 2019-01-23 ---
    end;

    var
        JobType: Record "Job Type";

    var
        WIPQst: Text;
}

