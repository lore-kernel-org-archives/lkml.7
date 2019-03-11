Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF278C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC7920657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfCKNT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:19:58 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:41037 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfCKNTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:38 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MSbp1-1hW79m3bSb-00SxsY for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:31 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 032/114] sound: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:44 +0100
Message-Id: <1552310346-7629-33-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:/1hYfn2nWr37ENy5Nn47aD2ErsTKS+91XcMOLiWrIAWIBh0qxt+
 8EVb4p50zOa2DB5YXEfsu9sceojKuVNCBaW7JI1ULZ1DFKC8IYo2CeTeDIxo2D59W2HPp0A
 qpzSJT8GFS+aQ9V6UsggZFG+AEVoxA+tFsnLu0TM06v0eILQlRH3VaX2FJza4NAj4KXiGHx
 1g0kW/n3QEgQVvE447hCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o9ZVRINgu6w=:vB5BKosclWvtXJOaECDZnn
 Lq0WkfJ3PWTO/i6+wdJuPCIDkUuDCqw3eXTUGH0If6V9NsM0lUoTlsV9xO854WzSI1U7OApl7
 PElh9N61f6GQ//A/5J8X5tuWYYmM3z7qpKMqbIuHMH2A7/0xMfurx+MAVeQdipSHa/ZCpfoah
 e4MrAreFAGa/LbzKB6INh40l44FmjW+GCmqmgOpMbxvs7cFOIFBJpZnPqbGouzuKmRCnsOdgq
 2NHKCe83ZxOFcGpBrdrXPT7H5RBjdpkpKofox87ABaYqNBYkaOjQ7+JDmEZmjW+PGTCugfIep
 iJMWem10/3Gp/VEY+tOWm9KmT8hZUvd00GtvIq3ZLwHxKW/BHMtqj2I/aZtGbYq7ie/Xiab/8
 ltvDp+/UYLSdbTybgJJkT2vBF8IyKBmhvxmXkveYTfaPlpD4320c7kxke+f3W/7B+uFXQtri1
 Xoa4EpzCmMkOLKmnAj9Z6leNWHF8zTsmJR5ikBbR93rb8fq2H01uexlWZUTT8Pi5v6BixZzas
 P3OPalh7jahO2jVjW+EjLnRoxcvS9Gt2q6sddod6j6kqjmWWR1VrAoWmXhmisslO69wti/gSK
 oaqcIGLcN+8dXe4W5GD6BJow5ReKfyDJKKBIwds15hSSmf5fqW1IyUN0WYcDLxM8P9N1i7dX2
 TGr0YWsOBdX/wLgzbU3zF/6c1tJGr43SQ1nwJKRy8fqh5ldrUIi/yCQA/knhH1qTwMzm3nOdJ
 kcRPTbyAZ+LcsMJ/P5/A0nnSns0wRm/+Ne5ymA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 sound/arm/Kconfig              |   2 +-
 sound/core/Kconfig             |  28 +++++-----
 sound/firewire/Kconfig         | 122 ++++++++++++++++++++---------------------
 sound/hda/Kconfig              |   4 +-
 sound/isa/Kconfig              |  27 +++++----
 sound/mips/Kconfig             |  15 +++--
 sound/parisc/Kconfig           |   2 +-
 sound/pci/Kconfig              |   4 +-
 sound/pcmcia/Kconfig           |   3 +-
 sound/ppc/Kconfig              |   2 +-
 sound/sh/Kconfig               |   3 +-
 sound/soc/Kconfig              |   5 +-
 sound/soc/amd/Kconfig          |   8 +--
 sound/soc/cirrus/Kconfig       |  14 ++---
 sound/soc/codecs/Kconfig       |  60 ++++++++++----------
 sound/soc/dwc/Kconfig          |  15 +++--
 sound/soc/fsl/Kconfig          |   8 +--
 sound/soc/generic/Kconfig      |   2 +-
 sound/soc/intel/Kconfig        |   2 +-
 sound/soc/intel/boards/Kconfig |  82 +++++++++++++--------------
 sound/soc/jz4740/Kconfig       |   2 +-
 sound/soc/mxs/Kconfig          |   3 +-
 sound/soc/pxa/Kconfig          |  29 +++++-----
 sound/soc/samsung/Kconfig      |   8 +--
 sound/soc/zte/Kconfig          |  12 ++--
 sound/sparc/Kconfig            |   2 +-
 sound/spi/Kconfig              |   3 +-
 sound/usb/Kconfig              |  47 ++++++++--------
 sound/x86/Kconfig              |   4 +-
 29 files changed, 254 insertions(+), 264 deletions(-)

diff --git a/sound/arm/Kconfig b/sound/arm/Kconfig
index 2886773..6bc3428 100644
--- a/sound/arm/Kconfig
+++ b/sound/arm/Kconfig
@@ -27,7 +27,7 @@ config SND_PXA2XX_AC97
 	  Say Y or M if you want to support any AC97 codec attached to
 	  the PXA2xx AC97 interface.
 
-endif	# SND_ARM
+endif # SND_ARM
 
 config SND_PXA2XX_LIB
 	tristate
diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index 63b3ef9..1b28ecb 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -71,11 +71,11 @@ config SND_PCM_OSS
 config SND_PCM_OSS_PLUGINS
 	bool "OSS PCM (digital audio) API - Include plugin system"
 	depends on SND_PCM_OSS
-        default y
+	default y
 	help
-          If you disable this option, the ALSA's OSS PCM API will not
-          support conversion of channels, formats and rates. It will
-          behave like most of new OSS/Free drivers in 2.4/2.6 kernels.
+	  If you disable this option, the ALSA's OSS PCM API will not
+	  support conversion of channels, formats and rates. It will
+	  behave like most of new OSS/Free drivers in 2.4/2.6 kernels.
 
 config SND_PCM_TIMER
 	bool "PCM timer interface" if EXPERT
@@ -127,13 +127,13 @@ config SND_SUPPORT_OLD_API
 	  or older).
 
 config SND_PROC_FS
-        bool "Sound Proc FS Support" if EXPERT
-        depends on PROC_FS
-        default y
-        help
-          Say 'N' to disable Sound proc FS, which may reduce code size about
-          9KB on x86_64 platform.
-          If unsure say Y.
+	bool "Sound Proc FS Support" if EXPERT
+	depends on PROC_FS
+	default y
+	help
+	  Say 'N' to disable Sound proc FS, which may reduce code size about
+	  9KB on x86_64 platform.
+	  If unsure say Y.
 
 config SND_VERBOSE_PROCFS
 	bool "Verbose procfs contents"
@@ -141,8 +141,8 @@ config SND_VERBOSE_PROCFS
 	default y
 	help
 	  Say Y here to include code for verbose procfs contents (provides
-          useful information to developers when a problem occurs).  On the
-          other side, it makes the ALSA subsystem larger.
+	  useful information to developers when a problem occurs).  On the
+	  other side, it makes the ALSA subsystem larger.
 
 config SND_VERBOSE_PRINTK
 	bool "Verbose printk"
@@ -163,7 +163,7 @@ config SND_DEBUG_VERBOSE
 	depends on SND_DEBUG
 	help
 	  Say Y here to enable extra-verbose debugging messages.
-	  
+
 	  Let me repeat: it enables EXTRA-VERBOSE DEBUGGING messages.
 	  So, say Y only if you are ready to be annoyed.
 
diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index b9e96d0..8575e0e 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -76,93 +76,93 @@ config SND_BEBOB
 	tristate "BridgeCo DM1000/DM1100/DM1500 with BeBoB firmware"
 	select SND_FIREWIRE_LIB
 	select SND_HWDEP
-        help
-	 Say Y here to include support for FireWire devices based
-	 on BridgeCo DM1000/DM1100/DM1500 with BeBoB firmware:
-	  * Edirol FA-66/FA-101
-	  * PreSonus FIREBOX/FIREPOD/FP10/Inspire1394
-	  * BridgeCo RDAudio1/Audio5
-	  * Mackie Onyx 1220/1620/1640 (FireWire I/O Card)
-	  * Mackie d.2 (FireWire Option)
-	  * Stanton FinalScratch 2 (ScratchAmp)
-	  * Tascam IF-FW/DM
-	  * Behringer XENIX UFX 1204/1604
-	  * Behringer Digital Mixer X32 series (X-UF Card)
-	  * Behringer FCA610/1616
-	  * Apogee Rosetta 200/400 (X-FireWire card)
-	  * Apogee DA/AD/DD-16X (X-FireWire card)
-	  * Apogee Ensemble
-	  * ESI QuataFire 610
-	  * AcousticReality eARMasterOne
-	  * CME MatrixKFW
-	  * Phonic Helix Board 12 MkII/18 MkII/24 MkII
-	  * Phonic Helix Board 12 Universal/18 Universal/24 Universal
-	  * Lynx Aurora 8/16 (LT-FW)
-	  * ICON FireXon
-	  * PrismSound Orpheus/ADA-8XR
-	  * TerraTec PHASE 24 FW/PHASE X24 FW/PHASE 88 Rack FW
-	  * TerraTec EWS MIC2/EWS MIC8
-	  * TerraTec Aureon 7.1 FireWire
-	  * Yamaha GO44/GO46
-	  * Focusrite Saffire/Saffire LE/SaffirePro10 IO/SaffirePro26 IO
-	  * M-Audio FireWire410/AudioPhile/Solo
-	  * M-Audio Ozonic/NRV10/ProfireLightBridge
-	  * M-Audio FireWire 1814/ProjectMix IO
-	  * Digidesign Mbox 2 Pro
-
-          To compile this driver as a module, choose M here: the module
-          will be called snd-bebob.
+	help
+	  Say Y here to include support for FireWire devices based
+	  on BridgeCo DM1000/DM1100/DM1500 with BeBoB firmware:
+	   * Edirol FA-66/FA-101
+	   * PreSonus FIREBOX/FIREPOD/FP10/Inspire1394
+	   * BridgeCo RDAudio1/Audio5
+	   * Mackie Onyx 1220/1620/1640 (FireWire I/O Card)
+	   * Mackie d.2 (FireWire Option)
+	   * Stanton FinalScratch 2 (ScratchAmp)
+	   * Tascam IF-FW/DM
+	   * Behringer XENIX UFX 1204/1604
+	   * Behringer Digital Mixer X32 series (X-UF Card)
+	   * Behringer FCA610/1616
+	   * Apogee Rosetta 200/400 (X-FireWire card)
+	   * Apogee DA/AD/DD-16X (X-FireWire card)
+	   * Apogee Ensemble
+	   * ESI QuataFire 610
+	   * AcousticReality eARMasterOne
+	   * CME MatrixKFW
+	   * Phonic Helix Board 12 MkII/18 MkII/24 MkII
+	   * Phonic Helix Board 12 Universal/18 Universal/24 Universal
+	   * Lynx Aurora 8/16 (LT-FW)
+	   * ICON FireXon
+	   * PrismSound Orpheus/ADA-8XR
+	   * TerraTec PHASE 24 FW/PHASE X24 FW/PHASE 88 Rack FW
+	   * TerraTec EWS MIC2/EWS MIC8
+	   * TerraTec Aureon 7.1 FireWire
+	   * Yamaha GO44/GO46
+	   * Focusrite Saffire/Saffire LE/SaffirePro10 IO/SaffirePro26 IO
+	   * M-Audio FireWire410/AudioPhile/Solo
+	   * M-Audio Ozonic/NRV10/ProfireLightBridge
+	   * M-Audio FireWire 1814/ProjectMix IO
+	   * Digidesign Mbox 2 Pro
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-bebob.
 
 config SND_FIREWIRE_DIGI00X
 	tristate "Digidesign Digi 002/003 family support"
 	select SND_FIREWIRE_LIB
 	select SND_HWDEP
 	help
-	 Say Y here to include support for Digidesign Digi 002/003 family.
-	  * Digi 002 Console
-	  * Digi 002 Rack
-	  * Digi 003 Console
-	  * Digi 003 Rack
-	  * Digi 003 Rack+
+	  Say Y here to include support for Digidesign Digi 002/003 family.
+	   * Digi 002 Console
+	   * Digi 002 Rack
+	   * Digi 003 Console
+	   * Digi 003 Rack
+	   * Digi 003 Rack+
 
-	 To compile this driver as a module, choose M here: the module
-	 will be called snd-firewire-digi00x.
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-firewire-digi00x.
 
 config SND_FIREWIRE_TASCAM
 	tristate "TASCAM FireWire series support"
 	select SND_FIREWIRE_LIB
 	select SND_HWDEP
 	help
-	 Say Y here to include support for TASCAM.
-	  * FW-1884
-	  * FW-1082
-	  * FW-1804
+	  Say Y here to include support for TASCAM.
+	   * FW-1884
+	   * FW-1082
+	   * FW-1804
 
-	 To compile this driver as a module, choose M here: the module
-	 will be called snd-firewire-tascam.
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-firewire-tascam.
 
 config SND_FIREWIRE_MOTU
 	tristate "Mark of the unicorn FireWire series support"
 	select SND_FIREWIRE_LIB
 	select SND_HWDEP
 	help
-	 Say Y here to enable support for FireWire devices which MOTU produced:
-	  * 828mk2
-	  * Traveler
-	  * 828mk3
-	  * Audio Express
+	  Say Y here to enable support for FireWire devices which MOTU produced:
+	   * 828mk2
+	   * Traveler
+	   * 828mk3
+	   * Audio Express
 
-	 To compile this driver as a module, choose M here: the module
-	 will be called snd-firewire-motu.
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-firewire-motu.
 
 config SND_FIREFACE
 	tristate "RME Fireface series support"
 	select SND_FIREWIRE_LIB
 	select SND_HWDEP
 	help
-	 Say Y here to include support for RME fireface series.
-	  * Fireface 400
-	  * Fireface 800
-	  * Fireface UCX
+	  Say Y here to include support for RME fireface series.
+	   * Fireface 400
+	   * Fireface 800
+	   * Fireface UCX
 
 endif # SND_FIREWIRE
diff --git a/sound/hda/Kconfig b/sound/hda/Kconfig
index 2d90e11..003f232 100644
--- a/sound/hda/Kconfig
+++ b/sound/hda/Kconfig
@@ -13,8 +13,8 @@ config SND_HDA_I915
 	select SND_HDA_COMPONENT
 
 config SND_HDA_EXT_CORE
-       tristate
-       select SND_HDA_CORE
+	tristate
+	select SND_HDA_CORE
 
 config SND_HDA_PREALLOC_SIZE
 	int "Pre-allocated buffer size for HD-audio driver"
diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index d7db1ee..5ff4340 100644
--- a/sound/isa/Kconfig
+++ b/sound/isa/Kconfig
@@ -1,22 +1,22 @@
 # ALSA ISA drivers
 
 config SND_WSS_LIB
-        tristate
-        select SND_PCM
+	tristate
+	select SND_PCM
 	select SND_TIMER
 
 config SND_SB_COMMON
-        tristate
+	tristate
 
 config SND_SB8_DSP
-        tristate
-        select SND_PCM
-        select SND_SB_COMMON
+	tristate
+	select SND_PCM
+	select SND_SB_COMMON
 
 config SND_SB16_DSP
-        tristate
-        select SND_PCM
-        select SND_SB_COMMON
+	tristate
+	select SND_PCM
+	select SND_SB_COMMON
 
 menuconfig SND_ISA
 	bool "ISA sound devices"
@@ -58,7 +58,7 @@ config SND_AD1848
 	help
 	  Say Y here to include support for AD1848 (Analog Devices) or
 	  CS4248 (Cirrus Logic - Crystal Semiconductors) chips.
-	  
+
 	  For newer chips from Cirrus Logic, use the CS4231 or CS4232+
 	  drivers.
 
@@ -343,7 +343,7 @@ config SND_MIRO
 	select SND_MPU401_UART
 	select SND_PCM
 	help
-	  Say 'Y' or 'M' to include support for Miro miroSOUND PCM1 pro, 
+	  Say 'Y' or 'M' to include support for Miro miroSOUND PCM1 pro,
 	  miroSOUND PCM12 and miroSOUND PCM20 Radio soundcards.
 
 	  To compile this driver as a module, choose M here: the module
@@ -408,7 +408,7 @@ config SND_SSCAPE
 	select SND_WSS_LIB
 	select FW_LOADER
 	help
-	  Say Y here to include support for Ensoniq SoundScape 
+	  Say Y here to include support for Ensoniq SoundScape
 	  and Ensoniq OEM soundcards.
 
 	  The PCM audio is supported on SoundScape Classic, Elite, PnP
@@ -467,5 +467,4 @@ config SND_MSND_CLASSIC
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-msnd-classic.
 
-endif	# SND_ISA
-
+endif # SND_ISA
diff --git a/sound/mips/Kconfig b/sound/mips/Kconfig
index 4a47050..162752f 100644
--- a/sound/mips/Kconfig
+++ b/sound/mips/Kconfig
@@ -13,15 +13,14 @@ config SND_SGI_O2
 	tristate "SGI O2 Audio"
 	depends on SGI_IP32
 	select SND_PCM
-        help
-                Sound support for the SGI O2 Workstation. 
+	help
+	  Sound support for the SGI O2 Workstation.
 
 config SND_SGI_HAL2
-        tristate "SGI HAL2 Audio"
-        depends on SGI_HAS_HAL2
+	tristate "SGI HAL2 Audio"
+	depends on SGI_HAS_HAL2
 	select SND_PCM
-        help
-                Sound support for the SGI Indy and Indigo2 Workstation.
-
-endif	# SND_MIPS
+	help
+	  Sound support for the SGI Indy and Indigo2 Workstation.
 
+endif # SND_MIPS
diff --git a/sound/parisc/Kconfig b/sound/parisc/Kconfig
index 9b61d95..a027171 100644
--- a/sound/parisc/Kconfig
+++ b/sound/parisc/Kconfig
@@ -17,4 +17,4 @@ config SND_HARMONY
 	  chip found in most GSC-based PA-RISC workstations.  It's frequently
 	  provided as part of the Lasi multi-function IC.
 
-endif	# SND_GSC
+endif # SND_GSC
diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index 4105d9f..834d508 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -216,7 +216,7 @@ config SND_CMIPCI
 	  will be called snd-cmipci.
 
 config SND_OXYGEN_LIB
-        tristate
+	tristate
 
 config SND_OXYGEN
 	tristate "C-Media 8786, 8787, 8788 (Oxygen)"
@@ -907,6 +907,6 @@ config SND_YMFPCI
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-ymfpci.
 
-endif	# SND_PCI
+endif # SND_PCI
 
 source "sound/pci/hda/Kconfig"
diff --git a/sound/pcmcia/Kconfig b/sound/pcmcia/Kconfig
index 7fbb190..e0c656f 100644
--- a/sound/pcmcia/Kconfig
+++ b/sound/pcmcia/Kconfig
@@ -29,5 +29,4 @@ config SND_PDAUDIOCF
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-pdaudiocf.
 
-endif	# SND_PCMCIA
-
+endif # SND_PCMCIA
diff --git a/sound/ppc/Kconfig b/sound/ppc/Kconfig
index 0519c60..1e7cae6 100644
--- a/sound/ppc/Kconfig
+++ b/sound/ppc/Kconfig
@@ -49,4 +49,4 @@ config SND_PS3_DEFAULT_START_DELAY
 	depends on SND_PS3
 	default "2000"
 
-endif	# SND_PPC
+endif # SND_PPC
diff --git a/sound/sh/Kconfig b/sound/sh/Kconfig
index 61139f3..f7997ac 100644
--- a/sound/sh/Kconfig
+++ b/sound/sh/Kconfig
@@ -27,5 +27,4 @@ config SND_SH_DAC_AUDIO
 	help
 	  Say Y here to include support for the on-chip DAC.
 
-endif	# SND_SUPERH
-
+endif # SND_SUPERH
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index aa35940..2fb9bb9 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -13,7 +13,7 @@ menuconfig SND_SOC
 
 	  If you want ASoC support, you should say Y here and also to the
 	  specific driver for your SoC platform below.
-	  
+
 	  ASoC provides power efficient ALSA support for embedded battery powered
 	  SoC based systems like PDA's, Phones and Personal Media Players.
 
@@ -83,5 +83,4 @@ source "sound/soc/codecs/Kconfig"
 # generic frame-work
 source "sound/soc/generic/Kconfig"
 
-endif	# SND_SOC
-
+endif # SND_SOC
diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 33ebec9..0f122b5 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -1,7 +1,7 @@
 config SND_SOC_AMD_ACP
 	tristate "AMD Audio Coprocessor support"
 	help
-	 This option enables ACP DMA support on AMD platform.
+	  This option enables ACP DMA support on AMD platform.
 
 config SND_SOC_AMD_CZ_DA7219MX98357_MACH
 	tristate "AMD CZ support for DA7219 and MAX9835"
@@ -11,17 +11,17 @@ config SND_SOC_AMD_CZ_DA7219MX98357_MACH
 	select REGULATOR
 	depends on SND_SOC_AMD_ACP && I2C
 	help
-	 This option enables machine driver for DA7219 and MAX9835.
+	  This option enables machine driver for DA7219 and MAX9835.
 
 config SND_SOC_AMD_CZ_RT5645_MACH
 	tristate "AMD CZ support for RT5645"
 	select SND_SOC_RT5645
 	depends on SND_SOC_AMD_ACP && I2C
 	help
-	 This option enables machine driver for rt5645.
+	  This option enables machine driver for rt5645.
 
 config SND_SOC_AMD_ACP3x
 	tristate "AMD Audio Coprocessor-v3.x support"
 	depends on X86 && PCI
 	help
-	 This option enables ACP v3.x I2S support on AMD platform
+	  This option enables ACP v3.x I2S support on AMD platform
diff --git a/sound/soc/cirrus/Kconfig b/sound/soc/cirrus/Kconfig
index e091991..d109ff2 100644
--- a/sound/soc/cirrus/Kconfig
+++ b/sound/soc/cirrus/Kconfig
@@ -32,13 +32,13 @@ config SND_EP93XX_SOC_AC97
 	select SND_SOC_AC97_BUS
 
 config SND_EP93XX_SOC_SNAPPERCL15
-        tristate "SoC Audio support for Bluewater Systems Snapper CL15 module"
-        depends on SND_EP93XX_SOC && MACH_SNAPPER_CL15 && I2C
-        select SND_EP93XX_SOC_I2S
-        select SND_SOC_TLV320AIC23_I2C
-        help
-          Say Y or M here if you want to add support for I2S audio on the
-          Bluewater Systems Snapper CL15 module.
+	tristate "SoC Audio support for Bluewater Systems Snapper CL15 module"
+	depends on SND_EP93XX_SOC && MACH_SNAPPER_CL15 && I2C
+	select SND_EP93XX_SOC_I2S
+	select SND_SOC_TLV320AIC23_I2C
+	help
+	  Say Y or M here if you want to add support for I2S audio on the
+	  Bluewater Systems Snapper CL15 module.
 
 config SND_EP93XX_SOC_SIMONE
 	tristate "SoC Audio support for Simplemachines Sim.One board"
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 419114e..ec042b7 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -246,16 +246,16 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM9705 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
 	select SND_SOC_WM9712 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
 	select SND_SOC_WM9713 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
-        help
-          Normally ASoC codec drivers are only built if a machine driver which
-          uses them is also built since they are only usable with a machine
-          driver.  Selecting this option will allow these drivers to be built
-          without an explicit machine driver for test and development purposes.
+	help
+	  Normally ASoC codec drivers are only built if a machine driver which
+	  uses them is also built since they are only usable with a machine
+	  driver.  Selecting this option will allow these drivers to be built
+	  without an explicit machine driver for test and development purposes.
 
 	  Support for the bus types used to access the codecs to be built must
 	  be selected separately.
 
-          If unsure select "N".
+	  If unsure select "N".
 
 config SND_SOC_88PM860X
 	tristate
@@ -439,7 +439,7 @@ config SND_SOC_AK5558
 	select REGMAP_I2C
 
 config SND_SOC_ALC5623
-       tristate "Realtek ALC5623 CODEC"
+	tristate "Realtek ALC5623 CODEC"
 	depends on I2C
 
 config SND_SOC_ALC5632
@@ -557,8 +557,8 @@ config SND_SOC_CS42XX8_I2C
 
 # Cirrus Logic CS43130 HiFi DAC
 config SND_SOC_CS43130
-        tristate "Cirrus Logic CS43130 CODEC"
-        depends on I2C
+	tristate "Cirrus Logic CS43130 CODEC"
+	depends on I2C
 
 config SND_SOC_CS4341
 	tristate "Cirrus Logic CS4341 CODEC"
@@ -606,22 +606,22 @@ config SND_SOC_JZ4725B_CODEC
 	  will be called snd-soc-jz4725b-codec.
 
 config SND_SOC_L3
-       tristate
+	tristate
 
 config SND_SOC_DA7210
-        tristate
+	tristate
 
 config SND_SOC_DA7213
-        tristate
+	tristate
 
 config SND_SOC_DA7218
 	tristate
 
 config SND_SOC_DA7219
-        tristate
+	tristate
 
 config SND_SOC_DA732X
-        tristate
+	tristate
 
 config SND_SOC_DA9055
 	tristate
@@ -640,10 +640,10 @@ config SND_SOC_HDMI_CODEC
 	select HDMI
 
 config SND_SOC_ES7134
-       tristate "Everest Semi ES7134 CODEC"
+	tristate "Everest Semi ES7134 CODEC"
 
 config SND_SOC_ES7241
-       tristate "Everest Semi ES7241 CODEC"
+	tristate "Everest Semi ES7241 CODEC"
 
 config SND_SOC_ES8316
 	tristate "Everest Semi ES8316 CODEC"
@@ -683,7 +683,7 @@ config SND_SOC_INNO_RK3036
 	select REGMAP_MMIO
 
 config SND_SOC_ISABELLE
-        tristate
+	tristate
 
 config SND_SOC_LM49453
 	tristate
@@ -693,16 +693,16 @@ config SND_SOC_MAX98088
 	depends on I2C
 
 config SND_SOC_MAX98090
-       tristate
+	tristate
 
 config SND_SOC_MAX98095
-       tristate
+	tristate
 
 config SND_SOC_MAX98357A
-       tristate
+	tristate
 
 config SND_SOC_MAX98371
-       tristate
+	tristate
 
 config SND_SOC_MAX98504
 	tristate "Maxim MAX98504 speaker amplifier"
@@ -713,7 +713,7 @@ config SND_SOC_MAX9867
 	depends on I2C
 
 config SND_SOC_MAX98925
-       tristate
+	tristate
 
 config SND_SOC_MAX98926
 	tristate
@@ -792,10 +792,10 @@ config SND_SOC_PCM186X_SPI
 	select REGMAP_SPI
 
 config SND_SOC_PCM3008
-       tristate
+	tristate
 
 config SND_SOC_PCM3060
-       tristate
+	tristate
 
 config SND_SOC_PCM3060_I2C
 	tristate "Texas Instruments PCM3060 CODEC - I2C"
@@ -923,7 +923,7 @@ config SND_SOC_RT5640
 	tristate
 
 config SND_SOC_RT5645
-        tristate
+	tristate
 
 config SND_SOC_RT5651
 	tristate
@@ -1141,10 +1141,10 @@ config SND_SOC_TWL6040
 	tristate
 
 config SND_SOC_UDA134X
-       tristate
+	tristate
 
 config SND_SOC_UDA1380
-        tristate
+	tristate
 	depends on I2C
 
 config SND_SOC_WCD9335
@@ -1271,7 +1271,7 @@ config SND_SOC_WM8904
 	depends on I2C
 
 config SND_SOC_WM8940
-        tristate
+	tristate
 
 config SND_SOC_WM8955
 	tristate
@@ -1389,8 +1389,8 @@ config SND_SOC_MT6358
 	  external codec device.
 
 config SND_SOC_NAU8540
-       tristate "Nuvoton Technology Corporation NAU85L40 CODEC"
-       depends on I2C
+	tristate "Nuvoton Technology Corporation NAU85L40 CODEC"
+	depends on I2C
 
 config SND_SOC_NAU8810
 	tristate "Nuvoton Technology Corporation NAU88C10 CODEC"
diff --git a/sound/soc/dwc/Kconfig b/sound/soc/dwc/Kconfig
index aa0c6ec..a2563dd 100644
--- a/sound/soc/dwc/Kconfig
+++ b/sound/soc/dwc/Kconfig
@@ -3,17 +3,16 @@ config SND_DESIGNWARE_I2S
 	depends on CLKDEV_LOOKUP
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
-	 Say Y or M if you want to add support for I2S driver for
-	 Synopsys designware I2S device. The device supports up to
-	 a maximum of 8 channels each for play and record.
+	  Say Y or M if you want to add support for I2S driver for
+	  Synopsys designware I2S device. The device supports up to
+	  a maximum of 8 channels each for play and record.
 
 config SND_DESIGNWARE_PCM
 	bool "PCM PIO extension for I2S driver"
 	depends on SND_DESIGNWARE_I2S
 	help
-	 Say Y or N if you want to add a custom ALSA extension that registers
-	 a PCM and uses PIO to transfer data.
-
-	 This functionality is specially suited for I2S devices that don't have
-	 DMA support.
+	  Say Y or N if you want to add a custom ALSA extension that registers
+	  a PCM and uses PIO to transfer data.
 
+	  This functionality is specially suited for I2S devices that don't have
+	  DMA support.
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 7b1d997..b81e535 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -291,10 +291,10 @@ config SND_SOC_FSL_ASOC_CARD
 	select SND_SOC_FSL_SAI
 	select SND_SOC_FSL_SSI
 	help
-	 ALSA SoC Audio support with ASRC feature for Freescale SoCs that have
-	 ESAI/SAI/SSI and connect with external CODECs such as WM8962, CS42888,
-	 CS4271, CS4272 and SGTL5000.
-	 Say Y if you want to add support for Freescale Generic ASoC Sound Card.
+	  ALSA SoC Audio support with ASRC feature for Freescale SoCs that have
+	  ESAI/SAI/SSI and connect with external CODECs such as WM8962, CS42888,
+	  CS4271, CS4272 and SGTL5000.
+	  Say Y if you want to add support for Freescale Generic ASoC Sound Card.
 
 endif # SND_IMX_SOC
 
diff --git a/sound/soc/generic/Kconfig b/sound/soc/generic/Kconfig
index 83f1243..d520d11 100644
--- a/sound/soc/generic/Kconfig
+++ b/sound/soc/generic/Kconfig
@@ -1,5 +1,5 @@
 config SND_SIMPLE_CARD_UTILS
-       tristate
+	tristate
 
 config SND_SIMPLE_CARD
 	tristate "ASoC Simple sound card support"
diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index bd9fd20..6dbf727 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -111,7 +111,7 @@ config SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_INTEL_CNL
 	select SND_SOC_INTEL_CFL
 	help
-          This is a backwards-compatible option to select all devices
+	  This is a backwards-compatible option to select all devices
 	  supported by the Intel SST/Skylake driver. This option is no
 	  longer recommended and will be deprecated when the SOF
 	  driver is introduced.  Distributions should explicitly
diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 12d6b73..92425c7 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -2,13 +2,13 @@ menuconfig SND_SOC_INTEL_MACH
 	bool "Intel Machine drivers"
 	depends on SND_SOC_INTEL_SST_TOPLEVEL
 	help
-         Intel ASoC Machine Drivers. If you have a Intel machine that
-         has an audio controller with a DSP and I2S or DMIC port, then
-         enable this option by saying Y
+	  Intel ASoC Machine Drivers. If you have a Intel machine that
+	  has an audio controller with a DSP and I2S or DMIC port, then
+	  enable this option by saying Y
 
-         Note that the answer to this question doesn't directly affect the
-         kernel: saying N will just cause the configurator to skip all
-         the questions about Intel ASoC machine drivers.
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about Intel ASoC machine drivers.
 
 if SND_SOC_INTEL_MACH
 
@@ -97,11 +97,11 @@ config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_ACPI
 	select SND_SOC_RT5670
-        help
-          This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
-          platforms with RT5672 audio codec.
-          Say Y or m if you have such a device. This is a recommended option.
-          If unsure select "N".
+	help
+	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
+	  platforms with RT5672 audio codec.
+	  Say Y or m if you have such a device. This is a recommended option.
+	  If unsure select "N".
 
 config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 	tristate "Cherrytrail & Braswell with RT5645/5650 codec"
@@ -181,10 +181,10 @@ config SND_SOC_INTEL_SKL_RT286_MACH
 	select SND_SOC_DMIC
 	select SND_SOC_HDAC_HDMI
 	help
-	   This adds support for ASoC machine driver for Skylake platforms
-	   with RT286 I2S audio codec.
-	   Say Y or m if you have such a device.
-	   If unsure select "N".
+	  This adds support for ASoC machine driver for Skylake platforms
+	  with RT286 I2S audio codec.
+	  Say Y or m if you have such a device.
+	  If unsure select "N".
 
 config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
 	tristate "SKL with NAU88L25 and SSM4567 in I2S Mode"
@@ -225,10 +225,10 @@ config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
 	select SND_SOC_HDAC_HDMI
 	select SND_HDA_DSP_LOADER
 	help
-	   This adds support for ASoC machine driver for Broxton-P platforms
-	   with DA7219 + MAX98357A I2S audio codec.
-	   Say Y or m if you have such a device. This is a recommended option.
-	   If unsure select "N".
+	  This adds support for ASoC machine driver for Broxton-P platforms
+	  with DA7219 + MAX98357A I2S audio codec.
+	  Say Y or m if you have such a device. This is a recommended option.
+	  If unsure select "N".
 
 config SND_SOC_INTEL_BXT_RT298_MACH
 	tristate "Broxton with RT298 I2S mode"
@@ -238,10 +238,10 @@ config SND_SOC_INTEL_BXT_RT298_MACH
 	select SND_SOC_HDAC_HDMI
 	select SND_HDA_DSP_LOADER
 	help
-	   This adds support for ASoC machine driver for Broxton platforms
-	   with RT286 I2S audio codec.
-	   Say Y or m if you have such a device. This is a recommended option.
-	   If unsure select "N".
+	  This adds support for ASoC machine driver for Broxton platforms
+	  with RT286 I2S audio codec.
+	  Say Y or m if you have such a device. This is a recommended option.
+	  If unsure select "N".
 
 endif ## SND_SOC_INTEL_APL
 
@@ -262,19 +262,19 @@ config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
 	  If unsure select "N".
 
 config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
-        tristate "KBL with RT5663, RT5514 and MAX98927 in I2S Mode"
-        depends on MFD_INTEL_LPSS && I2C && ACPI
-        depends on SPI
-        select SND_SOC_RT5663
-        select SND_SOC_RT5514
-        select SND_SOC_RT5514_SPI
-        select SND_SOC_MAX98927
-        select SND_SOC_HDAC_HDMI
-        help
-          This adds support for ASoC Onboard Codec I2S machine driver. This will
-          create an alsa sound card for RT5663 + RT5514 + MAX98927.
-          Say Y or m if you have such a device. This is a recommended option.
-          If unsure select "N".
+	tristate "KBL with RT5663, RT5514 and MAX98927 in I2S Mode"
+	depends on MFD_INTEL_LPSS && I2C && ACPI
+	depends on SPI
+	select SND_SOC_RT5663
+	select SND_SOC_RT5514
+	select SND_SOC_RT5514_SPI
+	select SND_SOC_MAX98927
+	select SND_SOC_HDAC_HDMI
+	help
+	  This adds support for ASoC Onboard Codec I2S machine driver. This will
+	  create an alsa sound card for RT5663 + RT5514 + MAX98927.
+	  Say Y or m if you have such a device. This is a recommended option.
+	  If unsure select "N".
 
 config SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH
 	tristate "KBL with DA7219 and MAX98357A in I2S Mode"
@@ -325,10 +325,10 @@ config SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH
 	select SND_SOC_HDAC_HDMI
 	select SND_HDA_DSP_LOADER
 	help
-	   This adds support for ASoC machine driver for Geminilake platforms
-	   with RT5682 + MAX98357A I2S audio codec.
-	   Say Y if you have such a device.
-	   If unsure select "N".
+	  This adds support for ASoC machine driver for Geminilake platforms
+	  with RT5682 + MAX98357A I2S audio codec.
+	  Say Y if you have such a device.
+	  If unsure select "N".
 
 endif ## SND_SOC_INTEL_GLK
 
@@ -341,7 +341,7 @@ config SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH
 	help
 	  This adds support for ASoC machine driver for Intel platforms
 	  SKL/KBL/BXT/APL with iDisp, HDA audio codecs.
-          Say Y or m if you have such a device. This is a recommended option.
+	  Say Y or m if you have such a device. This is a recommended option.
 	  If unsure select "N".
 
 endif ## SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC
diff --git a/sound/soc/jz4740/Kconfig b/sound/soc/jz4740/Kconfig
index 1a354a6..04eb671 100644
--- a/sound/soc/jz4740/Kconfig
+++ b/sound/soc/jz4740/Kconfig
@@ -21,7 +21,7 @@ config SND_JZ4740_SOC_QI_LB60
 	depends on HAS_IOMEM
 	depends on JZ4740_QI_LB60 || COMPILE_TEST
 	select SND_JZ4740_SOC_I2S
-    select SND_SOC_JZ4740_CODEC
+	select SND_SOC_JZ4740_CODEC
 	help
 	  Say Y if you want to add support for ASoC audio on the Qi LB60 board
 	  a.k.a Qi Ben NanoNote.
diff --git a/sound/soc/mxs/Kconfig b/sound/soc/mxs/Kconfig
index 219235c..8b4c14d 100644
--- a/sound/soc/mxs/Kconfig
+++ b/sound/soc/mxs/Kconfig
@@ -7,7 +7,6 @@ menuconfig SND_MXS_SOC
 	  Say Y or M if you want to add support for codecs attached to
 	  the MXS SAIF interface.
 
-
 if SND_MXS_SOC
 
 config SND_SOC_MXS_SGTL5000
@@ -18,4 +17,4 @@ config SND_SOC_MXS_SGTL5000
 	  Say Y if you want to add support for SoC audio on an MXS board with
 	  a sgtl5000 codec.
 
-endif	# SND_MXS_SOC
+endif # SND_MXS_SOC
diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 67159a6..2f78094e 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -157,7 +157,6 @@ config SND_SOC_TTC_DKB
 	help
 	  Say Y if you want to add support for SoC audio on TTC DKB
 
-
 config SND_SOC_ZYLONITE
 	tristate "SoC Audio support for Marvell Zylonite"
 	depends on SND_PXA2XX_SOC && MACH_ZYLONITE
@@ -189,23 +188,23 @@ config SND_PXA2XX_SOC_MAGICIAN
 	  HTC Magician.
 
 config SND_PXA2XX_SOC_MIOA701
-        tristate "SoC Audio support for MIO A701"
-        depends on SND_PXA2XX_SOC && MACH_MIOA701
+	tristate "SoC Audio support for MIO A701"
+	depends on SND_PXA2XX_SOC && MACH_MIOA701
 	depends on AC97_BUS=n
-        select SND_PXA2XX_SOC_AC97
-        select SND_SOC_WM9713
-        help
-          Say Y if you want to add support for SoC audio on the
-          MIO A701.
+	select SND_PXA2XX_SOC_AC97
+	select SND_SOC_WM9713
+	help
+	  Say Y if you want to add support for SoC audio on the
+	  MIO A701.
 
 config SND_PXA2XX_SOC_IMOTE2
-       tristate "SoC Audio support for IMote 2"
-       depends on SND_PXA2XX_SOC && MACH_INTELMOTE2 && I2C
-       select SND_PXA2XX_SOC_I2S
-       select SND_SOC_WM8940
-       help
-         Say Y if you want to add support for SoC audio on the
-	 IMote 2.
+	tristate "SoC Audio support for IMote 2"
+	depends on SND_PXA2XX_SOC && MACH_INTELMOTE2 && I2C
+	select SND_PXA2XX_SOC_I2S
+	select SND_SOC_WM8940
+	help
+	  Say Y if you want to add support for SoC audio on the
+	  IMote 2.
 
 config SND_MMP_SOC_BROWNSTONE
 	tristate "SoC Audio support for Marvell Brownstone"
diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 0520f5a..3739841 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -194,10 +194,10 @@ config SND_SOC_ODROID
 	  Say Y here to enable audio support for the Odroid XU3/XU4.
 
 config SND_SOC_ARNDALE_RT5631_ALC5631
-        tristate "Audio support for RT5631(ALC5631) on Arndale Board"
-        depends on I2C
-        select SND_SAMSUNG_I2S
-        select SND_SOC_RT5631
+	tristate "Audio support for RT5631(ALC5631) on Arndale Board"
+	depends on I2C
+	select SND_SAMSUNG_I2S
+	select SND_SOC_RT5631
 
 config SND_SOC_SAMSUNG_TM2_WM5110
 	tristate "SoC I2S Audio support for WM5110 on TM2 board"
diff --git a/sound/soc/zte/Kconfig b/sound/soc/zte/Kconfig
index 75f67a5..4afdc84 100644
--- a/sound/soc/zte/Kconfig
+++ b/sound/soc/zte/Kconfig
@@ -17,9 +17,9 @@ config ZX_I2S
 	  ZTE ZX I2S interface
 
 config ZX_TDM
-        tristate "ZTE ZX TDM Driver Support"
-        depends on COMMON_CLK
-        select SND_SOC_GENERIC_DMAENGINE_PCM
-        help
-          Say Y or M if you want to add support for codecs attached to the
-          ZTE ZX TDM interface
+	tristate "ZTE ZX TDM Driver Support"
+	depends on COMMON_CLK
+	select SND_SOC_GENERIC_DMAENGINE_PCM
+	help
+	  Say Y or M if you want to add support for codecs attached to the
+	  ZTE ZX TDM interface
diff --git a/sound/sparc/Kconfig b/sound/sparc/Kconfig
index dfcd386..df00bd0 100644
--- a/sound/sparc/Kconfig
+++ b/sound/sparc/Kconfig
@@ -39,4 +39,4 @@ config SND_SUN_DBRI
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-sun-dbri.
 
-endif	# SND_SPARC
+endif # SND_SPARC
diff --git a/sound/spi/Kconfig b/sound/spi/Kconfig
index e6485be..5659b45 100644
--- a/sound/spi/Kconfig
+++ b/sound/spi/Kconfig
@@ -34,5 +34,4 @@ config SND_AT73C213_TARGET_BITRATE
 
 	  Set to 48000 Hz by default.
 
-endif	# SND_SPI
-
+endif # SND_SPI
diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index f61b566..5ed4360 100644
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -52,8 +52,8 @@ config SND_USB_CAIAQ
 	select SND_RAWMIDI
 	select SND_PCM
 	help
-	   Say Y here to include support for caiaq USB audio interfaces,
-	   namely:
+	  Say Y here to include support for caiaq USB audio interfaces,
+	  namely:
 
 	    * Native Instruments RigKontrol2
 	    * Native Instruments RigKontrol3
@@ -70,16 +70,16 @@ config SND_USB_CAIAQ
 	    * Native Instruments Traktor Kontrol S4
 	    * Native Instruments Maschine Controller
 
-	   To compile this driver as a module, choose M here: the module
-	   will be called snd-usb-caiaq.
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-usb-caiaq.
 
 config SND_USB_CAIAQ_INPUT
 	bool "enable input device for controllers"
 	depends on SND_USB_CAIAQ
 	depends on INPUT=y || INPUT=SND_USB_CAIAQ
 	help
-	  Say Y here to support input controllers like buttons, knobs,
-	  alpha dials and analog pedals on the following products:
+	 Say Y here to support input controllers like buttons, knobs,
+	 alpha dials and analog pedals on the following products:
 
 	   * Native Instruments RigKontrol2
 	   * Native Instruments RigKontrol3
@@ -102,24 +102,24 @@ config SND_USB_US122L
 	  will be called snd-usb-us122l.
 
 config SND_USB_6FIRE
-        tristate "TerraTec DMX 6Fire USB"
-        select FW_LOADER
-        select BITREVERSE
-        select SND_RAWMIDI
-        select SND_PCM
-        select SND_VMASTER
-        help
-          Say Y here to include support for TerraTec 6fire DMX USB interface.
-
-          You will need firmware files in order to be able to use the device
-          after it has been coldstarted. An install script for the firmware
-          and further help can be found at
-          http://sixfireusb.sourceforge.net
+	tristate "TerraTec DMX 6Fire USB"
+	select FW_LOADER
+	select BITREVERSE
+	select SND_RAWMIDI
+	select SND_PCM
+	select SND_VMASTER
+	help
+	  Say Y here to include support for TerraTec 6fire DMX USB interface.
+
+	  You will need firmware files in order to be able to use the device
+	  after it has been coldstarted. An install script for the firmware
+	  and further help can be found at
+	  http://sixfireusb.sourceforge.net
 
 config SND_USB_HIFACE
-        tristate "M2Tech hiFace USB-SPDIF driver"
-        select SND_PCM
-        help
+	tristate "M2Tech hiFace USB-SPDIF driver"
+	select SND_PCM
+	help
 	  Select this option to include support for M2Tech hiFace USB-SPDIF
 	  interface.
 
@@ -162,5 +162,4 @@ config SND_BCD2000
 
 source "sound/usb/line6/Kconfig"
 
-endif	# SND_USB
-
+endif # SND_USB
diff --git a/sound/x86/Kconfig b/sound/x86/Kconfig
index 8adf4d1..fb7e1aa 100644
--- a/sound/x86/Kconfig
+++ b/sound/x86/Kconfig
@@ -12,6 +12,6 @@ config HDMI_LPE_AUDIO
 	depends on DRM_I915
 	select SND_PCM
 	help
-	 Choose this option to support HDMI LPE Audio mode
+	  Choose this option to support HDMI LPE Audio mode
 
-endif	# SND_X86
+endif # SND_X86
-- 
1.9.1

