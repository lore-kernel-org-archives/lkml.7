Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB74BC74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D1820844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562791818;
	bh=TyY2GTRl0SRc/N3vL/VGCXKc7Zo1ZjKqA+jq9ab2Qms=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=WYLUKWc1V7d+ulbh5UpNUKWPTULsbdzS9MZiQYOoAsB27Yfal90DYkHLdDqqYc+Ij
	 pp17H4QSczeDt6AdLY/zK8yqdXBVtbDbbUWLnKhIFmMPx1dI470VH18tKDxafbWtPF
	 5tljBWSM1JckQs+0HfJ0b849MpLY6JFyivoQ9FOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfGJUuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 16:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfGJUuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 16:50:17 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91BB821019;
        Wed, 10 Jul 2019 20:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562791814;
        bh=TyY2GTRl0SRc/N3vL/VGCXKc7Zo1ZjKqA+jq9ab2Qms=;
        h=From:Date:Subject:To:Cc:From;
        b=I4iGN8uBan09GuOsLvByQYhebLDBuIV/NooP6mG86NIwbXnallIyxu9atQ7CeaGk5
         okNLScyWB3TzZarJgp7hvEBZDNd96r62U291cdezJQo0Vfd2e9swz4PGzSGZS8Y5e1
         M6bbGZtYab2LOcTnzhaJQOpWFdW/1E8Cpub+pnP4=
Received: by mail-qt1-f173.google.com with SMTP id h24so4046128qto.0;
        Wed, 10 Jul 2019 13:50:14 -0700 (PDT)
X-Gm-Message-State: APjAAAWzj+uUuWffQF8Spoj84pvHtx9f/jFIrsvWEA7tvQR0F8+InR4I
        Z68H4/s2ERgDSAUvFJowVp/GSJH3BqLEgeQI+Q==
X-Google-Smtp-Source: APXvYqyAeCkhKhL7oXL7MjXoOf3GJZ+E5YrdvjuEoJM0RC+3kdFJoXcJByqC6ZfKjlIKlr/VOoVBbGTM8H9FrLj6azE=
X-Received: by 2002:a0c:b786:: with SMTP id l6mr26676423qve.148.1562791813740;
 Wed, 10 Jul 2019 13:50:13 -0700 (PDT)
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 10 Jul 2019 14:50:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJAydO3Zjx_9S+r8h5YAQbDBJjqHSFV-aKkN9n=MH7erg@mail.gmail.com>
Message-ID: <CAL_JsqJAydO3Zjx_9S+r8h5YAQbDBJjqHSFV-aKkN9n=MH7erg@mail.gmail.com>
Subject: [GIT PULL] Devicetree updates for 5.3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull. There's 2 conflicts. The first is with your tree and SPDX
tags in scripts/dtc/. The correct resolution is to take the version
from my tree as that has the correct licenses from upstream dtc. The
2nd conflict is with the netdev tree. It's fine to just delete
ethernet.txt. The necessary changes are already in the new schema
file.

Rob

The following changes since commit 852d095d16a6298834839f441593f59d58a31978=
:

  checkpatch.pl: Update DT vendor prefix check (2019-05-22 14:54:49 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/devicetree-for-5.3

for you to fetch changes up to f59d261180f3b66367962f1974090815ce710056:

  dt-bindings: vendor-prefixes: add Sipeed (2019-07-09 16:57:41 -0600)

----------------------------------------------------------------
Devicetree updates for v5.3:

- DT binding schema examples are now validated against the schemas.
  Various examples are fixed due to that.

- Sync dtc with upstream version v1.5.0-30-g702c1b6c0e73

- Initial schemas for networking bindings. This includes ethernet, phy
  and mdio common bindings with several Allwinner and stmmac converted
  to the schema.

- Conversion of more Arm top-level SoC/board bindings to DT schema

- Conversion of PSCI binding to DT schema

- Rework Arm CPU schema to coexist with other CPU schemas

- Add a bunch of missing vendor prefixes and new ones for SoChip,
  Sipeed, Kontron, B&R Industrial Automation GmbH, and Espressif

- Add Mediatek UART RX wakeup support to binding

- Add reset to ST UART binding

- Remove some Linuxisms from the endianness common-properties.txt
  binding

- Make the flattened DT read-only after init

- Ignore disabled reserved memory nodes

- Clean-up some dead code in FDT functions

----------------------------------------------------------------
Amit Kucheria (1):
      Documentation: arm: Link idle-states binding to "enable-method" prope=
rty

Brian Masney (1):
      dt-bindings: backlight: lm3630a: correct schema validation

Claire Chang (1):
      dt-bindings: serial: add documentation for Rx in-band wakeup support

Erwan Le Ray (1):
      dt-bindings: stm32: serial: Add optional reset

Geert Uytterhoeven (3):
      dt-bindings: property-units: Sanitize unit naming
      dt-bindings: Add missing newline at end of file
      of/platform: Drop superfluous cast in of_device_make_bus_id()

Hannes Schmelzer (1):
      Documentation: devicetree: Add vendor prefix for B&R Industrial
Automation GmbH

Icenowy Zheng (2):
      dt-bindings: vendor-prefixes: add SoChip
      dt-bindings: vendor-prefixes: add Sipeed

Kefeng Wang (2):
      of/fdt: Fix =E2=80=98of_fdt_match=E2=80=99 defined but not used compi=
ler warning
      dt-bindings: 83xx-512x-pci: Drop cell-index property

Krishna Reddy (1):
      of: reserved-memory: ignore disabled memory-region nodes

Marco Felsch (1):
      dt-bindings: add Kontron vendor prefix

Masahiro Yamada (1):
      of/fdt: pass early_init_dt_reserve_memory_arch() with bool type nomap

Maxime Ripard (22):
      dt-bindings: Add vendor prefix for Espressif
      dt-bindings: vendor: Escape single quote
      dt-bindings: vendor: Fix simtek vendor compatible
      dt-bindings: vendor: Add a bunch of vendors
      dt-bindings: net: Add YAML schemas for the generic Ethernet options
      dt-bindings: net: Add a YAML schemas for the generic PHY options
      dt-bindings: net: Add a YAML schemas for the generic MDIO options
      MAINTAINERS: Add Ethernet PHY YAML file
      dt-bindings: net: phy: The interrupt property is not mandatory
      dt-bindings: net: sun4i-emac: Convert the binding to a schemas
      dt-bindings: net: sun4i-mdio: Convert the binding to a schemas
      dt-bindings: net: stmmac: Convert the binding to a schemas
      dt-bindings: net: sun7i-gmac: Convert the binding to a schemas
      dt-bindings: net: sun8i-emac: Convert the binding to a schemas
      dt-bindings: net: dwmac: Deprecate the PHY reset properties
      dt-bindings: net: mdio: Add a nodename pattern
      dt-bindings: net: mdio: Add address and size cells
      dt-bindings: net: mdio: Add child nodes
      dt-bindings: display: Fix simple-framebuffer example
      dt-bindings: simple-framebuffer: Add requirement for pipelines
      dt-bindings: net: Use phy-mode instead of phy-connection-type
      dt-bindings: usb: ehci: Fix example warnings

Rob Herring (15):
      scripts/dtc: Update to upstream version v1.5.0-23-g87963ee20693
      dt-bindings: vendor-prefixes: Also allow node names starting with '_'
      dt-bindings: Check the examples against the schemas
      scripts/dtc: Update to upstream version v1.5.0-30-g702c1b6c0e73
      dt-bindings: arm: Convert Alpine board/soc bindings to json-schema
      dt-bindings: arm: qcom: Add missing schema for MSM8974
      dt-bindings: arm: qcom: Add missing schema for IPQ4019 boards
      dt-bindings: arm: Convert Axxia board/soc bindings to json-schema
      dt-bindings: arm: Convert MOXA ART board/soc bindings to json-schema
      dt-bindings: arm: Convert NXP LPC32xx board/soc bindings to json-sche=
ma
      dt-bindings: arm: Convert Conexant Digicolor board/soc bindings
to json-schema
      dt-bindings: arm: Convert PSCI binding to json-schema
      dt-bindings: arm: Limit cpus schema to only check Arm 'cpu' nodes
      dt-bindings: mtd: sunxi-nand: Drop 'maxItems' from child 'reg' proper=
ty
      dt-bindings: arm: Convert RDA Micro board/soc bindings to json-schema

Stephen Boyd (3):
      dt-bindings: Remove Linuxisms from common-properties binding
      of/fdt: Remove dead code and mark functions with __init
      of/fdt: Mark initial_boot_params as __ro_after_init

Wolfram Sang (1):
      of: unittest: simplify getting the adapter of a client

 Documentation/arm64/booting.txt                    |   2 +-
 Documentation/devicetree/bindings/Makefile         |   2 +-
 .../devicetree/bindings/arm/al,alpine.txt          |  16 -
 .../devicetree/bindings/arm/al,alpine.yaml         |  21 +
 Documentation/devicetree/bindings/arm/arm-boards   |   2 +-
 Documentation/devicetree/bindings/arm/axxia.txt    |  12 -
 Documentation/devicetree/bindings/arm/axxia.yaml   |  19 +
 Documentation/devicetree/bindings/arm/cpus.yaml    | 487 ++++++++++-------=
----
 .../devicetree/bindings/arm/digicolor.txt          |   6 -
 .../devicetree/bindings/arm/digicolor.yaml         |  16 +
 .../devicetree/bindings/arm/idle-states.txt        |  15 +-
 Documentation/devicetree/bindings/arm/moxart.txt   |  12 -
 Documentation/devicetree/bindings/arm/moxart.yaml  |  19 +
 .../devicetree/bindings/arm/nxp/lpc32xx.txt        |   8 -
 .../devicetree/bindings/arm/nxp/lpc32xx.yaml       |  25 ++
 Documentation/devicetree/bindings/arm/psci.txt     | 111 -----
 Documentation/devicetree/bindings/arm/psci.yaml    | 163 +++++++
 Documentation/devicetree/bindings/arm/qcom.yaml    |  14 +
 Documentation/devicetree/bindings/arm/rda.txt      |  17 -
 Documentation/devicetree/bindings/arm/rda.yaml     |  20 +
 .../devicetree/bindings/common-properties.txt      |  17 +-
 .../bindings/display/simple-framebuffer.yaml       |  25 +-
 .../devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt   |   2 +-
 .../bindings/leds/backlight/lm3630a-backlight.yaml |  21 +-
 .../bindings/mtd/allwinner,sun4i-a10-nand.yaml     |   1 -
 .../bindings/net/allwinner,sun4i-a10-emac.yaml     |  56 +++
 .../bindings/net/allwinner,sun4i-a10-mdio.yaml     |  70 +++
 .../bindings/net/allwinner,sun4i-emac.txt          |  19 -
 .../bindings/net/allwinner,sun4i-mdio.txt          |  27 --
 .../bindings/net/allwinner,sun7i-a20-gmac.txt      |  27 --
 .../bindings/net/allwinner,sun7i-a20-gmac.yaml     |  65 +++
 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    | 321 ++++++++++++++
 .../devicetree/bindings/net/dwmac-sun8i.txt        | 201 ---------
 .../bindings/net/ethernet-controller.yaml          | 206 +++++++++
 .../devicetree/bindings/net/ethernet-phy.yaml      | 177 ++++++++
 Documentation/devicetree/bindings/net/ethernet.txt |  68 +--
 .../devicetree/bindings/net/fixed-link.txt         |  55 +--
 Documentation/devicetree/bindings/net/mdio.txt     |  38 +-
 Documentation/devicetree/bindings/net/mdio.yaml    |  74 ++++
 Documentation/devicetree/bindings/net/phy.txt      |  80 +---
 .../devicetree/bindings/net/snps,dwmac.yaml        | 411 +++++++++++++++++
 Documentation/devicetree/bindings/net/stmmac.txt   | 179 +-------
 .../devicetree/bindings/pci/83xx-512x-pci.txt      |   1 -
 .../bindings/pinctrl/nuvoton,npcm7xx-pinctrl.txt   |   2 +-
 .../devicetree/bindings/property-units.txt         |  34 +-
 .../devicetree/bindings/regulator/pv88060.txt      |   2 +-
 .../devicetree/bindings/serial/mtk-uart.txt        |  13 +-
 .../devicetree/bindings/serial/st,stm32-usart.txt  |   1 +
 .../devicetree/bindings/sound/cs42l73.txt          |   2 +-
 .../devicetree/bindings/usb/generic-ehci.yaml      |   3 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |  76 +++-
 Documentation/translations/zh_CN/arm64/booting.txt |   2 +-
 MAINTAINERS                                        |   3 +-
 drivers/of/fdt.c                                   | 141 +++---
 drivers/of/of_reserved_mem.c                       |   3 +
 drivers/of/platform.c                              |   3 +-
 drivers/of/unittest.c                              |   2 +-
 include/linux/of_fdt.h                             |  11 -
 scripts/dtc/Makefile.dtc                           |   1 +
 scripts/dtc/checks.c                               |  72 ++-
 scripts/dtc/data.c                                 |  17 +-
 scripts/dtc/dtc-lexer.l                            |  17 +-
 scripts/dtc/dtc-parser.y                           |  17 +-
 scripts/dtc/dtc.c                                  |  17 +-
 scripts/dtc/dtc.h                                  |  20 +-
 scripts/dtc/flattree.c                             |  19 +-
 scripts/dtc/fstree.c                               |  17 +-
 scripts/dtc/libfdt/Makefile.libfdt                 |   3 +
 scripts/dtc/libfdt/fdt.c                           |  47 +-
 scripts/dtc/libfdt/fdt.h                           |  47 +-
 scripts/dtc/libfdt/fdt_addresses.c                 |  94 ++--
 scripts/dtc/libfdt/fdt_empty_tree.c                |  47 +-
 scripts/dtc/libfdt/fdt_overlay.c                   |  57 +--
 scripts/dtc/libfdt/fdt_ro.c                        |  97 ++--
 scripts/dtc/libfdt/fdt_rw.c                        |  69 +--
 scripts/dtc/libfdt/fdt_strerror.c                  |  47 +-
 scripts/dtc/libfdt/fdt_sw.c                        | 125 +++---
 scripts/dtc/libfdt/fdt_wip.c                       |  47 +-
 scripts/dtc/libfdt/libfdt.h                        | 205 ++++++---
 scripts/dtc/libfdt/libfdt_env.h                    |  48 +-
 scripts/dtc/libfdt/libfdt_internal.h               |  47 +-
 scripts/dtc/livetree.c                             |  37 +-
 scripts/dtc/srcpos.c                               |  16 +-
 scripts/dtc/srcpos.h                               |  16 +-
 scripts/dtc/treesource.c                           |  17 +-
 scripts/dtc/util.c                                 |  16 +-
 scripts/dtc/util.h                                 |  20 +-
 scripts/dtc/version_gen.h                          |   2 +-
 scripts/dtc/yamltree.c                             |  16 +-
 89 files changed, 2562 insertions(+), 2181 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/al,alpine.txt
 create mode 100644 Documentation/devicetree/bindings/arm/al,alpine.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/axxia.txt
 create mode 100644 Documentation/devicetree/bindings/arm/axxia.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/digicolor.txt
 create mode 100644 Documentation/devicetree/bindings/arm/digicolor.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/moxart.txt
 create mode 100644 Documentation/devicetree/bindings/arm/moxart.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/nxp/lpc32xx.txt
 create mode 100644 Documentation/devicetree/bindings/arm/nxp/lpc32xx.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/psci.txt
 create mode 100644 Documentation/devicetree/bindings/arm/psci.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/rda.txt
 create mode 100644 Documentation/devicetree/bindings/arm/rda.yaml
 create mode 100644
Documentation/devicetree/bindings/net/allwinner,sun4i-a10-emac.yaml
 create mode 100644
Documentation/devicetree/bindings/net/allwinner,sun4i-a10-mdio.yaml
 delete mode 100644
Documentation/devicetree/bindings/net/allwinner,sun4i-emac.txt
 delete mode 100644
Documentation/devicetree/bindings/net/allwinner,sun4i-mdio.txt
 delete mode 100644
Documentation/devicetree/bindings/net/allwinner,sun7i-a20-gmac.txt
 create mode 100644
Documentation/devicetree/bindings/net/allwinner,sun7i-a20-gmac.yaml
 create mode 100644
Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/dwmac-sun8i.txt
 create mode 100644
Documentation/devicetree/bindings/net/ethernet-controller.yaml
 create mode 100644 Documentation/devicetree/bindings/net/ethernet-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/net/mdio.yaml
 create mode 100644 Documentation/devicetree/bindings/net/snps,dwmac.yaml
