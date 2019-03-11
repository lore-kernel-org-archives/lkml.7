Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177E2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA55F2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfCKN3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:29:05 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:34267 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbfCKNTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:33 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MXH3Y-1hYc051ylq-00YiVp for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:31 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 029/114] sound: drivers: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:41 +0100
Message-Id: <1552310346-7629-30-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:VN+2+fHRA50us7Inz9TvRsUmNXHtp9x5xf3YE43SSLNNt20gWBb
 N3apSDV7zEmnG4KVe+o3vSU7oz5hxdIa+1o5o/GljLbbUY+8iiqESqPnOASO4xIvP+COgZP
 xfaQCWo2bH6DJir9EfhMcpClXJCFQ0p25I+O4PPaEndSZxnyswxk/tAbzNrpOuQ0SdDN5MN
 BrBJOcfpO138/sJzh5edA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iFd7BTxpfLo=:6YogadVHsnChPitq8rn7NN
 M5YVxlbhOyCaZBQaauvZww+xRpuCSJaO6HR3TShthRFRR+aHO78xtZ1SlKudYNH7vPnwVWJoZ
 5qKMst33X3PZsHdU9+8t3UzpNYlU6NdqokUSRysInrN5TYyo3BpgHe6JMfoxXe2GPEnXq/1P1
 wHl1MVqi/eL5NtI/6pu9CHywKHZKjBOPKmHVBTssE+x6ihvPqqKWnZJjgXktIfmc8If4X092u
 bvbkojog9qMdITiXbO+/aYRYZPYy8cpA6I+qDTQp463cQ5xnX4Jnspcx9zVKKhGf5s0/dwN6P
 7zpuj+GFdLr/XXRgBolqWxZdxrNpcYyJsvgrNuJxHy3CkQtEI4A8bo4p25FtendJhKEqQu2UY
 3n+93mFSoeIRnv5O/rm17TatVuNKIWEv4+Pr80ENOTO+hIXX+Ei/weOT6YlGrb3nL+tsZ2z3F
 TRGlKReSpfcyKDQsWQCzLIki5V0nzvTdaPA2TE83olZV6vMmcDZkvE5jyFVlfx5ARrmwfEtH9
 Yxd8I/d2yvcmkdPMUqrpOw/pl3lyFW5eqxkR3IAb0QGZROqyaEeX9QPe/xKzt1+jLQkBCyHbZ
 911UjPHz5zrx36TpQgOuuwGMV3RdbaJ1fSZLt31fGq4Llcmru2kQf6tI17Z+IBMOmlHaUeUA4
 urJZtbhjeaFKHTffwSSn2Ut2ZZUKgvCh+IyW/e3u+cJhihEdSIHcClS6Oege5xpKpIbIlUP0i
 hoGQ+WUTXQyb5EHIyR/pMgapEKq7AunUWY9Czg==
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

