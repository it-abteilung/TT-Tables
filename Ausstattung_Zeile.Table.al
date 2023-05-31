#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50012 Ausstattung_Zeile
{

    fields
    {
        field(1; "Lfd Nr"; Integer)
        {
        }
        field(10; "Projekt Nr"; Code[20])
        {
        }
        field(20; "Mitarbeiter Nr"; Code[20])
        {
        }
        field(30; "Artikel Nr"; Code[20])
        {
        }
        field(40; Beschreibung; Text[50])
        {
        }
        field(41; "Beschreibung 2"; Text[50])
        {
        }
        field(50; Seriennummer; Code[20])
        {

            trigger OnValidate()
            begin
                ArtikelSeriennr.Get("Artikel Nr", Seriennummer);
            end;
        }
        field(60; Postenart; Code[20])
        {
        }
        field(70; Buchungsdatum; DateTime)
        {
        }
        field(80; Menge; Decimal)
        {
        }
        field(90; Restmenge; Decimal)
        {
        }
        field(100; Offen; Boolean)
        {
        }
        field(110; Einheit; Code[10])
        {
        }
        field(200; "User ID"; Code[20])
        {
        }
        field(210; gebucht; Boolean)
        {
        }
        field(220; uebertragen; Boolean)
        {
            Caption = 'übertragen';
        }
        field(500; "Mitarbeiter Name"; Text[100])
        {
            CalcFormula = lookup(Resource.Name where("No." = field("Mitarbeiter Nr")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(600; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Lfd Nr")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ArtikelSeriennr: Record "Artikel-Seriennr";


    procedure Zeilenuebertragen()
    var
        L_Ausstattung_Posten: Record Ausstattung_Posten;
        L_Item: Record Item;
        L_JobJournalLine: Record "Job Journal Line";
        llfdnr_Mat: Integer;
        llfndr_Werk: Integer;
    begin
        Clear(L_Ausstattung_Posten);
        L_Ausstattung_Posten.SetRange(gebucht, true);
        L_Ausstattung_Posten.SetRange(uebertragen, false);
        if L_Ausstattung_Posten.FindSet then
            repeat
                L_Item.Get(L_Ausstattung_Posten."Artikel Nr");
                if L_Item."TT Type" = L_Item."tt type"::Material then begin
                    if llfdnr_Mat = 0 then begin
                        Clear(L_JobJournalLine);
                        L_JobJournalLine.SetRange("Journal Template Name", 'PROJEKT');
                        L_JobJournalLine.SetRange("Journal Batch Name", 'MATERIAL');
                        if L_JobJournalLine.FindLast then
                            llfdnr_Mat := L_JobJournalLine."Line No.";
                    end;
                    llfdnr_Mat += 10000;
                    Clear(L_JobJournalLine);
                    L_JobJournalLine.Validate("Journal Template Name", 'PROJEKT');
                    L_JobJournalLine.Validate("Journal Batch Name", 'MATERIAL');
                    L_JobJournalLine.Validate("Line No.", llfdnr_Mat);
                    L_JobJournalLine.Insert(true);
                end
                else begin
                    if llfndr_Werk = 0 then begin
                        Clear(L_JobJournalLine);
                        L_JobJournalLine.SetRange("Journal Template Name", 'PROJEKT');
                        L_JobJournalLine.SetRange("Journal Batch Name", 'WERKZEUG');
                        if L_JobJournalLine.FindLast then
                            llfndr_Werk := L_JobJournalLine."Line No.";
                    end;
                    llfndr_Werk += 10000;
                    Clear(L_JobJournalLine);
                    L_JobJournalLine.Validate("Journal Template Name", 'PROJEKT');
                    L_JobJournalLine.Validate("Journal Batch Name", 'WERKZEUG');
                    L_JobJournalLine.Validate("Line No.", llfndr_Werk);
                    L_JobJournalLine.Insert(true);
                end;
                L_JobJournalLine.Validate("Posting Date", Dt2Date(L_Ausstattung_Posten.Buchungsdatum));
                L_JobJournalLine.Validate("Document No.", 'Auslagerung');
                L_JobJournalLine.Validate("Job No.", L_Ausstattung_Posten."Projekt Nr");
                L_JobJournalLine.Validate(Type, L_JobJournalLine.Type::Item);
                L_JobJournalLine.Validate("No.", L_Ausstattung_Posten."Artikel Nr");
                L_JobJournalLine.Validate(Quantity, L_Ausstattung_Posten.Menge);
                L_JobJournalLine.Validate("Unit of Measure Code", L_Ausstattung_Posten.Einheit);
                if L_Ausstattung_Posten.Seriennummer <> '' then
                    L_JobJournalLine.Validate("Serial No.", L_Ausstattung_Posten.Seriennummer);
                if L_Ausstattung_Posten."Mitarbeiter Nr" <> '' then
                    L_JobJournalLine.Validate("Mitarbeiter Nr", L_Ausstattung_Posten."Mitarbeiter Nr");
                L_JobJournalLine.Modify(true);
                L_Ausstattung_Posten.uebertragen := true;
                L_Ausstattung_Posten.Modify;
            until L_Ausstattung_Posten.Next = 0;
    end;
}

