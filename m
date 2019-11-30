Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FC7C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 05:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD0720833
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 05:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575090661;
	bh=fu2rwiA79wHsR63bX26GGblq4kIkLiKBOvu7vRxpt2g=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=1wHZdIvIu+NmQlpvPzIP6eICe0d+4K+A04y06oyfNAivh2LtzMrRFGnt7vKeEkiiO
	 3bJQGLOIFXMkev6JFE5S6LmlBjqoJrh73PYdVRuILPWshOFhdfEer+JVdzhv9PoS/V
	 ygMWhE+Ni0uFSkB0euKrAoYXuBIyNX75b/3ulMs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfK3FLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 00:11:01 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:35356 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfK3FLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 00:11:00 -0500
Received: by mail-il1-f170.google.com with SMTP id g12so19148635ild.2;
        Fri, 29 Nov 2019 21:10:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=KZZ7+9tUO5Qi45DV52uoxbZxcjkWJ9JO2vQNFW1idk8=;
        b=jT0NEURnF0alQJJ3D5hDgMVQaAGlCaJrqQ+bnm3qXUICVeZwvSlExNpsbI4zfgIL2o
         d+Y4a/PKE0A9WRrbUSI+FueO1eU7TTh33fFCSOmsJpsXWMeYS4ZiHlDDqqEL8U/L+1te
         coTPyzLWqnzYelwMv/TMvq62OUJ7DkEiN7pXDxM6u+Mz8CD+IuRSt6B92hhGM0UMTyj0
         /i87YK5Fc3M+BPMXj7uGXpf4GRdCzobUegK69MnxEQ2bvS05YVcviDfsHEppKOOk/WPI
         WHOGHvIBAnxpr+b9Mi8rQ8oliRJz6C+1A+DN6LCBfkFtmGv0mNgQf+7bv0tial1494e7
         99jg==
X-Gm-Message-State: APjAAAXOlmbFuMCOwDaLoXENOTNen4N2OVM9qio34754/G2UE6hU9ZQI
        qYzvgHhd0++cgd9f8vfW/g==
X-Google-Smtp-Source: APXvYqz/QghjyvJ5SZZXRenzi6Y3vAqBbgizX5nkJspnMzHPwzXTtKjkrakeJzAzWjOigkOd+4BXYA==
X-Received: by 2002:a92:d2:: with SMTP id 201mr9798226ila.22.1575090658517;
        Fri, 29 Nov 2019 21:10:58 -0800 (PST)
Received: from localhost ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id n20sm7355253ilj.23.2019.11.29.21.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 21:10:57 -0800 (PST)
Date:   Fri, 29 Nov 2019 22:10:55 -0700
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree updates for v5.5
Message-ID: <20191130051055.GA2987@bogus>
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

Please pull DT updates for v5.5. There's a couple of conflicts to 
note. In the case of deleted binding files, just accept the deleted 
file. The modifications are either already reflected in the new 
schema or a follow-up change is in the works. The rest are context 
conflicts and you should take both changes. The correct resolutions are 
in linux-next.

Rob

The following changes since commit 5dba51754b04a941a1064f584e7a7f607df3f9bc:

  of: reserved_mem: add missing of_node_put() for proper ref-counting (2019-10-23 15:15:05 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.5

for you to fetch changes up to a8de1304b7df30e3a14f2a8b9709bb4ff31a0385:

  libfdt: define INT32_MAX and UINT32_MAX in libfdt_env.h (2019-11-26 13:35:25 -0700)

----------------------------------------------------------------
Devicetree updates for v5.5:

- DT schemas for PWM, syscon, power domains, SRAM, syscon-reboot,
  syscon-poweroff, renesas-irqc, simple-pm-bus, renesas-bsc, pwm-rcar,
  Renesas tpu, at24 eeprom, rtc-sh, Allwinner PS/2, sharp,ld-d5116z01b
  panel, Arm SMMU, max77650, Meson CEC, Amlogic canvas and DWC3 glue,
  Allwinner A10 mUSB and CAN, TI Davinci MDIO, QCom QCS404 interconnect,
  Unisoc/Spreadtrum SoCs and UART

- Convert a bunch of Samsung bindings to DT schema

- Convert a bunch of ST stm32 bindings to DT schema

- Realtek and Exynos additions to Arm Mali bindings

- Fix schema errors in RiscV CPU schema

- Various schema fixes from improved meta-schema checks

- Improve the handling of 'dma-ranges' and in particular fix DMA mask
  setup on PCI bridges

- Fix a memory leak in add_changeset_property() and DT unit tests.

- Several documentation improvements for schema validation

- Rework build rules to improve schema validation errors

- Color output for dtx_diff

----------------------------------------------------------------
Alain Volmat (1):
      dt-bindings: i2c: stm32: Migrate i2c-stm32 documentation to yaml

Alexandre Torgue (4):
      dt-bindings: arm: stm32: Add missing STM32 boards
      dt-bindings: pinctrl: stm32: Fix 'st, syscfg' description field
      dt-bindings: usb: generic-ehci: Add "companion" entry
      dt-bindings: interrupt-controller: Convert stm32-exti to json-schema

Andreas Färber (3):
      dt-bindings: gpu: mali-midgard: Tidy up conversion to YAML
      dt-bindings: gpu: mali-midgard: Add Realtek RTD1295
      dt-bindings: gpu: mali-bifrost: Add Realtek RTD1619

Arnaud Pouliquen (2):
      dt-bindings: mailbox: convert stm32-ipcc to json-schema
      dt-bindings: remoteproc: convert stm32-rproc to json-schema

Bartosz Golaszewski (8):
      dt-bindings: at24: convert the binding document to yaml
      dt-bindings: at24: add new compatible
      dt-bindings: input: max77650: convert the binding document to yaml
      dt-bindings: regulator: max77650: convert the binding document to yaml
      dt-bindings: power: max77650: convert the binding document to yaml
      dt-bindings: leds: max77650: convert the binding document to yaml
      dt-bindings: mfd: max77650: convert the binding document to yaml
      MAINTAINERS: update the list of maintained files for max77650

Benjamin Gaignard (13):
      dt-bindings: hwlock: Convert stm32 hwspinlock bindings to json-schema
      dt-bindings: media: Convert stm32 cec bindings to json-schema
      dt-bindings: media: Convert stm32 dcmi bindings to json-schema
      dt-bindings: thermal: Convert stm32 thermal bindings to json-schema
      dt-bindings: timer: Convert stm32 timer bindings to json-schema
      dt-bindings: display: Convert stm32 display bindings to json-schema
      dt-bindings: mfd: Convert stm32 timers bindings to json-schema
      dt-bindings: crypto: Convert stm32 CRC bindings to json-schema
      dt-bindings: crypto: Convert stm32 CRYP bindings to json-schema
      dt-bindings: rng: Convert stm32 RNG bindings to json-schema
      dt-bindings: crypto: Convert stm32 HASH bindings to json-schema
      dt-bindings: mfd: Convert stm32 low power timers bindings to json-schema
      dt-bindings: mtd: Convert stm32 fmc2-nand bindings to json-schema

Biju Das (2):
      dt-bindings: pwm: rcar: Add r8a774b1 support
      dt-bindings: irqchip: renesas-irqc: Document r8a774b1 bindings

Christoph Hellwig (1):
      of/fdt: don't ignore errors from of_setup_earlycon

Chunyan Zhang (4):
      dt-bindings: arm: Convert sprd board/soc bindings to json-schema
      dt-bindings: arm: Add bindings for Unisoc SC9863A
      dt-bindings: serial: Convert sprd-uart to json-schema
      dt-bindings: serial: Add a new compatible string for SC9863A

Erhard Furtner (1):
      of: unittest: fix memory leak in attach_node_and_children

Fabrizio Castro (3):
      dt-bindings: watchdog: renesas-wdt: Document r8a774b1 support
      dt-bindings: PCI: rcar: Add device tree support for r8a774b1
      dt-bindings: ata: sata_rcar: Add r8a774b1 support

Frank Rowand (1):
      of: overlay: add_changeset_property() memory leak

Geert Uytterhoeven (1):
      scripts/dtc: dtx_diff - add color output support

Georgi Djakov (1):
      dt-bindings: interconnect: Convert qcom, qcs404 to DT schema

Grygorii Strashko (1):
      dt-bindings: net: davinci-mdio: convert bindings to json-schema

Jeffrey Hugo (1):
      dt-bindings: display: Convert sharp, ld-d5116z01b panel to DT schema

Krzysztof Kozlowski (38):
      dt-bindings: power: syscon-reboot: Convert bindings to json-schema
      dt-bindings: power: syscon-poweroff: Convert bindings to json-schema
      dt-bindings: arm: samsung: Convert Samsung board/soc bindings to json-schema
      dt-bindings: arm: samsung: Document missing S5Pv210 boards bindings
      dt-bindings: arm: samsung: Document missing Exynos7 boards bindings
      dt-bindings: arm: samsung: Convert Exynos Chipid bindings to json-schema
      dt-bindings: rtc: s3c: Convert S3C/Exynos RTC bindings to json-schema
      dt-bindings: iio: adc: exynos: Convert Exynos ADC bindings to json-schema
      dt-bindings: iio: adc: exynos: Remove old requirement of two register address ranges
      dt-bindings: arm: samsung: Convert Exynos System Registers bindings to json-schema
      dt-bindings: arm: samsung: Convert Exynos PMU bindings to json-schema
      dt-bindings: timer: Convert Exynos MCT bindings to json-schema
      dt-bindings: timer: Use defines instead of numbers in Exynos MCT examples
      dt-bindings: watchdog: Convert Samsung SoC watchdog bindings to json-schema
      dt-bindings: watchdog: Add missing clocks requirement in Samsung SoC watchdog
      dt-bindings: watchdog: meson-gxbb-wdt: Include generic watchdog bindings
      dt-bindings: rng: exynos4-rng: Convert Exynos PRNG bindings to json-schema
      dt-bindings: memory-controllers: Convert Samsung Exynos SROM bindings to json-schema
      dt-bindings: crypto: samsung: Convert SSS and SlimSSS bindings to json-schema
      dt-bindings: samsung: Indent examples with four spaces
      dt-bindings: rtc: s3c: Use defines instead of clock numbers
      dt-bindings: rtc: s3c: Include generic dt-schema bindings
      dt-bindings: iio: adc: exynos: Use defines instead of clock numbers
      dt-bindings: gpu: samsung-rotator: Fix indentation
      dt-bindings: sram: Convert SRAM bindings to json-schema
      dt-bindings: sram: Merge Samsung SRAM bindings into generic
      dt-bindings: sram: Merge Amlogic SRAM bindings into generic
      dt-bindings: sram: Merge Renesas SRAM bindings into generic
      dt-bindings: sram: Merge Rockchip SRAM bindings into generic
      dt-bindings: sram: Merge Allwinner SRAM bindings into generic
      dt-bindings: sram: Merge Socionext SRAM bindings into generic
      dt-bindings: display: st,stm32-dsi: Fix white spaces
      dt-bindings: serial: Convert Samsung UART bindings to json-schema
      dt-bindings: power: Convert Generic Power Domain bindings to json-schema
      dt-bindings: power: Convert Samsung Exynos Power Domain bindings to json-schema
      dt-bindings: pwm: Convert PWM bindings to json-schema
      dt-bindings: pwm: Convert Samsung PWM bindings to json-schema
      dt-bindings: power: Rename back power_domain.txt bindings to fix references

Maciej Falkowski (5):
      dt-bindings: gpu: Convert Samsung Image Rotator to dt-schema
      dt-bindings: iommu: Convert Samsung Exynos IOMMU H/W, System MMU to dt-schema
      dt-bindings: gpu: Convert Samsung Image Scaler to dt-schema
      dt-bindings: gpu: Convert Samsung 2D Graphics Accelerator to dt-schema
      ASoC: samsung: i2s: Document clocks macros

Marian Mihailescu (1):
      dt-bindings: gpu: mali-midgard: add samsung exynos 5420 compatible

Martin Kaiser (2):
      dt-bindings: display: imx: fix native-mode setting
      dt-bindings: display: clps711x-fb: fix native-mode setting

Masahiro Yamada (2):
      libfdt: reduce the number of headers included from libfdt_env.h
      libfdt: define INT32_MAX and UINT32_MAX in libfdt_env.h

Matti Vaittinen (1):
      of: property: Fix documentation for out values

Maxime Ripard (5):
      dt-bindings: serio: Convert Allwinner PS2 controller to a schema
      dt-bindings: can: Convert Allwinner A10 CAN controller to a schema
      dt-bindings: usb: Convert Allwinner A10 mUSB controller to a schema
      dt-bindings: Remove FIXME in yaml bindings
      dt-bindings: Add syscon YAML description

Neil Armstrong (4):
      dt-bindings: media: meson-ao-cec: convert to yaml
      media: dt-bindings: media: add new rc map names
      dt-bindings: soc: amlogic: canvas: convert to yaml
      dt-bindings: usb: dwc3: Move Amlogic G12A DWC3 Glue Bindings to YAML schemas

Pavel Modilaynen (1):
      dtc: Use pkg-config to locate libyaml

Rajendra Nayak (1):
      dt-bindings: arm-smmu: update binding for qcom sc7180 SoC

Rob Herring (20):
      Merge branch 'dt/linus' into dt/next
      of: Remove unused of_find_matching_node_by_address()
      of: Make of_dma_get_range() private
      of/unittest: Add dma-ranges address translation tests
      of/address: Translate 'dma-ranges' for parent nodes missing 'dma-ranges'
      of/address: Fix of_pci_range_parser_one translation of DMA addresses
      dt-bindings: riscv: Fix CPU schema errors
      checkpatch: Warn if DT bindings are not in schema format
      dt-bindings: Clean-up regulator '-supply' schemas
      dt-bindings: iommu: Convert Arm SMMU to DT schema
      dt-bindings: iommu: Convert Arm SMMUv3 to DT schema
      dt: writing-schema: Add a note about tools PATH setup
      dt: submitting-patches: Document requirements for DT schema
      dt-bindings: example-schema: Add some additional examples and commentary
      Merge branch 'dt/linus' into dt/next
      dt-bindings: example-schema: Standard unit should be microvolt not microvolts
      dt-bindings: Improve validation build error handling
      dt-bindings: firmware: ixp4xx: Drop redundant minItems/maxItems
      dt-bindings: interrupt-controller: arm,gic-v3: Add missing type to interrupt-partition-* nodes
      dt-bindings: arm: Remove leftover axentia.txt

Robin Murphy (5):
      of: address: Report of_dma_get_range() errors meaningfully
      of/address: Introduce of_get_next_dma_parent() helper
      of: address: Follow DMA parent for "dma-coherent"
      of: Factor out #{addr,size}-cells parsing
      of: Make of_dma_get_range() work on bus nodes

Simon Horman (3):
      dt-bindings: bus: simple-pm-bus: convert bindings to json-schema
      dt-bindings: bus: renesas-bsc: convert bindings to json-schema
      dt-bindings: rtc: rtc-sh: convert bindings to json-schema

Sylwester Nawrocki (2):
      dt-bindings: arm: samsung: Update the CHIPID binding for ASV
      dt-bindings: arm: samsung: Drop syscon compatible from CHIPID binding

Yoshihiro Kaneko (3):
      dt-bindings: irqchip: renesas-irqc: convert bindings to json-schema
      dt-bindings: pwm: renesas: pwm-rcar: convert bindings to json-schema
      dt-bindings: pwm: renesas: tpu: convert bindings to json-schema

 Documentation/devicetree/bindings/Makefile         |   5 +-
 .../devicetree/bindings/arm/amlogic/smp-sram.txt   |  32 ---
 Documentation/devicetree/bindings/arm/arm,scmi.txt |   2 +-
 Documentation/devicetree/bindings/arm/arm,scpi.txt |   2 +-
 Documentation/devicetree/bindings/arm/axentia.txt  |  28 ---
 .../devicetree/bindings/arm/freescale/fsl,scu.txt  |   2 +-
 .../bindings/arm/samsung/exynos-chipid.txt         |  12 -
 .../bindings/arm/samsung/exynos-chipid.yaml        |  39 ++++
 .../devicetree/bindings/arm/samsung/pmu.txt        |  72 ------
 .../devicetree/bindings/arm/samsung/pmu.yaml       | 105 +++++++++
 .../bindings/arm/samsung/samsung-boards.txt        |  83 -------
 .../bindings/arm/samsung/samsung-boards.yaml       | 181 +++++++++++++++
 .../arm/samsung/samsung-secure-firmware.yaml       |  31 +++
 .../devicetree/bindings/arm/samsung/sysreg.txt     |  19 --
 .../devicetree/bindings/arm/samsung/sysreg.yaml    |  45 ++++
 Documentation/devicetree/bindings/arm/sprd.txt     |  14 --
 Documentation/devicetree/bindings/arm/sprd.yaml    |  33 +++
 .../devicetree/bindings/arm/stm32/stm32.yaml       |  27 ++-
 .../devicetree/bindings/arm/sunxi/smp-sram.txt     |  44 ----
 .../devicetree/bindings/ata/sata_rcar.txt          |   7 +-
 .../devicetree/bindings/bus/renesas,bsc.txt        |  46 ----
 .../devicetree/bindings/bus/renesas,bsc.yaml       |  60 +++++
 .../devicetree/bindings/bus/simple-pm-bus.txt      |  44 ----
 .../devicetree/bindings/bus/simple-pm-bus.yaml     |  75 ++++++
 .../devicetree/bindings/clock/renesas,cpg-mssr.txt |   2 +-
 .../devicetree/bindings/clock/ti/davinci/psc.txt   |   2 +-
 .../bindings/counter/stm32-lptimer-cnt.txt         |  29 ---
 .../bindings/counter/stm32-timer-cnt.txt           |  31 ---
 .../devicetree/bindings/crypto/samsung-slimsss.txt |  19 --
 .../bindings/crypto/samsung-slimsss.yaml           |  47 ++++
 .../devicetree/bindings/crypto/samsung-sss.txt     |  32 ---
 .../devicetree/bindings/crypto/samsung-sss.yaml    |  58 +++++
 .../devicetree/bindings/crypto/st,stm32-crc.txt    |  16 --
 .../devicetree/bindings/crypto/st,stm32-crc.yaml   |  38 +++
 .../devicetree/bindings/crypto/st,stm32-cryp.txt   |  19 --
 .../devicetree/bindings/crypto/st,stm32-cryp.yaml  |  51 ++++
 .../devicetree/bindings/crypto/st,stm32-hash.txt   |  30 ---
 .../devicetree/bindings/crypto/st,stm32-hash.yaml  |  69 ++++++
 .../bindings/display/amlogic,meson-dw-hdmi.yaml    |   2 -
 .../bindings/display/bridge/ti,sn65dsi86.txt       |   2 +-
 .../bindings/display/cirrus,clps711x-fb.txt        |   2 +-
 .../devicetree/bindings/display/imx/fsl,imx-fb.txt |   2 +-
 .../bindings/display/panel/sharp,ld-d5116z01b.txt  |  26 ---
 .../bindings/display/panel/sharp,ld-d5116z01b.yaml |  30 +++
 .../devicetree/bindings/display/st,stm32-dsi.yaml  | 150 ++++++++++++
 .../devicetree/bindings/display/st,stm32-ltdc.txt  | 144 ------------
 .../devicetree/bindings/display/st,stm32-ltdc.yaml |  81 +++++++
 .../bindings/dma/allwinner,sun50i-a64-dma.yaml     |   4 +-
 Documentation/devicetree/bindings/eeprom/at24.txt  |  90 +-------
 Documentation/devicetree/bindings/eeprom/at24.yaml | 188 +++++++++++++++
 .../devicetree/bindings/example-schema.yaml        |  81 ++++++-
 .../intel,ixp4xx-network-processing-engine.yaml    |   2 -
 .../bindings/firmware/nvidia,tegra186-bpmp.txt     |   2 +-
 .../devicetree/bindings/gpu/arm,mali-bifrost.yaml  |   4 +-
 .../devicetree/bindings/gpu/arm,mali-midgard.yaml  |  22 +-
 .../devicetree/bindings/gpu/arm,mali-utgard.yaml   |   3 +-
 .../devicetree/bindings/gpu/samsung-g2d.txt        |  27 ---
 .../devicetree/bindings/gpu/samsung-g2d.yaml       |  75 ++++++
 .../devicetree/bindings/gpu/samsung-rotator.txt    |  28 ---
 .../devicetree/bindings/gpu/samsung-rotator.yaml   |  48 ++++
 .../devicetree/bindings/gpu/samsung-scaler.txt     |  27 ---
 .../devicetree/bindings/gpu/samsung-scaler.yaml    |  81 +++++++
 .../bindings/hwlock/st,stm32-hwspinlock.txt        |  23 --
 .../bindings/hwlock/st,stm32-hwspinlock.yaml       |  50 ++++
 .../bindings/i2c/allwinner,sun6i-a31-p2wi.yaml     |   4 +-
 .../devicetree/bindings/i2c/i2c-stm32.txt          |  65 ------
 .../bindings/i2c/marvell,mv64xxx-i2c.yaml          |   4 +-
 .../devicetree/bindings/i2c/st,stm32-i2c.yaml      | 141 +++++++++++
 .../devicetree/bindings/iio/adc/adi,ad7124.yaml    |   3 -
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |   5 +-
 .../devicetree/bindings/iio/adc/adi,ad7780.yaml    |   1 -
 .../devicetree/bindings/iio/adc/avia-hx711.yaml    |   1 -
 .../bindings/iio/adc/samsung,exynos-adc.txt        | 107 ---------
 .../bindings/iio/adc/samsung,exynos-adc.yaml       | 151 ++++++++++++
 .../bindings/iio/chemical/plantower,pms7003.yaml   |   1 -
 .../devicetree/bindings/iio/pressure/bmp085.yaml   |   2 -
 .../bindings/iio/timer/stm32-lptimer-trigger.txt   |  23 --
 .../bindings/iio/timer/stm32-timer-trigger.txt     |  25 --
 .../devicetree/bindings/input/max77650-onkey.txt   |  26 ---
 .../devicetree/bindings/input/max77650-onkey.yaml  |  35 +++
 .../bindings/interconnect/qcom,qcs404.txt          |  45 ----
 .../bindings/interconnect/qcom,qcs404.yaml         |  77 ++++++
 .../allwinner,sun7i-a20-sc-nmi.yaml                |   4 +-
 .../bindings/interrupt-controller/arm,gic-v3.yaml  |   1 +
 .../bindings/interrupt-controller/renesas,irqc.txt |  48 ----
 .../interrupt-controller/renesas,irqc.yaml         |  87 +++++++
 .../interrupt-controller/st,stm32-exti.txt         |  29 ---
 .../interrupt-controller/st,stm32-exti.yaml        |  98 ++++++++
 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |  77 ------
 .../devicetree/bindings/iommu/arm,smmu-v3.yaml     |  95 ++++++++
 .../devicetree/bindings/iommu/arm,smmu.txt         | 182 ---------------
 .../devicetree/bindings/iommu/arm,smmu.yaml        | 230 ++++++++++++++++++
 .../devicetree/bindings/iommu/samsung,sysmmu.txt   |  67 ------
 .../devicetree/bindings/iommu/samsung,sysmmu.yaml  | 108 +++++++++
 .../devicetree/bindings/leds/leds-max77650.txt     |  57 -----
 .../devicetree/bindings/leds/leds-max77650.yaml    |  51 ++++
 .../devicetree/bindings/mailbox/st,stm32-ipcc.yaml |  84 +++++++
 .../devicetree/bindings/mailbox/stm32-ipcc.txt     |  47 ----
 .../bindings/media/allwinner,sun4i-a10-ir.yaml     |   4 +-
 .../bindings/media/amlogic,meson-gx-ao-cec.yaml    |  91 ++++++++
 .../devicetree/bindings/media/meson-ao-cec.txt     |  37 ---
 Documentation/devicetree/bindings/media/rc.yaml    |   6 +
 .../devicetree/bindings/media/st,stm32-cec.txt     |  19 --
 .../devicetree/bindings/media/st,stm32-cec.yaml    |  54 +++++
 .../devicetree/bindings/media/st,stm32-dcmi.txt    |  45 ----
 .../devicetree/bindings/media/st,stm32-dcmi.yaml   |  86 +++++++
 .../bindings/memory-controllers/exynos-srom.txt    |  79 -------
 .../bindings/memory-controllers/exynos-srom.yaml   | 128 ++++++++++
 Documentation/devicetree/bindings/mfd/max77650.txt |  46 ----
 .../devicetree/bindings/mfd/max77650.yaml          | 149 ++++++++++++
 .../bindings/mfd/samsung,exynos5433-lpass.txt      |   2 +-
 .../devicetree/bindings/mfd/st,stm32-lptimer.yaml  | 120 ++++++++++
 .../devicetree/bindings/mfd/st,stm32-timers.yaml   | 162 +++++++++++++
 .../devicetree/bindings/mfd/stm32-lptimer.txt      |  48 ----
 .../devicetree/bindings/mfd/stm32-timers.txt       |  73 ------
 Documentation/devicetree/bindings/mfd/syscon.txt   |  32 ---
 Documentation/devicetree/bindings/mfd/syscon.yaml  |  84 +++++++
 .../devicetree/bindings/misc/allwinner,syscon.txt  |  20 --
 .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml      |   6 +-
 .../bindings/mtd/st,stm32-fmc2-nand.yaml           |  98 ++++++++
 .../devicetree/bindings/mtd/stm32-fmc2-nand.txt    |  61 -----
 .../bindings/net/allwinner,sun4i-a10-emac.yaml     |   6 +-
 .../bindings/net/allwinner,sun4i-a10-mdio.yaml     |   6 +-
 .../bindings/net/allwinner,sun7i-a20-gmac.yaml     |   6 +-
 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    |   6 +-
 .../bindings/net/can/allwinner,sun4i-a10-can.yaml  |  51 ++++
 .../devicetree/bindings/net/can/sun4i_can.txt      |  36 ---
 .../devicetree/bindings/net/davinci-mdio.txt       |  36 ---
 .../devicetree/bindings/net/ti,davinci-mdio.yaml   |  71 ++++++
 .../bindings/nvmem/allwinner,sun4i-a10-sid.yaml    |   4 +-
 Documentation/devicetree/bindings/pci/rcar-pci.txt |   1 +
 .../bindings/phy/amlogic,meson-g12a-usb2-phy.yaml  |   1 -
 .../bindings/pinctrl/st,stm32-pinctrl.yaml         |   7 +-
 .../bindings/power/amlogic,meson-gx-pwrc.txt       |   2 +-
 .../devicetree/bindings/power/fsl,imx-gpc.txt      |   2 +-
 .../devicetree/bindings/power/fsl,imx-gpcv2.txt    |   2 +-
 .../devicetree/bindings/power/pd-samsung.txt       |  45 ----
 .../devicetree/bindings/power/pd-samsung.yaml      |  66 ++++++
 .../devicetree/bindings/power/power-domain.yaml    | 133 +++++++++++
 .../devicetree/bindings/power/power_domain.txt     |  95 +-------
 .../bindings/power/renesas,sysc-rmobile.txt        |   2 +-
 .../bindings/power/reset/syscon-poweroff.txt       |  30 ---
 .../bindings/power/reset/syscon-poweroff.yaml      |  60 +++++
 .../bindings/power/reset/syscon-reboot.txt         |  30 ---
 .../bindings/power/reset/syscon-reboot.yaml        |  60 +++++
 .../bindings/power/supply/max77650-charger.txt     |  28 ---
 .../bindings/power/supply/max77650-charger.yaml    |  34 +++
 .../bindings/power/xlnx,zynqmp-genpd.txt           |   2 +-
 .../devicetree/bindings/pwm/atmel-hlcdc-pwm.txt    |   2 +-
 .../devicetree/bindings/pwm/atmel-pwm.txt          |   2 +-
 .../devicetree/bindings/pwm/atmel-tcb-pwm.txt      |   2 +-
 .../devicetree/bindings/pwm/brcm,bcm7038-pwm.txt   |   2 +-
 .../devicetree/bindings/pwm/brcm,iproc-pwm.txt     |   2 +-
 .../devicetree/bindings/pwm/brcm,kona-pwm.txt      |   2 +-
 Documentation/devicetree/bindings/pwm/img-pwm.txt  |   2 +-
 Documentation/devicetree/bindings/pwm/imx-pwm.txt  |   2 +-
 .../devicetree/bindings/pwm/imx-tpm-pwm.txt        |   2 +-
 .../devicetree/bindings/pwm/lpc1850-sct-pwm.txt    |   2 +-
 Documentation/devicetree/bindings/pwm/mxs-pwm.txt  |   2 +-
 .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt |   2 +-
 .../devicetree/bindings/pwm/nxp,pca9685-pwm.txt    |   2 +-
 .../devicetree/bindings/pwm/pwm-bcm2835.txt        |   2 +-
 .../devicetree/bindings/pwm/pwm-berlin.txt         |   2 +-
 .../devicetree/bindings/pwm/pwm-fsl-ftm.txt        |   2 +-
 .../devicetree/bindings/pwm/pwm-hibvt.txt          |   2 +-
 .../devicetree/bindings/pwm/pwm-lp3943.txt         |   2 +-
 .../devicetree/bindings/pwm/pwm-mediatek.txt       |   2 +-
 .../devicetree/bindings/pwm/pwm-meson.txt          |   2 +-
 .../devicetree/bindings/pwm/pwm-mtk-disp.txt       |   2 +-
 .../devicetree/bindings/pwm/pwm-omap-dmtimer.txt   |   2 +-
 .../devicetree/bindings/pwm/pwm-rockchip.txt       |   2 +-
 .../devicetree/bindings/pwm/pwm-samsung.txt        |  51 ----
 .../devicetree/bindings/pwm/pwm-samsung.yaml       | 109 +++++++++
 .../devicetree/bindings/pwm/pwm-sifive.txt         |   2 +-
 Documentation/devicetree/bindings/pwm/pwm-sprd.txt |   2 +-
 .../devicetree/bindings/pwm/pwm-stm32-lp.txt       |  30 ---
 .../devicetree/bindings/pwm/pwm-stm32.txt          |  38 ---
 .../devicetree/bindings/pwm/pwm-tiecap.txt         |   2 +-
 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |   2 +-
 Documentation/devicetree/bindings/pwm/pwm-zx.txt   |   2 +-
 Documentation/devicetree/bindings/pwm/pwm.txt      |  11 +-
 Documentation/devicetree/bindings/pwm/pwm.yaml     |  29 +++
 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   |  40 ----
 .../devicetree/bindings/pwm/renesas,pwm-rcar.yaml  |  78 +++++++
 .../devicetree/bindings/pwm/renesas,tpu-pwm.txt    |  35 ---
 .../devicetree/bindings/pwm/renesas,tpu-pwm.yaml   |  69 ++++++
 .../devicetree/bindings/pwm/spear-pwm.txt          |   2 +-
 .../devicetree/bindings/pwm/st,stmpe-pwm.txt       |   2 +-
 .../devicetree/bindings/pwm/ti,twl-pwm.txt         |   2 +-
 .../devicetree/bindings/pwm/ti,twl-pwmled.txt      |   2 +-
 .../devicetree/bindings/pwm/vt8500-pwm.txt         |   2 +-
 .../bindings/regulator/fixed-regulator.yaml        |   1 -
 .../bindings/regulator/max77650-regulator.txt      |  41 ----
 .../bindings/regulator/max77650-regulator.yaml     |  31 +++
 .../bindings/remoteproc/st,stm32-rproc.yaml        | 128 ++++++++++
 .../devicetree/bindings/remoteproc/stm32-rproc.txt |  63 -----
 .../bindings/rng/samsung,exynos4-rng.txt           |  19 --
 .../bindings/rng/samsung,exynos4-rng.yaml          |  45 ++++
 .../devicetree/bindings/rng/st,stm32-rng.txt       |  25 --
 .../devicetree/bindings/rng/st,stm32-rng.yaml      |  48 ++++
 .../devicetree/bindings/rtc/renesas,sh-rtc.yaml    |  70 ++++++
 Documentation/devicetree/bindings/rtc/rtc-sh.txt   |  28 ---
 Documentation/devicetree/bindings/rtc/s3c-rtc.txt  |  31 ---
 Documentation/devicetree/bindings/rtc/s3c-rtc.yaml |  89 +++++++
 .../devicetree/bindings/serial/samsung_uart.txt    |  58 -----
 .../devicetree/bindings/serial/samsung_uart.yaml   | 118 ++++++++++
 .../devicetree/bindings/serial/sprd-uart.txt       |  32 ---
 .../devicetree/bindings/serial/sprd-uart.yaml      |  72 ++++++
 .../bindings/serio/allwinner,sun4i-a10-ps2.yaml    |  51 ++++
 .../bindings/serio/allwinner,sun4i-ps2.txt         |  22 --
 .../bindings/soc/amlogic/amlogic,canvas.txt        |  33 ---
 .../bindings/soc/amlogic/amlogic,canvas.yaml       |  49 ++++
 .../bindings/soc/bcm/brcm,bcm2835-pm.txt           |   2 +-
 .../devicetree/bindings/soc/mediatek/scpsys.txt    |   2 +-
 .../devicetree/bindings/soc/ti/sci-pm-domain.txt   |   2 +-
 .../devicetree/bindings/sram/milbeaut-smp-sram.txt |  24 --
 .../devicetree/bindings/sram/renesas,smp-sram.txt  |  27 ---
 .../devicetree/bindings/sram/rockchip-smp-sram.txt |  30 ---
 .../devicetree/bindings/sram/samsung-sram.txt      |  38 ---
 Documentation/devicetree/bindings/sram/sram.txt    |  80 -------
 Documentation/devicetree/bindings/sram/sram.yaml   | 257 +++++++++++++++++++++
 .../devicetree/bindings/submitting-patches.txt     |  21 +-
 .../bindings/thermal/st,stm32-thermal.yaml         |  79 +++++++
 .../devicetree/bindings/thermal/stm32-thermal.txt  |  61 -----
 .../devicetree/bindings/timer/ingenic,tcu.txt      |   2 +-
 .../bindings/timer/samsung,exynos4210-mct.txt      |  88 -------
 .../bindings/timer/samsung,exynos4210-mct.yaml     | 124 ++++++++++
 .../devicetree/bindings/timer/st,stm32-timer.txt   |  22 --
 .../devicetree/bindings/timer/st,stm32-timer.yaml  |  47 ++++
 .../bindings/usb/allwinner,sun4i-a10-musb.txt      |  28 ---
 .../bindings/usb/allwinner,sun4i-a10-musb.yaml     | 100 ++++++++
 .../devicetree/bindings/usb/amlogic,dwc3.txt       |  88 -------
 .../bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml  | 127 ++++++++++
 .../devicetree/bindings/usb/generic-ehci.yaml      |   5 +
 .../bindings/watchdog/amlogic,meson-gxbb-wdt.yaml  |   3 +
 .../devicetree/bindings/watchdog/renesas,wdt.txt   |   1 +
 .../devicetree/bindings/watchdog/samsung-wdt.txt   |  35 ---
 .../devicetree/bindings/watchdog/samsung-wdt.yaml  |  74 ++++++
 Documentation/devicetree/writing-schema.rst        |   9 +-
 MAINTAINERS                                        |  18 +-
 arch/arm/boot/compressed/libfdt_env.h              |   4 +-
 arch/powerpc/boot/libfdt_env.h                     |   2 +
 drivers/of/address.c                               | 103 ++++-----
 drivers/of/base.c                                  |  32 ++-
 drivers/of/fdt.c                                   |   4 +-
 drivers/of/of_private.h                            |  14 ++
 drivers/of/overlay.c                               |  37 +--
 drivers/of/property.c                              |   8 +-
 drivers/of/unittest-data/testcases.dts             |   1 +
 drivers/of/unittest-data/tests-address.dtsi        |  48 ++++
 drivers/of/unittest.c                              |  96 +++++++-
 include/dt-bindings/sound/samsung-i2s.h            |  12 +-
 include/linux/libfdt_env.h                         |   5 +-
 include/linux/of_address.h                         |  21 +-
 scripts/checkpatch.pl                              |   8 +
 scripts/dtc/Makefile                               |   4 +-
 scripts/dtc/dtx_diff                               |  12 +-
 257 files changed, 6472 insertions(+), 3841 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/amlogic/smp-sram.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/axentia.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/samsung/pmu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/pmu.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/samsung-secure-firmware.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/samsung/sysreg.txt
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/sysreg.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/sprd.txt
 create mode 100644 Documentation/devicetree/bindings/arm/sprd.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/sunxi/smp-sram.txt
 delete mode 100644 Documentation/devicetree/bindings/bus/renesas,bsc.txt
 create mode 100644 Documentation/devicetree/bindings/bus/renesas,bsc.yaml
 delete mode 100644 Documentation/devicetree/bindings/bus/simple-pm-bus.txt
 create mode 100644 Documentation/devicetree/bindings/bus/simple-pm-bus.yaml
 delete mode 100644 Documentation/devicetree/bindings/counter/stm32-lptimer-cnt.txt
 delete mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
 delete mode 100644 Documentation/devicetree/bindings/crypto/samsung-slimsss.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/samsung-slimsss.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/samsung-sss.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/samsung-sss.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/st,stm32-crc.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/st,stm32-crc.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/st,stm32-cryp.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/st,stm32-cryp.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/st,stm32-hash.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/st,stm32-hash.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/panel/sharp,ld-d5116z01b.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,ld-d5116z01b.yaml
 create mode 100644 Documentation/devicetree/bindings/display/st,stm32-dsi.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
 create mode 100644 Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
 create mode 100644 Documentation/devicetree/bindings/eeprom/at24.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpu/samsung-g2d.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/samsung-g2d.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpu/samsung-rotator.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpu/samsung-scaler.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
 delete mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
 create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-stm32.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/st,stm32-i2c.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
 delete mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.txt
 create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.yaml
 delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
 delete mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
 create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
 delete mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu.txt
 create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu.yaml
 delete mode 100644 Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt
 create mode 100644 Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.yaml
 create mode 100644 Documentation/devicetree/bindings/mailbox/st,stm32-ipcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt
 create mode 100644 Documentation/devicetree/bindings/media/amlogic,meson-gx-ao-cec.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/meson-ao-cec.txt
 delete mode 100644 Documentation/devicetree/bindings/media/st,stm32-cec.txt
 create mode 100644 Documentation/devicetree/bindings/media/st,stm32-cec.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/st,stm32-dcmi.txt
 create mode 100644 Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos-srom.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos-srom.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/max77650.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/stm32-timers.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/syscon.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/syscon.yaml
 delete mode 100644 Documentation/devicetree/bindings/misc/allwinner,syscon.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt
 create mode 100644 Documentation/devicetree/bindings/net/can/allwinner,sun4i-a10-can.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/sun4i_can.txt
 delete mode 100644 Documentation/devicetree/bindings/net/davinci-mdio.txt
 create mode 100644 Documentation/devicetree/bindings/net/ti,davinci-mdio.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/pd-samsung.txt
 create mode 100644 Documentation/devicetree/bindings/power/pd-samsung.yaml
 create mode 100644 Documentation/devicetree/bindings/power/power-domain.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/reset/syscon-poweroff.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-samsung.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
 delete mode 100644 Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt
 delete mode 100644 Documentation/devicetree/bindings/rng/samsung,exynos4-rng.txt
 create mode 100644 Documentation/devicetree/bindings/rng/samsung,exynos4-rng.yaml
 delete mode 100644 Documentation/devicetree/bindings/rng/st,stm32-rng.txt
 create mode 100644 Documentation/devicetree/bindings/rng/st,stm32-rng.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/renesas,sh-rtc.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-sh.txt
 delete mode 100644 Documentation/devicetree/bindings/rtc/s3c-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/samsung_uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/samsung_uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/sprd-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/sprd-uart.yaml
 create mode 100644 Documentation/devicetree/bindings/serio/allwinner,sun4i-a10-ps2.yaml
 delete mode 100644 Documentation/devicetree/bindings/serio/allwinner,sun4i-ps2.txt
 delete mode 100644 Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.txt
 create mode 100644 Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.yaml
 delete mode 100644 Documentation/devicetree/bindings/sram/milbeaut-smp-sram.txt
 delete mode 100644 Documentation/devicetree/bindings/sram/renesas,smp-sram.txt
 delete mode 100644 Documentation/devicetree/bindings/sram/rockchip-smp-sram.txt
 delete mode 100644 Documentation/devicetree/bindings/sram/samsung-sram.txt
 delete mode 100644 Documentation/devicetree/bindings/sram/sram.txt
 create mode 100644 Documentation/devicetree/bindings/sram/sram.yaml
 create mode 100644 Documentation/devicetree/bindings/thermal/st,stm32-thermal.yaml
 delete mode 100644 Documentation/devicetree/bindings/thermal/stm32-thermal.txt
 delete mode 100644 Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.txt
 create mode 100644 Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/st,stm32-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/st,stm32-timer.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.txt
 create mode 100644 Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
 create mode 100644 drivers/of/unittest-data/tests-address.dtsi
