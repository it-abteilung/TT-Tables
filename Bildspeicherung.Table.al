Table 50015 Bildspeicherung
{

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Purchase Header"."No." where("Document Type" = FIELD("Document Type"));
        }
        field(3; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(4; "Document Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Zeilennr.';
        }
        field(10; Picture; Blob)
        {
            Caption = 'Bild';
            SubType = Bitmap;
        }
        field(20; Date; Date)
        {
            Caption = 'Datum';
        }
        field(30; "Job No."; Code[20])
        {
            Caption = 'Projektnr.';
        }
    }

    keys
    {
        key(Key1; "Table ID", "Document No.", "Document Type", "Document Line No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure SavePictureInDatabase(PictureName: Text; PictureFilePath: Text; TableID: Integer; No: Code[20]; DocumentType: Option "DEU=Anfrage",Bestellung,Rechnung,Gutschrift,Rahmenbestellung,"Reklamation;ENU=Quote","Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocumentLineNo: Integer; Projektnr: Code[20])
    var
        FileManagement: Codeunit "File Management";
        File: File;
        InStr: InStream;
        OutStr: OutStream;
    begin
        // if (PictureName = '') or (PictureFilePath = '') then
        //     exit;
        // if not File.Open(PictureFilePath) then
        //     exit;
        // File.CreateInstream(InStr);

        //In Tabelle schreiben ANFANG
        SetRange("Table ID", TableID);
        SetRange("Document No.", No);
        SetRange("Document Type", DocumentType);
        SetRange("Document Line No.", DocumentLineNo);
        if not FindLast then
            "Line No." := 1
        else
            "Line No." += 1;
        "Table ID" := TableID;
        "Document No." := No;
        "Document Type" := DocumentType;
        "Document Line No." := DocumentLineNo;
        Date := Today;
        "Job No." := Projektnr;
        Picture.CreateOutstream(OutStr);
        CopyStream(OutStr, InStr);
        Insert(true);
        //In Tabelle schreiben ENDE

        // File.Close;
        // if Erase(PictureFilePath) then;
    end;
}

