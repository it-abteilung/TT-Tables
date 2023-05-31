#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
TableExtension 50010 tableextension50010 extends "Company Information"
{
    fields
    {
        field(50000; "Picture 1"; Blob)
        {
            Caption = 'Picture 1';
            Description = 'G-ERP';
            SubType = Bitmap;
        }
        field(50001; "Picture 2"; Blob)
        {
            Caption = 'Picture 2';
            Description = 'G-ERP';
            SubType = Bitmap;
        }
        field(50002; "Picture 3"; Blob)
        {
            Caption = 'Bild 3';
            Description = 'G-ERP';
            SubType = Bitmap;
        }
        field(50010; "Bank Name 1"; Text[50])
        {
            Caption = 'Bank Name';
            Description = 'G-ERP';
        }
        field(50011; "Bank Branch No. 1"; Text[20])
        {
            Caption = 'Bank Branch No.';
            Description = 'G-ERP';
        }
        field(50012; "Bank Account No. 1"; Text[30])
        {
            Caption = 'Bank Account No.';
            Description = 'G-ERP';
        }
        field(50013; "Bank Name 2"; Text[50])
        {
            Caption = 'Bank Name';
            Description = 'G-ERP';
        }
        field(50014; "Bank Branch No. 2"; Text[20])
        {
            Caption = 'Bank Branch No.';
            Description = 'G-ERP';
        }
        field(50015; "Bank Account No. 2"; Text[30])
        {
            Caption = 'Bank Account No.';
            Description = 'G-ERP';
        }
        field(50016; "Bank Name 3"; Text[50])
        {
            Caption = 'Bank Name';
            Description = 'G-ERP';
        }
        field(50017; "Bank Branch No. 3"; Text[20])
        {
            Caption = 'Bank Branch No.';
            Description = 'G-ERP';
        }
        field(50018; "Bank Account No. 3"; Text[30])
        {
            Caption = 'Bank Account No.';
            Description = 'G-ERP';
        }
        field(50019; "Bank Name 4"; Text[50])
        {
            Caption = 'Bank Name';
            Description = 'G-ERP';
        }
        field(50020; "Bank Branch No. 4"; Text[20])
        {
            Caption = 'Bank Branch No.';
            Description = 'G-ERP';
        }
        field(50021; "Bank Account No. 4"; Text[30])
        {
            Caption = 'Bank Account No.';
            Description = 'G-ERP';
        }
        field(50022; "IBAN 1"; Code[50])
        {
            Caption = 'IBAN';
            Description = 'G-ERP';

            trigger OnValidate()
            begin
                //CheckIBAN("IBAN 1");
            end;
        }
        field(50023; "IBAN 2"; Code[50])
        {
            Caption = 'IBAN';
            Description = 'G-ERP';

            trigger OnValidate()
            begin
                //CheckIBAN("IBAN 2");
            end;
        }
        field(50024; "IBAN 3"; Code[50])
        {
            Caption = 'IBAN';
            Description = 'G-ERP';

            trigger OnValidate()
            begin
                //CheckIBAN("IBAN 3");
            end;
        }
        field(50025; "IBAN 4"; Code[50])
        {
            Caption = 'IBAN';
            Description = 'G-ERP';

            trigger OnValidate()
            begin
                //CheckIBAN("IBAN 4");
            end;
        }
        field(50026; "SWIFT Code 1"; Code[20])
        {
            Description = 'G-ERP';
        }
        field(50030; "Managing Director"; Text[50])
        {
            Caption = 'Managing Director';
            Description = 'G-ERP';
        }
        field(50031; "SWIFT Code 2"; Code[20])
        {
            Description = 'G-ERP';
        }
    }
}

