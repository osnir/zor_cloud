CLASS LHC_ZR_EQUIPE_OR DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZrEquipeOr
        RESULT result,

      earlynumbering_create FOR NUMBERING
            entities FOR CREATE ZrEquipeOr,

      valida_pais FOR VALIDATE ON SAVE
            keys FOR ZrEquipeOr~valida_pais,

      determina_cidade FOR DETERMINE ON SAVE
            keys FOR ZrEquipeOr~determina_cidade,

      add_titulo FOR MODIFY
        IMPORTING keys FOR ACTION ZrEquipeOr~add_titulo RESULT result.

ENDCLASS.

CLASS LHC_ZR_EQUIPE_OR IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD earlynumbering_create.

    SELECT MAX( id ) FROM zr_equipe_or
      INTO @DATA(lv_max_id).

    IF lv_max_id IS NOT INITIAL.
        mapped-ZrEquipeOr =
            VALUE #(
                FOR ls_entities IN entities ( %cid      = ls_entities-%cid
                                              %is_draft = ls_entities-%is_draft
                                              %key      = ls_entities-%key
                                              id        = lv_max_id + 1 ) ).
    ENDIF.
  ENDMETHOD.

  METHOD valida_pais.
    READ ENTITIES OF zr_equipe_or IN LOCAL MODE
        ENTITY zr_equipe_or
        FIELDS ( Pais )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_equipes).

    IF lt_equipes IS NOT INITIAL.
        LOOP AT lt_equipes INTO DATA(ls_equipes).
            ls_equipes-Pais = |{ ls_equipes-Pais CASE = UPPER }|.

            IF ls_equipes-Pais NE 'BRASIL'.
               APPEND VALUE #( %tky = ls_equipes-%tky ) TO failed-ZrEquipeOr.

               APPEND VALUE #( %tky          = ls_equipes-%tky
                               %element-Pais = if_abap_behv=>mk-on
                               %state_area   = 'VALIDA_PAIS'
                               %msg          = new_message( id       = '01'
                                                            number   = 319
                                                            v1       = 'Único país permitido é o Brasil'
                                                            severity = if_abap_behv_message=>severity-error )
                            ) TO reported-ZrEquipeOr.
            ENDIF.
        ENDLOOP.

    ENDIF.
  ENDMETHOD.

  METHOD determina_cidade.
    READ ENTITIES OF zr_equipe_or IN LOCAL MODE
        ENTITY zr_equipe_or
        FIELDS ( Cidade )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_equipes).

    DELETE lt_equipes WHERE Cidade = 'São Paulo'
                         OR Cidade = 'Rio de Janeiro'.

    CHECK lt_equipes IS NOT INITIAL.

    MODIFY ENTITIES OF zr_equipe_or IN LOCAL MODE
        ENTITY zr_equipe_or
        UPDATE FIELDS ( Cidade )
        WITH VALUE #( FOR ls_equipes IN lt_equipes ( %tky = ls_equipes-%tky
                                                     Cidade = COND #( WHEN ls_equipes-Cidade = 'SP' THEN 'São Paulo'
                                                                      WHEN ls_equipes-Cidade = 'RJ' THEN 'Rio de Janeiro' ) ) )

        REPORTED DATA(lt_reported).

    IF lt_reported IS NOT INITIAL.
        reported = CORRESPONDING #( DEEP lt_reported ).
    ENDIF.
  ENDMETHOD.

  METHOD add_titulo.
    READ ENTITIES OF zr_equipe_or IN LOCAL MODE
        ENTITY zr_equipe_or
        FIELDS ( QtdTitulos )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_equipes).


    IF lt_equipes IS NOT INITIAL.
        MODIFY ENTITIES OF zr_equipe_or IN LOCAL MODE
            ENTITY zr_equipe_or
            UPDATE FIELDS ( QtdTitulos )
            WITH VALUE #( FOR ls_equipes IN lt_equipes ( %tky       = ls_equipes-%tky
                                                         QtdTitulos = ls_equipes-QtdTitulos + 1 ) )

            REPORTED DATA(lt_reported)
            FAILED DATA(lt_failed)
            MAPPED DATA(lt_mapped).

        IF lt_reported IS NOT INITIAL.
            reported = CORRESPONDING #( DEEP lt_reported ).
        ENDIF.

        IF lt_failed IS NOT INITIAL.
            failed = CORRESPONDING #( DEEP lt_failed ).
        ENDIF.

        IF lt_mapped IS NOT INITIAL.
            mapped = CORRESPONDING #( DEEP lt_mapped ).
        ENDIF.

        " Relê os dados já atualizados para devolver no result
        READ ENTITIES OF zr_equipe_or IN LOCAL MODE
            ENTITY zr_equipe_or
            ALL FIELDS WITH CORRESPONDING #( keys )
            RESULT DATA(lt_result).

        result = VALUE #( FOR ls_result IN lt_result ( %tky   = ls_result-%tky
                                                       %param = ls_result ) ).
    ENDIF.
  ENDMETHOD.

ENDCLASS.
