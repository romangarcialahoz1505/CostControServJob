tableextension 55200 "MFD Job CCJ" extends Job
{
    fields
    {
        field(55200; "Item Job No."; Code[20])
        {
            Caption = 'Producto No.';
            DataClassification = ToBeClassified;

        }
        field(55210; "Jobs of Item"; Integer)
        {
            Caption = 'Proyectos del Producto';
            FieldClass = FlowField;
            CalcFormula = count(Job where("Item Job No." = field("Item Job No.")));

        }

    }
}
