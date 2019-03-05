Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4675EC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED29D20663
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfCEWyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:54:16 -0500
Received: from sauhun.de ([88.99.104.3]:38416 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbfCEWyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 17:54:16 -0500
Received: from localhost (p54B3334F.dip0.t-ipconnect.de [84.179.51.79])
        by pokefinder.org (Postfix) with ESMTPSA id 40B592E3551;
        Tue,  5 Mar 2019 23:54:12 +0100 (CET)
Date:   Tue, 5 Mar 2019 23:54:11 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 5.1
Message-ID: <20190305225407.GA16211@kunai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

The I2C pull request contains this time:

* the I2C core gained helpers to assist drivers in handling their
  suspended state, and drivers were converted to use it
* two new fault-injectors for stress-testing
* bigger refactoring and feature improvements for the ocores, sh_mobile,
  and tegra drivers
* platform_data removal for the at24 EEPROM driver
* and various improvements and bugfixes all over the subsystem

Please pull.

Thanks,

   Wolfram


The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-5.1

for you to fetch changes up to 93b6604c5a669d84e45fe5129294875bf82eb1ff:

  i2c: Allow recovery of the initial IRQ by an I2C client device. (2019-02-24 14:43:22 +0100)

----------------------------------------------------------------
Andrew Lunn (2):
      i2c: ocores: Add support for IO mapper registers.
      i2c: ocores: Add support for bus clock via platform data

Andy Shevchenko (1):
      i2c: acpi: Move I2C bits from acpi.h to i2c.h

Bartosz Golaszewski (15):
      ARM: davinci: da850-evm: remove dead MTD code
      ARM: davinci: mityomapl138: don't read the MAC address from machine code
      ARM: davinci: dm365-evm: use device properties for at24 eeprom
      ARM: davinci: da830-evm: use device properties for at24 eeprom
      ARM: davinci: dm644x-evm: use device properties for at24 eeprom
      ARM: davinci: dm646x-evm: use device properties for at24 eeprom
      ARM: davinci: sffsdr: fix the at24 eeprom device name
      ARM: davinci: sffsdr: use device properties for at24 eeprom
      ARM: davinci: remove dead code related to MAC address reading
      ARM: davinci: mityomapl138: use nvmem notifiers
      ARM: davinci: mityomapl138: use device properties for at24 eeprom
      Merge branch 'v5.1/eeprom-for-bartosz' of git://git.kernel.org/.../nsekhar/linux-davinci into at24/for-next
      eeprom: at24: remove at24_platform_data
      dt-bindings: at24: add the 'num-addresses' property
      eeprom: at24: implement support for 'num-addresses' property

Chengguang Xu (1):
      i2c: expand minor range when registering chrdev region

Colin Ian King (1):
      i2c: tegra: change phrasing, "fallbacking" to "falling back"

Federico Vaga (5):
      i2c: ocores: stop transfer on timeout
      i2c: ocores: do not handle IRQ if IF is not set
      i2c: ocores: add polling interface
      i2c: ocores: add SPDX tag
      i2c: ocores: checkpatch fixes

Geert Uytterhoeven (1):
      i2c: rcar: Fix clients using i2c from suspend callback

Hans de Goede (1):
      i2c: designware: Do not allow i2c_dw_xfer() calls while suspended

Jae Hyun Yoo (2):
      i2c: aspeed: Remove hard-coded bus timeout value setting
      i2c: aspeed: Add multi-master use case support

Jim Broadus (1):
      i2c: Allow recovery of the initial IRQ by an I2C client device.

John Sperbeck (1):
      i2c: core-smbus: don't trace smbus_reply data on errors

Jonathan Hunter (1):
      i2c: tegra: Only display error messages if DMA setup fails

Linus Walleij (3):
      i2c: Add DT bindings for Xscale I2C masters
      i2c: iop3xx: Add device tree probing
      i2c: cbus-gpio: Switch to use GPIO descriptors

Oleksij Rempel (2):
      i2c: imx: notify about real errors on dma i2c_imx_dma_request
      i2c: imx: improve the error handling in i2c_imx_dma_request()

Sowjanya Komatineni (9):
      i2c: tegra: sort all the include headers alphabetically
      i2c: tegra: add bus clear Master Support
      i2c: tegra: fix maximum transfer size
      i2c: tegra: update maximum transfer size
      i2c: tegra: Add DMA support
      i2c: tegra: update transfer timeout
      i2c: tegra: add i2c interface timing support
      i2c: tegra: remove master fifo support on tegra186
      i2c: tegra: remove multi-master support

Thierry Reding (1):
      i2c: of: Try to find an I2C adapter matching the parent

Wolfram Sang (32):
      i2c: add suspended flag and accessors for i2c adapters
      i2c: synquacer: remove unused is_suspended flag
      i2c: brcmstb: use core helper to mark adapter suspended
      i2c: zx2967: use core helper to mark adapter suspended
      i2c: sprd: don't use pdev as variable name for struct device *
      i2c: sprd: use core helper to mark adapter suspended
      i2c: exynos5: use core helper to mark adapter suspended
      i2c: s3c2410: use core helper to mark adapter suspended
      i2c: rcar: add suspend/resume support
      i2c: sh_mobile: simplify sending address for RX
      i2c: sh_mobile: remove get_data function
      i2c: sh_mobile: drop 'data' argument from i2c_op function
      i2c: sh_mobile: remove is_first_byte function
      i2c: sh_mobile: replace break; with if-block
      i2c: sh_mobile: refactor rx isr
      i2c: sh_mobile: update copyright and comments
      i2c: algo-bit: include main i2c header
      i2c: algo-bit: convert to SPDX header
      i2c: gpio: sort includes
      i2c: gpio: fault-injector: sort debugfs files alphabetically
      i2c: gpio: fault-injector: better SPHINX style in docs
      i2c: rcar: comment maintenance
      i2c: sh_mobile: sort compatible entries
      i2c: sh_mobile: use new clock calculation formulas for Gen3
      i2c: sh_mobile: use new clock calculation formulas for Gen2
      i2c: gpio: merge two very similar comments
      i2c: rcar: refactor TCYC handling
      Merge branch 'i2c/for-current' into i2c/for-5.1
      Merge tag 'at24-5.1-updates-for-wolfram' of git://git.kernel.org/.../brgl/linux into i2c/for-5.1
      i2c: gpio: fault-injector: add 'lose_arbitration' injector
      i2c: gpio: fault-injector: add 'inject_panic' injector
      i2c: ocores: turn incomplete kdoc into a comment

YueHaibing (1):
      i2c: imx: Fix inconsistent IS_ERR and PTR_ERR in i2c_imx_dma_request()

qii wang (3):
      dt-bindings: i2c: Add Mediatek MT7629 i2c binding
      i2c: mediatek: speeds is replaced by macros definitions
      i2c: mediatek: remove completion_done()


with much appreciated quality assurance from
----------------------------------------------------------------
Aaro Koskinen (1):
      (Test) i2c: cbus-gpio: Switch to use GPIO descriptors

Andrew Lunn (6):
      (Rev.) i2c: ocores: turn incomplete kdoc into a comment
      (Rev.) i2c: ocores: checkpatch fixes
      (Rev.) i2c: ocores: add SPDX tag
      (Test) i2c: ocores: add polling interface
      (Rev.) i2c: ocores: do not handle IRQ if IF is not set
      (Rev.) i2c: ocores: stop transfer on timeout

Andy Shevchenko (6):
      (Rev.) i2c: designware: Do not allow i2c_dw_xfer() calls while suspended
      (Rev.) ARM: davinci: sffsdr: use device properties for at24 eeprom
      (Rev.) ARM: davinci: dm646x-evm: use device properties for at24 eeprom
      (Rev.) ARM: davinci: dm644x-evm: use device properties for at24 eeprom
      (Rev.) ARM: davinci: da830-evm: use device properties for at24 eeprom
      (Rev.) ARM: davinci: dm365-evm: use device properties for at24 eeprom

Baolin Wang (2):
      (Rev.) i2c: sprd: use core helper to mark adapter suspended
      (Rev.) i2c: sprd: don't use pdev as variable name for struct device *

Benjamin Tissoires (1):
      (Rev.) i2c: Allow recovery of the initial IRQ by an I2C client device.

Brendan Higgins (2):
      (Rev.) i2c: aspeed: Add multi-master use case support
      (Rev.) i2c: aspeed: Remove hard-coded bus timeout value setting

Charles Keepax (1):
      (Rev.) i2c: Allow recovery of the initial IRQ by an I2C client device.

Dmitry Osipenko (10):
      (Rev.) i2c: tegra: Only display error messages if DMA setup fails
      (Rev.) i2c: tegra: add i2c interface timing support
      (Test) i2c: tegra: add i2c interface timing support
      (Rev.) i2c: tegra: update transfer timeout
      (Rev.) i2c: tegra: Add DMA support
      (Test) i2c: tegra: Add DMA support
      (Rev.) i2c: tegra: update maximum transfer size
      (Rev.) i2c: tegra: fix maximum transfer size
      (Rev.) i2c: tegra: add bus clear Master Support
      (Rev.) i2c: tegra: sort all the include headers alphabetically

Geert Uytterhoeven (10):
      (Rev.) i2c: gpio: merge two very similar comments
      (Rev.) i2c: sh_mobile: use new clock calculation formulas for Gen2
      (Rev.) i2c: sh_mobile: use new clock calculation formulas for Gen3
      (Rev.) i2c: sh_mobile: sort compatible entries
      (Rev.) i2c: sh_mobile: refactor rx isr
      (Rev.) i2c: sh_mobile: replace break; with if-block
      (Rev.) i2c: sh_mobile: remove is_first_byte function
      (Rev.) i2c: sh_mobile: drop 'data' argument from i2c_op function
      (Rev.) i2c: sh_mobile: remove get_data function
      (Rev.) i2c: sh_mobile: simplify sending address for RX

Joel Stanley (1):
      (Rev.) i2c: aspeed: Remove hard-coded bus timeout value setting

Kamal Dasu (1):
      (Rev.) i2c: brcmstb: use core helper to mark adapter suspended

Marek Szyprowski (2):
      (Test) i2c: s3c2410: use core helper to mark adapter suspended
      (Test) i2c: exynos5: use core helper to mark adapter suspended

Nicolas Boichat (1):
      (Rev.) i2c: mediatek: speeds is replaced by macros definitions

Oleksij Rempel (1):
      (Rev.) i2c: imx: Fix inconsistent IS_ERR and PTR_ERR in i2c_imx_dma_request()

Rob Herring (1):
      (Rev.) dt-bindings: i2c: Add Mediatek MT7629 i2c binding

Simon Horman (7):
      (Rev.) i2c: rcar: refactor TCYC handling
      (Rev.) i2c: sh_mobile: use new clock calculation formulas for Gen3
      (Rev.) i2c: sh_mobile: sort compatible entries
      (Rev.) i2c: rcar: comment maintenance
      (Rev.) i2c: gpio: sort includes
      (Rev.) i2c: algo-bit: convert to SPDX header
      (Rev.) i2c: algo-bit: include main i2c header

Steven Rostedt (VMware) (1):
      (Rev.) i2c: core-smbus: don't trace smbus_reply data on errors

Tristan Bastian (1):
      (Test) i2c: of: Try to find an I2C adapter matching the parent

Uwe Kleine-K??nig (1):
      (Rev.) i2c: imx: Fix inconsistent IS_ERR and PTR_ERR in i2c_imx_dma_request()

 Documentation/devicetree/bindings/eeprom/at24.txt  |   3 +
 Documentation/devicetree/bindings/i2c/i2c-mtk.txt  |   1 +
 .../devicetree/bindings/i2c/i2c-xscale.txt         |  20 +
 Documentation/i2c/fault-codes                      |   4 +
 Documentation/i2c/gpio-fault-injection             |  61 +-
 MAINTAINERS                                        |   1 -
 arch/arm/mach-davinci/board-da830-evm.c            |  13 +-
 arch/arm/mach-davinci/board-da850-evm.c            |  28 -
 arch/arm/mach-davinci/board-dm365-evm.c            |  13 +-
 arch/arm/mach-davinci/board-dm644x-evm.c           |  13 +-
 arch/arm/mach-davinci/board-dm646x-evm.c           |  13 +-
 arch/arm/mach-davinci/board-mityomapl138.c         |  38 +-
 arch/arm/mach-davinci/board-sffsdr.c               |  13 +-
 arch/arm/mach-davinci/common.c                     |  15 -
 arch/arm/mach-omap1/board-nokia770.c               |  18 +-
 drivers/i2c/algos/i2c-algo-bit.c                   |  25 +-
 drivers/i2c/busses/i2c-aspeed.c                    | 120 +++-
 drivers/i2c/busses/i2c-brcmstb.c                   |  13 +-
 drivers/i2c/busses/i2c-cbus-gpio.c                 |  80 +--
 drivers/i2c/busses/i2c-designware-core.h           |   2 +
 drivers/i2c/busses/i2c-designware-master.c         |   6 +
 drivers/i2c/busses/i2c-designware-pcidrv.c         |   7 +-
 drivers/i2c/busses/i2c-designware-platdrv.c        |   3 +
 drivers/i2c/busses/i2c-exynos5.c                   |  11 +-
 drivers/i2c/busses/i2c-gpio.c                      | 134 +++-
 drivers/i2c/busses/i2c-imx.c                       |  37 +-
 drivers/i2c/busses/i2c-iop3xx.c                    |   8 +
 drivers/i2c/busses/i2c-mt65xx.c                    |   6 +-
 drivers/i2c/busses/i2c-ocores.c                    | 308 +++++++--
 drivers/i2c/busses/i2c-rcar.c                      |  49 +-
 drivers/i2c/busses/i2c-s3c2410.c                   |   8 +-
 drivers/i2c/busses/i2c-sh_mobile.c                 | 121 ++--
 drivers/i2c/busses/i2c-sprd.c                      |  34 +-
 drivers/i2c/busses/i2c-synquacer.c                 |   5 -
 drivers/i2c/busses/i2c-tegra.c                     | 740 ++++++++++++++++++---
 drivers/i2c/busses/i2c-zx2967.c                    |   8 +-
 drivers/i2c/i2c-core-base.c                        |  12 +-
 drivers/i2c/i2c-core-of.c                          |  14 +-
 drivers/i2c/i2c-core-smbus.c                       |   2 +-
 drivers/i2c/i2c-dev.c                              |   2 +-
 drivers/misc/eeprom/at24.c                         | 169 +++--
 include/linux/acpi.h                               |  11 -
 include/linux/davinci_emac.h                       |   1 -
 include/linux/i2c-algo-bit.h                       |  33 +-
 include/linux/i2c.h                                |  45 ++
 include/linux/platform_data/at24.h                 |  60 --
 include/linux/platform_data/i2c-cbus-gpio.h        |  27 -
 include/linux/platform_data/i2c-ocores.h           |   6 +-
 include/trace/events/smbus.h                       |   6 +-
 49 files changed, 1607 insertions(+), 760 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-xscale.txt
 delete mode 100644 include/linux/platform_data/at24.h
 delete mode 100644 include/linux/platform_data/i2c-cbus-gpio.h

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlx+/goACgkQFA3kzBSg
KbYqHQ/5AZPK8VoQi7QrKx0J2yqpShcBsfGc4UMHaiGMn5cib+3ko4QShQq4NWbW
YdZNFPmwUVbpC1A4U8NV2ZoeQx+Sj6ops1gztQq9Li5nFDyKU3TOxTU6cDEKUX15
Tm6mJ3AoqR7IBAkzhoHGc4OwtWLHs+/J07DCB3VGSYAtLmNjyut5G0py4v8MoFzC
lEDtmC2ZNVr78S4DFqU9zPziby1T8LRyJtkuLI5x4cG3z1B5++t33oDP5mO0CIyp
WlmnvxJQ6dum/07fn7PdLpPw4CdBTRVEermcYgaspwh3mQ/h+EPcqHFct627A9MS
wmRozXPLyLdsdCOyqN1N8VC3+wEKxdd9m+ot3d2Kr8b1s+nWGXat+ceeOrd8ZGd8
lrUTJ7s6wVWCwBb3L6yNUx0MQVN54TCuy9wmFlzCcHTSxvysKPHZb3JuUTuxv+Lr
cpZ3o5Phjd/RFOfm3fSKVdUqJLjtDQ44miFjeUnrN8nmy1a4hvmxStEI7a1Maq+B
lrSTeis2bOfG94D2ttXY0tt1yxcILL+aLT+AFGM2UCCY1lb69l3+IKHnkMJUCtD4
pXCvb3GWd2PJ89rRBKQI6T0wlu2xO7We4O59mTC6q3qFJ3MnlfIOrE0uhXMHgirb
/JcodHG33f5xHpCfEWa/jx0gmEnqfOZVhCvgvp7rm+/py2sHwdI=
=YX6C
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
