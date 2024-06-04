#  Counting Critters

After seeing numerous counting books after my son was born 8 months ago, I decided to make a simple counting app for my son.

---

## Gameplay
Counting Critters will generate a counting book (counting from 1 to 9), where each page will have a different critter to "count".  The critters are placed randomly in a grid, with random scaling and rotation, and are grayed out when tapped.
Once the last page is completed, the game can be restarted with the same critters or restarted with new critters.

---

## Settings
There are two animations (on the Starting Page, the scrolling view of critters) and for the counter on each page (fade from center to bottom left).  This animation is on by default (unless accessibilityReduceMotion is true), and can be toggled off.
There is a haptic when a critter is "counted" (tapped on).  This is on by default and can also be toggled off.
The setting sheet can be accessed on any page by tapping the "i" icon in the top right

---

## Testing
### **Unit Tests**
### Starting View
* Verify the animation properly switches pictures, and properly restarts once all the images are exhausted.
### Counting View
* Verify starting game
* Verify tapping critter
* Verify going to the next page
* Verify Restarting game
* Verify starting new game
* Verify quitting game
* Verify going through all pages

### **UI Tests**
* Verify start screen
* Verify animation on start screen
* Verify the Settings View when info button pressed
* Verify disabling animation
* Verify starting game
* Verify full game
* Verify full game with same critters
* Verify full game with new critters

---

## Thanks
Thank you to [Kenney](https://kenney.nl/assets/animal-pack-redux) for the critter icons, being used under Creative Commons CC0.
The app icon was created by ChatGPT/Dalle.

---

## Contact
Email me at <dowendeveloper@gmail.com>



