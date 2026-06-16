SELECT nome_heroi, nivel_forca FROM personagem
	WHERE nivel_forca > 
(SELECT nivel_forca FROM personagem 
	WHERE nome_heroi = 'Homem de Ferro'
);
SELECT nome_heroi, nivel_forca FROM personagem
	WHERE nivel_forca = (SELECT MAX(nivel_forca) FROM personagem
);

SELECT nome_heroi FROM personagem
	WHERE editora_id = (
SELECT editora_id FROM personagem 
	WHERE nome_heroi = 'Batman'
)
AND nome_heroi <> 'Batman';