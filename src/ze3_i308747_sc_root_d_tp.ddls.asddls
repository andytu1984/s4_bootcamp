@AbapCatalog.sqlViewAppendName: 'ZI308747_VSCRE3'
@EndUserText.label: 'extenstion for consumption view sc root'
extend view ZC_I308747_SC_ROOT_D_TP with ze3_i308747_sc_root_d_tp {
    @UI.identification.position: 100
    @UI.lineItem.position: 100
    @UI.lineItem.label: 'test field'
    root.test_field
}
