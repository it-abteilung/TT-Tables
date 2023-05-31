#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
TableExtension 50031 tableextension50031 extends "Inventory Setup"
{
    fields
    {
        field(50000; "Nummernserie Werkzeuge"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50100; "Picking Location"; Code[20])
        {
            Caption = 'Kommissionier Lager';
            Description = 'G-ERP';
            TableRelation = Location.Code;
        }
        field(50110; "Transit Location"; Code[20])
        {
            Caption = 'Transit Lager';
            Description = 'G-ERP';
            TableRelation = Location.Code;
        }
        field(50120; "Project Location"; Code[20])
        {
            Caption = 'Projekt Lager';
            Description = 'G-ERP';
            TableRelation = Location.Code;
        }
    }
}

