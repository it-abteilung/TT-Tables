TableExtension 50036 tableextension50036 extends Contact
{
    fields
    {
        field(50000; "Vendor No. TT"; Code[20])
        {
            CalcFormula = lookup("Contact Business Relation"."No." where("Business Relation Code" = filter('KRED'),
                                                                          "Contact No." = field("No.")));
            Caption = 'Kreditor Nr.';
            Description = 'G-ERP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Customer No. TT"; Code[20])
        {
            CalcFormula = lookup("Contact Business Relation"."No." where("Business Relation Code" = filter('DEB'),
                                                                          "Contact No." = field("No.")));
            Caption = 'Debitor Nr.';
            Description = 'G-ERP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50013; Abteilung; Text[200])
        {
            Description = 'G-ERP';
        }
        field(50040; "Private Phone Number"; Text[30])
        {
            Caption = 'Private Phone Number';
            Description = 'G-ERP';
        }
        field(50100; Branche; Code[10])
        {
            Caption = 'Branche';
            Description = 'G-ERP';
            TableRelation = "Industry Group";
        }
        field(50500; "EK-Anfragen"; Integer)
        {
            CalcFormula = count("Purchase Header" where("Document Type" = const(Quote),
                                                         "Buy-from Vendor No." = field("Vendor No. TT")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50501; "EK-Bestellungen"; Integer)
        {
            CalcFormula = count("Purchase Header" where("Document Type" = const(Order),
                                                         "Buy-from Vendor No." = field("Vendor No. TT")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50502; "EK-Rechnungen"; Integer)
        {
            CalcFormula = count("Purch. Inv. Header" where("Buy-from Vendor No." = field("Vendor No. TT")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50503; "EK-Gutschrift"; Integer)
        {
            CalcFormula = count("Purch. Cr. Memo Hdr." where("Buy-from Vendor No." = field("Vendor No. TT")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(51000; "Anzahl Projekte"; Integer)
        {
            CalcFormula = count(Job where("Bill-to Contact No." = field("No."),
                                           Status = filter(Planning | Quote)));
            Caption = 'Anzahl Projekte';
            Description = 'G-ERP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(51001; "Anzahl Aufträge"; Integer)
        {
            CalcFormula = count(Job where("Bill-to Contact No." = field("No."),
                                            Status = filter(Open)));
            Caption = 'Anzahl Aufträge>';
            Description = 'G-ERP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(82000; "Person Information"; Text[200])
        {
            Caption = 'Person Information';
        }
        field(82001; "Display Level"; Integer)
        {
            Caption = 'Display Level';
            Description = 'for Persons only';
        }
        field(82002; "Dialing Code"; Text[30])
        {
            Caption = 'Dialing Code';
            CharAllowed = '09--';

            trigger OnValidate()
            begin
                // + 01 ctm.we
                //generatePhoneNo;
                // - 01 ctm.we
            end;
        }
        field(82003; "Travel Time / h"; Decimal)
        {
            Caption = 'Travel Time / h';
            DecimalPlaces = 0 : 2;
        }
        field(82004; "Single Distance"; Integer)
        {
            BlankZero = true;
            Caption = 'Single Distance';

            trigger OnValidate()
            begin
                /*
                rDistanceZone.SETFILTER("Distance up to km",'>=%1',"Single Distance");
                IF rDistanceZone.FIND('-') THEN BEGIN
                  IF rDistanceZone.FIND('>') THEN
                    rDistanceZone.NEXT(-1);
                  "Distance Zone" := rDistanceZone.Zone;
                END ELSE BEGIN
                  rDistanceZone.SETRANGE("Distance up to km");
                  IF rDistanceZone.FIND('+') THEN
                    "Distance Zone" := rDistanceZone.Zone;
                END;
                IF (xRec."Distance Zone" <> 0) AND (xRec."Distance Zone" <> "Distance Zone") THEN
                  IF NOT CONFIRM(Text1000000000,TRUE,xRec."Distance Zone","Distance Zone") THEN
                    "Distance Zone" := xRec."Distance Zone";
                */

            end;
        }
        field(82005; "Distance Zone"; Integer)
        {
            Caption = 'Distance Zone';
        }
        field(82006; "Date of First Contact"; Date)
        {
            Caption = 'Date of First Contact';
        }
        field(82007; "Name 3"; Text[50])
        {
            Caption = 'Name 3';
        }
        field(82008; "Contact Information 1"; Text[70])
        {
            Caption = 'Contact Information 1';
        }
        field(82009; "Contact Information 2"; Text[70])
        {
            Caption = 'Contact Information 2';
        }
        field(82010; "Contact Information 3"; Text[70])
        {
            Caption = 'Contact Information 3';
        }
        field(82011; "Contact Information 4"; Text[70])
        {
            Caption = 'Contact Information 4';
        }
        field(82012; "Modified from"; Code[20])
        {
            Caption = 'Modified from';
            Editable = false;

            trigger OnLookup()
            var
            // LoginManagement: Codeunit "User Management";
            // DummyUser: Code[20];
            begin
                //DummyUser := "Modified from";
                //LoginManagement.ValidateUserName(DummyUser);
            end;
        }
        field(82013; "Business Condition"; Code[10])
        {
            Caption = 'Business Condition';
        }
        field(82014; "Nominal 1"; Code[10])
        {
            CaptionClass = '82000,1,82000';
            Caption = 'n1';
        }
        field(82015; "Nominal 2"; Code[10])
        {
            CaptionClass = '82000,1,82001';
            Caption = 'n2';
        }
        field(82016; "Nominal 3"; Code[10])
        {
            CaptionClass = '82000,1,82002';
            Caption = 'n3';
        }
        field(82017; "Nominal 4"; Code[10])
        {
            CaptionClass = '82000,1,82003';
            Caption = 'n4';
        }
        field(82018; "Nominal 5"; Code[10])
        {
            CaptionClass = '82000,1,82004';
            Caption = 'n5';
        }
        field(82019; "Actual 1"; Code[10])
        {
            CaptionClass = '82000,1,82000';
            Caption = 'a1';
        }
        field(82020; "Actual 2"; Code[10])
        {
            CaptionClass = '82000,1,82001';
            Caption = 'a2';
        }
        field(82021; "Actual 3"; Code[10])
        {
            CaptionClass = '82000,1,82002';
            Caption = 'a3';
        }
        field(82022; "Actual 4"; Code[10])
        {
            CaptionClass = '82000,1,82003';
            Caption = 'a4';
        }
        field(82023; "Actual 5"; Code[10])
        {
            CaptionClass = '82000,1,82004';
            Caption = 'a5';
        }
        field(82024; "Actual 6"; Code[10])
        {
            CaptionClass = '82000,1,82005';
            Caption = 'a6';
        }
        field(82025; "Nominal 6"; Code[10])
        {
            CaptionClass = '82000,1,82005';
            Caption = 'n6';
        }
        field(82026; "Sales Mio."; Decimal)
        {
            Caption = 'Sales Mio.';
        }
        field(82027; Employee; Integer)
        {
            Caption = 'Employee';
        }
        field(82028; "Employee Group"; Integer)
        {
            CaptionClass = '82000,1,82006';
            Caption = 'Employee Group';
        }
        field(82029; "Budget Last Year Group"; Integer)
        {
            CaptionClass = '82000,1,82007';
            Caption = 'Budget Last Year Group';
        }
        field(82030; "Budget Year Group"; Integer)
        {
            CaptionClass = '82000,1,82008';
            Caption = 'Budget Year Group';
        }
        field(82031; "Foundation Year"; Integer)
        {
            Caption = 'Foundation Year';
        }
        field(82032; Source; Code[10])
        {
            Caption = 'Source';
        }
        field(82033; "Agreement Type"; Code[10])
        {
            Caption = 'Agreement Type';
        }
        field(82034; Partner; Text[50])
        {
            Caption = 'Partner';
        }
        field(82048; "Conclusion Criterion 1"; Decimal)
        {
            CaptionClass = '82000,1,82009';
            Caption = 'Conclusion Criterion 1';
        }
        field(82049; "Conclusion Criterion 2"; Decimal)
        {
            CaptionClass = '82000,1,82010';
            Caption = 'Conclusion Criterion 2';
        }
        field(82050; "Conclusion Criterion 3"; Decimal)
        {
            CaptionClass = '82000,1,82011';
            Caption = 'Conclusion Criterion 3';
        }
        field(82051; "Conclusion Criterion 4"; Decimal)
        {
            CaptionClass = '82000,1,82012';
            Caption = 'Conclusion Criterion 4';
        }
        field(82052; "Conclusion Criterion 5"; Decimal)
        {
            CaptionClass = '82000,1,82013';
            Caption = 'Conclusion Criterion 5';
        }
        field(82053; "Conclusion Criterion 6"; Decimal)
        {
            CaptionClass = '82000,1,82014';
            Caption = 'Conclusion Criterion 6';
        }
        field(82054; "Conclusion Criterion 7"; Decimal)
        {
            CaptionClass = '82000,1,82015';
            Caption = 'Conclusion Criterion 7';
        }
        field(82055; "Conclusion Criterion Code 1"; Code[10])
        {
            Caption = 'Conclusion Criterion Code 1';

            trigger OnValidate()
            begin
                /*
                IF rCriteriaCode.GET("Conclusion Criterion Code 1") THEN
                  VALIDATE("Conclusion Criterion 1", rCriteriaCode.Rating)
                ELSE
                  VALIDATE("Conclusion Criterion 1", 0)
                */

            end;
        }
        field(82056; "Conclusion Criterion Code 2"; Code[10])
        {
            Caption = 'Conclusion Criterion Code 2';

            trigger OnValidate()
            begin
                /*
                IF rCriteriaCode.GET("Conclusion Criterion Code 2") THEN
                  VALIDATE("Conclusion Criterion 2", rCriteriaCode.Rating)
                ELSE
                  VALIDATE("Conclusion Criterion 2", 0)
                */

            end;
        }
        field(82057; "Conclusion Criterion Code 3"; Code[10])
        {
            Caption = 'Conclusion Criterion Code 3';

            trigger OnValidate()
            begin
                /*
                IF rCriteriaCode.GET("Conclusion Criterion Code 3") THEN
                  VALIDATE("Conclusion Criterion 3", rCriteriaCode.Rating)
                ELSE
                  VALIDATE("Conclusion Criterion 3", 0)
                */

            end;
        }
        field(82058; "Conclusion Criterion Code 4"; Code[10])
        {
            Caption = 'Conclusion Criterion Code 4';

            trigger OnValidate()
            begin
                /*
                IF rCriteriaCode.GET("Conclusion Criterion Code 4") THEN
                  VALIDATE("Conclusion Criterion 4", rCriteriaCode.Rating)
                ELSE
                  VALIDATE("Conclusion Criterion 4", 0)
                */

            end;
        }
        field(82059; "Conclusion Criterion Code 5"; Code[10])
        {
            Caption = 'Conclusion Criterion Code 5';

            trigger OnValidate()
            begin
                /*
                IF rCriteriaCode.GET("Conclusion Criterion Code 5") THEN
                  VALIDATE("Conclusion Criterion 5", rCriteriaCode.Rating)
                ELSE
                  VALIDATE("Conclusion Criterion 5", 0)
                */

            end;
        }
        field(82060; "Conclusion Criterion Code 6"; Code[10])
        {
            Caption = 'Conclusion Criterion Code 6';

            trigger OnValidate()
            begin
                /*
                IF rCriteriaCode.GET("Conclusion Criterion Code 6") THEN
                  VALIDATE("Conclusion Criterion 6", rCriteriaCode.Rating)
                ELSE
                  VALIDATE("Conclusion Criterion 6", 0)
                */

            end;
        }
        field(82061; "Conclusion Criterion Code 7"; Code[10])
        {
            Caption = 'Conclusion Criterion Code 7';

            trigger OnValidate()
            begin
                /*
                IF rCriteriaCode.GET("Conclusion Criterion Code 7") THEN
                  VALIDATE("Conclusion Criterion 7", rCriteriaCode.Rating)
                ELSE
                  VALIDATE("Conclusion Criterion 7", 0)
                */

            end;
        }
        field(82071; "amount of quotes"; Integer)
        {
            Caption = 'amount of quotes';
            Editable = false;
        }
        field(82072; "amount of orders"; Integer)
        {
            Caption = 'amount of orders';
            Editable = false;
        }
        field(82073; "Competitor 1"; Code[10])
        {
            Caption = 'Competitor 1';
        }
        field(82074; "Competitor 2"; Code[10])
        {
            Caption = 'Competitor 2';
        }
        field(82075; "Competitor 3"; Code[10])
        {
            Caption = 'Competitor 3';
        }
        field(82081; "Order Date as per  Customer"; Text[5])
        {
            Caption = 'Order Date as per  Customer';
        }
        field(82082; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
        }
        field(82084; "Privat Phone No."; Text[30])
        {
            Caption = 'Privat Phone No.';
        }
        field(82085; "Privat E-Mail"; Text[100])
        {
            Caption = 'Privat E-Mail';
        }
        field(82086; "Privat Fax No."; Text[30])
        {
            Caption = 'Privat Fax No.';
        }
        field(82087; "Job Responsibilities"; Code[10])
        {
            CalcFormula = lookup("Contact Job Responsibility"."Job Responsibility Code" where("Contact No." = field("No.")));
            Caption = 'Job Responsibilities';
            Editable = false;
            FieldClass = FlowField;
        }
        field(82088; "Business Relations"; Code[10])
        {
            CalcFormula = lookup("Contact Business Relation"."Business Relation Code" where("Contact No." = field("Company No.")));
            Caption = 'Business Relations';
            Editable = false;
            FieldClass = FlowField;
        }
        field(82089; "Industry Groups"; Code[10])
        {
            CalcFormula = lookup("Contact Industry Group"."Industry Group Code" where("Contact No." = field("Company No.")));
            Caption = 'Industry Groups';
            Editable = false;
            FieldClass = FlowField;
        }
        field(82090; "Old Sales No."; Code[20])
        {
            Caption = 'Old Sales No.';
            Description = 'only for upgrade from SalesFIN';
        }
        field(82091; "Old Kontaktperson No."; Code[20])
        {
            Caption = 'Old Contactperson No.';
            Description = 'only for upgrade from SalesFIN';
        }
        field(83792; "Is Customer"; Boolean)
        {
            CalcFormula = exist("Contact Business Relation" where("Contact No." = field("No."),
                                                                   "Link to Table" = const(Customer),
                                                                   "No." = filter(<> '')));
            Caption = 'Is Customer';
            Editable = false;
            FieldClass = FlowField;
        }
        field(83793; "Is Vendor"; Boolean)
        {
            CalcFormula = exist("Contact Business Relation" where("Contact No." = field("No."),
                                                                   "Link to Table" = const(Vendor),
                                                                   "No." = filter(<> '')));
            Caption = 'Is Vendor';
            Editable = false;
            FieldClass = FlowField;
        }
        field(83798; Canceled; Boolean)
        {
            Caption = 'Canceled';
        }
        field(83800; "Customer No."; Code[20])
        {
            CalcFormula = lookup("Contact Business Relation"."No." where("Contact No." = field("No."),
                                                                          "Link to Table" = const(Customer)));
            Caption = 'Customer No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(83801; "Complete Phone No."; Text[90])
        {
            Caption = 'Complete Phone No.';
        }
        field(83802; "Vendor No."; Code[20])
        {
            CalcFormula = lookup("Contact Business Relation"."No." where("Contact No." = field("No."),
                                                                          "Link to Table" = const(Vendor)));
            Caption = 'Vendor No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(88000; "Industry Group Text"; Text[200])
        {
            Caption = 'Industry Group Text';
            Description = 'ctm.we';
            Editable = false;
        }
        field(88001; DATEV; Code[20])
        {
            Caption = 'DATEV';
            Description = 'G-ERP';
        }
    }
}

