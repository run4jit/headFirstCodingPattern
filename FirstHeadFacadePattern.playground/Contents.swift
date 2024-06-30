import UIKit

var str = "Hello, Facade Pattern"

/// Facade Pattern: 
class Amplifier {
    var tuner = Tuner ()
    var dvdPlayer = DVDPlayer()
    var cdPlayer = CDPlayer()
    func on() {
        debugPrint("Amplifire On")
    }
    func off() {
        debugPrint("Amplifire Off")
    }
    func setCD(_ : CDPlayer) {
        debugPrint("Amplifire setup cd")
    }
    func setDVD(_ : DVDPlayer) {
        debugPrint("Amplifire setup dvd")
    }
    func setSurroundSound() {
        debugPrint("Amplifire set Surround Sound")
    }
    func setTune(_ : Tuner) {
        debugPrint("Amplifire set Tune")

    }
    func setVolume(_ volume: Int) {
        debugPrint("Amplifire set volume \(volume)")
    }
}

class Tuner {
    func on() {
        debugPrint("Tuner On")
    }
    func off() {
        debugPrint("Tuner Off")
    }
    func setAM() {
        debugPrint("Tuner set AM")
    }
    func setFM() {
        debugPrint("Tuner set FM")
    }
    func setFrequency() {
        debugPrint("Tuner set Frequency")
    }
}

class DVDPlayer {
    func on() {
        debugPrint("DVDPlayer On")
    }
    func off() {
        debugPrint("DVDPlayer Off")
    }
    func eject() {
        debugPrint("DVDPlayer eject")
    }
    func play(_ video: String) {
        debugPrint("DVDPlayer playing \(video)")
    }
    func pause() {
        debugPrint("DVDPlayer pause")
    }
    func stop() {
        debugPrint("DVDPlayer Stop")
    }
    func twoChannelAudio() {
        debugPrint("DVDPlayer two Chanel Audio")
    }
}

class CDPlayer {
    func on() {
        debugPrint("CDPlayer On")
    }
    func off() {
        debugPrint("CDPlayer Off")
    }
    func eject() {
        debugPrint("CDPlayer eject")
    }
    func play(_ video: String) {
        debugPrint("CDPlayer playing \(video)")
    }
    func pause() {
        debugPrint("CDPlayer pause")
    }
    func stop() {
        debugPrint("CDPlayer Stop")
    }
}

class Projector {
    var dvdPlayer = DVDPlayer()
    func on() {
        debugPrint("Projector On")
    }
    func off() {
        debugPrint("Projector Off")
    }
    func tvMode() {
        debugPrint("Projector TV Mode")
    }
    func wideScreenMode() {
        debugPrint("Projector wide Screen Mode")
    }
}

class Screen {
    func up() {
        debugPrint("Screen UP")
    }
    func down() {
        debugPrint("Screen Down")
    }
}

class PopconPopper {
    func on() {
        debugPrint("PopconPopper On")
    }
    func off() {
        debugPrint("PopconPopper Off")
    }
    func pop() {
        debugPrint("PopconPopper Pop")
    }
}

class TheaterLights {
    func on() {
        debugPrint("TheaterLights On")
    }
    func off() {
        debugPrint("TheaterLights Off")
    }
    func dim() {
        debugPrint("TheaterLights Dim")
    }
}


class HomeTheater {
    let amplifier = Amplifier()
    let tuner = Tuner()
    let dvdPlayer = DVDPlayer()
    let cdPlayer = CDPlayer()
    let projecter = Projector()
    let lights = TheaterLights()
    let screen = Screen()
    let popper = PopconPopper()
    
    func watchMovie(_ movie : String) {
        debugPrint("Get ready to watch a movie....")
        
        popper.on()
        popper.pop()
        
        lights.dim()
        
        screen.down()
        
        projecter.on()
        projecter.wideScreenMode()
        
        amplifier.on()
        amplifier.setDVD(dvdPlayer)
        amplifier.setSurroundSound()
        amplifier.setVolume(5)
        
        dvdPlayer.on()
        dvdPlayer.play(movie)
    }
    
    func endMovie() {
        dvdPlayer.stop()
        dvdPlayer.eject()
        dvdPlayer.off()
        projecter.off()
        amplifier.off()
        lights.off()
        screen.up()
        popper.off()
    }
}


class HomeTheaterTestDrive {
    let homeTheater = HomeTheater()
    
    func testHomeTherater() {
        homeTheater.watchMovie("Facade patter")
        debugPrint("------------------------------------")
        homeTheater.endMovie()
    }
}

HomeTheaterTestDrive().testHomeTherater()
