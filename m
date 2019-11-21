Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046CEC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62D420898
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574306417;
	bh=um6ph5SAyWFKw2HdzbX2NQp2sqeAJCBkpkg6d7B99gI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SRl+KpI8rmmTQyMg8PjNVPjBicNWZKPNpz2V13DvPBLM8y5Ub1JD43LP5x7P0Bmb8
	 kcMuZ4xAvqE6woM2/KiYS8VpdkMz81EJD6xSYfmfssetlyTNqiAS96ULMeVW/SpM04
	 XgBy7EYR+lYoXbQ4bFl/GHv5Yhjq+h6QwNylBoW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfKUDUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:20:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfKUDUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:20:13 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A020A2089D;
        Thu, 21 Nov 2019 03:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306412;
        bh=um6ph5SAyWFKw2HdzbX2NQp2sqeAJCBkpkg6d7B99gI=;
        h=From:To:Cc:Subject:Date:From;
        b=tk6RrceG0aTUrC3/psoJUjuJ9dDKOMH6Z4ZqTlY66ZK1x/4QML0lq4ZNHPwdCvnqq
         0KmwEcNoT16TOMo3RsFzLdI4VLJ6Z2GoBIM/cV43w9sBYHMKVztXivW0PpsEvGayhj
         FCxfl3abVJoR+90FnFNR72KcecpagoQuaRpEQ7BU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v2] tty: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:20:08 +0100
Message-Id: <1574306408-20021-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 drivers/tty/Kconfig             | 40 ++++++++---------
 drivers/tty/hvc/Kconfig         | 28 ++++++------
 drivers/tty/serial/8250/Kconfig |  2 +-
 drivers/tty/serial/Kconfig      | 96 ++++++++++++++++++++---------------------
 4 files changed, 83 insertions(+), 83 deletions(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index c7623f99ac0f..a312cb33a99b 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -82,20 +82,20 @@ config HW_CONSOLE
 	default y
 
 config VT_HW_CONSOLE_BINDING
-       bool "Support for binding and unbinding console drivers"
-       depends on HW_CONSOLE
-       ---help---
-         The virtual terminal is the device that interacts with the physical
-         terminal through console drivers. On these systems, at least one
-         console driver is loaded. In other configurations, additional console
-         drivers may be enabled, such as the framebuffer console. If more than
-         1 console driver is enabled, setting this to 'y' will allow you to
-         select the console driver that will serve as the backend for the
-         virtual terminals.
-
-	 See <file:Documentation/driver-api/console.rst> for more
-	 information. For framebuffer console users, please refer to
-	 <file:Documentation/fb/fbcon.rst>.
+	bool "Support for binding and unbinding console drivers"
+	depends on HW_CONSOLE
+	---help---
+	  The virtual terminal is the device that interacts with the physical
+	  terminal through console drivers. On these systems, at least one
+	  console driver is loaded. In other configurations, additional console
+	  drivers may be enabled, such as the framebuffer console. If more than
+	  1 console driver is enabled, setting this to 'y' will allow you to
+	  select the console driver that will serve as the backend for the
+	  virtual terminals.
+
+	  See <file:Documentation/driver-api/console.rst> for more
+	  information. For framebuffer console users, please refer to
+	  <file:Documentation/fb/fbcon.rst>.
 
 config UNIX98_PTYS
 	bool "Unix98 PTY support" if EXPERT
@@ -173,15 +173,15 @@ config ROCKETPORT
 	depends on SERIAL_NONSTANDARD && (ISA || EISA || PCI)
 	help
 	  This driver supports Comtrol RocketPort and RocketModem PCI boards.   
-          These boards provide 2, 4, 8, 16, or 32 high-speed serial ports or
-          modems.  For information about the RocketPort/RocketModem  boards
-          and this driver read <file:Documentation/driver-api/serial/rocket.rst>.
+	  These boards provide 2, 4, 8, 16, or 32 high-speed serial ports or
+	  modems.  For information about the RocketPort/RocketModem  boards
+	  and this driver read <file:Documentation/driver-api/serial/rocket.rst>.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called rocket.
 
 	  If you want to compile this driver into the kernel, say Y here.  If
-          you don't have a Comtrol RocketPort/RocketModem card installed, say N.
+	  you don't have a Comtrol RocketPort/RocketModem card installed, say N.
 
 config CYCLADES
 	tristate "Cyclades async mux support"
@@ -437,8 +437,8 @@ config MIPS_EJTAG_FDC_KGDB
 	depends on MIPS_EJTAG_FDC_TTY && KGDB
 	default y
 	help
-          This enables the use of KGDB over an FDC channel, allowing KGDB to be
-          used remotely or when a serial port isn't available.
+	  This enables the use of KGDB over an FDC channel, allowing KGDB to be
+	  used remotely or when a serial port isn't available.
 
 config MIPS_EJTAG_FDC_KGDB_CHAN
 	int "KGDB FDC channel"
diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index 4487a6b9acc8..6a3c97d345a0 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -70,22 +70,22 @@ config HVC_XEN_FRONTEND
 	  Xen driver for secondary virtual consoles
 
 config HVC_UDBG
-       bool "udbg based fake hypervisor console"
-       depends on PPC
-       select HVC_DRIVER
-       help
-         This is meant to be used during HW bring up or debugging when
-	 no other console mechanism exist but udbg, to get you a quick
-	 console for userspace. Do NOT enable in production kernels. 
+	bool "udbg based fake hypervisor console"
+	depends on PPC
+	select HVC_DRIVER
+	help
+	  This is meant to be used during HW bring up or debugging when
+	  no other console mechanism exist but udbg, to get you a quick
+	  console for userspace. Do NOT enable in production kernels.
 
 config HVC_DCC
-       bool "ARM JTAG DCC console"
-       depends on ARM || ARM64
-       select HVC_DRIVER
-       help
-         This console uses the JTAG DCC on ARM to create a console under the HVC
-	 driver. This console is used through a JTAG only on ARM. If you don't have
-	 a JTAG then you probably don't want this option.
+	bool "ARM JTAG DCC console"
+	depends on ARM || ARM64
+	select HVC_DRIVER
+	help
+	  This console uses the JTAG DCC on ARM to create a console under the HVC
+	  driver. This console is used through a JTAG only on ARM. If you don't have
+	  a JTAG then you probably don't want this option.
 
 config HVC_RISCV_SBI
 	bool "RISC-V SBI console support"
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 771ac5dc6023..fab3d4f20667 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -335,7 +335,7 @@ config SERIAL_8250_BCM2835AUX
 
 	  Features and limitations of the UART are
 	    Registers are similar to 16650 registers,
-              set bits in the control registers that are unsupported
+	      set bits in the control registers that are unsupported
 	      are ignored and read back as 0
 	    7/8 bit operation with 1 start and 1 stop bit
 	    8 symbols deep fifo for rx and tx
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 78e0a049a3df..99f5da3bf913 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -287,26 +287,26 @@ config SERIAL_SAMSUNG_CONSOLE
 	  boot time.)
 
 config SERIAL_SIRFSOC
-        tristate "SiRF SoC Platform Serial port support"
-        depends on ARCH_SIRF
-        select SERIAL_CORE
-        help
-          Support for the on-chip UART on the CSR SiRFprimaII series,
-          providing /dev/ttySiRF0, 1 and 2 (note, some machines may not
-          provide all of these ports, depending on how the serial port
-          pins are configured).
+	tristate "SiRF SoC Platform Serial port support"
+	depends on ARCH_SIRF
+	select SERIAL_CORE
+	help
+	  Support for the on-chip UART on the CSR SiRFprimaII series,
+	  providing /dev/ttySiRF0, 1 and 2 (note, some machines may not
+	  provide all of these ports, depending on how the serial port
+	  pins are configured).
 
 config SERIAL_SIRFSOC_CONSOLE
-        bool "Support for console on SiRF SoC serial port"
-        depends on SERIAL_SIRFSOC=y
-        select SERIAL_CORE_CONSOLE
-        help
-          Even if you say Y here, the currently visible virtual console
-          (/dev/tty0) will still be used as the system console by default, but
-          you can alter that using a kernel command line option such as
-          "console=ttySiRFx". (Try "man bootparam" or see the documentation of
-          your boot loader about how to pass options to the kernel at
-          boot time.)
+	bool "Support for console on SiRF SoC serial port"
+	depends on SERIAL_SIRFSOC=y
+	select SERIAL_CORE_CONSOLE
+	help
+	  Even if you say Y here, the currently visible virtual console
+	  (/dev/tty0) will still be used as the system console by default, but
+	  you can alter that using a kernel command line option such as
+	  "console=ttySiRFx". (Try "man bootparam" or see the documentation of
+	  your boot loader about how to pass options to the kernel at
+	  boot time.)
 
 config SERIAL_TEGRA
 	tristate "NVIDIA Tegra20/30 SoC serial controller"
@@ -1078,41 +1078,41 @@ config SERIAL_SCCNXP_CONSOLE
 	  Support for console on SCCNXP serial ports.
 
 config SERIAL_SC16IS7XX_CORE
-        tristate
+	tristate
 
 config SERIAL_SC16IS7XX
-        tristate "SC16IS7xx serial support"
-        select SERIAL_CORE
-        depends on (SPI_MASTER && !I2C) || I2C
-        help
-          This selects support for SC16IS7xx serial ports.
-          Supported ICs are SC16IS740, SC16IS741, SC16IS750, SC16IS752,
-          SC16IS760 and SC16IS762. Select supported buses using options below.
+	tristate "SC16IS7xx serial support"
+	select SERIAL_CORE
+	depends on (SPI_MASTER && !I2C) || I2C
+	help
+	  This selects support for SC16IS7xx serial ports.
+	  Supported ICs are SC16IS740, SC16IS741, SC16IS750, SC16IS752,
+	  SC16IS760 and SC16IS762. Select supported buses using options below.
 
 config SERIAL_SC16IS7XX_I2C
-        bool "SC16IS7xx for I2C interface"
-        depends on SERIAL_SC16IS7XX
-        depends on I2C
-        select SERIAL_SC16IS7XX_CORE if SERIAL_SC16IS7XX
-        select REGMAP_I2C if I2C
-        default y
-        help
-          Enable SC16IS7xx driver on I2C bus,
-          If required say y, and say n to i2c if not required,
-          Enabled by default to support oldconfig.
-          You must select at least one bus for the driver to be built.
+	bool "SC16IS7xx for I2C interface"
+	depends on SERIAL_SC16IS7XX
+	depends on I2C
+	select SERIAL_SC16IS7XX_CORE if SERIAL_SC16IS7XX
+	select REGMAP_I2C if I2C
+	default y
+	help
+	  Enable SC16IS7xx driver on I2C bus,
+	  If required say y, and say n to i2c if not required,
+	  Enabled by default to support oldconfig.
+	  You must select at least one bus for the driver to be built.
 
 config SERIAL_SC16IS7XX_SPI
-        bool "SC16IS7xx for spi interface"
-        depends on SERIAL_SC16IS7XX
-        depends on SPI_MASTER
-        select SERIAL_SC16IS7XX_CORE if SERIAL_SC16IS7XX
-        select REGMAP_SPI if SPI_MASTER
-        help
-          Enable SC16IS7xx driver on SPI bus,
-          If required say y, and say n to spi if not required,
-          This is additional support to exsisting driver.
-          You must select at least one bus for the driver to be built.
+	bool "SC16IS7xx for spi interface"
+	depends on SERIAL_SC16IS7XX
+	depends on SPI_MASTER
+	select SERIAL_SC16IS7XX_CORE if SERIAL_SC16IS7XX
+	select REGMAP_SPI if SPI_MASTER
+	help
+	  Enable SC16IS7xx driver on SPI bus,
+	  If required say y, and say n to spi if not required,
+	  This is additional support to exsisting driver.
+	  You must select at least one bus for the driver to be built.
 
 config SERIAL_TIMBERDALE
 	tristate "Support for timberdale UART"
@@ -1212,7 +1212,7 @@ config SERIAL_ALTERA_UART_CONSOLE
 	  Enable a Altera UART port to be the system console.
 
 config SERIAL_IFX6X60
-        tristate "SPI protocol driver for Infineon 6x60 modem (EXPERIMENTAL)"
+	tristate "SPI protocol driver for Infineon 6x60 modem (EXPERIMENTAL)"
 	depends on GPIOLIB || COMPILE_TEST
 	depends on SPI && HAS_DMA
 	help
-- 
2.7.4

