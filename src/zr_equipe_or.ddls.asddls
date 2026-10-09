@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZTBEQUIPE_OR'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_EQUIPE_OR
  as select from ztb_equipe_or
  association [0..*] to ZC_ASS_JOGADOR_OR as _Jogador on _Jogador.IdEquipe = $projection.ID
{
  key id as ID,
  nome as Nome,
  pais as Pais,
  cidade as Cidade,
  qtd_titulos as QtdTitulos,
  @Semantics.user.createdBy: true
  criado_por as CriadoPor,
  @Semantics.user.lastChangedBy: true
  modificado_por as ModificadoPor,
  @Semantics.systemDateTime.createdAt: true
  criado_em as CriadoEm,
  @Semantics.systemDateTime.lastChangedAt: true
  modificado_em as ModificadoEm,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_modificado_em as LocalModificadoEm,
  
  _Jogador
}
