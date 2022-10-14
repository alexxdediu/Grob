import { boardConstants } from "../constants/constants";

const { Op } = require("sequelize");

var { user } = require('../models/users.ts');
var { board } = require('../models/boards.ts');
let today = new Date().toLocaleDateString()

/**
 * 
 * @param req 
 */
export const addNewAccount = async (req) => {
    await user.create({
        email: req.body.email,
        pwd: req.body.pwd,
        credits: req.body.credits,
        wins: 1,
        defeats: 1,
        draw: 1
    })

}

/**
 * 
 * @param email 
 * @returns 
 */

export const findUser = async (email) => {
    return await user.findAll({
        where: {
            email: email
        }
    });

}
/**
 * 
 * @returns 
 */
export const findAllUsers = async () => {
    return await user.findAll()
}
/**
 * 
 * @param map 
 * @returns 
 */
export const addNewGame = async (map) => {
    return await board.create({
        player: map.get(boardConstants.PLAYER),
        color: map.get(boardConstants.COLOR),
        history: map.get(boardConstants.BOARD_HISTORY),
        config: map.get(boardConstants.BOARD_CONFIGURATION),
        startdate: today,
        level: map.get(boardConstants.GAME_LEVEL),
        state : map.get(boardConstants.GAME_STATE)
    })
}
/**
 * 
 * @param config 
 * @param history 
 * @param id 
 */
export const updateBoard = async (config, history, id) => {
    await board.update({ config: JSON.stringify(config), history: JSON.stringify(history) }, {
        where: {
            id: id
        }
    })

}
/**
 * 
 * @param id 
 */
export const updateUserWin = async (id) =>{
    var data = await findUserById(id)
    var val = data[0].dataValues.wins
    await user.update({ wins : Number(val) + 1 },{
        where : {
            id : id
        }
    })

}
/**
 * 
 * @param id 
 */
export const updateUserDef = async (id) => {
    var data = await findUserById(id)
    var val = data[0].dataValues.defeats
    await user.update({ wins : Number(val) + 1 },{
        where : {
            id : id
        }
    })
}
/**
 * 
 * @param id 
 * @returns 
 */
export const findUserById = async (id) =>{
    return await user.findAll({
        where: {
            id: id
        }
    });

}
export const updateUserCredits = async (credits,id) =>{
    return await user.update({credits : credits },{
        where : {
            id : id 
        }
    })
}
/**
 * 
 * @param state 
 * @param id 
 */
export const updateBoardState = async (state,id) =>{
    await board.update({state : state },{ where : { id : id} })
}
/**
 * 
 * @param req 
 * @returns 
 */
export const findGamesByDate = async (req) => {
    return await board.findAll({
        where: { startdate: req.body.date }
    })
}
/**
 * 
 * @param boardId 
 * @param userId 
 * @returns 
 */
export const findGameByBoardId = async (boardId, userId) => {
    return await board.findAll({
        where: {
            id: boardId,
            player: userId,
        }
    })
}
/**
 * 
 * @param userId 
 * @returns 
 */
export const findGamesByUserId = async (userId) => {
    return await board.findAll({
        where: {
            player: userId,
        }
    })
}
/**
 * 
 * @param boardid 
 * @param userid 
 * @returns 
 */
export const abandonedGame = async (boardid,userid) =>{
    var games = await findGameByBoardId(boardid,userid)
   var config = JSON.parse(games[0].dataValues.config)
   config.isFinished=true
    return await board.update({ state : boardConstants.STATE_ABANDONED,config : JSON.stringify(config)},{ where : { id : boardid}})
}
