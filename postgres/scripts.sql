-- insert test data to nz_document

DO
$do$
BEGIN
    FOR i IN 5..7 LOOP
        INSERT INTO nz_document (
      orgeh,
      year,
      month,
      time_from,
      time_to,
      dept,
      nz_status,
      nz_time,
      nz_people,
      timely,
      time_record,
      time_zone,
      add_info,
      is_error,
      nvplan,
      nvfact,
      nvbase,
      tplan,
      tfact,
      nvplan_rank,
      nvfact_rank,
      nvplan_rank_tkf,
      nvfact_rank_tkf,
      tplan_rank,
      tfact_rank,
      tplan_rank_tkf,
      tfact_rank_tkf,
      issued_by,
      last_modified,
      last_modified_by
    ) VALUES (
      0,
      2022,
      i,
      '2022-01-01 00:00:00',
      '2022-01-01 00:00:00',
      1,
      1,
      'S',
      'I',
      true,
      true,
      'C',
      false,
      false,
      2.0,
      3.0,
      4.0,
      5.0,
      6.0,
      7.0,
      8.0,
      9.0,
      10.0,
      11.0,
      12.0,
      13.0,
      14.0,
      'Pepkin',
      '2022-01-01 00:00:00',
      'E'
    );
        
	    
    END LOOP;
END
$do$;

-- insert winter koefs  
INSERT INTO public.sapref_winter_koef (temp_zone, wgroup_type, month_from,
  month_to, winter_koef)
    SELECT tzone, wgn, mes1, mes2, wfact_val
    FROM json_to_recordset('[{"tzone": "1","wgn": "1","mes1": "01","mes2": "02","wfact_val": "1.05","date_cr": "0000-00-00","usnam": ""},{"tzone": "1","wgn": "2","mes1": "01","mes2": "02","wfact_val": "1.07","date_cr": "0000-00-00","usnam": ""},{"tzone": "1","wgn": "3","mes1": "01","mes2": "02","wfact_val": "1.08","date_cr": "0000-00-00","usnam": ""},{"tzone": "2","wgn": "1","mes1": "01","mes2": "02","wfact_val": "1.08","date_cr": "0000-00-00","usnam": ""},{"tzone": "2","wgn": "1","mes1": "03","mes2": "03","wfact_val": "1.05","date_cr": "0000-00-00","usnam": ""},{"tzone": "2","wgn": "1","mes1": "12","mes2": "12","wfact_val": "1.06","date_cr": "0000-00-00","usnam": ""},{"tzone": "2","wgn": "2","mes1": "01","mes2": "02","wfact_val": "1.11","date_cr": "0000-00-00","usnam": ""},{"tzone": "2","wgn": "2","mes1": "03","mes2": "03","wfact_val": "1.07","date_cr": "0000-00-00","usnam": ""},{"tzone": "2","wgn": "2","mes1": "12","mes2": "12","wfact_val": "1.09","date_cr": "0000-00-00","usnam": ""},{"tzone": "2","wgn": "3","mes1": "01","mes2": "02","wfact_val": "1.14","date_cr": "0000-00-00","usnam": ""},{"tzone": "2","wgn": "3","mes1": "03","mes2": "03","wfact_val": "1.10","date_cr": "0000-00-00","usnam": ""},{"tzone": "2","wgn": "3","mes1": "12","mes2": "12","wfact_val": "1.12","date_cr": "0000-00-00","usnam": ""},{"tzone": "3","wgn": "1","mes1": "01","mes2": "02","wfact_val": "1.13","date_cr": "0000-00-00","usnam": ""},{"tzone": "3","wgn": "1","mes1": "03","mes2": "03","wfact_val": "1.08","date_cr": "0000-00-00","usnam": ""},{"tzone": "3","wgn": "1","mes1": "11","mes2": "11","wfact_val": "1.06","date_cr": "0000-00-00","usnam": ""},{"tzone": "3","wgn": "1","mes1": "12","mes2": "12","wfact_val": "1.08","date_cr": "0000-00-00","usnam": ""},{"tzone": "3","wgn": "2","mes1": "01","mes2": "02","wfact_val": "1.20","date_cr": "0000-00-00","usnam": ""},{"tzone": "3","wgn": "2","mes1": "03","mes2": "03","wfact_val": "1.12","date_cr": "0000-00-00","usnam": ""},{"tzone": "3","wgn": "2","mes1": "11","mes2": "11","wfact_val": "1.09","date_cr": "0000-00-00","usnam": ""},{"tzone": "3","wgn": "2","mes1": "12","mes2": "12","wfact_val": "1.12","date_cr": "0000-00-00","usnam": ""},{"tzone": "3","wgn": "3","mes1": "01","mes2": "02","wfact_val": "1.25","date_cr": "0000-00-00","usnam": ""},{"tzone": "3","wgn": "3","mes1": "03","mes2": "03","wfact_val": "1.17","date_cr": "0000-00-00","usnam": ""},{"tzone": "3","wgn": "3","mes1": "11","mes2": "11","wfact_val": "1.13","date_cr": "0000-00-00","usnam": ""},{"tzone": "3","wgn": "3","mes1": "12","mes2": "12","wfact_val": "1.17","date_cr": "0000-00-00","usnam": ""},{"tzone": "4","wgn": "1","mes1": "01","mes2": "02","wfact_val": "1.16","date_cr": "0000-00-00","usnam": ""},{"tzone": "4","wgn": "1","mes1": "03","mes2": "03","wfact_val": "1.10","date_cr": "0000-00-00","usnam": ""},{"tzone": "4","wgn": "1","mes1": "11","mes2": "11","wfact_val": "1.08","date_cr": "0000-00-00","usnam": ""},{"tzone": "4","wgn": "1","mes1": "12","mes2": "12","wfact_val": "1.10","date_cr": "0000-00-00","usnam": ""},{"tzone": "4","wgn": "2","mes1": "01","mes2": "02","wfact_val": "1.28","date_cr": "0000-00-00","usnam": ""},{"tzone": "4","wgn": "2","mes1": "03","mes2": "03","wfact_val": "1.15","date_cr": "0000-00-00","usnam": ""},{"tzone": "4","wgn": "2","mes1": "11","mes2": "11","wfact_val": "1.13","date_cr": "0000-00-00","usnam": ""},{"tzone": "4","wgn": "2","mes1": "12","mes2": "12","wfact_val": "1.15","date_cr": "0000-00-00","usnam": ""},{"tzone": "4","wgn": "3","mes1": "01","mes2": "02","wfact_val": "1.38","date_cr": "0000-00-00","usnam": ""},{"tzone": "4","wgn": "3","mes1": "03","mes2": "03","wfact_val": "1.20","date_cr": "0000-00-00","usnam": ""},{"tzone": "4","wgn": "3","mes1": "11","mes2": "11","wfact_val": "1.17","date_cr": "0000-00-00","usnam": ""},{"tzone": "4","wgn": "3","mes1": "12","mes2": "12","wfact_val": "1.20","date_cr": "0000-00-00","usnam": ""},{"tzone": "5","wgn": "1","mes1": "01","mes2": "02","wfact_val": "1.18","date_cr": "0000-00-00","usnam": ""},{"tzone": "5","wgn": "1","mes1": "03","mes2": "03","wfact_val": "1.12","date_cr": "0000-00-00","usnam": ""},{"tzone": "5","wgn": "1","mes1": "11","mes2": "11","wfact_val": "1.10","date_cr": "0000-00-00","usnam": ""},{"tzone": "5","wgn": "1","mes1": "12","mes2": "12","wfact_val": "1.12","date_cr": "0000-00-00","usnam": ""},{"tzone": "5","wgn": "2","mes1": "01","mes2": "02","wfact_val": "1.30","date_cr": "0000-00-00","usnam": ""},{"tzone": "5","wgn": "2","mes1": "03","mes2": "03","wfact_val": "1.17","date_cr": "0000-00-00","usnam": ""},{"tzone": "5","wgn": "2","mes1": "11","mes2": "11","wfact_val": "1.15","date_cr": "0000-00-00","usnam": ""},{"tzone": "5","wgn": "2","mes1": "12","mes2": "12","wfact_val": "1.17","date_cr": "0000-00-00","usnam": ""},{"tzone": "5","wgn": "3","mes1": "01","mes2": "02","wfact_val": "1.40","date_cr": "0000-00-00","usnam": ""},{"tzone": "5","wgn": "3","mes1": "03","mes2": "03","wfact_val": "1.22","date_cr": "0000-00-00","usnam": ""},{"tzone": "5","wgn": "3","mes1": "11","mes2": "11","wfact_val": "1.20","date_cr": "0000-00-00","usnam": ""},{"tzone": "5","wgn": "3","mes1": "12","mes2": "12","wfact_val": "1.22","date_cr": "0000-00-00","usnam": ""},{"tzone": "6","wgn": "1","mes1": "01","mes2": "02","wfact_val": "1.25","date_cr": "0000-00-00","usnam": ""},{"tzone": "6","wgn": "1","mes1": "03","mes2": "03","wfact_val": "1.17","date_cr": "0000-00-00","usnam": ""},{"tzone": "6","wgn": "1","mes1": "04","mes2": "04","wfact_val": "1.07","date_cr": "0000-00-00","usnam": ""},{"tzone": "6","wgn": "1","mes1": "10","mes2": "10","wfact_val": "1.07","date_cr": "0000-00-00","usnam": ""},{"tzone": "6","wgn": "1","mes1": "11","mes2": "11","wfact_val": "1.17","date_cr": "0000-00-00","usnam": ""},{"tzone": "6","wgn": "1","mes1": "12","mes2": "12","wfact_val": "1.25","date_cr": "0000-00-00","usnam": ""},{"tzone": "6","wgn": "2","mes1": "01","mes2": "02","wfact_val": "1.45","date_cr": "0000-00-00","usnam": ""},{"tzone": "6","wgn": "2","mes1": "03","mes2": "03","wfact_val": "1.30","date_cr": "0000-00-00","usnam": ""},{"tzone": "6","wgn": "2","mes1": "04","mes2": "04","wfact_val": "1.10","date_cr": "0000-00-00","usnam": ""},{"tzone": "6","wgn": "2","mes1": "10","mes2": "10","wfact_val": "1.10","date_cr": "0000-00-00","usnam": ""},{"tzone": "6","wgn": "2","mes1": "11","mes2": "11","wfact_val": "1.30","date_cr": "0000-00-00","usnam": ""},{"tzone": "6","wgn": "2","mes1": "12","mes2": "12","wfact_val": "1.45","date_cr": "0000-00-00","usnam": ""},{"tzone": "6","wgn": "3","mes1": "01","mes2": "02","wfact_val": "1.60","date_cr": "0000-00-00","usnam": ""},{"tzone": "6","wgn": "3","mes1": "03","mes2": "03","wfact_val": "1.40","date_cr": "0000-00-00","usnam": ""},{"tzone": "6","wgn": "3","mes1": "04","mes2": "04","wfact_val": "1.13","date_cr": "0000-00-00","usnam": ""},{"tzone": "6","wgn": "3","mes1": "10","mes2": "10","wfact_val": "1.13","date_cr": "0000-00-00","usnam": ""},{"tzone": "6","wgn": "3","mes1": "11","mes2": "11","wfact_val": "1.40","date_cr": "0000-00-00","usnam": ""},{"tzone": "6","wgn": "3","mes1": "12","mes2": "12","wfact_val": "1.60","date_cr": "0000-00-00","usnam": ""}]')
    as cols(tzone varchar, wgn varchar, mes1 integer, mes2 integer, wfact_val numeric);
