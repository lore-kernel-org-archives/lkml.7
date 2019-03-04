Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87948C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F299206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551719266;
	bh=2oHD1TxuPOFFqUwSOdSixoH/ONIChPg4Uh2vDODD1To=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ZgMc+T/BdVXWIgLRUzZEOtaZq6Mq6Rb4Ij0ImyyaVteNJamAIxQbKTnXBvrvmGv2I
	 rcVaOkYzvmVrDko/LJxJhkYivFz6NcM7usnhI2GGheq75gfVoUQ5TPrkJ//eq5Omux
	 WKaiBVi7yjhcNjaGRTYM4dRH1gFLPA9JX9gkmmPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfCDRHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:07:44 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45800 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfCDRHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vwNv1dYFCFvZXIDFjNkgIQ/XXfWPpYQUHtHKzq/C2ZQ=; b=WpefFS3oL3tbo8QDO5y/XjGQP
        zl4krtFdjS30gGc2Ue2R7LYNb5bAQJJZ4Qht9SjO6/AN+6TlHC+jrLMXr8sLMT1zA5+c02owVl60r
        XIU4sNebdc1qI9Jzjk5vp8K3bwExTiGeiDny+RPzSrw2y0xcAf00/U+ysiwifVyus6d+Q=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h0r40-0003EF-E5; Mon, 04 Mar 2019 17:07:40 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C02AD1128814; Mon,  4 Mar 2019 17:07:34 +0000 (GMT)
Date:   Mon, 4 Mar 2019 17:07:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [GIT PULL] SPI updates for v5.1
Message-ID: <20190304170734.GC8877@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline
X-Cookie: Do, or do not
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 1c163f4c7b3f621efff9b28a47abb36f7378d783:

  Linux 5.0 (2019-03-03 15:21:29 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-=
v5.1

for you to fetch changes up to 14dbfb417bd80c96ec700c7a8414bb6f5db7ecd2:

  Merge branch 'spi-5.1' into spi-next (2019-03-04 15:32:51 +0000)

----------------------------------------------------------------
spi: Updates for v5.1

A fairly quiet release for SPI, the biggest thing is the conversion to
use GPIO descriptors which is now 90% done but still needs some
stragglers converting.

 - Support for inter-word delays.
 - Conversion of the core and most drivers to use GPIO descriptors for
   GPIO controlled chip selects.
 - New drivers for NXP FlexSPI and QuadSPI, SiFive and Spreadtrum.

----------------------------------------------------------------
Alban Bedel (4):
      spi: bitbang: Don't call chipselect() in spi_bitbang_setup()
      spi: ath79: Simplify ath79_spi_chipselect()
      spi: ath79: Enable support for compile test
      spi: ath79: Remove now useless code

Anders Roxell (1):
      spi: dw: fix warning unused variable 'ret'

Andy Shevchenko (1):
      spi: pxa2xx: Setup maximum supported DMA transfer length

Angelo Dureghello (2):
      spi: fix initial SPI_SR value in spi-fsl-dspi
      spi: add cpu details to fsl-dspi Kconfig help

Axel Lin (1):
      spi: npcm-pspi: Fix wrong priv pointer

Baolin Wang (1):
      spi: sprd: Add a prefix for SPI DMA channel macros

Boris Brezillon (3):
      spi: spi-mem: Fix spi_mem_dirmap_destroy() kerneldoc
      spi: spi-mem: Fix a memory leak in spi_mem_dirmap_destroy()
      spi: spi-mem: Add devm_spi_mem_dirmap_{create,destroy}()

Cezary Gapinski (13):
      spi: stm32: switch to SPDX identifier
      spi: stm32: use NULL pointer instead of plain integer
      spi: stm32: fix DMA configuration with only one channel
      spi: fix typo in SPI_STM32 help text
      spi: stm32: use explicit CPOL and CPHA mode bits
      spi: stm32: remove SPI LOOP mode
      spi: stm32: rename STM32 SPI registers to STM32H7
      spi: stm32: rename interrupt function
      spi: stm32: split transfer one setup function
      spi: stm32: add start dma transfer function
      spi: stm32: introduce compatible data cfg
      spi: stm32: add support for STM32F4
      spi: stm32: add description about STM32F4 bindings

Charles Keepax (1):
      spi: cadence: Correct initialisation of runtime PM

Clark Wang (3):
      spi: lpspi: Improve the stability of lpspi data transmission
      spi: lpspi: Fix wrong transmission when don't use CONT
      spi: lpspi: Fix CLK pin becomes low before one transfer

Fabio Estevam (2):
      spi: Kconfig: imx: Update the help text to make it more generic
      dt-bindings: spi: imx: Add an entry for the i.MX8QM compatible

Felix Fietkau (1):
      spi: use gpio[d]_set_value_cansleep for setting chipselect GPIO

Frieder Schrempf (5):
      spi: Add a driver for the Freescale/NXP QuadSPI controller
      dt-bindings: spi: Move the bindings for the FSL QSPI driver
      dt-bindings: spi: Adjust the bindings for the FSL QSPI driver
      mtd: fsl-quadspi: Remove the driver as it was replaced by spi-fsl-qsp=
i.c
      MAINTAINERS: Move the Freescale QSPI driver to the SPI framework

Geert Uytterhoeven (5):
      spi: sh-hspi: Remove error messages on out-of-memory conditions
      spi: rspi: Replace spi_master by spi_controller
      spi: sh-hspi: Replace spi_master by spi_controller
      spi: sh-msiof: Replace spi_master by spi_controller
      spi: sh-msiof: Restrict bits per word to 8/16/24/32 on R-Car Gen2/3

Hoan Nguyen An (2):
      spi: sh-msiof: fix *info pointer in request_dma()
      spi: sh-msiof: Use DMA if possible

Jiwei Sun (1):
      spi: pl022: add a message state STATE_TIMEOUT for timeout transfer

Jonas Bonn (2):
      spi: support inter-word delay requirement for devices
      spi-atmel: support inter-word delay

Jonathan Neusch=E4fer (1):
      spi: gpio: Advertise support for SPI_CS_HIGH

Lanqing Liu (4):
      spi: sprd: Fix the error data length in SPI read-only mode
      spi: sprd: Add the SPI irq function for the SPI DMA mode
      dt-bindings: spi: Add the DMA properties for the SPI dma mode
      spi: sprd: spi: sprd: Add DMA mode support

Linus Walleij (12):
      spi: Optionally use GPIO descriptors for CS GPIOs
      spi: ath79: Convert to use CS GPIO descriptors
      spi: atmel: Convert to use CS GPIO descriptors
      spi: cadence: Convert to use CS GPIO descriptors
      spi: clps711x: Convert to use CS GPIO descriptors
      spi: davinci: Convert to use CS GPIO descriptors
      spi: dw: Convert to use CS GPIO descriptors
      spi: davinci: Get rid of dangling variable
      spi: Support high CS when using descriptors
      spi: dw: Fix default polarity of native chipselect
      spi: cadence: Fix default polarity of native chipselect
      gpio: of: Fix logic inversion

Lubomir Rintel (1):
      pxa2xx: replace spi_master with spi_controller

Lukasz Majewski (1):
      spi: spi-fsl-dspi: Provide support for DSPI slave mode operation (Vyb=
ryd vf610)

Mark Brown (5):
      Merge branch 'spi-4.21' into spi-5.0
      spi: Go back to immediate teardown
      Merge branch 'for-5.0' of https://git.kernel.org/.../broonie/spi into=
 spi-5.1
      Merge branch 'spi-5.0' into spi-linus
      Merge branch 'spi-5.1' into spi-next

Martin Sperl (1):
      spi: core: avoid waking pump thread from spi_sync instead run teardow=
n delayed

Russell King (1):
      spi: spi-gpio: fix SPI_CS_HIGH capability

Silvio Cesare (1):
      spi: dw: change snprintf to scnprintf for possible overflow

Stephen Boyd (2):
      spi: spi-geni-qcom: Don't initialize completion for normal message
      spi: spi-geni-qcom: Get rid of forward declaration

Tudor Ambarus (13):
      spi: atmel-quadspi: cache MR value to avoid a write access
      spi: atmel-quadspi: order header files inclusion alphabetically
      spi: atmel-quadspi: drop wrappers for iomem accesses
      spi: atmel-quadspi: fix naming scheme
      spi: atmel-quadspi: remove unnecessary cast
      spi: atmel-quadspi: return appropriate error code
      spi: atmel-quadspi: switch to SPDX license identifiers
      spi: atmel-quadspi: rework transfer macros
      dt-bindings: spi: atmel-quadspi: update example to new clock binding
      dt-bindings: spi: atmel-quadspi: make "pclk" mandatory
      spi: atmel-quadspi: add support for named peripheral clock
      dt-bindings: spi: atmel-quadspi: QuadSPI driver for Microchip SAM9X60
      spi: atmel-quadspi: add support for sam9x60 qspi controller

Uwe Kleine-K=F6nig (3):
      spi/trace: drop useless and wrong (but harmless) casts
      spi/trace: include buffer contents in traces
      spi: mxs: add tracing to custom .transfer_one_message callback

Vignesh R (2):
      spi: omap2-mcspi: Fix DMA and FIFO event trigger size mismatch
      spi: ti-qspi: Fix mmap read when more than one CS in use

Wei Yongjun (2):
      spi: sifive: Remove spi_master_put in sifive_spi_remove()
      spi: sifive: Remove redundant dev_err call in sifive_spi_probe()

Yash Shah (2):
      spi: sifive: Add DT documentation for SiFive SPI controller
      spi: sifive: Add driver for the SiFive SPI controller

Yogesh Narayan Gaur (6):
      spi: spi-mem: Add driver for NXP FlexSPI controller
      dt-bindings: spi: add binding file for NXP FlexSPI controller
      MAINTAINERS: add maintainers for the NXP FlexSPI driver
      spi: nxp-fspi: add octal mode flag bit for octal support
      spi: spi-mem: spi-nxp-fspi: add module license info
      spi: spi-mem: spi-fsl-qspi: typo fix in author name

YueHaibing (2):
      spi: bcm2835aux: remove unneeded NULL check of devm_clk_get
      spi/topcliff_pch: Fix potential NULL dereference on allocation error

shaftarger (1):
      spi: dw: fix potential variable assignment error

 .../devicetree/bindings/spi/atmel-quadspi.txt      |   12 +-
 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |    1 +
 .../{mtd/fsl-quadspi.txt =3D> spi/spi-fsl-qspi.txt}  |   18 +-
 .../devicetree/bindings/spi/spi-nxp-fspi.txt       |   39 +
 .../devicetree/bindings/spi/spi-sifive.txt         |   37 +
 Documentation/devicetree/bindings/spi/spi-sprd.txt |    7 +
 .../devicetree/bindings/spi/spi-stm32.txt          |    9 +-
 Documentation/spi/pxa2xx                           |   10 +-
 MAINTAINERS                                        |   12 +-
 arch/arm/mach-pxa/cm-x255.c                        |    2 +-
 arch/arm/mach-pxa/cm-x270.c                        |    2 +-
 arch/arm/mach-pxa/corgi.c                          |    2 +-
 arch/arm/mach-pxa/devices.c                        |    2 +-
 arch/arm/mach-pxa/em-x270.c                        |    4 +-
 arch/arm/mach-pxa/hx4700.c                         |    2 +-
 arch/arm/mach-pxa/icontrol.c                       |    4 +-
 arch/arm/mach-pxa/littleton.c                      |    2 +-
 arch/arm/mach-pxa/lubbock.c                        |    2 +-
 arch/arm/mach-pxa/magician.c                       |    2 +-
 arch/arm/mach-pxa/pcm027.c                         |    2 +-
 arch/arm/mach-pxa/poodle.c                         |    2 +-
 arch/arm/mach-pxa/spitz.c                          |    2 +-
 arch/arm/mach-pxa/stargate2.c                      |    6 +-
 arch/arm/mach-pxa/tosa.c                           |    2 +-
 arch/arm/mach-pxa/z2.c                             |    4 +-
 arch/arm/mach-pxa/zeus.c                           |    2 +-
 arch/mips/ath79/dev-spi.h                          |    2 +-
 drivers/gpio/gpiolib-of.c                          |    2 +-
 drivers/mtd/spi-nor/Kconfig                        |    9 -
 drivers/mtd/spi-nor/Makefile                       |    1 -
 drivers/mtd/spi-nor/fsl-quadspi.c                  | 1224 -----------------
 drivers/spi/Kconfig                                |   36 +-
 drivers/spi/Makefile                               |    3 +
 drivers/spi/atmel-quadspi.c                        |  270 ++--
 drivers/spi/spi-ath79.c                            |  114 +-
 drivers/spi/spi-atmel.c                            |  102 +-
 drivers/spi/spi-bcm2835aux.c                       |    2 +-
 drivers/spi/spi-bitbang.c                          |   13 -
 drivers/spi/spi-cadence.c                          |   84 +-
 drivers/spi/spi-clps711x.c                         |   23 +-
 drivers/spi/spi-davinci.c                          |   54 +-
 drivers/spi/spi-dw-mmio.c                          |   22 -
 drivers/spi/spi-dw.c                               |   54 +-
 drivers/spi/spi-fsl-dspi.c                         |   42 +-
 drivers/spi/spi-fsl-lpspi.c                        |   92 +-
 drivers/spi/spi-fsl-qspi.c                         |  966 ++++++++++++++
 drivers/spi/spi-geni-qcom.c                        |   56 +-
 drivers/spi/spi-gpio.c                             |    4 +-
 drivers/spi/spi-mem.c                              |   72 +-
 drivers/spi/spi-mxs.c                              |    5 +
 drivers/spi/spi-npcm-pspi.c                        |    3 +-
 drivers/spi/spi-nxp-fspi.c                         | 1106 +++++++++++++++
 drivers/spi/spi-omap2-mcspi.c                      |    4 +-
 drivers/spi/spi-pl022.c                            |   30 +-
 drivers/spi/spi-pxa2xx-dma.c                       |   58 +-
 drivers/spi/spi-pxa2xx-pci.c                       |    4 +-
 drivers/spi/spi-pxa2xx.c                           |  157 +--
 drivers/spi/spi-pxa2xx.h                           |    4 +-
 drivers/spi/spi-rspi.c                             |  170 +--
 drivers/spi/spi-sh-hspi.c                          |   39 +-
 drivers/spi/spi-sh-msiof.c                         |  184 +--
 drivers/spi/spi-sifive.c                           |  448 +++++++
 drivers/spi/spi-sprd.c                             |  354 ++++-
 drivers/spi/spi-stm32.c                            | 1403 +++++++++++++++-=
----
 drivers/spi/spi-ti-qspi.c                          |    6 +-
 drivers/spi/spi-topcliff-pch.c                     |    6 +
 drivers/spi/spi.c                                  |  115 +-
 .../linux/platform_data/spi-ath79.h                |    0
 include/linux/spi/pxa2xx_spi.h                     |    4 +-
 include/linux/spi/spi-mem.h                        |    5 +
 include/linux/spi/spi.h                            |   29 +-
 include/trace/events/spi.h                         |   31 +-
 72 files changed, 5094 insertions(+), 2507 deletions(-)
 rename Documentation/devicetree/bindings/{mtd/fsl-quadspi.txt =3D> spi/spi=
-fsl-qspi.txt} (73%)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sifive.txt
 delete mode 100644 drivers/mtd/spi-nor/fsl-quadspi.c
 create mode 100644 drivers/spi/spi-fsl-qspi.c
 create mode 100644 drivers/spi/spi-nxp-fspi.c
 create mode 100644 drivers/spi/spi-sifive.c
 rename arch/mips/include/asm/mach-ath79/ath79_spi_platform.h =3D> include/=
linux/platform_data/spi-ath79.h (100%)

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx9W1UACgkQJNaLcl1U
h9AsnAf+LC8G4Lr9eODQJo6wS18pGKKcfng/0E0n+hfSscx8wW5YPbhftaYQv0YY
lAbJIKai5ybRjC/OQTAOqRXLI0Xe4oBAVLuUL79UmKnNFXSacg6HffNf8Ev5SQlt
0dC0MxOEZ2BPXAYLaIq+ZTx/1b5BHnsmA5QFY8uRB6uUHe/g8kNODk/LYZw/As1J
XkAmoawNX8FGGBcXJk6MUROrhc/9dNxqPvni/bUYgbnI+20k+U8iXr8rdnopZwzp
spWQ79X8zdJY7AkidHopSMiKWmJvdljPYb5+3rTliotW6m4/UBB2Ji0BwiupMY0f
JeDHw6jqw/oZNG/vfY7V0OL4kGlGbQ==
=/50M
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
