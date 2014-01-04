CREATE TRIGGER update_skizze_rec_last_updated BEFORE UPDATE
	ON clique.skizzen FOR EACH ROW EXECUTE PROCEDURE 
	clique.update_rec_last_updated_column();