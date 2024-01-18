table 50057 "Employee Sign Store"
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
        field(20; "User Name"; Code[20])
        {
            DataClassification = OrganizationIdentifiableInformation;
            TableRelation = User."User Name";
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                User: Record User;
                TenantMedia: Record "Tenant Media";
            begin
                if Rec."User Name" <> xRec."User Name" then begin
                    User.SetRange("User Name", Rec."User Name");
                    if User.FindFirst() then begin
                        Rec."User Security ID" := User."User Security ID";
                    end;
                    if TenantMedia.Get(Signature.MediaId) then
                        TenantMedia.Delete();
                end;
            end;
        }
        field(30; "Signature"; Media)
        {
            DataClassification = OrganizationIdentifiableInformation;
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
}