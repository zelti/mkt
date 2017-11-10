create or replace function mkt_sfunc(agg_state point, TEMP numeric)
returns point
immutable
language plpgsql
as $$
declare
  DH numeric; --activation energy
  R numeric; --Gas Constant:
  KV numeric; -- C° to Kelvin
  Xs numeric; 
  Xn numeric; -- X current
  n integer; -- number of temperature
begin
	DH := 83.14472;
	R  := 0.008314472;
	KV := 273.15;

	Xn := exp((-1*DH)/(R*(TEMP+KV)));
	
	Xs := agg_state[0] + Xn;
	n  := 1 + agg_state[1];
  return point(Xs,n);
end;
$$;

create or replace function mkt_finalfunc(agg_state  point)
returns numeric
immutable
strict
language plpgsql
as $$
declare
	DH numeric; --activation energy
  	R numeric; --Gas Constant:
  	KV numeric;
  	Xs numeric; 
  	n integer; -- number of temperature
  	dividend numeric;
  	divider numeric; 
begin
	DH := 83.14472;
	R  := 0.008314472;
	KV := 273.15;

	Xs := agg_state[0];
	n  := agg_state[1];
	dividend := DH/R;
  	divider  := (ln(Xs/n)) * -1;

  	return round((dividend/divider) - KV,2); 
end;
$$;

create aggregate mkt(numeric)
(
    sfunc = mkt_sfunc,
    stype = point,
    finalfunc = mkt_finalfunc,
    initcond = '0,0'
);