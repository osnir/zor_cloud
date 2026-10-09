@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZTBEQUIPE_OR'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_EQUIPE_OR
  provider contract transactional_query
  as projection on ZR_EQUIPE_OR
  association [1..1] to ZR_EQUIPE_OR as _BaseEntity on $projection.ID = _BaseEntity.ID
{
  key ID,
  Nome,
  Pais,
  Cidade,
  QtdTitulos,
  @Semantics: {
    user.createdBy: true
  }
  CriadoPor,
  @Semantics: {
    user.lastChangedBy: true
  }
  ModificadoPor,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  CriadoEm,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  ModificadoEm,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  LocalModificadoEm,
  _BaseEntity,
  
  _Jogador
}
