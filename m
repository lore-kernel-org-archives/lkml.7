Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A28FC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF15218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568908439;
	bh=baO7aHG9LjHxLD7RTIPRgmRYChWzMwfNYhSBNH1ULUg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=iRxgmb32fo52qCYEq9l2tDZEdAPpbFZAfyqNh8EY8auq21Z65DHwCcFVA2uFz+oy+
	 /SDuU8r0cXoMUf8MO2KtBr4EEcDxYGxasqxVPVa0kH+1xjwro8xJCPgDqH7Mt+bxmY
	 xb6rsDdrbWvx4JvRRS+WKHvZE6B8/kPO7KB3Yjkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390135AbfISPx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:53:58 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44678 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387881AbfISPx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:53:57 -0400
Received: by mail-oi1-f195.google.com with SMTP id w6so3100449oie.11;
        Thu, 19 Sep 2019 08:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=EijMKpMKYMOETFMtSDdyBHjc/F+STYbBCeMRpw3f/uU=;
        b=uHJ+MPwy2Yr2MP9W99sKRkWA0cmXOoXhYePPark1r6Bi4H/MILerG2Sx1JlRshH7hR
         LI/6GcqC93gqzggmKH7im0rWTBYsNKjibsOqlicZH12Hs1MTWCqfEoTDw4BNH6/hQ1Gw
         aFnNspIGoPCegeimnf3PLuaKeMWXsyvPCmBPGHfXHUvVDIlA0/hdoOM9IuEoeXdVpYpR
         bqWrT8F2htOu1kHVcNR7aRlk3VEZX7yJ3G8zwmV2Gzs9ay54F7ljpCgMkk98iSZZ81Ug
         GwuIdOdyzVvCkmbmP4Hv8A+BmyHqiXCaWKWBTnTV25Q7MAsv4RN8TLfvA1OVc/JKG1lP
         uIlg==
X-Gm-Message-State: APjAAAXlzVzh4Z2ZWZgmRtKBlg4jO3Hq3W6ZORV4+JF6v10stMcp5nRq
        6EbOFuZ140PunzlbTz3cMpBcNVE=
X-Google-Smtp-Source: APXvYqz8bAyBxn7daCO4V1xZH6QvWdNChN7tV//vhd4TiS0Hk3lmk1aZ23aqdCWhKTy1vT3rZwLcwQ==
X-Received: by 2002:aca:47d8:: with SMTP id u207mr2904988oia.130.1568908435893;
        Thu, 19 Sep 2019 08:53:55 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y137sm2918325oie.53.2019.09.19.08.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 08:53:55 -0700 (PDT)
Date:   Thu, 19 Sep 2019 10:53:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree updates for v5.4
Message-ID: <20190919155354.GA8880@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull Devicetree updates for 5.4.

Rob


The following changes since commit 83f82d7a42583e93d0f0dde3d61ed10f75c0f4d8:

  of: irq: fix a trivial typo in a doc comment (2019-08-14 20:12:16 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.4

for you to fetch changes up to 59e9fcf8772bd97b6d681706fb8c9a972500c524:

  of: restore old handling of cells_name=NULL in of_*_phandle_with_args() (2019-09-19 08:33:02 -0500)

----------------------------------------------------------------
Devicetree updates for v5.4:

- A bunch of DT binding conversions to DT schema format

- Clean-ups of the Arm idle-states binding

- Support a default number of cells in of_for_each_phandle() when the
  cells name is missing

- Expose dtbs_check and dt_binding_check in the make help

- Convert writting-schema.md to ReST

- HiSilicon reset controller binding updates

- Add documentation for MT8516 RNG

----------------------------------------------------------------
Bin Meng (1):
      dt-bindings: pci: pci-msi: Correct the unit-address of the pci node name

Colin Ian King (1):
      bus: qcom: fix spelling mistake "ambigous" -> "ambiguous"

Fabien Parent (1):
      dt-bindings: rng: mtk-rng: Add documentation for MT8516

Geert Uytterhoeven (6):
      dt-bindings: arm-boards: Update pointer to ARM CPU bindings
      dt-bindings: arm: idle-states: Use "e.g." and "i.e." consistently
      dt-bindings: arm: idle-states: Correct references to wake-up delay
      dt-bindings: arm: idle-states: Correct "constraint guarantees"
      dt-bindings: arm: idle-states: Add punctuation to improve readability
      dt-bindings: arm: idle-states: Move exit-latency-us explanation

Guillaume Gardet (1):
      dt-bindings: gpu: mali-midgard: Add samsung exynos5250 compatible

John Wang (1):
      dt-bindings: Add vendor prefix for Inspur Corporation

Mauro Carvalho Chehab (1):
      docs: writing-schema.md: convert from markdown to ReST

Maxime Ripard (5):
      dt-bindings: input: Convert Allwinner LRADC to a schema
      dt-bindings: bus: Convert Allwinner DE2 bus to a schema
      dt-bindings: crypto: Convert Allwinner A10 Security Engine to a schema
      dt-bindings: irq: Convert Allwinner IRQ Controller to a schema
      dt-bindings: irq: Convert Allwinner NMI Controller to a schema

Miquel Raynal (1):
      dt-bindings: ata: fix typo in Allwinner R40 reset specific paragraph

Neil Armstrong (9):
      dt-bindings: mailbox: meson-mhu: convert to yaml
      dt-bindings: rng: amlogic,meson-rng: convert to yaml
      dt-bindings: spi: meson: convert to yaml
      dt-bindings: reset: amlogic,meson-reset: convert to yaml
      dt-bindings: arm: amlogic: amlogic,meson-gx-ao-secure: convert to yaml
      dt-bindings: phy: meson-g12a-usb2-phy: convert to yaml
      dt-bindings: phy: meson-g12a-usb3-pcie-phy: convert to yaml
      dt-bindings: serial: meson-uart: convert to yaml
      dt-bindings: watchdog: meson-gxbb-wdt: convert to yaml

Nishka Dasgupta (1):
      of: unittest: Add of_node_put() before return

Peter Griffin (3):
      dt-bindings: gpu: mali-utgard: add hisilicon,hi6220-mali compatible
      dt-bindings: reset: hisilicon: Update compatible documentation
      dt-bindings: reset: hisilicon: Add ao reset controller

Peter Vernia (1):
      pinctrl-mcp23s08: Fix property-name in dt-example

Rob Herring (6):
      Merge branch 'dt/linus' into dt/next
      dt-bindings: Convert Arm Mali Midgard GPU to DT schema
      dt-bindings: Convert Arm Mali Bifrost GPU to DT schema
      dt-bindings: Convert Arm Mali Utgard GPU to DT schema
      dt-bindings: arm: Convert Actions Semi bindings to jsonschema
      dt-bindings: arm: Convert Realtek board/soc bindings to json-schema

Sakari Ailus (1):
      dt-bindings: smiapp: Align documentation with current practices

Simon Horman (1):
      dt-bindings: Correct spelling in example schema

Stephen Boyd (2):
      devicetree: Expose dtbs_check and dt_binding_check some more
      dt-bindings: Clarify interrupts-extended usage

Uwe Kleine-König (3):
      iommu: pass cell_count = -1 to of_for_each_phandle with cells_name
      of: Let of_for_each_phandle fallback to non-negative cell_count
      of: restore old handling of cells_name=NULL in of_*_phandle_with_args()

Vinod Koul (1):
      dt-bindings: arm: Add kryo485 compatible

james.tai (1):
      dt-bindings: cpu: Add a support cpu type for cortex-a55

 Documentation/devicetree/bindings/arm/actions.txt  |  56 -------
 Documentation/devicetree/bindings/arm/actions.yaml |  38 +++++
 .../arm/amlogic/amlogic,meson-gx-ao-secure.txt     |  28 ----
 .../arm/amlogic/amlogic,meson-gx-ao-secure.yaml    |  52 +++++++
 Documentation/devicetree/bindings/arm/arm-boards   |   2 +-
 Documentation/devicetree/bindings/arm/cpus.yaml    |   2 +
 .../devicetree/bindings/arm/idle-states.txt        |  32 ++--
 Documentation/devicetree/bindings/arm/realtek.txt  |  22 ---
 Documentation/devicetree/bindings/arm/realtek.yaml |  23 +++
 .../devicetree/bindings/ata/ahci-platform.txt      |   2 +-
 .../bindings/bus/allwinner,sun50i-a64-de2.yaml     |  85 +++++++++++
 .../devicetree/bindings/bus/qcom,ebi2.txt          |   2 +-
 .../devicetree/bindings/bus/sun50i-de2-bus.txt     |  40 -----
 .../crypto/allwinner,sun4i-a10-crypto.yaml         |  79 ++++++++++
 .../devicetree/bindings/crypto/sun4i-ss.txt        |  23 ---
 .../devicetree/bindings/example-schema.yaml        |   2 +-
 .../devicetree/bindings/gpu/arm,mali-bifrost.txt   |  92 -----------
 .../devicetree/bindings/gpu/arm,mali-bifrost.yaml  | 116 ++++++++++++++
 .../devicetree/bindings/gpu/arm,mali-midgard.txt   | 119 ---------------
 .../devicetree/bindings/gpu/arm,mali-midgard.yaml  | 168 +++++++++++++++++++++
 .../devicetree/bindings/gpu/arm,mali-utgard.txt    | 124 ---------------
 .../devicetree/bindings/gpu/arm,mali-utgard.yaml   | 168 +++++++++++++++++++++
 .../input/allwinner,sun4i-a10-lradc-keys.yaml      |  95 ++++++++++++
 .../devicetree/bindings/input/sun4i-lradc-keys.txt |  65 --------
 .../allwinner,sun4i-a10-ic.yaml                    |  47 ++++++
 .../interrupt-controller/allwinner,sun4i-ic.txt    |  20 ---
 .../allwinner,sun7i-a20-sc-nmi.yaml                |  70 +++++++++
 .../interrupt-controller/allwinner,sunxi-nmi.txt   |  29 ----
 .../bindings/interrupt-controller/interrupts.txt   |   8 +-
 .../bindings/mailbox/amlogic,meson-gxbb-mhu.yaml   |  52 +++++++
 .../devicetree/bindings/mailbox/meson-mhu.txt      |  34 -----
 .../devicetree/bindings/media/i2c/nokia,smia.txt   |  10 +-
 Documentation/devicetree/bindings/pci/pci-msi.txt  |   2 +-
 .../bindings/phy/amlogic,meson-g12a-usb2-phy.yaml  |  63 ++++++++
 .../phy/amlogic,meson-g12a-usb3-pcie-phy.yaml      |  57 +++++++
 .../bindings/phy/meson-g12a-usb2-phy.txt           |  22 ---
 .../bindings/phy/meson-g12a-usb3-pcie-phy.txt      |  22 ---
 .../bindings/pinctrl/pinctrl-mcp23s08.txt          |   2 +-
 .../bindings/reset/amlogic,meson-reset.txt         |  19 ---
 .../bindings/reset/amlogic,meson-reset.yaml        |  37 +++++
 .../bindings/reset/hisilicon,hi6220-reset.txt      |   1 +
 .../devicetree/bindings/rng/amlogic,meson-rng.txt  |  21 ---
 .../devicetree/bindings/rng/amlogic,meson-rng.yaml |  37 +++++
 Documentation/devicetree/bindings/rng/mtk-rng.txt  |   1 +
 .../bindings/serial/amlogic,meson-uart.txt         |  38 -----
 .../bindings/serial/amlogic,meson-uart.yaml        |  73 +++++++++
 .../bindings/spi/amlogic,meson-gx-spicc.yaml       |  67 ++++++++
 .../bindings/spi/amlogic,meson6-spifc.yaml         |  53 +++++++
 .../devicetree/bindings/spi/spi-meson.txt          |  55 -------
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 .../bindings/watchdog/amlogic,meson-gxbb-wdt.yaml  |  37 +++++
 .../bindings/watchdog/meson-gxbb-wdt.txt           |  16 --
 Documentation/devicetree/writing-schema.md         | 130 ----------------
 Documentation/devicetree/writing-schema.rst        | 154 +++++++++++++++++++
 MAINTAINERS                                        |   4 +-
 Makefile                                           |   6 +-
 drivers/iommu/arm-smmu.c                           |   2 +-
 drivers/iommu/mtk_iommu_v1.c                       |   2 +-
 drivers/of/base.c                                  |  58 +++++--
 drivers/of/unittest.c                              |   4 +-
 include/dt-bindings/reset/hisi,hi6220-resets.h     |   7 +
 61 files changed, 1675 insertions(+), 1022 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/actions.txt
 create mode 100644 Documentation/devicetree/bindings/arm/actions.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/realtek.txt
 create mode 100644 Documentation/devicetree/bindings/arm/realtek.yaml
 create mode 100644 Documentation/devicetree/bindings/bus/allwinner,sun50i-a64-de2.yaml
 delete mode 100644 Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/allwinner,sun4i-a10-crypto.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/sun4i-ss.txt
 delete mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
 create mode 100644 Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-a10-ic.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/allwinner,sunxi-nmi.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/amlogic,meson-gxbb-mhu.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/meson-mhu.txt
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-g12a-usb2-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-g12a-usb3-pcie-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
 delete mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
 delete mode 100644 Documentation/devicetree/bindings/rng/amlogic,meson-rng.txt
 create mode 100644 Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-meson.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/amlogic,meson-gxbb-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt
 delete mode 100644 Documentation/devicetree/writing-schema.md
 create mode 100644 Documentation/devicetree/writing-schema.rst
