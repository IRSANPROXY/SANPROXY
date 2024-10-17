--CREDIT : IRSAN

-- Menyimpan nama penulis sebagai konstan
local AUTHOR_NAME = "IRSAN"  -- Nama ini tidak bisa diubah
local MESSAGE_ON_ACTIVATION = "`4SC BY " .. AUTHOR_NAME .. "."  -- Pesan yang tidak dapat diubah

local sLog = "`7[`9" .. AUTHOR_NAME .. "|PROXY`7]`o "
local sCmd = "`7[`9" .. AUTHOR_NAME .. "|PROXY`7]`9 "

-- Memastikan bahwa nama penulis tidak diubah
local function validateAuthorName()
    if AUTHOR_NAME ~= "IRSAN" then
        error("Nama penulis telah diubah! Skrip tidak dapat dijalankan.")
    end
end

local proxy = "\nadd_label_with_icon|big|`oHelper Casino|left|32|"..
              "\nadd_textbox|`4This Script by `6" .. AUTHOR_NAME .. "|left|2440|"..
              "\nadd_spacer|small|"..
              "\nadd_label|small|`2All Features Helper:|left||"..      
              "\nadd_spacer|smal|"..
              "\nadd_textbox|`o/proxy `2 (Proxy List)|left|2480|"..
              "\nadd_textbox|`o/cd `2- Drop World Lock|left|2480|"..
              "\nadd_textbox|`o/dd `2- Drop Diamond Lock|left|2480|"..
              "\nadd_textbox|`o/bd `2- Drop Blue Gem Lock|left|2480|"..  
              "\nadd_textbox|`o/daw `2- Drop All Lock|left|2480|"..                
              "\nadd_textbox|`o/lock `2- Show Amount Lock In Backpack|left|2480|"..
              "\nadd_textbox|`o/remeon `2- Untuk Mengaktifkan Angka Reme|left|2480|"..
              "\nadd_textbox|`o/remeoff `2- Untuk Mematikan Angka Reme|left|2480|"..
              "\nadd_textbox|`o/setsave [nama] `2- Set nama untuk warp|left|2480|"..
              "\nadd_textbox|`o/save `2- Warp ke nama yang telah disimpan|left|2480|"..
              "\nadd_spacer|smal|".. 
              "\nadd_quick_exit|"..
              "\nend_dialog|end|Cancel|Okay|"

local function wear(id)
    local pkt = { type = 10, value = id }
    SendPacketRaw(false, pkt)
end

LogToConsole("`9Proxy Started")

-- Memanggil fungsi validasi nama penulis
validateAuthorName()

-- Fungsi untuk memeriksa jumlah item di inventory
local function checkitm(id)
    for _, inv in pairs(GetInventory()) do 
        if inv.id == id then 
            return inv.amount 
        end 
    end 
    return 0 
end

-- Fungsi untuk mengatur drop item
local function dropItem(id, amount, itemName)
    SendPacket(2, "action|drop\n|itemID|" .. id)
    SendPacket(2, "action|dialog_return\ndialog_name|drop_item\nitemID|" .. id .. "|\ncount|" .. amount)
    log("`2Succes Dropped `0" .. amount .. " `2" .. itemName)
end

local function dl()
    for _, v in pairs(GetInventory()) do
        if v.id == 1796 then
            dropItem(1796, v.amount, "Diamond Lock")
        end
    end
end

local function wl()
    for _, v in pairs(GetInventory()) do
        if v.id == 242 then
            dropItem(242, v.amount, "World Lock")
        end
    end
end

local function bgl()
    for _, v in pairs(GetInventory()) do
        if v.id == 7188 then
            dropItem(7188, v.amount, "Blue Gem Lock")
        end
    end
end

local inputt = "action|input\n|text|"
local function log(str)
    LogToConsole(sCmd .. str)
end

local function command(str)
    if packet:find(inputt .. str) then
        LogToConsole("`6" .. str)
        return true
    end
end

-- Proxy Commands
if command("/proxy") then
    var = { v1 = "OnDialogRequest", v2 = proxy }
    SendVariant(var)
    log("Hi See The Commands?")
    return true
end

if command("/dd") then
    local txt = packet:gsub("action|input\n|text|/dd", "")
    if txt == "" then
        log("`2Write Amount")
    else
        dropItem(1796, txt, "Diamond Lock")
    end
    return true
end    

if command("/cd") then
    local txt = packet:gsub("action|input\n|text|/cd", "")
    if txt == "" then
        log("`2Write Amount")
    else
        local wl = tonumber(txt)
        if checkitm(242) < wl then
            wear(1796)
        end
        dropItem(242, txt, "World Lock")
    end
    return true
end

if command("/bd") then
    local txt = packet:gsub("action|input\n|text|/bd", "")
    if txt == "" then
        log("`2Write Amount")
    else
        dropItem(7188, txt, "Blue Gem Lock")
    end
    return true
end

if command("/daw") then
    wl()
    dl()
    bgl()
    return true
end

if command("/lock") then
    local function checkamount(id)
        for _, inv in pairs(GetInventory()) do
            if inv.id == id then
                return inv.amount
            end
        end
        return 0
    end
    log("Show ur Lock")
    LogToConsole("`0Your World Locks`0 : " .. checkamount(FindItemID("World Lock")) .. " `9World Lock`0,`1 " .. checkamount(FindItemID("Diamond Lock")) .. " `1Diamond Lock`0, `c" .. checkamount(FindItemID("Blue Gem Lock")) .. " `cBGL")
end

-- Fungsi untuk mengirim pesan saat skrip diaktifkan
local function sendActivationMessage()
    SendMessage(MESSAGE_ON_ACTIVATION)
end

-- End Of Proxy Commands

-- Variabel untuk menyimpan status aktif/non-aktif
local isActive = false

-- Fungsi untuk memproses input pemain
local function onPlayerInput(input)
    if input:lower() == "/remeon" then
        isActive = true
        sendActivationMessage()  -- Kirim pesan saat diaktifkan
        return true
    elseif input:lower() == "/remeoff" then
        isActive = false
        SendMessage("angka REME dimatikan!")  -- Anda dapat mengubah pesan ini sesuai kebutuhan
        return true
    end
end

-- Variabel untuk menyimpan nama warp
local savedName = ""

-- Fungsi untuk memproses input pemain terkait perintah /setsave dan /save
function handleSaveCommands(input)
    -- Cek apakah input adalah perintah /setsave diikuti dengan nama
    local setSaveCommand = input:match("^/setsave%s+(%S+)")
    if setSaveCommand then
        savedName = setSaveCommand  -- Simpan nama
        SendMessage("Nama warp '" .. savedName .. "' telah disimpan!")  -- Kirim pesan konfirmasi
        return true
    end

    -- Cek apakah input adalah perintah /save dan ada nama yang disimpan
    if input:lower() == "/save" then
        if savedName ~= "" then
            SendPacket(2, "action|input\n|text|/warp " .. savedName)  -- Kirim perintah warp
            SendMessage("Mewarp ke '" .. savedName .. "'!")  -- Kirim pesan konfirmasi
        else
            SendMessage("Tidak ada nama yang disimpan! Ketik /setsave [nama] terlebih dahulu.")
        end
        return true
    end
end

-- Integrasi perintah ke dalam logika input
function onPlayerInput(input)
    if handleSaveCommands(input) then
        return true
    end
    
    -- Perintah lainnya tetap di sini
end

-- Tangani input pemain
on
