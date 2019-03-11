Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555BCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC0C2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfCKNUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:20:10 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:54741 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbfCKNTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:40 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M5wTt-1h9glW49Cl-007SjI for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:38 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 079/114] drivers: char: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:31 +0100
Message-Id: <1552310346-7629-80-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:3/Sfe//RhCPdp3BAf76oNUfJT9DcEXmGYjbHY4m6/DzQjufkvTu
 g5D+OiQyOAL7QhgAAc8COcWFEFxxdGUKUk7Y8QS/hZDdDPLWyi/h/FVOjRy+yJow9VPzdvF
 UWxb4H/rMrKRb77bScuf8mfrEgAoHpfmEkE/grOvJ5LUISw7REkqz7uZtlOV7y3RjVG1+n+
 /ay29O3ZdIJueRHanYGEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vAkq9Qn5/KM=:wWwzNgNNHACVtLm7ytJUUk
 kWsN+TUi872INho/ZUonSURguHeR0GAA/S+pd8Q8fLSevsoV6FHdvvqlaYr47YKUJrHwyz/rU
 gfBVVcV8UwDM8DdFM4wYaECPF2W/IX65qmNwqCj1Ko6gdXJHqGe4Q1TQEYSlGZUlnG+uWYZ9f
 WxF+Ns4W3fLcpHHXSw1FiJFey11uEljEKV2zID84pdjb9gTtZnPCtzwfC7jcKONaIE5a2GrSK
 +X+5YlA29+avNvi7xO8cbjZPz0TaiUUNYICdQL8pHOuJtZLnEfcKPTB8vzKiBRTZERdEW2pHh
 ULCaL0JkbWAd/EnBlYlaR67+aaoNZhP/hCVGTHwjKX5InGgqPrbgVg+MGAMVCuQXH8dXDA9S0
 EzN7tlde5U0933heYJC8eDsfwZEWs3KDBz6KXm6A9Td55hie/OLkmUoJVJzUqf493e7SSSv2C
 xf2Tq8ah/OV9M/RNrPXW8WrNVTEzGqOLcxLfnX0sr8hHT04sq05Pug5uiWudfheyUqEgxzu0Z
 9LzV/yE2ZMNdqAiYXwiAUwOn8+MC+ygGI/KwEwIWbCOvJOrYBM4qie6RxkkBl9SoTFWERzAQX
 ozJg4bHY7VDZfVB7VQNpdfp3GAFElWmPeolLcgzx4gqv8RoyJNUpRxIuvdx7Z/hfyKqtcy9E5
 FsSULgNKXv4k3lNvjfDFtga+rBN/w0VsSRhwI2Q3sLeFfLJjveFOsimBBqpSplHlqcA+rshJd
 htaAp0T2M7B+FbA1ldbvF1bZxFnR6PbLUWYiiw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/char/Kconfig           | 24 +++++-----
 drivers/char/agp/Kconfig       | 13 +++---
 drivers/char/hw_random/Kconfig | 24 +++++-----
 drivers/char/ipmi/Kconfig      | 99 +++++++++++++++++++++---------------------
 4 files changed, 80 insertions(+), 80 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 72866a0..ab33583 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -35,18 +35,18 @@ config SGI_SNSC
 	  say Y.  Otherwise, say N.
 
 config SGI_TIOCX
-       bool "SGI TIO CX driver support"
-       depends on (IA64_SGI_SN2 || IA64_GENERIC)
-       help
-         If you have an SGI Altix and you have fpga devices attached
-         to your TIO, say Y here, otherwise say N.
+	bool "SGI TIO CX driver support"
+	depends on (IA64_SGI_SN2 || IA64_GENERIC)
+	help
+	  If you have an SGI Altix and you have fpga devices attached
+	  to your TIO, say Y here, otherwise say N.
 
 config SGI_MBCS
-       tristate "SGI FPGA Core Services driver support"
-       depends on SGI_TIOCX
-       help
-         If you have an SGI Altix with an attached SABrick
-         say Y or M here, otherwise say N.
+	tristate "SGI FPGA Core Services driver support"
+	depends on SGI_TIOCX
+	help
+	  If you have an SGI Altix with an attached SABrick
+	  say Y or M here, otherwise say N.
 
 source "drivers/tty/serial/Kconfig"
 source "drivers/tty/serdev/Kconfig"
@@ -461,8 +461,8 @@ config RAW_DRIVER
 	  Once bound, I/O against /dev/raw/rawN uses efficient zero-copy I/O.
 	  See the raw(8) manpage for more details.
 
-          Applications should preferably open the device (eg /dev/hda1)
-          with the O_DIRECT flag.
+	  Applications should preferably open the device (eg /dev/hda1)
+	  with the O_DIRECT flag.
 
 config MAX_RAW_DEVS
 	int "Maximum number of RAW devices to support (1-65536)"
diff --git a/drivers/char/agp/Kconfig b/drivers/char/agp/Kconfig
index 6231714..6da28d5 100644
--- a/drivers/char/agp/Kconfig
+++ b/drivers/char/agp/Kconfig
@@ -63,7 +63,7 @@ config AGP_AMD64
 	  This option gives you AGP support for the GLX component of
 	  X using the on-CPU northbridge of the AMD Athlon64/Opteron CPUs.
 	  You still need an external AGP bridge like the AMD 8151, VIA
-          K8T400M, SiS755. It may also support other AGP bridges when loaded
+	  K8T400M, SiS755. It may also support other AGP bridges when loaded
 	  with agp_try_unsupported=1.
 
 config AGP_INTEL
@@ -151,13 +151,12 @@ config AGP_EFFICEON
 	  series processors with integrated northbridges.
 
 config AGP_SGI_TIOCA
-        tristate "SGI TIO chipset AGP support"
-        depends on AGP && (IA64_SGI_SN2 || IA64_GENERIC)
-        help
-          This option gives you AGP GART support for the SGI TIO chipset
-          for IA64 processors.
+	tristate "SGI TIO chipset AGP support"
+	depends on AGP && (IA64_SGI_SN2 || IA64_GENERIC)
+	help
+	  This option gives you AGP GART support for the SGI TIO chipset
+	  for IA64 processors.
 
 config INTEL_GTT
 	tristate
 	depends on X86 && PCI
-
diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 25a7d8f..6265931 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -156,15 +156,15 @@ config HW_RANDOM_OMAP
 	tristate "OMAP Random Number Generator support"
 	depends on ARCH_OMAP16XX || ARCH_OMAP2PLUS || ARCH_MVEBU
 	default HW_RANDOM
- 	---help---
- 	  This driver provides kernel-side support for the Random Number
+	---help---
+	  This driver provides kernel-side support for the Random Number
 	  Generator hardware found on OMAP16xx, OMAP2/3/4/5, AM33xx/AM43xx
 	  multimedia processors, and Marvell Armada 7k/8k SoCs.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called omap-rng.
 
- 	  If unsure, say Y.
+	  If unsure, say Y.
 
 config HW_RANDOM_OMAP3_ROM
 	tristate "OMAP3 ROM Random Number Generator support"
@@ -372,17 +372,17 @@ config HW_RANDOM_MESON
 	  If unsure, say Y.
 
 config HW_RANDOM_CAVIUM
-       tristate "Cavium ThunderX Random Number Generator support"
-       depends on HW_RANDOM && PCI && (ARM64 || (COMPILE_TEST && 64BIT))
-       default HW_RANDOM
-       ---help---
-         This driver provides kernel-side support for the Random Number
-         Generator hardware found on Cavium SoCs.
+	tristate "Cavium ThunderX Random Number Generator support"
+	depends on HW_RANDOM && PCI && (ARM64 || (COMPILE_TEST && 64BIT))
+	default HW_RANDOM
+	---help---
+	  This driver provides kernel-side support for the Random Number
+	  Generator hardware found on Cavium SoCs.
 
-         To compile this driver as a module, choose M here: the
-         module will be called cavium_rng.
+	  To compile this driver as a module, choose M here: the
+	  module will be called cavium_rng.
 
-         If unsure, say Y.
+	  If unsure, say Y.
 
 config HW_RANDOM_MTK
 	tristate "Mediatek Random Number Generator support"
diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
index 94719fc..b6219c3 100644
--- a/drivers/char/ipmi/Kconfig
+++ b/drivers/char/ipmi/Kconfig
@@ -1,40 +1,41 @@
+
 #
 # IPMI device configuration
 #
 
 menuconfig IPMI_HANDLER
-       tristate 'IPMI top-level message handler'
-       depends on HAS_IOMEM
-       select IPMI_DMI_DECODE if DMI
-       help
-         This enables the central IPMI message handler, required for IPMI
-	 to work.
+	tristate 'IPMI top-level message handler'
+	depends on HAS_IOMEM
+	select IPMI_DMI_DECODE if DMI
+	help
+	  This enables the central IPMI message handler, required for IPMI
+	  to work.
 
-         IPMI is a standard for managing sensors (temperature,
-         voltage, etc.) in a system.
+	  IPMI is a standard for managing sensors (temperature,
+	  voltage, etc.) in a system.
 
-         See <file:Documentation/IPMI.txt> for more details on the driver.
+	  See <file:Documentation/IPMI.txt> for more details on the driver.
 
-	 If unsure, say N.
+	  If unsure, say N.
 
 config IPMI_DMI_DECODE
-       select IPMI_PLAT_DATA
-       bool
+	select IPMI_PLAT_DATA
+	bool
 
 config IPMI_PLAT_DATA
-       bool
+	bool
 
 if IPMI_HANDLER
 
 config IPMI_PANIC_EVENT
-       bool 'Generate a panic event to all BMCs on a panic'
-       help
-	 When a panic occurs, this will cause the IPMI message handler to,
-	 by default, generate an IPMI event describing the panic to each
-	 interface registered with the message handler.  This is always
-	 available, the module parameter for ipmi_msghandler named
-	 panic_op can be set to "event" to chose this value, this config
-	 simply causes the default value to be set to "event".
+	bool 'Generate a panic event to all BMCs on a panic'
+	help
+	  When a panic occurs, this will cause the IPMI message handler to,
+	  by default, generate an IPMI event describing the panic to each
+	  interface registered with the message handler.  This is always
+	  available, the module parameter for ipmi_msghandler named
+	  panic_op can be set to "event" to chose this value, this config
+	  simply causes the default value to be set to "event".
 
 config IPMI_PANIC_STRING
 	bool 'Generate OEM events containing the panic string'
@@ -53,43 +54,43 @@ config IPMI_PANIC_STRING
 	  causes the default value to be set to "string".
 
 config IPMI_DEVICE_INTERFACE
-       tristate 'Device interface for IPMI'
-       help
-         This provides an IOCTL interface to the IPMI message handler so
-	 userland processes may use IPMI.  It supports poll() and select().
+	tristate 'Device interface for IPMI'
+	help
+	  This provides an IOCTL interface to the IPMI message handler so
+	  userland processes may use IPMI.  It supports poll() and select().
 
 config IPMI_SI
-       tristate 'IPMI System Interface handler'
-       select IPMI_PLAT_DATA
-       help
-         Provides a driver for System Interfaces (KCS, SMIC, BT).
-	 Currently, only KCS and SMIC are supported.  If
-	 you are using IPMI, you should probably say "y" here.
+	tristate 'IPMI System Interface handler'
+	select IPMI_PLAT_DATA
+	help
+	  Provides a driver for System Interfaces (KCS, SMIC, BT).
+	  Currently, only KCS and SMIC are supported.  If
+	  you are using IPMI, you should probably say "y" here.
 
 config IPMI_SSIF
-       tristate 'IPMI SMBus handler (SSIF)'
-       select I2C
-       help
-         Provides a driver for a SMBus interface to a BMC, meaning that you
-	 have a driver that must be accessed over an I2C bus instead of a
-	 standard interface.  This module requires I2C support.
+	tristate 'IPMI SMBus handler (SSIF)'
+	select I2C
+	help
+	  Provides a driver for a SMBus interface to a BMC, meaning that you
+	  have a driver that must be accessed over an I2C bus instead of a
+	  standard interface.  This module requires I2C support.
 
 config IPMI_POWERNV
-       depends on PPC_POWERNV
-       tristate 'POWERNV (OPAL firmware) IPMI interface'
-       help
-         Provides a driver for OPAL firmware-based IPMI interfaces.
+	depends on PPC_POWERNV
+	tristate 'POWERNV (OPAL firmware) IPMI interface'
+	help
+	  Provides a driver for OPAL firmware-based IPMI interfaces.
 
 config IPMI_WATCHDOG
-       tristate 'IPMI Watchdog Timer'
-       help
-         This enables the IPMI watchdog timer.
+	tristate 'IPMI Watchdog Timer'
+	help
+	  This enables the IPMI watchdog timer.
 
 config IPMI_POWEROFF
-       tristate 'IPMI Poweroff'
-       help
-         This enables a function to power off the system with IPMI if
-	 the IPMI management controller is capable of this.
+	tristate 'IPMI Poweroff'
+	help
+	  This enables a function to power off the system with IPMI if
+	  the IPMI management controller is capable of this.
 
 endif # IPMI_HANDLER
 
@@ -125,7 +126,7 @@ config NPCM7XX_KCS_IPMI_BMC
 
 config ASPEED_BT_IPMI_BMC
 	depends on ARCH_ASPEED || COMPILE_TEST
-       depends on REGMAP && REGMAP_MMIO && MFD_SYSCON
+	depends on REGMAP && REGMAP_MMIO && MFD_SYSCON
 	tristate "BT IPMI bmc driver"
 	help
 	  Provides a driver for the BT (Block Transfer) IPMI interface
-- 
1.9.1

