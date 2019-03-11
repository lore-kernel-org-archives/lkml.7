Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F229C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165D820857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfCKN1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:27:50 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:47653 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbfCKNTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:36 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MfYHW-1gatun0efA-00fybL for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:33 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 042/114] drivers: tty: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:54 +0100
Message-Id: <1552310346-7629-43-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:OdC/iQivdO24L1GG8odneqVZfSi0m4/Tjz66vQqq0u4s3OEvqQi
 TKZ74EBuq3IW6LeeVcHPuFu2kYQB/wibNv6HHgs0u1/JtymyVMJont7g1P/uYAndM3SOixb
 aTArGbr5VE/fhlfQrSRFejtucvymorToWz37p8goyC/9V+wERjjcFyuhb/nKiHIq1fJChk5
 0g7t3s1TGfbAauYlPRfjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5SlLwMUO6wc=:bVpmJcfsQUCjo4BPSyBlvD
 BwgLEXVX+DsH6CtWkblZC3QnsABv7uyuun71VzCVDeyspHVcXkH9+cXX2fvJ0JfPLdsCNwq2/
 IavoDaSHhXgTkc9D4h0y46nrlgxZJUMykuSLyWwt+TI9tnbvpvxqmHeS8UCaDUS+OszBC1Pzw
 6FXyjEZJMPlUpdRiIFyDjUCuZv6FtCng0N+PqP+44kBKUFNlk9LGC7wnWamIDSofOAyOfVmSc
 PQGixoABU2R5o2gEphnqSXyjy8p8pVi3OrVLt0JxiMYxjvZ60bltyHKIa3RdYLUdXM0R/glWw
 Q3FtVkExevxKvrWaX9ZCQxNnLNr0fgH5v8JXYjxEipyWXLfeJup0Gw2VTPOXQWfQ059KziNsz
 dUNz4k4iasx7HFxf5zAZBoYVaOaRGwIUJSQcwXyz6y/wFpEitfDzN7xQwpsHg5iaVxrMLu9T9
 7bRrucqd/vaSmZ2+qzTB/1vuRKmCOxxm1Ynt1gBIy7X7plWrIbhCt7Or1u2rVMvBpf3IMLVYy
 LmOqoIIQKLUMY/RL1EE+5dd1dQOwqznISvBpnGPGI+F9/iepCkuyd0T6dRR4zcYb1Ze6344oT
 dK27oENmt/hhQIwFWTDyIvogf16KL+FppMVrgwmSKKOFiEfeFQ2GWQG+RfO6N63dqetBEuvA9
 cuxyb8mjuPYr05fyDFKhmDIEPGrKSfXAvChYODWEmFEJ8HyaKmSbFxdyu2vnivb+/yhNON1W5
 sUJ39fZ0jR0TBqcwufVTHjT8Dz+Ncp3TmtjzXw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/Kconfig             |  45 ++++++++-------
 drivers/tty/hvc/Kconfig         |  30 +++++-----
 drivers/tty/serial/8250/Kconfig |   4 +-
 drivers/tty/serial/Kconfig      | 122 ++++++++++++++++++++--------------------
 4 files changed, 100 insertions(+), 101 deletions(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index e0a04bf..fa8f7ff 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -81,21 +81,21 @@ config HW_CONSOLE
 	default y
 
 config VT_HW_CONSOLE_BINDING
-       bool "Support for binding and unbinding console drivers"
-       depends on HW_CONSOLE
-       default n
-       ---help---
-         The virtual terminal is the device that interacts with the physical
-         terminal through console drivers. On these systems, at least one
-         console driver is loaded. In other configurations, additional console
-         drivers may be enabled, such as the framebuffer console. If more than
-         1 console driver is enabled, setting this to 'y' will allow you to
-         select the console driver that will serve as the backend for the
-         virtual terminals.
-
-	 See <file:Documentation/console/console.txt> for more
-	 information. For framebuffer console users, please refer to
-	 <file:Documentation/fb/fbcon.txt>.
+	bool "Support for binding and unbinding console drivers"
+	depends on HW_CONSOLE
+	default n
+	---help---
+	  The virtual terminal is the device that interacts with the physical
+	  terminal through console drivers. On these systems, at least one
+	  console driver is loaded. In other configurations, additional console
+	  drivers may be enabled, such as the framebuffer console. If more than
+	  1 console driver is enabled, setting this to 'y' will allow you to
+	  select the console driver that will serve as the backend for the
+	  virtual terminals.
+
+	  See <file:Documentation/console/console.txt> for more
+	  information. For framebuffer console users, please refer to
+	  <file:Documentation/fb/fbcon.txt>.
 
 config UNIX98_PTYS
 	bool "Unix98 PTY support" if EXPERT
@@ -137,7 +137,6 @@ config LEGACY_PTYS
 	  security.  This option enables these legacy devices; on most
 	  systems, it is safe to say N.
 
-
 config LEGACY_PTY_COUNT
 	int "Maximum number of legacy PTY in use"
 	depends on LEGACY_PTYS
@@ -172,16 +171,16 @@ config ROCKETPORT
 	tristate "Comtrol RocketPort support"
 	depends on SERIAL_NONSTANDARD && (ISA || EISA || PCI)
 	help
-	  This driver supports Comtrol RocketPort and RocketModem PCI boards.   
-          These boards provide 2, 4, 8, 16, or 32 high-speed serial ports or
-          modems.  For information about the RocketPort/RocketModem  boards
-          and this driver read <file:Documentation/serial/rocket.txt>.
+	  This driver supports Comtrol RocketPort and RocketModem PCI boards.
+	  These boards provide 2, 4, 8, 16, or 32 high-speed serial ports or
+	  modems.  For information about the RocketPort/RocketModem  boards
+	  and this driver read <file:Documentation/serial/rocket.txt>.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called rocket.
 
 	  If you want to compile this driver into the kernel, say Y here.  If
-          you don't have a Comtrol RocketPort/RocketModem card installed, say N.
+	  you don't have a Comtrol RocketPort/RocketModem card installed, say N.
 
 config CYCLADES
 	tristate "Cyclades async mux support"
@@ -425,8 +424,8 @@ config MIPS_EJTAG_FDC_KGDB
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
index 4293c17..fe7632a 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -70,23 +70,23 @@ config HVC_XEN_FRONTEND
 	  Xen driver for secondary virtual consoles
 
 config HVC_UDBG
-       bool "udbg based fake hypervisor console"
-       depends on PPC
-       select HVC_DRIVER
-       default n
-       help
-         This is meant to be used during HW bring up or debugging when
-	 no other console mechanism exist but udbg, to get you a quick
-	 console for userspace. Do NOT enable in production kernels. 
+	bool "udbg based fake hypervisor console"
+	depends on PPC
+	select HVC_DRIVER
+	default n
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
index 15c2c54..6bcb0cf 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -45,7 +45,7 @@ config SERIAL_8250_DEPRECATED_OPTIONS
 	  keep the 8250_core.* options around until they revert the changes
 	  they already did.
 
-	  If 8250 is built as a module, this adds 8250_core alias instead. 
+	  If 8250 is built as a module, this adds 8250_core alias instead.
 
 	  If you did not notice yet and/or you have userspace from pre-3.7, it
 	  is safe (and recommended) to say N here.
@@ -329,7 +329,7 @@ config SERIAL_8250_BCM2835AUX
 
 	  Features and limitations of the UART are
 	    Registers are similar to 16650 registers,
-              set bits in the control registers that are unsupported
+	      set bits in the control registers that are unsupported
 	      are ignored and read back as 0
 	    7/8 bit operation with 1 start and 1 stop bit
 	    8 symbols deep fifo for rx and tx
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 72966bc..0d5fd72 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -303,26 +303,26 @@ config SERIAL_SAMSUNG_CONSOLE
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
@@ -640,7 +640,7 @@ config SERIAL_MUX
 	    1. create the device entry (mknod /dev/ttyB0 c 11 0)
 	    2. Edit the /etc/inittab to start a getty listening on /dev/ttyB0
 	    3. Add device ttyB0 to /etc/securetty (if you want to log on as
-		 root on this console.)
+	       root on this console.)
 	    4. Change the kernel command console parameter to: console=ttyB0
 
 config SERIAL_MUX_CONSOLE
@@ -654,15 +654,15 @@ config PDC_CONSOLE
 	depends on PARISC && !SERIAL_MUX && VT
 	default n
 	help
-	  Saying Y here will enable the software based PDC console to be 
-	  used as the system console.  This is useful for machines in 
+	  Saying Y here will enable the software based PDC console to be
+	  used as the system console.  This is useful for machines in
 	  which the hardware based console has not been written yet.  The
 	  following steps must be completed to use the PDC console:
 
 	    1. create the device entry (mknod /dev/ttyB0 c 11 0)
 	    2. Edit the /etc/inittab to start a getty listening on /dev/ttyB0
 	    3. Add device ttyB0 to /etc/securetty (if you want to log on as
-		 root on this console.)
+	       root on this console.)
 	    4. Change the kernel command console parameter to: console=ttyB0
 
 config SERIAL_SUNSAB
@@ -850,7 +850,7 @@ config SERIAL_CPM
 	depends on CPM2 || CPM1
 	select SERIAL_CORE
 	help
-	  This driver supports the SCC and SMC serial ports on Motorola 
+	  This driver supports the SCC and SMC serial ports on Motorola
 	  embedded PowerPC that contain a CPM1 (8xx) or CPM2 (8xxx)
 
 config SERIAL_CPM_CONSOLE
@@ -1001,9 +1001,9 @@ config SERIAL_SGI_IOC4
 	depends on (IA64_GENERIC || IA64_SGI_SN2) && SGI_IOC4
 	select SERIAL_CORE
 	help
-		If you have an SGI Altix with an IOC4 based Base IO card
-		and wish to use the serial ports on this card, say Y.
-		Otherwise, say N.
+	  If you have an SGI Altix with an IOC4 based Base IO card
+	  and wish to use the serial ports on this card, say Y.
+	  Otherwise, say N.
 
 config SERIAL_SGI_IOC3
 	tristate "SGI Altix IOC3 serial support"
@@ -1057,8 +1057,8 @@ config SERIAL_NETX
 	  If you have a machine based on a Hilscher NetX SoC you
 	  can enable its onboard serial port by enabling this option.
 
-          To compile this driver as a module, choose M here: the
-          module will be called netx-serial.
+	  To compile this driver as a module, choose M here: the
+	  module will be called netx-serial.
 
 config SERIAL_NETX_CONSOLE
 	bool "Console on NetX serial port"
@@ -1130,48 +1130,48 @@ config SERIAL_SCCNXP_CONSOLE
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
 	select SERIAL_CORE
 	depends on X86_32 || COMPILE_TEST
 	---help---
-	Add support for UART controller on timberdale.
+	  Add support for UART controller on timberdale.
 
 config SERIAL_BCM63XX
 	tristate "Broadcom BCM63xx/BCM33xx UART support"
@@ -1200,14 +1200,14 @@ config SERIAL_GRLIB_GAISLER_APBUART
 	depends on OF && SPARC
 	select SERIAL_CORE
 	---help---
-	Add support for the GRLIB APBUART serial port.
+	  Add support for the GRLIB APBUART serial port.
 
 config SERIAL_GRLIB_GAISLER_APBUART_CONSOLE
 	bool "Console on GRLIB APBUART serial port"
 	depends on SERIAL_GRLIB_GAISLER_APBUART=y
 	select SERIAL_CORE_CONSOLE
 	help
-	Support for running a console on the GRLIB APBUART
+	  Support for running a console on the GRLIB APBUART
 
 config SERIAL_ALTERA_JTAGUART
 	tristate "Altera JTAG UART support"
@@ -1264,7 +1264,7 @@ config SERIAL_ALTERA_UART_CONSOLE
 	  Enable a Altera UART port to be the system console.
 
 config SERIAL_IFX6X60
-        tristate "SPI protocol driver for Infineon 6x60 modem (EXPERIMENTAL)"
+	tristate "SPI protocol driver for Infineon 6x60 modem (EXPERIMENTAL)"
 	depends on GPIOLIB || COMPILE_TEST
 	depends on SPI && HAS_DMA
 	help
-- 
1.9.1

