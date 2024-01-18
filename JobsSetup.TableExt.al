#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
TableExtension 50032 tableextension50032 extends "Jobs Setup"
{
    fields
    {
        field(50000; "Job Nos. TP"; Code[10])
        {
            Caption = 'Job Nos.';
            TableRelation = "No. Series";
        }
        field(50010; "Dry Drock Nos."; Code[10])
        {
            Caption = 'Dry Dock Projektnummern';
            TableRelation = "No. Series";
        }
        field(51000; "Reparatur intern ░"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(51010; "Gütesicherung intern ░"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(51020; "Brandwache intern ░"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(60000; Folder; Text[100])
        {
            Caption = 'Ordner';
            Description = 'G-ERP.RS 2019-01-23';
        }
    }
}

