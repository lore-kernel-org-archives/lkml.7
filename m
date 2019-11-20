Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56FBC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961A0224FC
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257131;
	bh=OGyvxxufgY2sQjCluqmGhbKmqgIDv4cVe/ho7ZRYV8w=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=cXqpNu/9F9uyr1o+vNYMJ2vecUjI6caY0OxpyxvOz13Qk4x6duqjukouX8iNc4DZ/
	 ZUDFYU85IM4R7V4zXRxCsXP9chMjf0UwdVRTOPntYh0hnQS6PCHAZf1nMtZIkmXzEe
	 gdljlhx0rQbczuc0Eqb8BXy/Lv3vEyEJUxh+i6Ss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbfKTNiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:38:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:46096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729825AbfKTNis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:38:48 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9C33224D0;
        Wed, 20 Nov 2019 13:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257127;
        bh=OGyvxxufgY2sQjCluqmGhbKmqgIDv4cVe/ho7ZRYV8w=;
        h=From:To:Cc:Subject:Date:From;
        b=rjHHgUQlUGyWervs/3d4KOKSxuYxK+ZuWFQerotWMSvCliqKjL8oOXwGEqY92vSiQ
         zfJduJbdUuH6JEFzLVppBs5UZR7StoTDAE7VEf9UqFJ0AxZCzCQ0pUqD0ivUq6cDNl
         5cChFc7D7t9OhX91CtNMOXrUPTII4bGPEKnxOiHU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org,
        linux-serial@vger.kernel.org
Subject: [PATCH] tty: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:38:43 +0800
Message-Id: <20191120133843.13189-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/tty/Kconfig             | 26 ++++-----
 drivers/tty/hvc/Kconfig         |  4 +-
 drivers/tty/serial/8250/Kconfig |  2 +-
 drivers/tty/serial/Kconfig      | 96 ++++++++++++++++-----------------
 4 files changed, 64 insertions(+), 64 deletions(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index c7623f99ac0f..ec53b1d4aef3 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -85,13 +85,13 @@ config VT_HW_CONSOLE_BINDING
        bool "Support for binding and unbinding console drivers"
        depends on HW_CONSOLE
        ---help---
-         The virtual terminal is the device that interacts with the physical
-         terminal through console drivers. On these systems, at least one
-         console driver is loaded. In other configurations, additional console
-         drivers may be enabled, such as the framebuffer console. If more than
-         1 console driver is enabled, setting this to 'y' will allow you to
-         select the console driver that will serve as the backend for the
-         virtual terminals.
+	 The virtual terminal is the device that interacts with the physical
+	 terminal through console drivers. On these systems, at least one
+	 console driver is loaded. In other configurations, additional console
+	 drivers may be enabled, such as the framebuffer console. If more than
+	 1 console driver is enabled, setting this to 'y' will allow you to
+	 select the console driver that will serve as the backend for the
+	 virtual terminals.
 
 	 See <file:Documentation/driver-api/console.rst> for more
 	 information. For framebuffer console users, please refer to
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
index 4487a6b9acc8..94734ac511bf 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -74,7 +74,7 @@ config HVC_UDBG
        depends on PPC
        select HVC_DRIVER
        help
-         This is meant to be used during HW bring up or debugging when
+	 This is meant to be used during HW bring up or debugging when
 	 no other console mechanism exist but udbg, to get you a quick
 	 console for userspace. Do NOT enable in production kernels. 
 
@@ -83,7 +83,7 @@ config HVC_DCC
        depends on ARM || ARM64
        select HVC_DRIVER
        help
-         This console uses the JTAG DCC on ARM to create a console under the HVC
+	 This console uses the JTAG DCC on ARM to create a console under the HVC
 	 driver. This console is used through a JTAG only on ARM. If you don't have
 	 a JTAG then you probably don't want this option.
 
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
2.17.1

