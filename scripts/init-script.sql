CREATE DATABASE grobdb;
\c grobdb
CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    email VARCHAR(50),
    pwd VARCHAR(40),
    credits NUMERIC,
    wins INTEGER,
    defeats INTEGER,
    admin BOOLEAN
);
CREATE TABLE boards(
    id SERIAL PRIMARY KEY,
    player INTEGER REFERENCES users(id),
    color VARCHAR(10),
    config TEXT,
    history TEXT,
    startDate VARCHAR(20),
    level INTEGER,
    state VARCHAR(15)
  
);

--inserimento utenti
INSERT INTO users(email, pwd,credits,wins,defeats,admin) VALUES
('alex@progettopa.it', 'progettopa',3,4,2,false),
('carlo@progettopa.it', 'progettopa',1,1,3,false),
('marco@progettopa.it', 'progettopa',0,7,6,1,false),
('alex@progettopa.it', 'progettopa',2,4,2,true),

--inserimento partite
INSERT INTO boards(player, color,config,history,startDate,level,state) VALUES
(1,
'white',
'{"moves":{"B1":["C3","A3"],"G1":["H3","F3"],"A2":["A3","A4"],"B2":["B3","B4"],"C2":["C3","C4"],"D2":["D3","D4"],"E2":["E3","E4"],"F2":["F3","F4"],
"G2":["G3","G4"],"H2":["H3","H4"]},"pieces":{"E1":"K","D1":"Q","A1":"R","H1":"R","C1":"B","F1":"B","B1":"N","G1":"N","A2":"P","B2":"P","C2":"P","D2":"P","E2":"P","F2":"P",
"G2":"P","H2":"P","E8":"k","D8":"q","A8":"r","H8":"r","C8":"b","F8":"b","B8":"n","G8":"n","A7":"p","B7":"p","C7":"p","D7":"p","E7":"p","F7":"p","G7":"p","H7":"p"},"turn":"white",
"isFinished":false,"check":false,"checkMate":false,"castling":{"whiteShort":true,"blackShort":true,"whiteLong":true,"blackLong":true},"enPassant":null,"halfMove":0,"fullMove":1}',
'[]',
'16/10/2022',
2,
null),

INSERT INTO boards(player, color,config,history,startDate,level,state) VALUES
(1,
'black',
'{"moves":{"B1":["C3","A3"],"G1":["H3","F3"],"A2":["A3","A4"],"B2":["B3","B4"],"C2":["C3","C4"],"D2":["D3","D4"],"E2":["E3","E4"],"F2":["F3","F4"],
"G2":["G3","G4"],"H2":["H3","H4"]},"pieces":{"E1":"K","D1":"Q","A1":"R","H1":"R","C1":"B","F1":"B","B1":"N","G1":"N","A2":"P","B2":"P","C2":"P","D2":"P","E2":"P","F2":"P",
"G2":"P","H2":"P","E8":"k","D8":"q","A8":"r","H8":"r","C8":"b","F8":"b","B8":"n","G8":"n","A7":"p","B7":"p","C7":"p","D7":"p","E7":"p","F7":"p","G7":"p","H7":"p"},"turn":"white",
"isFinished":false,"check":false,"checkMate":false,"castling":{"whiteShort":true,"blackShort":true,"whiteLong":true,"blackLong":true},"enPassant":null,"halfMove":0,"fullMove":1}',
'[]',
'16/10/2022',
2,
null),

INSERT INTO boards(player, color,config,history,startDate,level,state) VALUES
(2,
'white',
'{"moves":{"B1":["C3","A3"],"G1":["H3","F3"],"A2":["A3","A4"],"B2":["B3","B4"],"C2":["C3","C4"],"D2":["D3","D4"],"E2":["E3","E4"],"F2":["F3","F4"],
"G2":["G3","G4"],"H2":["H3","H4"]},"pieces":{"E1":"K","D1":"Q","A1":"R","H1":"R","C1":"B","F1":"B","B1":"N","G1":"N","A2":"P","B2":"P","C2":"P","D2":"P","E2":"P","F2":"P",
"G2":"P","H2":"P","E8":"k","D8":"q","A8":"r","H8":"r","C8":"b","F8":"b","B8":"n","G8":"n","A7":"p","B7":"p","C7":"p","D7":"p","E7":"p","F7":"p","G7":"p","H7":"p"},"turn":"white",
"isFinished":false,"check":false,"checkMate":false,"castling":{"whiteShort":true,"blackShort":true,"whiteLong":true,"blackLong":true},"enPassant":null,"halfMove":0,"fullMove":1}',
'[]',
'15/10/2022',
1,
null),

INSERT INTO boards(player, color,config,history,startDate,level,state) VALUES
(3,
'black',
'{"moves":{"B1":["C3","A3"],"G1":["H3","F3"],"A2":["A3","A4"],"B2":["B3","B4"],"C2":["C3","C4"],"D2":["D3","D4"],"E2":["E3","E4"],"F2":["F3","F4"],
"G2":["G3","G4"],"H2":["H3","H4"]},"pieces":{"E1":"K","D1":"Q","A1":"R","H1":"R","C1":"B","F1":"B","B1":"N","G1":"N","A2":"P","B2":"P","C2":"P","D2":"P","E2":"P","F2":"P",
"G2":"P","H2":"P","E8":"k","D8":"q","A8":"r","H8":"r","C8":"b","F8":"b","B8":"n","G8":"n","A7":"p","B7":"p","C7":"p","D7":"p","E7":"p","F7":"p","G7":"p","H7":"p"},"turn":"white",
"isFinished":false,"check":false,"checkMate":false,"castling":{"whiteShort":true,"blackShort":true,"whiteLong":true,"blackLong":true},"enPassant":null,"halfMove":0,"fullMove":1}',
'[]',
'16/10/2022',
2,
null),

INSERT INTO boards(player, color,config,history,startDate,level,state) VALUES
(3,
'black',
'{"moves":{"B1":["C3","A3"],"G1":["H3","F3"],"A2":["A3","A4"],"B2":["B3","B4"],"C2":["C3","C4"],"D2":["D3","D4"],"E2":["E3","E4"],"F2":["F3","F4"],
"G2":["G3","G4"],"H2":["H3","H4"]},"pieces":{"E1":"K","D1":"Q","A1":"R","H1":"R","C1":"B","F1":"B","B1":"N","G1":"N","A2":"P","B2":"P","C2":"P","D2":"P","E2":"P","F2":"P",
"G2":"P","H2":"P","E8":"k","D8":"q","A8":"r","H8":"r","C8":"b","F8":"b","B8":"n","G8":"n","A7":"p","B7":"p","C7":"p","D7":"p","E7":"p","F7":"p","G7":"p","H7":"p"},"turn":"white",
"isFinished":false,"check":false,"checkMate":false,"castling":{"whiteShort":true,"blackShort":true,"whiteLong":true,"blackLong":true},"enPassant":null,"halfMove":0,"fullMove":1}',
'[]',
'16/10/2022',
1,
null),

INSERT INTO boards(player, color,config,history,startDate,level,state) VALUES
(4,
'white',
'{"moves":{"B1":["C3","A3"],"G1":["H3","F3"],"A2":["A3","A4"],"B2":["B3","B4"],"C2":["C3","C4"],"D2":["D3","D4"],"E2":["E3","E4"],"F2":["F3","F4"],
"G2":["G3","G4"],"H2":["H3","H4"]},"pieces":{"E1":"K","D1":"Q","A1":"R","H1":"R","C1":"B","F1":"B","B1":"N","G1":"N","A2":"P","B2":"P","C2":"P","D2":"P","E2":"P","F2":"P",
"G2":"P","H2":"P","E8":"k","D8":"q","A8":"r","H8":"r","C8":"b","F8":"b","B8":"n","G8":"n","A7":"p","B7":"p","C7":"p","D7":"p","E7":"p","F7":"p","G7":"p","H7":"p"},"turn":"white",
"isFinished":false,"check":false,"checkMate":false,"castling":{"whiteShort":true,"blackShort":true,"whiteLong":true,"blackLong":true},"enPassant":null,"halfMove":0,"fullMove":1}',
'[]',
'14/10/2022',
1,
null),