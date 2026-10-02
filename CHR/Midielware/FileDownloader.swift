import UIKit



class FileDownlode {
    let internetcall = INTERNET()
    
    private func Online(URL:String) async -> Data? {
        do {
                let data = try await internetcall.GET(
                    URI: URL
                )
                return data
            
        }
        
        catch ErrorService.AllNetworkError.Usernetoff {
            let (WentWorng, Retrybutton) = ERRORVIEW.Nointernet(
                ErrorTitle: "No internet connection",
                Description: "Your net is off please check your internet connection"
            )
        } catch ErrorService.AllNetworkError.InvalidURL {
            let RequestError = ERRORVIEW.RequestError(
                ErrorTitle: "InvalidURL",
                Descrption: "Given url is not corect please give the valid URL"
            )

        } catch ErrorService.AllNetworkError.ServerError {
            let RequestError = ERRORVIEW.RequestError(
                ErrorTitle: "Server Error",
                Descrption: "Server Not Responding for this url may server is close"
            )
        } catch ErrorService.AllNetworkError.ServerErrorCode(let statusCode) {
            let BadRequest = ERRORVIEW.BadRequest(
                ErroCode: "\(statusCode)",
                ErroMessage: "THIS THINGS CANTBE PROSSEND"
            )

        } catch {
            let (WentWorng, Retrybutton) = ERRORVIEW.WentWorng(
                ErrorTitle: "Somthing Went Worng",
                Descrption: "Anable to connect to the server. We couldn't connect to our server right now If the problem continues, please try again later."
            )
        
        }
        return nil
    }
    
    func SaveImage(Data data: Data) throws -> String {

            guard UIImage(data: data) != nil else {
                throw NSError(
                    domain: "FileDownlode",
                    code: 3,
                    userInfo: [
                        NSLocalizedDescriptionKey: "Data is not a valid image"
                    ]
                )
            }
        
        let documentsURL = FileManager.default.urls(
                for: .documentDirectory,
                in: .userDomainMask
        )[0]

            let fileName = UUID().uuidString + ".jpg"

            let fileURL = documentsURL.appendingPathComponent(fileName)
            try data.write(to: fileURL)

            return fileName
    }
    
    
    func SaveImag_Temporary(Data data: Data) throws -> String {
        guard UIImage(data: data) != nil else {
            throw NSError(
                domain: "FileDownlode",
                code: 3,
                userInfo: [
                    NSLocalizedDescriptionKey: "Data is not a valid image"
                ]
            )
        }

        let ImgName = UUID().uuidString + ".jpg"

        let TemporaryPath = FileManager.default.temporaryDirectory

        let fileUrl = TemporaryPath.appendingPathComponent(ImgName)

        try data.write(to: fileUrl)
        return ImgName
    }
    
    func ImgDonwlode(URL: String , SaveType:Save) async -> String {

        do {
            let NewRawImg = await Online(URL: URL)

            guard let imageData = NewRawImg else {
                return ""
            }
            
            if(SaveType == Save.Permanently){
                let path = try SaveImage(Data: imageData)
                return path
            }else{
                let path = try SaveImag_Temporary(Data: imageData)
                return path
            }
            
        } catch {
            return ""
        }
    }

    
}



