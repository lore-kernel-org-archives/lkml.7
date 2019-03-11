Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999E9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744BE206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfCKNoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:44:02 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:44921 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfCKNoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:44:01 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MfZ9C-1gauDF2Rc8-00g04j; Mon, 11 Mar 2019 14:43:09 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     perex@perex.cz, tiwai@suse.com
Subject: [PATCH] sound: drivers: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:43:07 +0100
Message-Id: <1552311787-19307-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:lnMdlG615AqPP6WbkgNURHKOy9O1Bzqr4pNKNtH8B4LM4LsWIPG
 py5fiqv1FLiLrqyhLspGMZ3f7znVCK79RDTze30CKK1hWtJKPG0efiEYHHjjmqsC0K80bhT
 fTUVQsp6sR0sKqGHVtoPpFKXJJtw/gG+M4e1SoLOzZAR9jG3AP5SifDj3Roup5a9Sfz/yp/
 edVWvRKJjpPqyBlm3fCoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PrmK+Ckx3N4=:P0f4DLHKy+wcGIJ7Z9Lyih
 /zLmlTTS4z8PxfkChUfd6xXzYr2DxHmA/qeOAmejH74mzTO2bB0HNSg5leJxReDnrMV435cxa
 VhA3HOQ9hkSgal2EAKuFEGytlz+zL0RvGkUXzAW5pLJPRSKAi4K0UrpXLxg0JYYl8060f2zUS
 RRf61mmmRlT6986xYD9Im0UdMLAFnHK7+HhHIMMFdghjPaxwIVJoHZ72Vg2R5TJpyung8nBdC
 6xi0Qd1P4vRDrHZtGaY7Rc2AYccVPKWCTmRgZm/LgxuaKYn7zozfzhZhqxXxt7gl7V6Sy19Za
 YD3ksRpL6JNb0py7aTmSnJcLPJClqf4a1DVas+WE2QGSjUx5JgwJqUpTvt9e9X6VRUjKUeMEv
 i7Xv8hjyBAI6jPsZd3oOZ1/HPXt0t4os6a+zSzHFfEUeqvnOZRQK0ifMq3M680nnqaEdeA//D
 e/NftrmWcHvaPUxj+ZxMDFBUnnqck+r65LmblnKKlMjEOjGuzs4uvkZ0Hkpx4wczQTpshaOgr
 i1IdEMnO6Io8WwZC9Vdqg6KeCTDlyRkolEm3fq9dZ/vLh4N5a0YO9KnUtqV+jPUBIcQrRMCWD
 /YrQdjR6Zugx1bHVFPd7lNw3AKfJVPzhMkff1fIIsrYll+255a0LFKAM/0H2xkciY/BBVJpYO
 IUeWd7szSZsuDBtg8bGUPUFf9OuBNIGNjRMoWyYixmbUi7eTAsKDdeGYRt8Gwi9/0BXMEoelC
 2hX3DwA8buoY0h++u48hctfm6xAcvEIKrG4Clw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 sound/drivers/Kconfig | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/drivers/Kconfig b/sound/drivers/Kconfig
index 648a12d..77618ed 100644
--- a/sound/drivers/Kconfig
+++ b/sound/drivers/Kconfig
@@ -1,6 +1,6 @@
 config SND_MPU401_UART
-        tristate
-        select SND_RAWMIDI
+	tristate
+	select SND_RAWMIDI
 
 config SND_OPL3_LIB
 	tristate
@@ -42,7 +42,7 @@ menuconfig SND_DRIVERS
 	default y
 	help
 	  Support for generic sound devices.
-  
+
 if SND_DRIVERS
 
 config SND_PCSP
@@ -89,16 +89,16 @@ config SND_DUMMY
 	  will be called snd-dummy.
 
 config SND_ALOOP
-        tristate "Generic loopback driver (PCM)"
-        select SND_PCM
-        help
-          Say 'Y' or 'M' to include support for the PCM loopback device.
+	tristate "Generic loopback driver (PCM)"
+	select SND_PCM
+	help
+	  Say 'Y' or 'M' to include support for the PCM loopback device.
 	  This module returns played samples back to the user space using
 	  the standard ALSA PCM device. The devices are routed 0->1 and
           1->0, where first number is the playback PCM device and second
 	  number is the capture device. Module creates two PCM devices and
 	  configured number of substreams (see the pcm_substreams module
-          parameter).
+	  parameter).
 
 	  The loopback device allows time sychronization with an external
 	  timing source using the time shift universal control (+-20%
@@ -140,13 +140,13 @@ config SND_MTS64
 	depends on PARPORT
 	select SND_RAWMIDI
 	help
-	  The ESI Miditerminal 4140 is a 4 In 4 Out MIDI Interface with 
-          additional SMPTE Timecode capabilities for the parallel port.
+	  The ESI Miditerminal 4140 is a 4 In 4 Out MIDI Interface with
+	  additional SMPTE Timecode capabilities for the parallel port.
 
 	  Say 'Y' to include support for this device.
 
-	  To compile this driver as a module, chose 'M' here: the module 
-          will be called snd-mts64.
+	  To compile this driver as a module, chose 'M' here: the module
+	  will be called snd-mts64.
 
 config SND_SERIAL_U16550
 	tristate "UART16550 serial MIDI driver"
@@ -235,4 +235,4 @@ config SND_AC97_POWER_SAVE_DEFAULT
 
 	  See SND_AC97_POWER_SAVE for more details.
 
-endif	# SND_DRIVERS
+endif # SND_DRIVERS
-- 
1.9.1

