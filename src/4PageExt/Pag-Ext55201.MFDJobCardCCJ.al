pageextension 55201 "MFD Job Card CCJ" extends "Job Card"
{
    layout
    {
        addafter("Project Manager")
        {
            group("Cost Control Service Item")
            {
                Caption = 'Control Coste Productos Servicios';

                field("Item No."; "Item Job No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Producto No.';
                    ToolTip = 'Control coste del Producto Servicio';
                }
                field("Jobs of Item"; "Jobs of Item")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Proyectos del Producto';
                    ToolTip = 'Número de Proyectos de cotrol de coste del Producto';
                }

            }
        }
    }
}
