Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DF9C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 13:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046AA2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 13:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfCQNZi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 09:25:38 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44394 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfCQNZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 09:25:37 -0400
Received: by mail-oi1-f195.google.com with SMTP id i21so7537810oib.11;
        Sun, 17 Mar 2019 06:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=QXEYrOztdHx/nYYcqluthLb/5rwfPWYInBCz4wzSoRI=;
        b=kWJEwYSXLg/ekN91cDEPkaiTNaKTDjb/YZopDXbzBnEShFimU51c5uDfK6HICyJDDK
         UJZtX1Nf0rYKq3a2aw5wxfxQsOPXwnMdEAgPSuBl9GrdzN3gdcZj6KOJG4XJLtReUYMH
         Q4DQ3ziFYlAvAZMeIl/g5UvOYI6PMnVkSheCbemw8Q8qxC0BTC+KuYYZ2qFXwSiQx89w
         g4iv0rbfBlOXfgDuIv7VfL6DAwXesd68/Edf8hPKp8ldaOvZL0jVqTDVWmimBmiJk3ck
         ThKM1zBHQgIzYRMUoPE3zYeeL5hu5XW2xkZRlAh9HFgm3xamdqcXMPHtc46CHsuNZBAn
         qz3g==
X-Gm-Message-State: APjAAAUTORxn0GYTsaZAPQq8E7w++GTmt/xabM//ooYWrmfZWOI1zM2t
        /cv+VQPAr419QqUlvDuOppGmEGKDqdg=
X-Google-Smtp-Source: APXvYqz+83vEPnm8akuJtM3duhJyrW2PN4S+5iIS34uAOsCPVGzhJRjqsAGZBckZOCDzkQvFpvRBCw==
X-Received: by 2002:aca:52cc:: with SMTP id g195mr2407213oib.30.1552829134805;
        Sun, 17 Mar 2019 06:25:34 -0700 (PDT)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id r184sm3002228oif.31.2019.03.17.06.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 06:25:33 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id e22so3801605oiy.0;
        Sun, 17 Mar 2019 06:25:33 -0700 (PDT)
X-Received: by 2002:aca:f0c3:: with SMTP id o186mr6664223oih.101.1552829132885;
 Sun, 17 Mar 2019 06:25:32 -0700 (PDT)
MIME-Version: 1.0
Reply-To: contact@peterschueller.com
From:   =?UTF-8?Q?Peter_Sch=C3=BCller?= <contact@peterschueller.com>
Date:   Sun, 17 Mar 2019 14:25:15 +0100
X-Gmail-Original-Message-ID: <CALomXVo2zc9NS2wSq=DV-ZVZD-WZQitywbkSExVe3Gx15a8h4g@mail.gmail.com>
Message-ID: <CALomXVo2zc9NS2wSq=DV-ZVZD-WZQitywbkSExVe3Gx15a8h4g@mail.gmail.com>
Subject: PROBLEM: HUAWEI E3531 HSPA+ USB Stick "please report the device ID to
 the Linux USB developers"
To:     =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kai-Heng Feng <kaihengfeng@mail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Christopher M. Penalver" <christopher.m.penalver@gmail.com>,
        =?UTF-8?Q?Peter_Sch=C3=BCller?= <contact@peterschueller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

Plugging in HUAWEI E3531 USB Modem causes "report the device ID to the
Linux USB developers" and device can only be used with a workaround

[2.] Full description of the problem/report:

Plugging in HUAWEI E3531 USB Modem causes (among many others) the
following line in the journal:

Mar 17 14:06:33 gigabyte usb_modeswitch[4282]: usb_modeswitch: add
device ID 12d1:14dc to driver option
Mar 17 14:06:33 gigabyte usb_modeswitch[4282]: usb_modeswitch: please
report the device ID to the Linux USB developers!

The full journal log of plugging in is:

Mar 17 14:06:30 gigabyte kernel: usb 1-4.1: new high-speed USB device
number 8 using xhci_hcd
Mar 17 14:06:30 gigabyte kernel: usb 1-4.1: New USB device found,
idVendor=12d1, idProduct=1f01, bcdDevice= 1.02
Mar 17 14:06:30 gigabyte kernel: usb 1-4.1: New USB device strings:
Mfr=1, Product=2, SerialNumber=3
Mar 17 14:06:30 gigabyte kernel: usb 1-4.1: Product: HUAWEI Mobile
Mar 17 14:06:30 gigabyte kernel: usb 1-4.1: Manufacturer: HUAWEI
Mar 17 14:06:30 gigabyte kernel: usb 1-4.1: SerialNumber: FFFFFFFFFFFFFFFF
Mar 17 14:06:30 gigabyte kernel: usb-storage 1-4.1:1.0: USB Mass
Storage device detected
Mar 17 14:06:30 gigabyte kernel: scsi host1: usb-storage 1-4.1:1.0
Mar 17 14:06:30 gigabyte mtp-probe[4257]: checking bus 1, device 8:
"/sys/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.1"
Mar 17 14:06:30 gigabyte mtp-probe[4257]: bus: 1, device: 8 was not an
MTP device
Mar 17 14:06:30 gigabyte systemd[1]: Starting USB_ModeSwitch_1-4.1:1.0...
Mar 17 14:06:30 gigabyte usb_modeswitch_dispatcher[4282]: Could not
read attribute: No such file or directory
Mar 17 14:06:30 gigabyte usb_modeswitch_dispatcher[4282]: Could not
read attribute: No such file or directory
Mar 17 14:06:30 gigabyte baloo_file.desktop[1940]: UdevQt: unhandled
device action "bind"
Mar 17 14:06:30 gigabyte upowerd[1192]: unhandled action 'bind' on
/sys/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.1/1-4.1:1.0
Mar 17 14:06:30 gigabyte baloo_file.desktop[1940]: UdevQt: unhandled
device action "bind"
Mar 17 14:06:30 gigabyte upowerd[1192]: unhandled action 'bind' on
/sys/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.1
Mar 17 14:06:31 gigabyte kernel: scsi 1:0:0:0: CD-ROM
HUAWEI   Mass Storage     2.31 PQ: 0 ANSI: 2
Mar 17 14:06:31 gigabyte kernel: scsi 1:0:0:1: Direct-Access
HUAWEI   TF CARD Storage  2.31 PQ: 0 ANSI: 2
Mar 17 14:06:31 gigabyte usb_modeswitch[4289]: switch device 12d1:1f01
on 001/008
Mar 17 14:06:31 gigabyte kernel: sr 1:0:0:0: Power-on or device reset occurred
Mar 17 14:06:31 gigabyte kernel: sr 1:0:0:0: [sr0] scsi-1 drive
Mar 17 14:06:31 gigabyte kernel: sr 1:0:0:0: Attached scsi CD-ROM sr0
Mar 17 14:06:31 gigabyte kernel: sr 1:0:0:0: Attached scsi generic sg1 type 5
Mar 17 14:06:31 gigabyte kernel: sd 1:0:0:1: Attached scsi generic sg2 type 0
Mar 17 14:06:31 gigabyte kernel: sd 1:0:0:1: Power-on or device reset occurred
Mar 17 14:06:31 gigabyte kernel: sd 1:0:0:1: [sdb] Attached SCSI removable disk
Mar 17 14:06:31 gigabyte baloo_file.desktop[1940]:
"/org/freedesktop/UDisks2/drives/HUAWEI_HUAWEI_Mobile_FFFFFFFFFFFFFFFF"
has new interfaces: ("org.freedesktop.UDisks2.Drive")
Mar 17 14:06:31 gigabyte systemd-udevd[4295]: inotify_add_watch(9,
/dev/sdb, 10) failed: No such file or directory
Mar 17 14:06:31 gigabyte baloo_file.desktop[1940]: QObject::connect:
invalid null parameter
Mar 17 14:06:31 gigabyte baloo_file.desktop[1940]:
"/org/freedesktop/UDisks2/block_devices/sr0" has new interfaces:
("org.freedesktop.UDisks2.Block")
Mar 17 14:06:32 gigabyte baloo_file.desktop[1940]: QObject::connect:
invalid null parameter
Mar 17 14:06:32 gigabyte baloo_file.desktop[1940]:
"/org/freedesktop/UDisks2/block_devices/sr0" lost interfaces:
("org.freedesktop.UDisks2.Block")
Mar 17 14:06:32 gigabyte baloo_file.desktop[1940]:
"/org/freedesktop/UDisks2/drives/HUAWEI_HUAWEI_Mobile_FFFFFFFFFFFFFFFF"
lost interfaces: ("org.freedesktop.UDisks2.Drive")
Mar 17 14:06:32 gigabyte systemd-udevd[4298]: inotify_add_watch(9,
/dev/sdb, 10) failed: No such file or directory
Mar 17 14:06:32 gigabyte baloo_file.desktop[1940]:
"/org/freedesktop/UDisks2/drives/HUAWEI_HUAWEI_Mobile_FFFFFFFFFFFFFFFF"
has new interfaces: ("org.freedesktop.UDisks2.Drive")
Mar 17 14:06:32 gigabyte baloo_file.desktop[1940]: QObject::connect:
invalid null parameter
Mar 17 14:06:32 gigabyte baloo_file.desktop[1940]:
"/org/freedesktop/UDisks2/block_devices/sdb" has new interfaces:
("org.freedesktop.UDisks2.Block")
Mar 17 14:06:32 gigabyte baloo_file.desktop[1940]: QObject::connect:
invalid null parameter
Mar 17 14:06:32 gigabyte baloo_file.desktop[1940]:
"/org/freedesktop/UDisks2/block_devices/sdb" lost interfaces:
("org.freedesktop.UDisks2.Block")
Mar 17 14:06:32 gigabyte baloo_file.desktop[1940]:
"/org/freedesktop/UDisks2/drives/HUAWEI_HUAWEI_Mobile_FFFFFFFFFFFFFFFF"
lost interfaces: ("org.freedesktop.UDisks2.Drive")
Mar 17 14:06:32 gigabyte baloo_file.desktop[1940]: UdevQt: unhandled
device action "unbind"
Mar 17 14:06:32 gigabyte upowerd[1192]: unhandled action 'unbind' on
/sys/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.1/1-4.1:1.0
Mar 17 14:06:32 gigabyte baloo_file.desktop[1940]: UdevQt: unhandled
device action "bind"
Mar 17 14:06:32 gigabyte upowerd[1192]: unhandled action 'bind' on
/sys/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.1/1-4.1:1.0
Mar 17 14:06:32 gigabyte baloo_file.desktop[1940]: UdevQt: unhandled
device action "unbind"
Mar 17 14:06:32 gigabyte upowerd[1192]: unhandled action 'unbind' on
/sys/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.1/1-4.1:1.0
Mar 17 14:06:32 gigabyte kernel: usb 1-4.1: USB disconnect, device number 8
Mar 17 14:06:32 gigabyte baloo_file.desktop[1940]: UdevQt: unhandled
device action "unbind"
Mar 17 14:06:32 gigabyte upowerd[1192]: unhandled action 'unbind' on
/sys/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.1
Mar 17 14:06:32 gigabyte kernel: usb 1-4.1: new high-speed USB device
number 9 using xhci_hcd
Mar 17 14:06:32 gigabyte kernel: usb 1-4.1: New USB device found,
idVendor=12d1, idProduct=14dc, bcdDevice= 1.02
Mar 17 14:06:32 gigabyte kernel: usb 1-4.1: New USB device strings:
Mfr=1, Product=2, SerialNumber=0
Mar 17 14:06:32 gigabyte kernel: usb 1-4.1: Product: HUAWEI Mobile
Mar 17 14:06:32 gigabyte kernel: usb 1-4.1: Manufacturer: HUAWEI
Mar 17 14:06:32 gigabyte kernel: cdc_ether 1-4.1:1.0 eth0: register
'cdc_ether' at usb-0000:00:14.0-4.1, CDC Ethernet Device,
00:1e:10:1f:00:00
Mar 17 14:06:32 gigabyte kernel: usb-storage 1-4.1:1.2: USB Mass
Storage device detected
Mar 17 14:06:32 gigabyte kernel: scsi host1: usb-storage 1-4.1:1.2
Mar 17 14:06:32 gigabyte NetworkManager[1008]: <info>
[1552827992.7296] manager: (eth0): new Ethernet device
(/org/freedesktop/NetworkManager/Devices/6)
Mar 17 14:06:32 gigabyte mtp-probe[4349]: checking bus 1, device 9:
"/sys/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.1"
Mar 17 14:06:32 gigabyte mtp-probe[4349]: bus: 1, device: 9 was not an
MTP device
Mar 17 14:06:32 gigabyte baloo_file.desktop[1940]: UdevQt: unhandled
device action "bind"
Mar 17 14:06:32 gigabyte systemd-udevd[4345]: link_config:
autonegotiation is unset or enabled, the speed and duplex are not
writable.
Mar 17 14:06:32 gigabyte kernel: cdc_ether 1-4.1:1.0 enx001e101f0000:
renamed from eth0
Mar 17 14:06:32 gigabyte baloo_file.desktop[1940]: UdevQt: unhandled
device action "bind"
Mar 17 14:06:32 gigabyte upowerd[1192]: unhandled action 'bind' on
/sys/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.1/1-4.1:1.1
Mar 17 14:06:32 gigabyte upowerd[1192]: unhandled action 'bind' on
/sys/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.1/1-4.1:1.2
Mar 17 14:06:32 gigabyte systemd-networkd[764]: eth0: Interface name
change detected, eth0 has been renamed to enx001e101f0000.
Mar 17 14:06:32 gigabyte NetworkManager[1008]: <info>
[1552827992.8111] devices added (path:
/sys/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.1/1-4.1:1.0/net/enx001e101f0000,
iface: enx001e101f0000)
Mar 17 14:06:32 gigabyte NetworkManager[1008]: <info>
[1552827992.8111] device added (path:
/sys/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.1/1-4.1:1.0/net/enx001e101f0000,
iface: enx001e101f0000): no ifupdown configuration found.
Mar 17 14:06:32 gigabyte systemd-timesyncd[761]: Network configuration
changed, trying to establish connection.
Mar 17 14:06:32 gigabyte baloo_file.desktop[1940]: QObject::connect:
invalid null parameter
Mar 17 14:06:32 gigabyte networkd-dispatcher[1012]: WARNING:Unknown
index 6 seen, reloading interface list
Mar 17 14:06:32 gigabyte baloo_file.desktop[1940]: UdevQt: unhandled
device action "bind"
Mar 17 14:06:32 gigabyte upowerd[1192]: unhandled action 'bind' on
/sys/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.1/1-4.1:1.0
Mar 17 14:06:32 gigabyte baloo_file.desktop[1940]: UdevQt: unhandled
device action "bind"
Mar 17 14:06:32 gigabyte upowerd[1192]: unhandled action 'bind' on
/sys/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.1
Mar 17 14:06:32 gigabyte baloo_file.desktop[1940]: UdevQt: unhandled
device action "move"
Mar 17 14:06:32 gigabyte systemd-timesyncd[761]: Synchronized to time
server [2001:67c:1560:8003::c8]:123 (ntp.ubuntu.com).
Mar 17 14:06:32 gigabyte usb_modeswitch_dispatcher[4282]: Could not
read attribute: No such file or directory
Mar 17 14:06:32 gigabyte usb_modeswitch[4282]: usb_modeswitch:
switched to 12d1:14dc on 1/9
Mar 17 14:06:33 gigabyte kernel: scsi 1:0:0:0: Direct-Access
HUAWEI   TF CARD Storage  2.31 PQ: 0 ANSI: 2
Mar 17 14:06:33 gigabyte kernel: sd 1:0:0:0: Attached scsi generic sg1 type 0
Mar 17 14:06:33 gigabyte kernel: sd 1:0:0:0: [sdb] Attached SCSI removable disk
Mar 17 14:06:33 gigabyte usb_modeswitch_dispatcher[4282]: Unable to
open bind list file: No such file or directory
Mar 17 14:06:33 gigabyte usb_modeswitch[4282]: usb_modeswitch: add
device ID 12d1:14dc to driver option
Mar 17 14:06:33 gigabyte usb_modeswitch[4282]: usb_modeswitch: please
report the device ID to the Linux USB developers!
Mar 17 14:06:34 gigabyte baloo_file.desktop[1940]:
"/org/freedesktop/UDisks2/drives/HUAWEI_TF_CARD_Storage_HUAWEI_TF_CARD_Storage_0_3a0"
has new interfaces: ("org.freedesktop.UDisks2.Drive")
Mar 17 14:06:34 gigabyte baloo_file.desktop[1940]: QObject::connect:
invalid null parameter
Mar 17 14:06:34 gigabyte baloo_file.desktop[1940]:
"/org/freedesktop/UDisks2/block_devices/sdb" has new interfaces:
("org.freedesktop.UDisks2.Block")
Mar 17 14:06:34 gigabyte baloo_file.desktop[1940]: QObject::connect:
invalid null parameter
Mar 17 14:06:35 gigabyte ModemManager[954]: <info>  Couldn't check
support for device at
'/sys/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.1': not supported
by any plugin
Mar 17 14:06:40 gigabyte systemd[1]: Started USB_ModeSwitch_1-4.1:1.0.

The issue was initially reported at
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1819362 and I was
asked to report it upstream.

Please CC me in replies as I am not subscribed.

[3.] Keywords (i.e., modules, networking, kernel):

none

[4.] Kernel version (from /proc/version):

Linux version 5.0.2-050002-generic (kernel@tangerine) (gcc version
8.3.0 (Ubuntu 8.3.0-2ubuntu2)) #201903131832 SMP Wed Mar 13 22:35:19
UTC 2019

[5.] Output of Oops.. message (if applicable) with symbolic
information resolved (see Documentation/oops-tracing.txt)

No Oops.

[6.] A small shell script or example program which triggers the
problem (if possible)

Triggered by plugging in the device on USB.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

# /usr/src/linux-headers-5.0.2-050002/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux gigabyte 5.0.2-050002-generic #201903131832 SMP Wed Mar 13
22:35:19 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

GNU Make            4.1
Binutils            2.30
Util-linux          2.31.1
Mount                2.31.1
Module-init-tools    24
E2fsprogs            1.44.1
Pcmciautils          018
PPP                  2.4.7
Linux C Library      2.27
Dynamic linker (ldd) 2.27
Linux C++ Library    6.0.25
Procps              3.3.12
Net-tools            2.10
Kbd                  2.0.4
Console-tools        2.0.4
Sh-utils            8.28
Udev                237
Wireless-tools      30
Modules Loaded      ac97_bus acpi_pad aesni_intel aes_x86_64 ahci arc4
autofs4 binfmt_misc bluetooth bnep bpfilter btbcm btintel btrtl btusb
ccm cdc_ether cfg80211 cmac coretemp crc32_pclmul crct10dif_pclmul
cryptd crypto_simd drm drm_kms_helper e1000e ecdh_generic fb_sys_fops
ghash_clmulni_intel glue_helper hid hid_generic i2c_algo_bit i915
input_leds intel_cstate intel_pch_thermal intel_powerclamp intel_rapl
intel_rapl_perf intel_xhci_usb_role_switch ip6table_filter ip6_tables
iptable_filter ip_tables irqbypass iwlmvm iwlwifi joydev kvm kvmgt
kvm_intel ledtrig_audio libahci lp mac80211 mac_hid mdev mei mei_me
mii nls_iso8859_1 option parport parport_pc ppdev rfcomm roles
sch_fq_codel snd snd_compress snd_hda_codec snd_hda_codec_generic
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_core snd_hda_ext_core
snd_hda_intel snd_hrtimer snd_hwdep snd_pcm snd_pcm_dmaengine
snd_rawmidi snd_seq snd_seq_device snd_seq_dummy snd_seq_midi
snd_seq_midi_event snd_seq_oss snd_soc_acpi snd_soc_acpi_intel_match
snd_soc_core snd_soc_hdac_hda snd_soc_skl snd_soc_skl_ipc
snd_soc_sst_dsp snd_soc_sst_ipc snd_timer soundcore syscopyarea
sysfillrect sysimgblt uas usbhid usbnet usbserial usb_storage usb_wwan
vfio vfio_iommu_type1 vfio_mdev video x86_pkg_temp_thermal x_tables

[7.2.] Processor information (from /proc/cpuinfo):

processor : 0
vendor_id : GenuineIntel
cpu family : 6
model : 142
model name : Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz
stepping : 10
microcode : 0x96
cpu MHz : 605.785
cache size : 6144 KB
physical id : 0
siblings : 8
core id : 0
cpu cores : 4
apicid : 0
initial apicid : 0
fpu : yes
fpu_exception : yes
cpuid level : 22
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb invpcid_single
pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid ept_ad
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx
smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida
arat pln pts hwp hwp_notify hwp_act_window hwp_epp flush_l1d
bugs : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf
bogomips : 3600.00
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 1
vendor_id : GenuineIntel
cpu family : 6
model : 142
model name : Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz
stepping : 10
microcode : 0x96
cpu MHz : 657.942
cache size : 6144 KB
physical id : 0
siblings : 8
core id : 1
cpu cores : 4
apicid : 2
initial apicid : 2
fpu : yes
fpu_exception : yes
cpuid level : 22
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb invpcid_single
pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid ept_ad
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx
smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida
arat pln pts hwp hwp_notify hwp_act_window hwp_epp flush_l1d
bugs : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf
bogomips : 3600.00
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 2
vendor_id : GenuineIntel
cpu family : 6
model : 142
model name : Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz
stepping : 10
microcode : 0x96
cpu MHz : 631.506
cache size : 6144 KB
physical id : 0
siblings : 8
core id : 2
cpu cores : 4
apicid : 4
initial apicid : 4
fpu : yes
fpu_exception : yes
cpuid level : 22
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb invpcid_single
pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid ept_ad
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx
smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida
arat pln pts hwp hwp_notify hwp_act_window hwp_epp flush_l1d
bugs : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf
bogomips : 3600.00
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 3
vendor_id : GenuineIntel
cpu family : 6
model : 142
model name : Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz
stepping : 10
microcode : 0x96
cpu MHz : 642.711
cache size : 6144 KB
physical id : 0
siblings : 8
core id : 3
cpu cores : 4
apicid : 6
initial apicid : 6
fpu : yes
fpu_exception : yes
cpuid level : 22
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb invpcid_single
pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid ept_ad
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx
smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida
arat pln pts hwp hwp_notify hwp_act_window hwp_epp flush_l1d
bugs : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf
bogomips : 3600.00
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 4
vendor_id : GenuineIntel
cpu family : 6
model : 142
model name : Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz
stepping : 10
microcode : 0x96
cpu MHz : 604.233
cache size : 6144 KB
physical id : 0
siblings : 8
core id : 0
cpu cores : 4
apicid : 1
initial apicid : 1
fpu : yes
fpu_exception : yes
cpuid level : 22
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb invpcid_single
pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid ept_ad
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx
smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida
arat pln pts hwp hwp_notify hwp_act_window hwp_epp flush_l1d
bugs : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf
bogomips : 3600.00
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 5
vendor_id : GenuineIntel
cpu family : 6
model : 142
model name : Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz
stepping : 10
microcode : 0x96
cpu MHz : 601.122
cache size : 6144 KB
physical id : 0
siblings : 8
core id : 1
cpu cores : 4
apicid : 3
initial apicid : 3
fpu : yes
fpu_exception : yes
cpuid level : 22
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb invpcid_single
pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid ept_ad
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx
smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida
arat pln pts hwp hwp_notify hwp_act_window hwp_epp flush_l1d
bugs : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf
bogomips : 3600.00
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 6
vendor_id : GenuineIntel
cpu family : 6
model : 142
model name : Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz
stepping : 10
microcode : 0x96
cpu MHz : 601.049
cache size : 6144 KB
physical id : 0
siblings : 8
core id : 2
cpu cores : 4
apicid : 5
initial apicid : 5
fpu : yes
fpu_exception : yes
cpuid level : 22
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb invpcid_single
pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid ept_ad
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx
smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida
arat pln pts hwp hwp_notify hwp_act_window hwp_epp flush_l1d
bugs : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf
bogomips : 3600.00
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 7
vendor_id : GenuineIntel
cpu family : 6
model : 142
model name : Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz
stepping : 10
microcode : 0x96
cpu MHz : 612.961
cache size : 6144 KB
physical id : 0
siblings : 8
core id : 3
cpu cores : 4
apicid : 7
initial apicid : 7
fpu : yes
fpu_exception : yes
cpuid level : 22
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb invpcid_single
pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid ept_ad
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx
smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida
arat pln pts hwp hwp_notify hwp_act_window hwp_epp flush_l1d
bugs : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf
bogomips : 3600.00
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

[7.3.] Module information (from /proc/modules):

option 57344 0 - Live 0x0000000000000000
usb_wwan 24576 1 option, Live 0x0000000000000000
usbserial 49152 2 option,usb_wwan, Live 0x0000000000000000
cdc_ether 20480 0 - Live 0x0000000000000000
usbnet 45056 1 cdc_ether, Live 0x0000000000000000
mii 16384 1 usbnet, Live 0x0000000000000000
uas 24576 0 - Live 0x0000000000000000
usb_storage 69632 1 uas, Live 0x0000000000000000
ip6table_filter 16384 0 - Live 0x0000000000000000
ip6_tables 32768 1 ip6table_filter, Live 0x0000000000000000
iptable_filter 16384 0 - Live 0x0000000000000000
bpfilter 32768 0 - Live 0x0000000000000000
rfcomm 77824 4 - Live 0x0000000000000000
ccm 20480 3 - Live 0x0000000000000000
snd_hrtimer 16384 1 - Live 0x0000000000000000
cmac 16384 1 - Live 0x0000000000000000
bnep 24576 2 - Live 0x0000000000000000
snd_hda_codec_hdmi 53248 1 - Live 0x0000000000000000
snd_hda_codec_realtek 114688 1 - Live 0x0000000000000000
snd_hda_codec_generic 77824 1 snd_hda_codec_realtek, Live 0x0000000000000000
ledtrig_audio 16384 2 snd_hda_codec_realtek,snd_hda_codec_generic,
Live 0x0000000000000000
binfmt_misc 24576 1 - Live 0x0000000000000000
nls_iso8859_1 16384 1 - Live 0x0000000000000000
snd_soc_skl 106496 0 - Live 0x0000000000000000
snd_soc_hdac_hda 24576 1 snd_soc_skl, Live 0x0000000000000000
snd_hda_ext_core 28672 2 snd_soc_skl,snd_soc_hdac_hda, Live 0x0000000000000000
snd_soc_skl_ipc 65536 1 snd_soc_skl, Live 0x0000000000000000
intel_rapl 24576 0 - Live 0x0000000000000000
snd_soc_sst_ipc 20480 1 snd_soc_skl_ipc, Live 0x0000000000000000
x86_pkg_temp_thermal 20480 0 - Live 0x0000000000000000
snd_soc_sst_dsp 36864 1 snd_soc_skl_ipc, Live 0x0000000000000000
intel_powerclamp 20480 0 - Live 0x0000000000000000
snd_soc_acpi_intel_match 28672 1 snd_soc_skl, Live 0x0000000000000000
coretemp 20480 0 - Live 0x0000000000000000
snd_soc_acpi 16384 2 snd_soc_skl,snd_soc_acpi_intel_match, Live
0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
snd_soc_core 233472 2 snd_soc_skl,snd_soc_hdac_hda, Live 0x0000000000000000
snd_compress 24576 1 snd_soc_core, Live 0x0000000000000000
ac97_bus 16384 1 snd_soc_core, Live 0x0000000000000000
snd_pcm_dmaengine 16384 1 snd_soc_core, Live 0x0000000000000000
kvm_intel 245760 0 - Live 0x0000000000000000
snd_hda_intel 40960 6 - Live 0x0000000000000000
i915 1814528 27 - Live 0x0000000000000000
snd_hda_codec 126976 5
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_soc_hdac_hda,snd_hda_intel,
Live 0x0000000000000000
snd_hda_core 86016 8
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_soc_skl,snd_soc_hdac_hda,snd_hda_ext_core,snd_hda_intel,snd_hda_codec,
Live 0x0000000000000000
snd_hwdep 20480 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 106496 8
snd_hda_codec_hdmi,snd_soc_skl,snd_hda_ext_core,snd_soc_core,snd_pcm_dmaengine,snd_hda_intel,snd_hda_codec,snd_hda_core,
Live 0x0000000000000000
snd_seq_dummy 16384 0 - Live 0x0000000000000000
kvmgt 28672 0 - Live 0x0000000000000000
snd_seq_oss 40960 0 - Live 0x0000000000000000
vfio_mdev 16384 0 - Live 0x0000000000000000
mdev 24576 2 kvmgt,vfio_mdev, Live 0x0000000000000000
btusb 49152 0 - Live 0x0000000000000000
snd_seq_midi 20480 0 - Live 0x0000000000000000
crct10dif_pclmul 16384 1 - Live 0x0000000000000000
vfio_iommu_type1 28672 0 - Live 0x0000000000000000
btrtl 20480 1 btusb, Live 0x0000000000000000
snd_seq_midi_event 16384 2 snd_seq_oss,snd_seq_midi, Live 0x0000000000000000
joydev 24576 0 - Live 0x0000000000000000
vfio 32768 3 kvmgt,vfio_mdev,vfio_iommu_type1, Live 0x0000000000000000
btbcm 16384 1 btusb, Live 0x0000000000000000
input_leds 16384 0 - Live 0x0000000000000000
btintel 24576 1 btusb, Live 0x0000000000000000
iwlmvm 380928 0 - Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
kvm 634880 2 kvm_intel,kvmgt, Live 0x0000000000000000
bluetooth 561152 33 rfcomm,bnep,btusb,btrtl,btbcm,btintel, Live
0x0000000000000000
snd_rawmidi 36864 1 snd_seq_midi, Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
mac80211 811008 1 iwlmvm, Live 0x0000000000000000
ecdh_generic 28672 2 bluetooth, Live 0x0000000000000000
snd_seq 69632 7
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event, Live
0x0000000000000000
irqbypass 16384 1 kvm, Live 0x0000000000000000
iwlwifi 311296 1 iwlmvm, Live 0x0000000000000000
aesni_intel 372736 4 - Live 0x0000000000000000
drm_kms_helper 180224 1 i915, Live 0x0000000000000000
snd_seq_device 16384 4 snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq,
Live 0x0000000000000000
aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
drm 479232 16 i915,drm_kms_helper, Live 0x0000000000000000
snd_timer 36864 3 snd_hrtimer,snd_pcm,snd_seq, Live 0x0000000000000000
crypto_simd 16384 1 aesni_intel, Live 0x0000000000000000
cryptd 24576 3 ghash_clmulni_intel,aesni_intel,crypto_simd, Live
0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
snd 86016 27 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_soc_core,snd_compress,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_seq_oss,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
fb_sys_fops 16384 1 drm_kms_helper, Live 0x0000000000000000
syscopyarea 16384 1 drm_kms_helper, Live 0x0000000000000000
mei_me 40960 0 - Live 0x0000000000000000
sysfillrect 16384 1 drm_kms_helper, Live 0x0000000000000000
intel_cstate 20480 0 - Live 0x0000000000000000
intel_xhci_usb_role_switch 16384 0 - Live 0x0000000000000000
cfg80211 671744 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
intel_rapl_perf 16384 0 - Live 0x0000000000000000
sysimgblt 16384 1 drm_kms_helper, Live 0x0000000000000000
intel_pch_thermal 16384 0 - Live 0x0000000000000000
roles 16384 1 intel_xhci_usb_role_switch, Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
mei 102400 1 mei_me, Live 0x0000000000000000
acpi_pad 180224 0 - Live 0x0000000000000000
mac_hid 16384 0 - Live 0x0000000000000000
sch_fq_codel 20480 6 - Live 0x0000000000000000
parport_pc 40960 0 - Live 0x0000000000000000
ppdev 24576 0 - Live 0x0000000000000000
lp 20480 0 - Live 0x0000000000000000
parport 53248 3 parport_pc,ppdev,lp, Live 0x0000000000000000
ip_tables 28672 1 iptable_filter, Live 0x0000000000000000
x_tables 40960 4 ip6table_filter,ip6_tables,iptable_filter,ip_tables,
Live 0x0000000000000000
autofs4 45056 2 - Live 0x0000000000000000
hid_generic 16384 0 - Live 0x0000000000000000
usbhid 53248 0 - Live 0x0000000000000000
hid 135168 2 hid_generic,usbhid, Live 0x0000000000000000
e1000e 245760 0 - Live 0x0000000000000000
ahci 40960 3 - Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
video 49152 1 i915, Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)


0000-0000 : PCI Bus 0000:00
  0000-0000 : dma1
  0000-0000 : pic1
  0000-0000 : timer0
  0000-0000 : timer1
  0000-0000 : keyboard
  0000-0000 : keyboard
  0000-0000 : rtc0
  0000-0000 : dma page reg
  0000-0000 : pic2
  0000-0000 : dma2
  0000-0000 : fpu
  0000-0000 : pnp 00:01
  0000-0000 : pnp 00:00
  0000-0000 : pnp 00:00
  0000-0000 : pnp 00:00
  0000-0000 : pnp 00:00
0000-0000 : PCI conf1
0000-0000 : PCI Bus 0000:00
  0000-0000 : pnp 00:01
  0000-0000 : pnp 00:01
    0000-0000 : ACPI PM1a_EVT_BLK
    0000-0000 : ACPI PM1a_CNT_BLK
    0000-0000 : ACPI PM_TMR
    0000-0000 : ACPI PM2_CNT_BLK
    0000-0000 : pnp 00:03
    0000-0000 : ACPI GPE0_BLK
  0000-0000 : 0000:00:02.0
  0000-0000 : 0000:00:1f.4
  0000-0000 : 0000:00:17.0
    0000-0000 : ahci
  0000-0000 : 0000:00:17.0
    0000-0000 : ahci
  0000-0000 : 0000:00:17.0
    0000-0000 : ahci
  0000-0000 : pnp 00:06
  0000-0000 : pnp 00:01
    0000-0000 : pnp 00:01
      0000-0000 : pnp 00:01


00000000-00000000 : Reserved
00000000-00000000 : System RAM
00000000-00000000 : Reserved
00000000-00000000 : System RAM
00000000-00000000 : Reserved
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
    00000000-00000000 : System ROM
00000000-00000000 : System RAM
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : System RAM
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : Reserved
00000000-00000000 : System RAM
00000000-00000000 : Reserved
00000000-00000000 : System RAM
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : Reserved
00000000-00000000 : Unknown E820 type
00000000-00000000 : System RAM
00000000-00000000 : Reserved
  00000000-00000000 : Graphics Stolen Memory
00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : 0000:00:02.0
  00000000-00000000 : 0000:00:02.0
  00000000-00000000 : PCI Bus 0000:02
    00000000-00000000 : 0000:02:00.0
      00000000-00000000 : iwlwifi
  00000000-00000000 : PCI Bus 0000:01
    00000000-00000000 : 0000:01:00.0
      00000000-00000000 : xhci-hcd
  00000000-00000000 : 0000:00:1f.6
    00000000-00000000 : e1000e
  00000000-00000000 : 0000:00:1f.3
    00000000-00000000 : ICH HD audio
  00000000-00000000 : 0000:00:14.0
    00000000-00000000 : xhci-hcd
      00000000-00000000 : intel_xhci_usb_sw
  00000000-00000000 : 0000:00:1f.3
    00000000-00000000 : ICH HD audio
  00000000-00000000 : 0000:00:1f.2
  00000000-00000000 : 0000:00:17.0
    00000000-00000000 : ahci
  00000000-00000000 : 0000:00:1f.4
  00000000-00000000 : 0000:00:17.0
    00000000-00000000 : ahci
  00000000-00000000 : 0000:00:17.0
    00000000-00000000 : ahci
  00000000-00000000 : 0000:00:16.0
    00000000-00000000 : mei_me
  00000000-00000000 : 0000:00:14.2
    00000000-00000000 : Intel PCH thermal driver
  00000000-00000000 : pnp 00:04
00000000-00000000 : PCI MMCONFIG 0000 [bus 00-ff]
  00000000-00000000 : Reserved
    00000000-00000000 : pnp 00:04
00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : pnp 00:05
  00000000-00000000 : pnp 00:07
  00000000-00000000 : pnp 00:05
  00000000-00000000 : pnp 00:07
  00000000-00000000 : pnp 00:07
  00000000-00000000 : pnp 00:05
  00000000-00000000 : Reserved
  00000000-00000000 : pnp 00:07
  00000000-00000000 : pnp 00:07
  00000000-00000000 : pnp 00:05
  00000000-00000000 : pnp 00:05
  00000000-00000000 : pnp 00:05
00000000-00000000 : Reserved
  00000000-00000000 : IOAPIC 0
00000000-00000000 : Reserved
  00000000-00000000 : HPET 0
    00000000-00000000 : PNP0103:00
00000000-00000000 : pnp 00:04
00000000-00000000 : pnp 00:04
00000000-00000000 : pnp 00:04
00000000-00000000 : pnp 00:04
00000000-00000000 : pnp 00:04
00000000-00000000 : dmar0
00000000-00000000 : dmar1
00000000-00000000 : Local APIC
  00000000-00000000 : Reserved
00000000-00000000 : Reserved
  00000000-00000000 : INT0800:00
    00000000-00000000 : pnp 00:04
00000000-00000000 : System RAM
  00000000-00000000 : Kernel code
  00000000-00000000 : Kernel data
  00000000-00000000 : Kernel bss
00000000-00000000 : RAM buffer


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v6/7th Gen Core
Processor Host Bridge/DRAM Registers (rev 08)
Subsystem: Gigabyte Technology Co., Ltd Xeon E3-1200 v6/7th Gen Core
Processor Host Bridge/DRAM Registers
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
Latency: 0
Capabilities: [e0] Vendor Specific Information: Len=10 <?>
Kernel driver in use: skl_uncore

00:02.0 VGA compatible controller: Intel Corporation UHD Graphics 620
(rev 07) (prog-if 00 [VGA controller])
Subsystem: Gigabyte Technology Co., Ltd UHD Graphics 620
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 16
Region 0: Memory at de000000 (64-bit, non-prefetchable) [size=16M]
Region 2: Memory at c0000000 (64-bit, prefetchable) [size=256M]
Region 4: I/O ports at f000 [size=64]
[virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
Capabilities: [40] Vendor Specific Information: Len=0c <?>
Capabilities: [70] Express (v2) Root Complex Integrated Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF
Not Supported
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
Capabilities: [ac] MSI: Enable- Count=1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Capabilities: [d0] Power Management version 2
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [100 v1] Process Address Space ID (PASID)
PASIDCap: Exec- Priv-, Max PASID Width: 14
PASIDCtl: Enable- Exec- Priv-
Capabilities: [200 v1] Address Translation Service (ATS)
ATSCap: Invalidate Queue Depth: 00
ATSCtl: Enable-, Smallest Translation Unit: 00
Capabilities: [300 v1] Page Request Interface (PRI)
PRICtl: Enable- Reset-
PRISta: RF- UPRGI- Stopped+
Page Request Capacity: 00008000, Page Request Allocation: 00000000
Kernel driver in use: i915
Kernel modules: i915

00:14.0 USB controller: Intel Corporation Sunrise Point-LP USB 3.0
xHCI Controller (rev 21) (prog-if 30 [XHCI])
Subsystem: Gigabyte Technology Co., Ltd Sunrise Point-LP USB 3.0 xHCI Controller
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 16
Region 0: Memory at df230000 (64-bit, non-prefetchable) [size=64K]
Capabilities: [70] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [80] MSI: Enable- Count=1/8 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Kernel driver in use: xhci_hcd

00:14.2 Signal processing controller: Intel Corporation Sunrise
Point-LP Thermal subsystem (rev 21)
Subsystem: Gigabyte Technology Co., Ltd Sunrise Point-LP Thermal subsystem
Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin C routed to IRQ 18
Region 0: Memory at df24e000 (64-bit, non-prefetchable) [size=4K]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Kernel driver in use: intel_pch_thermal
Kernel modules: intel_pch_thermal

00:16.0 Communication controller: Intel Corporation Sunrise Point-LP
CSME HECI #1 (rev 21)
Subsystem: Gigabyte Technology Co., Ltd Sunrise Point-LP CSME HECI
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 16
Region 0: Memory at df24d000 (64-bit, non-prefetchable) [size=4K]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [8c] MSI: Enable- Count=1/1 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Kernel driver in use: mei_me
Kernel modules: mei_me

00:17.0 SATA controller: Intel Corporation Sunrise Point-LP SATA
Controller [AHCI mode] (rev 21) (prog-if 01 [AHCI 1.0])
Subsystem: Gigabyte Technology Co., Ltd Sunrise Point-LP SATA
Controller [AHCI mode]
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 16
Region 0: Memory at df248000 (32-bit, non-prefetchable) [size=8K]
Region 1: Memory at df24c000 (32-bit, non-prefetchable) [size=256]
Region 2: I/O ports at f090 [size=8]
Region 3: I/O ports at f080 [size=4]
Region 4: I/O ports at f060 [size=32]
Region 5: Memory at df24b000 (32-bit, non-prefetchable) [size=2K]
Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Capabilities: [70] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
Kernel driver in use: ahci
Kernel modules: ahci

00:1c.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express
Root Port #1 (rev f1) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 16
Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: df100000-df1fffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 256 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 256 bytes, MaxReadReq 128 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #1, Speed 8GT/s, Width x2, ASPM not supported, Exit
Latency L0s <1us, L1 <16us
ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 8GT/s, Width x2, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #4, PowerLimit 25.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not
Supported ARIFwd+
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+,
EqualizationPhase1+
EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Capabilities: [90] Subsystem: Gigabyte Technology Co., Ltd Sunrise
Point-LP PCI Express Root Port
Capabilities: [a0] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [100 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt+ RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 12, GenCap- CGenEn- ChkCap- ChkEn-
Capabilities: [140 v1] Access Control Services
ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd-
EgressCtrl- DirectTrans-
ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
EgressCtrl- DirectTrans-
Capabilities: [220 v1] #19
Kernel driver in use: pcieport

00:1c.5 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express
Root Port #6 (rev f1) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin B routed to IRQ 17
Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: df000000-df0fffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 256 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #6, Speed 8GT/s, Width x1, ASPM not supported, Exit
Latency L0s <1us, L1 <16us
ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #9, PowerLimit 10.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not
Supported ARIFwd+
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Capabilities: [90] Subsystem: Gigabyte Technology Co., Ltd Sunrise
Point-LP PCI Express Root Port
Capabilities: [a0] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [100 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt+ RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
Capabilities: [140 v1] Access Control Services
ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd-
EgressCtrl- DirectTrans-
ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
EgressCtrl- DirectTrans-
Capabilities: [220 v1] #19
Kernel driver in use: pcieport

00:1f.0 ISA bridge: Intel Corporation Intel(R) 100 Series Chipset
Family LPC Controller/eSPI Controller - 9D4E (rev 21)
Subsystem: Gigabyte Technology Co., Ltd Device 1000
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0

00:1f.2 Memory controller: Intel Corporation Sunrise Point-LP PMC (rev 21)
Subsystem: Gigabyte Technology Co., Ltd Sunrise Point-LP PMC
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Region 0: Memory at df244000 (32-bit, non-prefetchable) [disabled] [size=16K]

00:1f.3 Audio device: Intel Corporation Sunrise Point-LP HD Audio (rev 21)
Subsystem: Gigabyte Technology Co., Ltd Sunrise Point-LP HD Audio
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 32, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 16
Region 0: Memory at df240000 (64-bit, non-prefetchable) [size=16K]
Region 4: Memory at df220000 (64-bit, non-prefetchable) [size=64K]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [60] MSI: Enable- Count=1/1 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Kernel driver in use: snd_hda_intel
Kernel modules: snd_hda_intel, snd_soc_skl

00:1f.4 SMBus: Intel Corporation Sunrise Point-LP SMBus (rev 21)
Subsystem: Gigabyte Technology Co., Ltd Sunrise Point-LP SMBus
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin A routed to IRQ 255
Region 0: Memory at df24a000 (64-bit, non-prefetchable) [size=256]
Region 4: I/O ports at f040 [size=32]
Kernel modules: i2c_i801

00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection
I219-V (rev 21)
Subsystem: Gigabyte Technology Co., Ltd Ethernet Connection I219-V
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 16
Region 0: Memory at df200000 (32-bit, non-prefetchable) [size=128K]
Capabilities: [c8] Power Management version 3
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Capabilities: [e0] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: e1000e
Kernel modules: e1000e

01:00.0 USB controller: ASMedia Technology Inc. Device 2142 (prog-if 30 [XHCI])
Subsystem: Gigabyte Technology Co., Ltd Device 1000
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 16
Region 0: Memory at df100000 (64-bit, non-prefetchable) [size=32K]
Capabilities: [50] MSI: Enable- Count=1/8 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Capabilities: [68] MSI-X: Enable- Count=8 Masked-
Vector table: BAR=0 offset=00002000
PBA: BAR=0 offset=00002080
Capabilities: [78] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [80] Express (v2) Legacy Endpoint, MSI 00
DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1 <2us
ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
MaxPayload 256 bytes, MaxReadReq 512 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #0, Speed 8GT/s, Width x2, ASPM L0s L1, Exit Latency L0s
<2us, L1 unlimited
ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 8GT/s, Width x2, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+, OBFF
Not Supported
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled
LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+,
EqualizationPhase1+
EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
Capabilities: [100 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap- ChkEn-
Capabilities: [200 v1] #19
Capabilities: [300 v1] Latency Tolerance Reporting
Max snoop latency: 3145728ns
Max no snoop latency: 3145728ns
Kernel driver in use: xhci_hcd

02:00.0 Network controller: Intel Corporation Dual Band Wireless-AC
3168NGW [Stone Peak] (rev 10)
Subsystem: Intel Corporation Device 2110
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 17
Region 0: Memory at df000000 (64-bit, non-prefetchable) [size=8K]
Capabilities: [c8] Power Management version 3
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Capabilities: [40] Express (v2) Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlimited
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0.000W
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L1, Exit Latency L0s
<4us, L1 <32us
ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Range B, TimeoutDis+, LTR+, OBFF Via WAKE#
DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-, LTR+, OBFF Disabled
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [100 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
Capabilities: [140 v1] Device Serial Number 0c-54-15-ff-ff-8f-de-aa
Capabilities: [14c v1] Latency Tolerance Reporting
Max snoop latency: 3145728ns
Max no snoop latency: 3145728ns
Capabilities: [154 v1] L1 PM Substates
L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
  PortCommonModeRestoreTime=30us PortTPowerOnTime=60us
L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
   T_CommonMode=0us LTR1.2_Threshold=0ns
L1SubCtl2: T_PwrOn=60us
Kernel driver in use: iwlwifi
Kernel modules: iwlwifi

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Samsung SSD 860  Rev: 1B6Q
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: HUAWEI   Model: TF CARD Storage  Rev: 2.31
  Type:   Direct-Access                    ANSI  SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

# ls /proc
1     1129  1243  1360  1404  1690  1776  1830  1918  2037  2452  2715
 3027  339   39    42    475  62   76   85   950        cgroups
ioports      modules       sys
10    1130  1255  1363  1477  1692  1784  1831  1920  2045  2581  272
 303   34    3925  4294  48   63   761  852  954        cmdline
irq          mounts        sysrq-trigger
1008  1131  1260  1364  15    17    179   1832  1924  2052  2588  2740
 304   35    3945  4344  50   64   764  859  955        consoles
kallsyms     mtrr          sysvipc
1009  1132  1262  1365  1564  1710  1792  1835  193   2064  2595  2772
 305   3502  3953  4346  51   65   78   862  962        cpuinfo
kcore        net           thread-self
1012  1133  1266  1369  1569  1717  18    1841  1930  2068  2596  28
 306   3526  3960  4347  511  66   79   9    965        crypto
keys         pagetypeinfo  timer_list
1013  1145  1267  1371  1573  1722  180   1848  1934  21    2599  2855
 308   3539  3961  4348  52   67   798  902  966        devices
key-users    partitions    tty
1043  1146  1320  1372  1574  1733  1800  1853  1940  212   26    29
 313   354   3962  44    53   68   799  903  969        diskstats
kmsg         pressure      uptime
1044  1157  1323  1375  1587  175   1805  1859  1974  2136  2600  2949
 3155  36    3973  4433  54   69   8    904  970        dma
kpagecgroup  sched_debug   version
1084  1158  1325  1376  1591  1750  1809  1865  1983  2138  2603  2950
 3176  3632  3974  4472  56   70   800  905  971        driver
kpagecount   schedstat     vmallocinfo
1099  1173  1328  1379  1593  1752  1813  1869  1992  2157  2629  2951
 32    3687  3986  45    57   714  801  906  976        execdomains
kpageflags   scsi          vmstat
11    1175  1347  1383  16    1756  1817  1872  2     22    2633  2965
 3248  3719  3995  4526  58   73   806  907  98         fb
loadavg      self          zoneinfo
1102  1177  1348  1387  1601  1758  182   1874  20    23    27    3
 3255  38    4     46    59   735  810  908  acpi       filesystems
locks        slabinfo
1115  1185  1354  1389  1604  1760  1821  1878  2001  2313  270   30
 3271  3801  40    461   6    74   811  944  asound     fs
mdstat       softirqs
1121  1192  1357  1390  1682  177   1828  1880  2012  24    271   301
 33    382   41    4640  60   75   83   946  buddyinfo  interrupts
meminfo      stat
1128  12    1359  14    1685  1772  1829  1885  2032  2442  2713  3013
 338   3880  4190  47    600  750  84   948  bus        iomem
misc         swaps

[X.] Other notes, patches, fixes, workarounds:

The device can be used with the first step of the workaround described
at https://github.com/EMnify/doc/wiki/How-to-use-a-Huawei-E3531-in-Modem-Mode

Concretly, the workaround consists of creating the file

/etc/usb_modeswitch.d/12d1:1f01

with content

# Huawei E353 (3.se)

TargetVendor=  0x12d1
TargetProduct= 0x1f01

MessageContent="55534243123456780000000000000011062000000100000000000000000000"
NoDriverLoading=1

The issue was initially reported at
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1819362 and I was
asked to report it upstream.

Please CC me in replies as I am not subscribed.

Best Regards,
Peter Schüller

-- 
Dr Peter SCHÜLLER
https://peterschueller.com/
