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
      nvfakt,
      nvbase,
      tplan,
      tfakt,
      nvplan_rank,
      nvfakt_rank,
      nvplan_rank_tkf,
      nvfakt_rank_tkf,
      tplan_rank,
      tfakt_rank,
      tplan_rank_tkf,
      tfakt_rank_tkf,
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
      'A',
      'B',
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


