#! /usr/bin/env node

import fs from 'fs'
import path from 'path'
import url from 'url'
import net from 'net'
import { exec, execSync } from 'child_process'
import robot from 'robotjs'
import { getWindows, focusWindow, toggleTopmost } from '../lib/yabai.mjs'

const __filename = url.fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)

const PIPE_PATH = path.join(__dirname, '../tmp/yabacritmux')

process.chdir(__dirname)

let L = console.log

const windows = getWindows().reverse()
const terminalName = 'Alacritty'
const terminalWindowId = windows.find(win => win.app === terminalName)?.id
const browserName = 'Firefox'
const browserWindowId = windows.find(win => win.app === browserName)?.id

fs.open(PIPE_PATH, fs.constants.O_RDONLY | fs.constants.O_NONBLOCK, (_err, fd) => {
    const pipe = new net.Socket({ fd })
    pipe.on('data', data => {
      const messagge = data.toString().split('\n')[0]
      switch (messagge) {
        case 'focus':
          onFocus()
          L('FOCUS', new Date())
          break
        case 'toggle':
          onToggle()
          L('TOGGLE', new Date())
          break
        case 'resize':
          onResize()
          L('RESIZE', new Date())
          break
        case 'change':
          onResize()
          onChange()
          L('CHANGE', new Date())
          break
        default:
          break
      }
    })

    pipe.on('error', err => {
      console.error('Error:', err)
    })

    process.on('SIGINT', () => {
      process.exit(0)
    })
  }
)

function onFocus () {
  const windows = getWindows().reverse()
  const paneIndex = Number(
    execSync('tmux display -p "#{pane_index}"').toString()
  )

  const terminalWindow = windows.find(win => win.id === terminalWindowId)

  const isTerminal = terminalWindow['is-topmost']

  if (paneIndex === 0 && !isTerminal) {
    windows.forEach(win => {
      if (win.space === terminalWindow.space && win.id !== terminalWindowId) {
        unsetTopmost(win)
        setFocus(win)
      }
    })
  } else if (!isTerminal) {
    windows.forEach(win => {
      if (win.space === terminalWindow.space && win.id !== terminalWindowId) {
        setTopmost(win)
      }
    })
    setFocus(terminalWindow)
  }
}

function tabGroupChange () {
  const tmuxWinId = Number(execSync('tmux display -p "#I"').toString()).toString()
  robot.keyToggle('escape', 'down')
  robot.keyToggle('escape', 'up')
  // robot.keyToggle('f6', 'down')
  // robot.keyToggle('f6', 'up')
  robot.keyToggle(tmuxWinId, 'down', ['control', 'shift', 'alt', 'command'])
  robot.keyToggle(tmuxWinId, 'up', ['control', 'shift', 'alt', 'command'])
}

function onToggle () {
  const windows = getWindows().reverse()
  const terminalWindow = windows.find(win => win.id === terminalWindowId)

  execSync(`yabai -m window ${terminalWindow.id} --toggle topmost`)
  if (!terminalWindow['is-topmost']) {
    windows.forEach(win => {
      if (win.space === terminalWindow.space && win.id !== terminalWindowId) {
        unsetTopmost(win)
      }
    })
    setFocus(terminalWindow)
  } else {
    windows.forEach(win => {
      if (win.space === terminalWindow.space && win.id !== terminalWindowId) {
        setFocus(win)
        if (win.id === browserWindowId) {
          tabGroupChange()
        }
      }
    })
  }
}

function onChange () {
  const windows = getWindows().reverse()
  const browserWindow = windows.find(win => win.id === browserWindowId)
  const terminalWindow = windows.find(win => win.id === terminalWindowId)
  if (!terminalWindow['is-topmost']) {
    setFocus(browserWindow)
    tabGroupChange()
  }
}

function onResize () {
  const height = Number(
    execSync(`tmux display -p -t config:.0 '#{pane_height}'`)
  )
  const padding = Math.round(1050 - ((height + 1) * 161) / 10 + 2)
  exec(`yabai -m config --space 1 bottom_padding ${padding}`)
}

function setFocus (win) {
  focusWindow(win.id)
  L('focus', win.title)
}

function setTopmost (win) {
  if (!win['is-topmost']) {
    toggleTopmost(win.id)
  }
}

function unsetTopmost (win) {
  if (win['is-topmost']) {
    toggleTopmost(win.id)
  }
}
