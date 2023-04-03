import { exec, execSync } from 'child_process'

export const getWindows = () => {
  return JSON.parse(execSync('yabai -m query --windows').toString())
}

export const focusWindow = windowId => {
  return execSync(`yabai -m window --focus ${windowId}`)
}

export const toggleTopmost = windowId => {
  return execSync(`yabai -m window ${windowId} --toggle topmost`)
}
