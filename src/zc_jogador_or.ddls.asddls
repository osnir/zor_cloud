@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZTBJOGADOR_OR'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_JOGADOR_OR
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_JOGADOR_OR
  association [1..1] to ZR_JOGADOR_OR as _BaseEntity on $projection.ID = _BaseEntity.ID and $projection.IDEQUIPE = _BaseEntity.IDEQUIPE
{
  key ID,
  key IdEquipe,
  Nome,
  Idade,
  Nacionalidade,
  @Semantics: {
    User.Createdby: true
  }
  CriadoPor,
  @Semantics: {
    User.Lastchangedby: true
  }
  ModificadoPor,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  CriadoEm,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  ModificadoEm,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalModificadoEm,
  _BaseEntity
}
