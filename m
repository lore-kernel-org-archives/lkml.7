Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8BFC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F7620675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551868493;
	bh=umSn0NNLW3/lH9cgWN/5R+xDce5uaoi1pb+SchcSDYg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Z8KeDan88lhP+PYEcVVxah/Z6oZLXkDRd5+RGrg/d6qM8rFTZfBfPpzlXCH4N88JG
	 /WopuEpTrBC5bJMm8gHdJmmQ6WqC77VYG9TYdwUKAPoxK2XJpEcaVKdiYw6Wk2pJ+Q
	 st6Ko1ODSz2VPhiraDseamjEvuBaFjZEH19//1y0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfCFKev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:34:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:33326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfCFKev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:34:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDBBE20675;
        Wed,  6 Mar 2019 10:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551868489;
        bh=umSn0NNLW3/lH9cgWN/5R+xDce5uaoi1pb+SchcSDYg=;
        h=Date:From:To:Cc:Subject:From;
        b=O1+EsjhLnA7fQdUioI/JSzlEApSGoX7WdwJq3M6Eonr0e+6Ucj2l8YcudhQmCaXfq
         6Y0FaG2zjvKp2dDuogjqGBsTg0SUdwQWgaA+XXdVRX+PTGBiimYsvW35R9JGVfoYB0
         bsz7xpk8UFcAf+eF4VgEY90xCG4XZfI7PzQz6+AA=
Date:   Wed, 6 Mar 2019 11:34:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial patches for 5.1-rc1
Message-ID: <20190306103447.GA10773@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.1-rc1

for you to fetch changes up to f694936c3b5a4c140ded5b673555d95aedc866b9:

  tty: xilinx_uartps: Correct return value in probe (2019-03-01 18:07:34 +0100)

----------------------------------------------------------------
TTY/Serial patches for 5.1-rc1

Here is the "big" patchset for the tty/serial driver layer for 5.1-rc1.

It's really not all that big, nothing major here.

There are a lot of tiny driver fixes and updates, combined with other
cleanups for different serial drivers and the vt layer.  Full details
are in the shortlog.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Shiyan (2):
      serial: clps711x: Remove board support
      serial: max310x: Correction of the initial setting of the MODE1 bits for various supported ICs.

Alexandre Belloni (1):
      tty: serial: lpc32xx_hs: fix missing console boot messages

Andreas Schwab (1):
      tty/serial: use uart_console_write in the RISC-V SBL early console

Anssi Hannula (1):
      serial: uartps: Fix stuck ISR if RX disabled with non-empty FIFO

Atsushi Nemoto (3):
      serial: fsl_lpuart: specify transmit FIFO size for 32-bit variant
      serial: fsl_lpuart: consider TX FIFO too in lpuart32_tx_empty
      serial: fsl_lpuart: DMA support for 32-bit variant

Chengguang Xu (1):
      tty: serial: remove redundant likely annotation

Christoph Hellwig (1):
      tty/synclink: remove ISA support

Geert Uytterhoeven (4):
      serial: sh-sci: Extract sci_dma_rx_chan_invalidate()
      serial: sh-sci: Extract sci_dma_rx_reenable_irq()
      serial: sh-sci: Fix fallback to PIO in sci_dma_rx_complete()
      serial: sh-sci: Make RX/TX DMA function names consistent

Greg Kroah-Hartman (4):
      Merge 5.0-rc2 into tty-next
      Merge 5.0-rc4 into tty-next
      tty: ldisc: add sysctl to prevent autoloading of ldiscs
      Merge 5.0-rc6 into tty-next

Gustavo A. R. Silva (5):
      sc16is7xx: Use struct_size() in devm_kzalloc()
      serial: max310x: Use struct_size() in devm_kzalloc()
      tty/n_hdlc: mark expected switch fall-through
      tty: n_gsm: Mark expected switch fall-throughs
      tty: hvc_xen: Mark expected switch fall-through

Heikki Krogerus (1):
      serial: 8250_pci: Replace custom code with pci_match_id()

Hugo Lefeuvre (1):
      tty/nozomi: use pci_iomap instead of ioremap_nocache

Jay Dolan (2):
      serial: 8250_pci: Fix number of ports for ACCES serial cards
      serial: 8250_pci: Have ACCES cards that use the four port Pericom PI7C9X7954 chip use the pci_pericom_setup()

Jeffrey Hugo (1):
      tty: serial: msm_serial: Remove __init from msm_console_setup()

Johan Hovold (1):
      serdev: ttyport: call tiocmget and tiocmset ops directly

Kangjie Lu (1):
      serial: max310x: pass return value of spi_register_driver

Lanqing Liu (1):
      serial: sprd: Modify the baud rate calculation formula

Linus Walleij (1):
      serial: 8250: Add OF support for Xscale variant

Loys Ollivier (1):
      tty: serial: meson: if no alias specified use an available id

Lubomir Rintel (2):
      serial: 8250_pxa: honor the port number from devicetree
      serial: 8250_of: assume reg-shift of 2 for mrvl,mmp-uart

Manfred Schlaegl (1):
      tty: increase the default flip buffer limit to 2*640K

Martin Hostettler (4):
      vt: refactor vc_ques to allow of other private sequences.
      vt: Implement parsing for >, =, < private sequences.
      vt: ignore csi sequences with intermediate characters.
      vt: ignore sequences that contain ':' in parameters.

Mathieu Malaterre (1):
      vt: annotate implicit fall throughs

Mikko Perttunen (1):
      dt-bindings: serial: Add bindings for nvidia,tegra194-tcu

Nathan Chancellor (1):
      serial: mps2-uart: Add parentheses around conditional in mps2_uart_shutdown

Nicolas Pitre (5):
      vcsa: clamp header values when they don't fit
      vcs: poll(): cope with a deallocated vt
      vcs: fasync(): make it consistent with poll()
      vcs: restore and document initial POLLPRI event
      vt: perform safe console erase in the right order

Petr Mladek (2):
      sysrq: Restore original console_loglevel when sysrq disabled
      sysrq: Remove duplicated sysrq message

Rajan Vaja (1):
      tty: xilinx_uartps: Correct return value in probe

Rob Herring (3):
      dt-bindings: serial: Convert snps,dw-apb-uart to json-schema
      dt-bindings: serial: Move renesas,rzn1-uart into the snps-dw-apb-uart binding
      dt-bindings: serial: Convert arm,pl011 to json-schema

Ryan Case (4):
      tty: serial: qcom_geni_serial: Remove use of *_relaxed() and mb()
      tty: serial: qcom_geni_serial: Remove set_rfr_wm() and related variables
      tty: serial: qcom_geni_serial: Remove xfer_mode variable
      tty: serial: qcom_geni_serial: Use u32 for register variables

Stuart Menefy (1):
      tty: serial: samsung: Enable baud clock during initialisation

Sugaya Taichi (1):
      dt-bindings: serial: Add Milbeaut serial driver description

Thierry Reding (1):
      serial: Add Tegra Combined UART driver

Tony Lindgren (2):
      tty: n_gsm: Add copy_config() and gsm_config() to prepare for serdev
      n_gsm: Constify u8 and unsigned char usage

Ulrich Hecht (1):
      dt-bindings: serial: sh-sci: Document r8a7778/9 HSCIF bindings

Valentin Vidic (1):
      n_tty: update comment for WAKEUP_CHARS define

Vignesh R (3):
      serial: 8250_omap: Drop check for of_node
      dt-bindings: serial: omap_serial: add clocks entry
      serial: 8250_omap: Use clk_get_rate() to obtain fclk frequency

Vladimir Murzin (2):
      serial: mps2-uart: move to dynamic port allocation
      serial: mps2-uart: support combined irq

YueHaibing (1):
      tty: ipwireless: Fix potential NULL pointer dereference

Zhou Yanjie (2):
      Serial: Ingenic: Add support for the X1000.
      Dt-bindings: Serial: Add X1000 serial bindings.

 Documentation/devicetree/bindings/serial/8250.txt  |   1 +
 .../devicetree/bindings/serial/ingenic,uart.txt    |   3 +-
 .../devicetree/bindings/serial/milbeaut-uart.txt   |  21 ++
 .../bindings/serial/nvidia,tegra194-tcu.txt        |  35 +++
 .../devicetree/bindings/serial/omap_serial.txt     |   2 +
 Documentation/devicetree/bindings/serial/pl011.txt |  51 ----
 .../devicetree/bindings/serial/pl011.yaml          | 126 +++++++++
 .../bindings/serial/renesas,rzn1-uart.txt          |  10 -
 .../bindings/serial/renesas,sci-serial.txt         |   2 +
 .../bindings/serial/snps-dw-apb-uart.txt           |  76 ------
 .../bindings/serial/snps-dw-apb-uart.yaml          | 140 ++++++++++
 drivers/tty/Kconfig                                |  24 ++
 drivers/tty/hvc/hvc_xen.c                          |   2 +-
 drivers/tty/ipwireless/hardware.c                  |   2 +
 drivers/tty/n_gsm.c                                | 246 ++++++++---------
 drivers/tty/n_hdlc.c                               |   2 +-
 drivers/tty/n_tty.c                                |   6 +-
 drivers/tty/nozomi.c                               |  10 +-
 drivers/tty/serdev/serdev-ttyport.c                |   4 +-
 drivers/tty/serial/8250/8250_ingenic.c             |  13 +-
 drivers/tty/serial/8250/8250_of.c                  |   5 +
 drivers/tty/serial/8250/8250_omap.c                |  75 +++---
 drivers/tty/serial/8250/8250_pci.c                 | 170 +++++++++---
 drivers/tty/serial/8250/8250_pxa.c                 |   4 +
 drivers/tty/serial/Kconfig                         |  22 ++
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/clps711x.c                      |  23 +-
 drivers/tty/serial/fsl_lpuart.c                    | 208 +++++++++++---
 drivers/tty/serial/lpc32xx_hs.c                    |   4 +
 drivers/tty/serial/max310x.c                       |  21 +-
 drivers/tty/serial/meson_uart.c                    |  13 +-
 drivers/tty/serial/mps2-uart.c                     | 138 +++++++---
 drivers/tty/serial/msm_serial.c                    |   2 +-
 drivers/tty/serial/qcom_geni_serial.c              | 279 ++++++++-----------
 drivers/tty/serial/samsung.c                       |  42 +++
 drivers/tty/serial/sc16is7xx.c                     |   4 +-
 drivers/tty/serial/serial_core.c                   |   2 +-
 drivers/tty/serial/sh-sci.c                        |  71 +++--
 drivers/tty/serial/sprd_serial.c                   |   2 +-
 drivers/tty/serial/tegra-tcu.c                     | 298 +++++++++++++++++++++
 drivers/tty/serial/xilinx_uartps.c                 |  40 ++-
 drivers/tty/synclink.c                             |  54 ----
 drivers/tty/sysrq.c                                |   8 +-
 drivers/tty/tty_buffer.c                           |   2 +-
 drivers/tty/tty_io.c                               |   3 +
 drivers/tty/tty_ldisc.c                            |  47 ++++
 drivers/tty/vt/vc_screen.c                         |  48 +++-
 drivers/tty/vt/vt.c                                |  77 ++++--
 include/linux/console_struct.h                     |   2 +-
 include/uapi/linux/serial_core.h                   |   3 +
 50 files changed, 1672 insertions(+), 772 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
 delete mode 100644 Documentation/devicetree/bindings/serial/pl011.txt
 create mode 100644 Documentation/devicetree/bindings/serial/pl011.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/renesas,rzn1-uart.txt
 delete mode 100644 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
 create mode 100644 drivers/tty/serial/tegra-tcu.c
