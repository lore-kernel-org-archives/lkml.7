Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFD2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18C721B26
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfCKNaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:30:02 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:55959 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfCKNTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:32 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MV6G0-1hRzDr485m-00S8w1 for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:30 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 018/114] drivers: ntb: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:30 +0100
Message-Id: <1552310346-7629-19-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:3aGPsIr+jiZgkhTpdIZm4NOS0s0RgTBk4uwfzuTm00n1kMNMyfl
 33SRFUhu/nQPwa5r6fX63k/p3zkCveU3L9tYDACDyZTWWbSnJWKVSX7y4JKu6QqeM+yhqbv
 Fb33e5C9FYkaOfGfXtcmLDXaognpovZRq8wPN4z8Afv0IYFUQyUdf3OgUqwq7bt6E8zJ1Vj
 ZTOFnvCcYdtFu1PpRLy/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0KvIYAr1vUI=:04o/T/SYygZZ0bY+YS+amh
 977CORiOQ15I8d4ENA2eULYHv6IT2EauUaB/sujm1fLpVol26f4O9GC8ybwBP9er1zqd2lC3h
 FBCLsG0fR3OZhSuxdjAhJLdK46BRlqgHRrY4BHt+ViKOteqZDTlrHoz3Ree5O6zwgVSKyt+Fx
 jgj2xPcpm4Asus6nNP2y5HN7spU0eikPOvyTs85leg+P60m7TxlxtkEdzg/VESa08TyX9xCmT
 WYf95GRqwn1dUnL+hbtGPURgc7AcigXwrSzuZkjEznnNidaDNoebkCPkF7vL4lGGHC7i7QVIg
 PGf25U/HhbgKucveCBhtv2qHZ6NC7M1MMeKWb/srEmMYUqXoA0hUeHC6FO/RybJR6C4Ei3Z2X
 0ZC1MBuKTpdPNvD2jBN9f6WWMPEzt5F3lhLfhtmIKqB6gGneP9Qsq+vVdcTqxmOcIgZsYr4/W
 nh1yYJrqfvlEDbAGAdNXPxWo59+cBsNxT4bdyUZHH0im6t3Hsq9Fq/wh6LEazJCriZPCoCv9+
 c/Tuq4CzQMBqVscXEng6XwPRBSeMZ6IP5pcI7t/vOFw9Fs9Hpm8XOF0Qb9NbpDEweBjyhfegD
 BQ1A+fjS2bAp7QXUH0AnHPZokCNMJccSkOlUsKVsN9vvFktS7mbjcr3o3eY51Fbf7sfe2dZKm
 Y8uNsyBWEPklpTtCN6egMI774yKvzFFQJUQlmCjWY+ASJBS2cq+/L3q+KaIzj+1BG+t+qj6TO
 fRpyQc2p2c6Yt4d/ONPW+tMnBAd1nr83M/ZOtQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ntb/Kconfig          | 20 ++++++++++----------
 drivers/ntb/hw/amd/Kconfig   |  4 ++--
 drivers/ntb/hw/idt/Kconfig   | 41 ++++++++++++++++++++---------------------
 drivers/ntb/hw/intel/Kconfig |  4 ++--
 drivers/ntb/hw/mscc/Kconfig  |  8 ++++----
 drivers/ntb/test/Kconfig     | 26 +++++++++++++-------------
 6 files changed, 51 insertions(+), 52 deletions(-)

diff --git a/drivers/ntb/Kconfig b/drivers/ntb/Kconfig
index 95944e5..5ce3fdd 100644
--- a/drivers/ntb/Kconfig
+++ b/drivers/ntb/Kconfig
@@ -2,13 +2,13 @@ menuconfig NTB
 	tristate "Non-Transparent Bridge support"
 	depends on PCI
 	help
-	 The PCI-E Non-transparent bridge hardware is a point-to-point PCI-E bus
-	 connecting 2 systems.  When configured, writes to the device's PCI
-	 mapped memory will be mirrored to a buffer on the remote system.  The
-	 ntb Linux driver uses this point-to-point communication as a method to
-	 transfer data from one system to the other.
+	  The PCI-E Non-transparent bridge hardware is a point-to-point PCI-E bus
+	  connecting 2 systems.  When configured, writes to the device's PCI
+	  mapped memory will be mirrored to a buffer on the remote system.  The
+	  ntb Linux driver uses this point-to-point communication as a method to
+	  transfer data from one system to the other.
 
-	 If unsure, say N.
+	  If unsure, say N.
 
 if NTB
 
@@ -19,10 +19,10 @@ source "drivers/ntb/test/Kconfig"
 config NTB_TRANSPORT
 	tristate "NTB Transport Client"
 	help
-	 This is a transport driver that enables connected systems to exchange
-	 messages over the ntb hardware.  The transport exposes a queue pair api
-	 to client drivers.
+	  This is a transport driver that enables connected systems to exchange
+	  messages over the ntb hardware.  The transport exposes a queue pair api
+	  to client drivers.
 
-	 If unsure, say N.
+	  If unsure, say N.
 
 endif # NTB
diff --git a/drivers/ntb/hw/amd/Kconfig b/drivers/ntb/hw/amd/Kconfig
index cfe903c..9a90f17 100644
--- a/drivers/ntb/hw/amd/Kconfig
+++ b/drivers/ntb/hw/amd/Kconfig
@@ -2,6 +2,6 @@ config NTB_AMD
 	tristate "AMD Non-Transparent Bridge support"
 	depends on X86_64
 	help
-	 This driver supports AMD NTB on capable Zeppelin hardware.
+	  This driver supports AMD NTB on capable Zeppelin hardware.
 
-	 If unsure, say N.
+	  If unsure, say N.
diff --git a/drivers/ntb/hw/idt/Kconfig b/drivers/ntb/hw/idt/Kconfig
index f8948cf..5d106ac 100644
--- a/drivers/ntb/hw/idt/Kconfig
+++ b/drivers/ntb/hw/idt/Kconfig
@@ -3,28 +3,27 @@ config NTB_IDT
 	depends on PCI
 	select HWMON
 	help
-	 This driver supports NTB of cappable IDT PCIe-switches.
+	  This driver supports NTB of cappable IDT PCIe-switches.
 
-	 Some of the pre-initializations must be made before IDT PCIe-switch
-	 exposes it NT-functions correctly. It should be done by either proper
-	 initialisation of EEPROM connected to master smbus of the switch or
-	 by BIOS using slave-SMBus interface changing corresponding registers
-	 value. Evidently it must be done before PCI bus enumeration is
-	 finished in Linux kernel.
+	  Some of the pre-initializations must be made before IDT PCIe-switch
+	  exposes it NT-functions correctly. It should be done by either proper
+	  initialisation of EEPROM connected to master smbus of the switch or
+	  by BIOS using slave-SMBus interface changing corresponding registers
+	  value. Evidently it must be done before PCI bus enumeration is
+	  finished in Linux kernel.
 
-	 First of all partitions must be activated and properly assigned to all
-	 the ports with NT-functions intended to be activated (see SWPARTxCTL
-	 and SWPORTxCTL registers). Then all NT-function BARs must be enabled
-	 with chosen valid aperture. For memory windows related BARs the
-	 aperture settings shall determine the maximum size of memory windows
-	 accepted by a BAR. Note that BAR0 must map PCI configuration space
-	 registers.
+	  First of all partitions must be activated and properly assigned to all
+	  the ports with NT-functions intended to be activated (see SWPARTxCTL
+	  and SWPORTxCTL registers). Then all NT-function BARs must be enabled
+	  with chosen valid aperture. For memory windows related BARs the
+	  aperture settings shall determine the maximum size of memory windows
+	  accepted by a BAR. Note that BAR0 must map PCI configuration space
+	  registers.
 
-	 It's worth to note, that since a part of this driver relies on the
-	 BAR settings of peer NT-functions, the BAR setups can't be done over
-	 kernel PCI fixups. That's why the alternative pre-initialization
-	 techniques like BIOS using SMBus interface or EEPROM should be
-	 utilized.
-
-	 If unsure, say N.
+	  It's worth to note, that since a part of this driver relies on the
+	  BAR settings of peer NT-functions, the BAR setups can't be done over
+	  kernel PCI fixups. That's why the alternative pre-initialization
+	  techniques like BIOS using SMBus interface or EEPROM should be
+	  utilized.
 
+	  If unsure, say N.
diff --git a/drivers/ntb/hw/intel/Kconfig b/drivers/ntb/hw/intel/Kconfig
index 91f995e..c166d50 100644
--- a/drivers/ntb/hw/intel/Kconfig
+++ b/drivers/ntb/hw/intel/Kconfig
@@ -2,6 +2,6 @@ config NTB_INTEL
 	tristate "Intel Non-Transparent Bridge support"
 	depends on X86_64
 	help
-	 This driver supports Intel NTB on capable Xeon and Atom hardware.
+	  This driver supports Intel NTB on capable Xeon and Atom hardware.
 
-	 If unsure, say N.
+	  If unsure, say N.
diff --git a/drivers/ntb/hw/mscc/Kconfig b/drivers/ntb/hw/mscc/Kconfig
index 013ed67..74ec015 100644
--- a/drivers/ntb/hw/mscc/Kconfig
+++ b/drivers/ntb/hw/mscc/Kconfig
@@ -2,8 +2,8 @@ config NTB_SWITCHTEC
 	tristate "MicroSemi Switchtec Non-Transparent Bridge Support"
 	select PCI_SW_SWITCHTEC
 	help
-	 Enables NTB support for Switchtec PCI switches. This also
-	 selects the Switchtec management driver as they share the same
-	 hardware interface.
+	  Enables NTB support for Switchtec PCI switches. This also
+	  selects the Switchtec management driver as they share the same
+	  hardware interface.
 
-	 If unsure, say N.
+	  If unsure, say N.
diff --git a/drivers/ntb/test/Kconfig b/drivers/ntb/test/Kconfig
index a5d0eda..416ab56 100644
--- a/drivers/ntb/test/Kconfig
+++ b/drivers/ntb/test/Kconfig
@@ -1,27 +1,27 @@
 config NTB_PINGPONG
 	tristate "NTB Ping Pong Test Client"
 	help
-	 This is a simple ping pong driver that exercises the scratchpads and
-	 doorbells of the ntb hardware.  This driver may be used to test that
-	 your ntb hardware and drivers are functioning at a basic level.
+	  This is a simple ping pong driver that exercises the scratchpads and
+	  doorbells of the ntb hardware.  This driver may be used to test that
+	  your ntb hardware and drivers are functioning at a basic level.
 
-	 If unsure, say N.
+	  If unsure, say N.
 
 config NTB_TOOL
 	tristate "NTB Debugging Tool Test Client"
 	help
-	 This is a simple debugging driver that enables the doorbell and
-	 scratchpad registers to be read and written from the debugfs.  This
-	 enables more complicated debugging to be scripted from user space.
-	 This driver may be used to test that your ntb hardware and drivers are
-	 functioning at a basic level.
+	  This is a simple debugging driver that enables the doorbell and
+	  scratchpad registers to be read and written from the debugfs.  This
+	  enables more complicated debugging to be scripted from user space.
+	  This driver may be used to test that your ntb hardware and drivers are
+	  functioning at a basic level.
 
-	 If unsure, say N.
+	  If unsure, say N.
 
 config NTB_PERF
 	tristate "NTB RAW Perf Measuring Tool"
 	help
-	 This is a tool to measure raw NTB performance by transferring data
-	 to and from the window without additional software interaction.
+	  This is a tool to measure raw NTB performance by transferring data
+	  to and from the window without additional software interaction.
 
-	 If unsure, say N.
+	  If unsure, say N.
-- 
1.9.1

