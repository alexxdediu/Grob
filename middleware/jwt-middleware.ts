import { findUser } from "../database/queries"
import { Utils } from "../utils/utils"

export const checkEmailJwt = (req, res, next) => {
    //console.log(req.headers.authorization)
    const token= req.headers.authorization
   // console.log(token)
    var jwtDecode = Utils.decodeJwt(token)

    
    if (jwtDecode != null) {
        findUser(jwtDecode.email).then((user) => {
            if (typeof user == 'undefined') res.json("Non esiste un account associato all'email " + req.body.email)
            else  {console.log("JWT corretto!") 
            next()}

        })
    } else res.json("Jwt Errato!")

}

