#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50007 Materialanforderungskopf
{
    //DrillDownPageID = UnknownPage50064;
    //LookupPageID = UnknownPage50064;

    fields
    {
        field(1; "Projekt Nr"; Code[20])
        {
            TableRelation = Job."No.";
            Caption = 'Projekt-Nr.';
        }
        field(2; "Lfd Nr"; Integer)
        {
            Caption = 'Lfd. Nr.';
        }
        field(10; Belegdatum; Date)
        {
        }
        field(20; "Geplantes Versanddatum"; Date)
        {
        }
        field(30; Status; Option)
        {
            OptionCaption = 'erfasst,freigegeben,beendet';
            OptionMembers = erfasst,freigegeben,beendet;
        }
        field(80; "Place of Delivery"; Option)
        {
            Caption = 'Lieferort';
            OptionMembers = "WHV","Benutzerdefinitert";
        }
        field(81; "Ship-to Name"; Text[100])
        {
            Caption = 'Name';
        }
        field(82; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(83; "Ship-to Address"; Text[100])
        {
            Caption = 'Adresse';
        }
        field(84; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Adresse 2';
        }
        field(85; "Ship-to City"; Text[30])
        {
            Caption = 'Ort';
        }
        field(86; "Ship-to Post Code"; Code[20])
        {
            Caption = 'PLZ';
        }
        field(87; "Ship-to Country/Region Code"; Code[10])
        {
            Caption = 'Land/Region';
            TableRelation = "Country/Region";
        }
        field(88; "Ship-to Contact"; Text[100])
        {
            TableRelation = Resource."No.";
            Caption = 'Kontakt';
            ValidateTableRelation = false;
        }
        field(90; "Purchase Order Date"; Date)
        {
            Caption = 'Delivery Date';
        }
        field(91; "Delivery Period"; Code[50])
        {
            Caption = 'Delivery Period';
        }
        field(500; Beschreibung; Text[100])
        {
            CalcFormula = lookup(Job.Description where("No." = field("Projekt Nr")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(501; "Beschreibung 2"; Text[50])
        {
            CalcFormula = lookup(Job."Description 2" where("No." = field("Projekt Nr")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(502; Stichwort; Text[50])
        {
            Caption = 'Anforderungsgrund';
        }
        field(600; Typ; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Stock,Order,Request';
            OptionMembers = " ",Lagerware,Bestellung,Anfrage;
        }
        field(610; Anforderer; Code[50])
        {
        }
        field(700; Vorlauftext; Code[20])
        {
            Caption = 'Vortext 1';
            TableRelation = "Standard Text";
        }
        field(701; "Vorlauftext 2"; Code[20])
        {
            Caption = 'Vortext 2';
            TableRelation = "Standard Text";
        }
        field(702; "Vorlauftext m"; Text[1000])
        {
            Caption = 'Vortext manuell';
        }
        field(710; Nachlauftext; Code[20])
        {
            Caption = 'Nachtext 1';
            TableRelation = "Standard Text";
        }
        field(711; "Nachlauftext 2"; Code[20])
        {
            Caption = 'Nachtext 2';
            TableRelation = "Standard Text";
        }
        field(712; "Nachlauftext m"; Text[1000])
        {
            Caption = 'Nachtext manuell';
        }
        field(720; Leistung; Text[120])
        {
            Caption = 'Leistung';
        }
        field(730; AngebotsAbgabeBis; Date)
        {
            Caption = 'Angebots abgabe bis';
        }
        field(740; "GewünschtesWareneingangsdatum"; Date)
        {
            Caption = 'Gewünschtes Wareneingangsdatum';
        }
    }

    keys
    {
        key(Key1; "Projekt Nr", "Lfd Nr")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        Materialanforderungzeile_l: Record Materialanforderungzeile;
        VendorSerienanfrage_l: Record "Vendor - Serienanfrage";
    begin
        //G-ERP.RS 2021-05-25 +
        Materialanforderungzeile_l.SetRange("Projekt Nr", "Projekt Nr");
        Materialanforderungzeile_l.SetRange("Lfd Nr", "Lfd Nr");
        Materialanforderungzeile_l.DeleteAll();

        VendorSerienanfrage_l.SetRange(Serienanfragenr, Format("Projekt Nr") + ';' + Format("Lfd Nr"));
        VendorSerienanfrage_l.DeleteAll();
        //G-ERP.RS 2021-05-25 -
    end;

    trigger OnInsert()
    begin
        Anforderer := UserId; //G-ERP.RS 2021-05-25
    end;
}