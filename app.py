#!/usr/bin/env python3
import subprocess
import sys
import time

import gi
try:
    gi.require_version('Gtk', '3.0')
except ValueError:
    print('[erro] GTK 3 não disponível. Instale python3-gi e libgtk-3-0.')
    sys.exit(1)
from gi.repository import Gtk

WAYDROID = 'waydroid'


def run_cmd(cmd):
    try:
        return subprocess.run(cmd, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    except subprocess.CalledProcessError as e:
        return e


def waydroid_installed():
    return subprocess.call(['which', WAYDROID], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL) == 0


def waydroid_running():
    r = run_cmd([WAYDROID, 'status'])
    out = (r.stdout or '') + (r.stderr or '')
    return 'Session: RUNNING' in out


def start_waydroid():
    if waydroid_running():
        return True
    subprocess.Popen([WAYDROID, 'session', 'start'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    for _ in range(20):
        if waydroid_running():
            return True
        time.sleep(1)
    return False


def launch_whatsapp():
    return run_cmd([WAYDROID, 'app', 'launch', 'com.whatsapp'])


class Window(Gtk.Window):
    def __init__(self):
        super().__init__(title='WhatsApp (Waydroid)')
        self.set_default_size(420, 180)

        box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8)
        box.set_border_width(12)
        self.add(box)

        self.lbl = Gtk.Label(label='Use o WhatsApp oficial (Android) em um container Waydroid.')
        self.lbl.set_line_wrap(True)
        box.pack_start(self.lbl, False, False, 0)

        self.btn_start = Gtk.Button(label='Iniciar Waydroid')
        self.btn_start.connect('clicked', self.on_start)
        box.pack_start(self.btn_start, False, False, 0)

        self.btn_launch = Gtk.Button(label='Abrir WhatsApp')
        self.btn_launch.connect('clicked', self.on_launch)
        box.pack_start(self.btn_launch, False, False, 0)

        self.status = Gtk.Label(label='Status: Desconhecido')
        box.pack_end(self.status, False, False, 0)

        self.update_status()

    def update_status(self):
        if not waydroid_installed():
            self.status.set_text('Status: Waydroid não instalado')
            self.btn_start.set_sensitive(False)
            self.btn_launch.set_sensitive(False)
        else:
            running = waydroid_running()
            self.status.set_text('Status: Waydroid em execução' if running else 'Status: Waydroid parado')
            self.btn_start.set_sensitive(True)
            self.btn_launch.set_sensitive(running)

    def on_start(self, _btn):
        if not waydroid_installed():
            self.dialog('Waydroid não encontrado. Instale com: sudo apt install waydroid')
            return
        ok = start_waydroid()
        if not ok:
            self.dialog('Falha ao iniciar Waydroid. Verifique instalação e módulos do kernel (binder/ashmem).')
        self.update_status()

    def on_launch(self, _btn):
        r = launch_whatsapp()
        if isinstance(r, subprocess.CalledProcessError):
            self.dialog('Falha ao abrir WhatsApp. Instale o app Android dentro do Waydroid (Aurora Store/Play).')

    def dialog(self, message: str):
        md = Gtk.MessageDialog(transient_for=self,
                               flags=0,
                               message_type=Gtk.MessageType.INFO,
                               buttons=Gtk.ButtonsType.OK,
                               text=message)
        md.run()
        md.destroy()


def main():
    win = Window()
    win.connect('destroy', Gtk.main_quit)
    win.show_all()
    Gtk.main()


if __name__ == '__main__':
    main()
