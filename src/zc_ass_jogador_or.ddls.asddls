@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consuption para ass. Jogador'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType: {
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZC_ASS_JOGADOR_OR as select from ZR_JOGADOR_OR
{
    key ID,
    key IdEquipe,
    Nome,
    Idade,
    Nacionalidade,
    CriadoPor,
    ModificadoPor,
    CriadoEm,
    ModificadoEm,
    LocalModificadoEm
}
