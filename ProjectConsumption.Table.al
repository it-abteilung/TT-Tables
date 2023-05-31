#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50024 "Project Consumption"
{
    // ***************************************************************
    // *                 Gerwing-ERP Software GmbH                   *
    // ***************************************************************
    // 
    // Nummer  Datum       Benutzer      Gruppe      Ticket  Bemerkung
    // 01      2021-02-02  Stalljann     Erstellung  239310  Erstellung der Page.
    //                                                       Diese Page ist da um Bestände die auf den Projekten gebucht wurden, wieder auszubuchen.
    // 02      2021-02-04  Stalljann     Anpassung   239310  Die folgenden Felder wurden aufgenommen:
    //                                                        -  3 Bin Code da die Projekt Nr. nicht immer der Lagerplatznummer entspricht
    //                                                        - 70 Item TT Type für die Unterscheidung ob der Artikel Material oder Werkzeug ist.
    // 03      2021-03-09  Stalljann     Anpassung   239310  Anpassung der Caption des Feldes Unit Price von VK-Preis in Verkaufspreis Änderung
    // 04      2021-03-09  Stalljann     Anpassung   239310  Hinzufügen der Spalten "Selling Price Project", "Employee" und "Employee No."

    Caption = 'Projekt Verbrauch';

    fields
    {
        field(1;"Job No.";Code[20])
        {
            Caption = 'Projekt Nr.';
            NotBlank = true;
            TableRelation = Job;
        }
        field(2;"Entry No.";Integer)
        {
            Caption = 'Lfd. Nr.';
        }
        field(3;"Bin Code";Code[20])
        {
            Caption = 'Lagerplatz Code';
            TableRelation = Bin;
        }
        field(10;"Item No.";Code[20])
        {
            Caption = 'Artikel Nr.';
            TableRelation = Item;
        }
        field(11;"Item Description";Text[50])
        {
            Caption = 'Artikel Beschreibung';
        }
        field(12;"Item Description 2";Text[50])
        {
            Caption = 'Artikel Beschreibung 2';
        }
        field(20;Stock;Decimal)
        {
            Caption = 'Bestand';
        }
        field(30;"Serial No.";Code[20])
        {
            Caption = 'Seriennr.';
        }
        field(40;"Lot No.";Code[20])
        {
            Caption = 'Chargennr.';
        }
        field(50;Quantity;Decimal)
        {
            Caption = 'Menge';
        }
        field(60;"Post Out";Boolean)
        {
            Caption = 'Ausbuchen';
        }
        field(70;"Item TT Type";Option)
        {
            Caption = 'Artikel TT Art';
            OptionMembers = Material,Werkzeug;
        }
        field(80;"Last Direct Cost";Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Last Direct Cost';
            MinValue = 0;
        }
        field(90;"Unit Price";Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';
            MinValue = 0;

            trigger OnValidate()
            begin
                "Selling Price Project" := "Unit Price";
            end;
        }
        field(100;"Selling Price Project";Decimal)
        {
            Caption = 'Verkaufspreis Projekt';
        }
        field(110;Employee;Text[50])
        {
            Caption = 'Mitarbeiter';
        }
        field(120;"Employee No.";Code[20])
        {
            Caption = 'Mitarbeiter Nr.';
            TableRelation = Employee;
        }
        field(130;"Unit of Measure";Code[10])
        {
            Caption = 'Einheit';
        }
    }

    keys
    {
        key(Key1;"Job No.","Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

