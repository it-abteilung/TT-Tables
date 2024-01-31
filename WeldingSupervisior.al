table 50060 "Welding Supervisior"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(10; "User Security ID"; GUID)
        {
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(20; "User Name"; Code[50])
        {
            DataClassification = OrganizationIdentifiableInformation;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(key1; "Entry No.") { Clustered = true; }
    }

    trigger OnInsert()
    var
        User: Record User;
        WeldingSupervisior: Record "Welding Supervisior";
    begin
        User.SetRange("User Name", Rec."User Name");
        if User.IsEmpty() then
            Error('Bitte einen vorhandenen Benutzer auswählen.');
        WeldingSupervisior.SetRange("User Name", Rec."User Name");
        if NOT WeldingSupervisior.IsEmpty() then
            Error('Benutzer ist bereits als Schweißaufsicht hinterlegt.');
    end;
}