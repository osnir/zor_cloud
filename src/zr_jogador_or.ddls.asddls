@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZTBJOGADOR_OR'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_JOGADOR_OR
  as select from ZTB_JOGADOR_OR
{
  key id as ID,
  key id_equipe as IdEquipe,
  nome as Nome,
  idade as Idade,
  nacionalidade as Nacionalidade,
  @Semantics.user.createdBy: true
  criado_por as CriadoPor,
  @Semantics.user.lastChangedBy: true
  modificado_por as ModificadoPor,
  @Semantics.systemDateTime.createdAt: true
  criado_em as CriadoEm,
  @Semantics.systemDateTime.lastChangedAt: true
  modificado_em as ModificadoEm,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_modificado_em as LocalModificadoEm
}
