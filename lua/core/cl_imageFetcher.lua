AWS.Client.ImageFetcher = AWS.Client.ImageFetcher or {}

function AWS.Client.ImageFetcher:FetchImage(url, filename, callback)
    if not isstring(url) or not isstring(filename) or not isfunction(callback) then
        print("[AWS] Invalid arguments passed to FetchImage.")
        return
    end

    local extension = string.match(url, "%.([a-zA-Z0-9]+)$") or "png"
    local filePath = "aws_downloads/" .. filename .. "." .. extension

    if file.Exists(filePath, "DATA") then
        print("[AWS] Image already exists: " .. filePath)
        callback(filePath)
        return
    end

    http.Fetch(url, function(body, len, headers, code)
            if not file.IsDir("aws_downloads", "DATA") then
                file.CreateDir("aws_downloads")
            end

            file.Write(filePath, body)
            print("[AWS] Image downloaded and saved as: " .. filePath)

            callback(filePath)
        end,

        function(err)
            print("[AWS] Failed to download image: " .. tostring(err))
        end
    )
end

return AWS.Client.ImageFetcher