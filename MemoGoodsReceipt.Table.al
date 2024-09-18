table 50026 "Memo. Goods Receipt"
{
    Caption = 'TT Fehler im Wareneingang';
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Lfd Nr.';
            AutoIncrement = true;
        }
        field(10; "Order No."; Code[20])
        {
            Caption = 'Bestellnr.';
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));
        }
        field(15; "Job No."; Code[20])
        {
            Caption = 'Projektnr.';
            TableRelation = Job;
        }
        field(20; "Item No."; Code[20])
        {
            Caption = 'Artikelnr.';
            TableRelation = Item;
        }
        field(25; Description; Text[200])
        {
            Caption = 'Beschreibung';
        }
        field(30; Quantity; Decimal)
        {
            Caption = 'Tatsächliche Menge';
            BlankZero = false;
        }
        field(33; "Quantity Ordered"; Decimal)
        {
            Caption = 'Bestellmenge';
            BlankZero = false;
        }
        field(35; "Quantity Received"; Decimal)
        {
            Caption = 'Gebuchte Menge';
            BlankZero = false;
        }
        field(40; Reason; Text[200])
        {
            Caption = 'Begründung';
        }
        field(50; Blocked; Boolean)
        {
            Caption = 'Erledigt';
        }
    }

    keys
    {
        key(key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if Rec."Order No." = '' then Error('Die Bestellnr. darf nicht leer sein.');
    end;
}