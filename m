Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88AFC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E252084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfCKNYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:24:22 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:37899 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfCKNTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:40 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MK3eC-1hLQii2cus-00LZMj for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:38 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 084/114] drivers: acpi: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:36 +0100
Message-Id: <1552310346-7629-85-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:AQNnDB/e1gbR5TBjz9C43jBXAtxhMYOKI46rLPTe6ig6elaa0Qv
 DLo3ISM0Od4KXujng2VWH6gkWDtWDB51VTv3eZJlNLsaTVKvdfYmo3qEt4Vkg7zq1YVK/GI
 1vbTENnrEL0vHcwiBXHnHW1JV2hU/NBtN0Wix31xF9a9Six7UWhBxB+EPMmPaOywPEPOpgf
 MpfUtfV9XdEOzN+vBRiog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SEeD4Dwo5G0=:HD0WpIaBRzTN6EIFOrHodt
 Tc9/UiSM033NJ8vy+Sn88cZ1NlpRXaS81+4hX6LWQEoRlL8pL4sMMplqWmnDCcHfN8wkVEaHD
 gaas8I2KBntPF3bzRsEvYOlyD6bFVaYryhfAl21UdIUUmzW957oZcgRUT+vADI/86denTOajU
 ETW6dgGnUxqBGb3PdkZvVS+4xmlO0o78Eg3Zvc8Yezhzxq8BBHPOEGIX9znyCmYteMyFuQX/S
 WuEm+dMn+/2MjjLMQejwUr2rRkL/4nhTPixDSBkiGyJTRrJsPhXLVFHOIZcQYaM3KFrt3E+r5
 vUgE2yLH3KoIfbWM5TTz+mek5Vr/zkYAxuxzb1bOC/8hN3tGeAbMkbP6w4ZOhqqbZgj+pJwkz
 nGNGlMCc+6FIQKpGs3/JNf81jCCXj4rMHLbLvmH6Y/acwPGP5OFz4NXjWJLFnU2SUIFJ5vd6p
 oLOdYTqTOegEfhVRAhwPrPqNtpLLfcndx+oaWXSFWiAOWkSimi4jdxawIy5wmai78NMtm+QEh
 OXSxojiHuBCymUQI5BTBe8843erD0tDhJjOziHSSJRdRfHpu1n18TpIRhNm5gzAmMXIagO1EE
 LX3Tt2f7d/C+WZwTzUUCs/v6hnw1VPR7yqAeOB08VqTsgceyNwWm0/0mjQScbtJzO13J/6AMV
 0l88AYN40gWMIeLi3aXKfTs3/BmLsB8pmMlxIFYbO9L0Go0NOE80VxN3IcrOPbls9eqjax8J0
 fKPce3Dthobi2nqzRf2NojYTnF+ZQPBptfYn0g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/acpi/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 4e015c7..d00f7a6 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -13,17 +13,17 @@ menuconfig ACPI
 	select NLS
 	default y if X86
 	help
-	  Advanced Configuration and Power Interface (ACPI) support for 
+	  Advanced Configuration and Power Interface (ACPI) support for
 	  Linux requires an ACPI-compliant platform (hardware/firmware),
 	  and assumes the presence of OS-directed configuration and power
-	  management (OSPM) software.  This option will enlarge your 
+	  management (OSPM) software.  This option will enlarge your
 	  kernel by about 70K.
 
-	  Linux ACPI provides a robust functional replacement for several 
+	  Linux ACPI provides a robust functional replacement for several
 	  legacy configuration and power management interfaces, including
-	  the Plug-and-Play BIOS specification (PnP BIOS), the 
-	  MultiProcessor Specification (MPS), and the Advanced Power 
-	  Management (APM) specification.  If both ACPI and APM support 
+	  the Plug-and-Play BIOS specification (PnP BIOS), the
+	  MultiProcessor Specification (MPS), and the Advanced Power
+	  Management (APM) specification.  If both ACPI and APM support
 	  are configured, ACPI is used.
 
 	  The project home page for the Linux ACPI subsystem is here:
@@ -104,9 +104,9 @@ config ACPI_PROCFS_POWER
 	depends on X86 && PROC_FS
 	help
 	  For backwards compatibility, this option allows
-          deprecated power /proc/acpi/ directories to exist, even when
-          they have been replaced by functions in /sys.
-          The deprecated directories (and their replacements) include:
+	  deprecated power /proc/acpi/ directories to exist, even when
+	  they have been replaced by functions in /sys.
+	  The deprecated directories (and their replacements) include:
 	  /proc/acpi/battery/* (/sys/class/power_supply/*) and
 	  /proc/acpi/ac_adapter/* (sys/class/power_supply/*).
 	  This option has no effect on /proc/acpi/ directories
@@ -173,7 +173,7 @@ config ACPI_BATTERY
 	default y
 	help
 	  This driver adds support for battery information through
-	  /proc/acpi/battery. If you have a mobile system with a battery, 
+	  /proc/acpi/battery. If you have a mobile system with a battery,
 	  say Y.
 
 	  To compile this driver as a module, choose M here:
@@ -456,7 +456,7 @@ config ACPI_CUSTOM_METHOD
 config ACPI_BGRT
 	bool "Boottime Graphics Resource Table support"
 	depends on EFI && (X86 || ARM64)
-        help
+	help
 	  This driver adds support for exposing the ACPI Boottime Graphics
 	  Resource Table, which allows the operating system to obtain
 	  data from the firmware boot splash. It will appear under
@@ -577,7 +577,7 @@ config TPS68470_PMIC_OPREGION
 	  region, which must be available before any of the devices
 	  using this, are probed.
 
-endif	# ACPI
+endif # ACPI
 
 config X86_PM_TIMER
 	bool "Power Management Timer Support" if EXPERT
-- 
1.9.1

