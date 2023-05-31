#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50006 "Packliste Erfassung"
{

    fields
    {
        field(1;"Projektnr.";Code[10])
        {
        }
        field(2;"Zeilennr.";Integer)
        {
        }
        field(10;"Artikelnr.";Code[20])
        {
            TableRelation = Item."No.";

            trigger OnValidate()
            var
                l_ItemRec: Record Item;
            begin
                if l_ItemRec.Get("Artikelnr.") then begin
                  Beschreibung := l_ItemRec.Description;
                  "Beschreibung 2" := l_ItemRec."Description 2";
                end;
            end;
        }
        field(20;"Seriennr.";Code[20])
        {
        }
        field(30;Menge;Decimal)
        {
        }
        field(40;Beschreibung;Text[50])
        {
        }
        field(50;"Beschreibung 2";Text[50])
        {
        }
        field(60;Packmittel;Code[20])
        {
        }
        field(70;Gebucht;Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Projektnr.","Zeilennr.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

