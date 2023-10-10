#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50019 "Artikel-Seriennr"
{

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Artikelnr.';
            TableRelation = Item."No.";
        }
        field(2; "Serial No."; Code[20])
        {
            Caption = 'Seriennr.';
        }
        field(10; "Serial No. Description"; Text[100])
        {
            Caption = 'Seriennr. Beschreibung';
        }
        field(20; "Serial No. Description 2"; Text[500])
        {
            Caption = 'Seriennr. Beschreibung 2';
        }
        field(30; Hersteller; Text[50])
        {
        }
        field(40; "Hersteller Typ"; Text[50])
        {
        }
        field(50; "Hersteller Seriennr."; Text[50])
        {
        }
        field(55; "Hersteller-Bezeichnung"; Text[50])
        {
        }
        field(60; Strom; Text[50])
        {
        }
        field(70; Spannung; Text[50])
        {
        }
        field(80; Leistung; Text[50])
        {
        }
        field(85; "Letzte Prüfung"; Date)
        {
        }
        field(90; "Nächste Prüfung"; Date)
        {
        }
        field(100; Baujahr; Text[50])
        {
        }
        field(110; ZG; Date)
        {
        }
        field(120; Traglast; Decimal)
        {
        }
        field(130; "Hubhöhe"; Text[50])
        {
        }
        field(140; "Gewicht (kg)"; Decimal)
        {
        }
        field(200; "Object ID"; Code[20])
        {
            Caption = 'Objekt ID';
        }
        field(300; Bestand; Boolean)
        {
            CalcFormula = lookup("Item Ledger Entry".Open where("Item No." = field("Item No."),
                                                                 "Serial No." = field("Serial No."),
                                                                 Open = const(true)));
            FieldClass = FlowField;
        }
        field(500; Description; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Caption = 'Beschreibung';
            Editable = false;
            FieldClass = FlowField;
        }
        field(510; "Description 2"; Text[50])
        {
            CalcFormula = lookup(Item."Description 2" where("No." = field("Item No.")));
            Caption = 'Beschreibung 2';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Item No.", "Serial No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

