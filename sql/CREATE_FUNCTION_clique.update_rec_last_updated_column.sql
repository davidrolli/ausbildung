CREATE OR REPLACE FUNCTION clique.update_rec_last_updated_column()
 RETURNS TRIGGER AS $$
	BEGIN
		 NEW.rec_last_updated = now(); 
		 RETURN NEW;
	END;
	$$ language 'plpgsql';
