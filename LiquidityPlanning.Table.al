#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50021 "Liquidity Planning"
{
    Caption = 'Liquiditätsplanung';

    fields
    {
        field(1;"Job No.";Code[20])
        {
            Caption = 'Projekt Nummer';
            TableRelation = Job;
        }
        field(2;"Entry No.";Integer)
        {
            Caption = 'Lfd. Nr.';
        }
        field(10;"Planned invoice date";Date)
        {
            Caption = 'Geplantes Rechnungsdatum';
        }
        field(20;Amount;Decimal)
        {
            Caption = 'Betrag';
        }
        field(30;"Invoice No.";Code[20])
        {
            Caption = 'Rechnungsnummer';
        }
        field(40;"Posted Invoice No.";Code[20])
        {
            Caption = 'Geb. Rechnungsnummer';
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

