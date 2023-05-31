TableExtension 50027 tableextension50027 extends Resource
{
    fields
    {
        field(50001; Durchwahlnummer; Text[10])
        {
            Caption = 'Direct Dial Number';
            Description = 'G-ERP';
        }
        field(50002; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            Description = 'G-ERP';
            ExtendedDatatype = EMail;
        }
        field(50003; Vendor; Code[20])
        {
            Caption = 'Kreditor';
            TableRelation = Vendor;
        }
    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "No." = '' THEN BEGIN
      ResSetup.GET;
      ResSetup.TESTFIELD("Resource Nos.");
    #4..10
    DimMgt.UpdateDefaultDim(
      DATABASE::Resource,"No.",
      "Global Dimension 1 Code","Global Dimension 2 Code");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..13

    // 20180323+
    IF (STRLEN("No.") = 5) AND ((COPYSTR("No.",1,1) = '2') OR (COPYSTR("No.",1,1) = '3')) THEN BEGIN
      EmployeeRec."No." := "No.";
      EmployeeRec.INSERT(TRUE);
    END;
    // 20180323-
    */
    //end;


    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Last Date Modified" := TODAY;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Last Date Modified" := TODAY;
    // 20180323+
    IF (STRLEN("No.") = 5) AND ((COPYSTR("No.",1,1) = '2') OR (COPYSTR("No.",1,1) = '3')) THEN BEGIN
      EmployeeRec."No." := "No.";
      EmployeeRec."Last Name" := Name;
      EmployeeRec."Search Name" := "Search Name";
      EmployeeRec.Address := Address;
      EmployeeRec."Address 2" := "Address 2";
      EmployeeRec.City := City;
      EmployeeRec."Post Code" := "Post Code";
      EmployeeRec.Extension := Durchwahlnummer;
      EmployeeRec."E-Mail" := "E-Mail";

      IF NOT EmployeeRec.INSERT(TRUE) THEN
        EmployeeRec.MODIFY(TRUE);
    END;
    // 20180323-
    */
    //end;

    var
        EmployeeRec: Record Employee;
}

