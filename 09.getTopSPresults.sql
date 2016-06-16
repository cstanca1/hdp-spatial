SELECT *
FROM   ( SELECT DISTINCT VW_POINTACCUMULATION_SP_RESULTS.sp_site_id       AS "sp_site_id",
                         VW_POINTACCUMULATION_SP_RESULTS.pa_analysis_id   AS "pa_analysis_id",
                         VW_POINTACCUMULATION_SP_RESULTS.cp_site_id       AS "cp_site_id",
                         VW_POINTACCUMULATION_SP_RESULTS.bufferzone_id    AS "bufferzone_id",
                         VW_POINTACCUMULATION_SP_RESULTS.sp_site_shape    AS "buffer_shape",
                         VW_POINTACCUMULATION_SP_RESULTS.account_num      AS "p_1",
                         VW_POINTACCUMULATION_SP_RESULTS.sitenum          AS "p_2",
                         VW_POINTACCUMULATION_SP_RESULTS.full_address     AS "p_3",
                         VW_POINTACCUMULATION_SP_RESULTS.country_id       AS "a_34_id",
                         VW_POINTACCUMULATION_SP_RESULTS.g_mc_level1_id   AS "g_35_id",
                         VW_POINTACCUMULATION_SP_RESULTS.g_mc_level2_id   AS "g_36_id",
                         VW_POINTACCUMULATION_SP_RESULTS.g_mc_level3_id   AS "g_37_id",
                         VW_POINTACCUMULATION_SP_RESULTS.g_mc_level4_id   AS "g_38_id",
                         VW_POINTACCUMULATION_SP_RESULTS.g_mc_level5_id   AS "g_39_id",
                         VW_POINTACCUMULATION_SP_RESULTS.g_mc_level6_id   AS "g_40_id",
                         VW_POINTACCUMULATION_SP_RESULTS.lob1             AS "a_4",
                         VW_POINTACCUMULATION_SP_RESULTS.const_short_desc AS "a_5",
                         VW_POINTACCUMULATION_SP_RESULTS.occ_short_desc   AS "a_6",
                         VW_POINTACCUMULATION_SP_RESULTS.year_built       AS "a_7",
                         VW_POINTACCUMULATION_SP_RESULTS.num_stories      AS "a_8",
                         VW_POINTACCUMULATION_SP_RESULTS.g_level          AS "a_9_id",
                         VW_POINTACCUMULATION_SP_RESULTS.tiv              AS "m_10",
                         VW_POINTACCUMULATION_SP_RESULTS.site_limit       AS "m_11",
                         VW_POINTACCUMULATION_SP_RESULTS.cov1val          AS "m_12",
                         VW_POINTACCUMULATION_SP_RESULTS.cov2val          AS "m_13",
                         VW_POINTACCUMULATION_SP_RESULTS.cov3val          AS "m_14",
                         VW_POINTACCUMULATION_SP_RESULTS.cov4val          AS "m_15",
                         VW_POINTACCUMULATION_SP_RESULTS.site_deduct      AS "m_17",
                         VW_POINTACCUMULATION_SP_RESULTS.damage_loss      AS "m_18",
                         VW_POINTACCUMULATION_SP_RESULTS.gross_loss       AS "m_19",
                         VW_POINTACCUMULATION_SP_RESULTS.net_loss         AS "m_20",
                         VW_POINTACCUMULATION_SP_RESULTS.risk_count       AS "m_21",
                         VW_POINTACCUMULATION_SP_RESULTS.p_udf_attr3      AS "udpa_63",
                         VW_POINTACCUMULATION_SP_RESULTS.p_udf_attr4      AS "udpa_64",
                         VW_POINTACCUMULATION_SP_RESULTS.p_udf_met2       AS "udpm_77",
                         VW_POINTACCUMULATION_SP_RESULTS.p_udf_met5       AS "udpm_80",
                         VW_POINTACCUMULATION_SP_RESULTS.s_udf_attr3      AS "udsa_43",
                         VW_POINTACCUMULATION_SP_RESULTS.s_udf_attr4      AS "udsa_44",
                         VW_POINTACCUMULATION_SP_RESULTS.s_udf_attr5      AS "udsa_45",
                         VW_POINTACCUMULATION_SP_RESULTS.s_udf_attr7      AS "udsa_47",
                         VW_POINTACCUMULATION_SP_RESULTS.s_udf_met1       AS "udsm_51",
                         VW_POINTACCUMULATION_SP_RESULTS.s_udf_met3       AS "udsm_53",
                         VW_POINTACCUMULATION_SP_RESULTS.s_udf_met5       AS "udsm_55",
                         VW_POINTACCUMULATION_SP_RESULTS.s_udf_met9       AS "udsm_59",
                         VW_POINTACCUMULATION_SP_RESULTS.site_id          AS "p_99",
                         VW_POINTACCUMULATION_SP_RESULTS.policy_num       AS "p_100",
                         LU_COUNTRY.country_name                          AS "a_34",
                         LU_MC_MAPLEVEL1.mc_level1_display                AS "g_35",
                         LU_MC_MAPLEVEL2.mc_level2_display                AS "g_36",
                         LU_MC_MAPLEVEL3.mc_level3_display                AS "g_37",
                         LU_MC_MAPLEVEL4.mc_level4_display                AS "g_38",
                         LU_MC_MAPLEVEL5.mc_level5_display                AS "g_39",
                         LU_MC_MAPLEVEL6.mc_level6_display                AS "g_40",
                         LU_GEOCODE_LEVEL.description                     AS "a_9",
                         Row_number( )
                           over (
                             PARTITION BY cp_site_id, bufferzone_id
                             ORDER BY "m_10" DESC )                       rn
         FROM   VW_POINTACCUMULATION_SP_RESULTS
                inner join LU_MC_MAPLEVEL4
                        ON VW_POINTACCUMULATION_SP_RESULTS.g_mc_level4_id = LU_MC_MAPLEVEL4.g_mc_level4_id
                inner join LU_MC_MAPLEVEL3
                        ON VW_POINTACCUMULATION_SP_RESULTS.g_mc_level3_id = LU_MC_MAPLEVEL3.g_mc_level3_id
                inner join LU_MC_MAPLEVEL6
                        ON VW_POINTACCUMULATION_SP_RESULTS.g_mc_level6_id = LU_MC_MAPLEVEL6.g_mc_level6_id
                inner join LU_MC_MAPLEVEL5
                        ON VW_POINTACCUMULATION_SP_RESULTS.g_mc_level5_id = LU_MC_MAPLEVEL5.g_mc_level5_id
                inner join LU_COUNTRY
                        ON VW_POINTACCUMULATION_SP_RESULTS.country_id = LU_COUNTRY.g_country_id
                inner join LU_GEOCODE_LEVEL
                        ON VW_POINTACCUMULATION_SP_RESULTS.g_level = LU_GEOCODE_LEVEL.g_level
                inner join LU_MC_MAPLEVEL2
                        ON VW_POINTACCUMULATION_SP_RESULTS.g_mc_level2_id = LU_MC_MAPLEVEL2.g_mc_level2_id
                inner join LU_MC_MAPLEVEL1
                        ON VW_POINTACCUMULATION_SP_RESULTS.g_mc_level1_id = LU_MC_MAPLEVEL1.g_mc_level1_id
         WHERE  VW_POINTACCUMULATION_SP_RESULTS.pa_analysis_id = ?pa_analysis_id?  AND
                VW_POINTACCUMULATION_SP_RESULTS.portfolio_id = ?portfolio_id?  ) sp
WHERE  rn <= 5
