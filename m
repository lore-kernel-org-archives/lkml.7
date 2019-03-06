Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEFBC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BBD2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbfCFPe2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:34:28 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37689 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCFPe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:34:28 -0500
Received: by mail-qt1-f196.google.com with SMTP id a48so13262672qtb.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 07:34:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L/Lm/mU4YpSl5FDor1xg7Nlp8Z/dsglv3924f0dOL5U=;
        b=MP9lTrIb0ezAb46O3UjmgVcmuvZJsKLMEg7VnxedKhL1y90ENHHMyZ4u6LzGueszff
         3BJGw8Ja+Bm4v5SxKEWsStzFKWhdQOblXYY5hUDyr71vcwEaABb/n8nQaNQ+CEWMamNT
         1ClZBP50w02M8LZ9sYd4XNR3KfZ9PXNDMQG9FjFfHe8bOitLCT7dY7UBKnX9vm857mpJ
         12v2yYuYMTBhhDzNl+vU82XljMEhf1SE/bOCAWEOf6K5I0+cTR/8ABTHjA+yvZcUIOud
         50c9WKdczhOJqMaJXazBfxIs8NdTaxz/TNnrgt2oW+AN7r4n+UYsEiQ9egcFS4yw8mJW
         PSOg==
X-Gm-Message-State: APjAAAW0+d+OawqyWwBZmWzHXhC/9Q3svqow2G8pvpDdsXbyvu40uZ1n
        ByLafGhXWRgx2gBQ0sZ6y47yoaAhTpx5Kr+UqGVzad98
X-Google-Smtp-Source: APXvYqwMO+5REtxO0k1ZUsDNphUI5AtdUUXc2cIXPwweKJWQR1V4FlVY6HmjTTKBDCGu62eQnI+1IwduCOxXYawCNzQ=
X-Received: by 2002:a0c:b501:: with SMTP id d1mr6819128qve.115.1551886465760;
 Wed, 06 Mar 2019 07:34:25 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a1mnNrpf5moqi4x9BaTNpE9ZUgs-VBjXoG7=AxENwYtbQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1mnNrpf5moqi4x9BaTNpE9ZUgs-VBjXoG7=AxENwYtbQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Mar 2019 16:34:07 +0100
Message-ID: <CAK8P3a1-j-rr1MKnVqD8__YnqPsP8y4S_TWr+TRJScRvkrFymA@mail.gmail.com>
Subject: [GIT PULL 3/6] ARM: SoC driver updates for 5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f17b5f06cb92ef2250513a1e154c47b78df07d40:

  Linux 5.0-rc4 (2019-01-27 15:18:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-drivers

for you to fetch changes up to 8ceb820b69fe6ff58234ff604146a9e88e6c1974:

  Merge tag 'soc-fsl-next-v5.1-4' of
git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux into
arm/drivers (2019-03-01 15:05:54 +0100)

----------------------------------------------------------------
ARM: SoC driver updates for 5.1

As usual, the drivers/tee and drivers/reset subsystems get merged
here, with the expected set of smaller updates and some new hardware
support. The tee subsystem now supports device drivers to be attached
to a tee, the first example here is a random number driver with its
implementation in the secure world.

Three new power domain drivers get added for specific chip families:
 - Broadcom BCM283x chips (used in Raspberry Pi)
 - Qualcomm Snapdragon phone chips
 - Xilinx ZynqMP FPGA SoCs

One new driver is added to talk to the BPMP firmware on NVIDIA
Tegra210

Existing drivers are extended for new SoC variants from NXP,
NVIDIA, Amlogic and Qualcomm.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Abel Vesa (1):
      soc: imx: Break dependency on SOC_IMX8MQ for GPCv2

Aisheng Dong (3):
      dt-bindings: fsl: scu: add fallback compatible string for power domain
      dt-bindings: fsl: scu: add imx8qm scu power domain support
      firmware: imx: scu-pd: add fallback compatible string support

Alexey Khoroshilov (1):
      soc: qcom: gsbi: Fix error handling in gsbi_probe()

Amit Kucheria (1):
      MAINTAINERS: update list of qcom drivers

Andrey Smirnov (3):
      dt-bindings: reset: imx7: Document usage on i.MX8MQ SoCs
      reset: imx7: Add plubming to support multiple IP variants
      reset: imx7: Add support for i.MX8MQ IP block variant

Andy Gross (2):
      Merge tag 'qcom-fixes-for-5.0-rc1' into drivers-for-5.1
      soc: qcom: llcc-slice: Fix typos

Arnd Bergmann (19):
      Merge tag 'soc-fsl-next-v5.1-2' of
git://git.kernel.org/.../leo/linux into arm/drivers
      Merge tag 'zynqmp-soc-for-v5.1' of
https://github.com/Xilinx/linux-xlnx into arm/drivers
      Merge tag 'imx-drivers-5.1' of
git://git.kernel.org/.../shawnguo/linux into arm/drivers
      Merge tag 'amlogic-drivers' of
git://git.kernel.org/.../khilman/linux-amlogic into arm/drivers
      Merge tag 'reset-for-5.1' of
git://git.pengutronix.de/git/pza/linux into arm/drivers
      Merge tag 'tegra-for-5.1-firmware' of
git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'tegra-for-5.1-soc' of
git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'tegra-for-5.1-cpufreq' of
git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'tegra-for-5.1-clk' of
git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'hisi-drivers-for-5.1' of
git://github.com/hisilicon/linux-hisi into arm/drivers
      Merge tag 'tee-bus-for-5.1' of
https://git.linaro.org/people/jens.wiklander/linux-tee into
arm/drivers
      Merge tag 'qcom-drivers-for-5.1' of
git://git.kernel.org/.../agross/linux into arm/drivers
      Merge tag 'arm-soc/for-5.1/drivers' of
https://github.com/Broadcom/stblinux into arm/drivers
      Merge tag 'drivers_soc_for_5.1' of
git://git.kernel.org/.../ssantosh/linux-keystone into arm/drivers
      Merge tag 'qcom-drivers-for-5.1-2' of
git://git.kernel.org/.../agross/linux into arm/drivers
      Merge tag 'qcom-drivers-for-5.1-3' of
git://git.kernel.org/.../agross/linux into arm/drivers
      Merge tag 'soc-fsl-next-v5.1-3' of
git://git.kernel.org/.../leo/linux into arm/drivers
      Merge tag 'tee-misc-for-v5.1' of
https://git.linaro.org/people/jens.wiklander/linux-tee into
arm/drivers
      Merge tag 'soc-fsl-next-v5.1-4' of
git://git.kernel.org/.../leo/linux into arm/drivers

Bjorn Andersson (1):
      soc: qcom: rpmpd: Drop family A RPM dependency

Colin Ian King (1):
      soc: fsl: dpio: fix memory leak of a struct qbman on error exit path

Craig Tatlor (1):
      soc: qcom: smd-rpm: Add sdm660 compatible

Dan Carpenter (1):
      soc: fsl: dpio: Use after free in dpaa2_dpio_remove()

Daniel Baluta (1):
      firmware: imx: Add support to start/stop a CPU

Eric Anholt (5):
      dt-bindings: soc: Add a new binding for the BCM2835 PM node. (v4)
      bcm2835-pm: Move bcm2835-watchdog's DT probe to an MFD.
      soc: bcm: bcm2835-pm: Add support for power domains under a new binding.
      ARM: bcm283x: Extend the WDT DT node out to cover the whole PM block. (v4)
      ARM: bcm283x: Switch V3D over to using the PM driver instead of firmware.

Evan Green (2):
      soc: qcom: rmtfs-mem: Add class to enable uevents
      soc: qcom: rmtfs-mem: Make sysfs attributes world-readable

Florian Fainelli (3):
      dt-bindings: reset: Add document for Broadcom STB reset controller
      reset: Add Broadcom STB SW_INIT reset controller driver
      Merge tag 'tags/bcm2835-drivers-next-2019-02-01' into drivers/next

Horia Geantă (1):
      soc: fsl: guts: make fsl_guts_get_svr() static

Igor Opaniuk (1):
      tee: add cancellation support to client interface

Ioana Ciocoi Radulescu (2):
      soc: fsl: dpio: Add prefetch instruction
      soc: fsl: dpio: Change bpid type to u16

Ioana Ciornei (3):
      soc: fsl: dpio: enable frame data cache stashing per software portal
      soc: fsl: dpio: configure cache stashing destination
      dpaa2-eth: configure the cache stashing amount on a queue

Jerome Brunet (3):
      dt-bindings: amlogic: add new compatible devices to clk_measure
      soc: amlogic: clk-measure: add axg and g12a support
      dt-bindings: reset: meson: add g12a bindings

Jerome Forissier (1):
      tee: optee: update optee_msg.h and optee_smc.h to dual license

John Garry (1):
      bus: hisi_lpc: Don't fail probe for unrecognised child devices

Jolly Shah (2):
      firmware: xilinx: Implement ZynqMP power management APIs
      drivers: soc: xilinx: Add ZynqMP power domain driver

Jon Hunter (1):
      soc/tegra: pmc: Make tegra_powergate_is_powered() a local function

Jordan Crouse (2):
      qcom: soc: llcc-slice: Clear the global drv_data pointer on error
      qcom: soc: llcc-slice: Consolidate some code

Joseph Lo (8):
      soc/tegra: fuse: Fix typo in tegra210_init_speedo_data
      clk: tegra: dfll: CVB calculation alignment with the regulator
      clk: tegra: dfll: support PWM regulator control
      clk: tegra: dfll: round down voltages based on alignment
      clk: tegra: dfll: add CVB tables for Tegra210
      cpufreq: tegra124: do not handle the CPU rail
      cpufreq: tegra124: extend to support Tegra210
      cpufreq: dt-platdev: add Tegra210 to blacklist

Li Yang (1):
      soc: fsl: guts: reuse machine name from device tree

Lucas Stach (2):
      soc: imx: gpcv2: handle additional power-down bits in handshake register
      soc: imx: gpcv2: handle reset clocks

Mikko Perttunen (1):
      soc/tegra: pmc: Support systems where PMC is marked secure

Nathan Chancellor (3):
      soc: ti: knav_dma: Use proper enum in pktdma_init_chan
      tee: optee: Initialize some structs using memset instead of braces
      hwrng: optee: Initialize some structs using memset instead of braces

Nava kishore Manne (6):
      firmware: xilinx: Add reset API's
      dt-bindings: reset: Add bindings for ZynqMP reset driver
      reset: reset-zynqmp: Adding support for Xilinx zynqmp reset controller.
      firmware: xilinx: Add zynqmp_pm_get_chipid() API
      dt-bindings: nvmem: Add bindings for ZynqMP nvmem driver
      nvmem: zynqmp: Added zynqmp nvmem firmware driver

Neil Armstrong (1):
      soc: amlogic: canvas: Fix meson_canvas_get when probe failed

Peter De Schrijver (2):
      clk: tegra: dfll: registration for multiple SoCs
      clk: tegra: dfll: build clk-dfll.c for Tegra124 and Tegra210

Philipp Zabel (3):
      MAINTAINERS: use include/linux/reset for reset controller related headers
      reset: sunxi: declare sun6i_reset_init in a header file
      reset: socfpga: declare socfpga_reset_init in a header file

Rajan Vaja (4):
      dt-bindings: soc: Add ZynqMP PM bindings
      drivers: soc: xilinx: Add ZynqMP PM driver
      dt-bindings: power: Add ZynqMP power domain bindings
      firmware: xilinx: Add APIs to control node status/power

Rajendra Nayak (8):
      dt-bindings: opp: Introduce opp-level bindings
      OPP: Add support for parsing the 'opp-level' property
      dt-bindings: power: Add qcom rpm power domain driver bindings
      soc: qcom: rpmpd: Add a Power domain driver to model corners
      soc: qcom: rpmpd: Add support for get/set performance state
      soc: qcom: rpmhpd: Add RPMh power domain driver
      soc: qcom: rpmhpd: Mark mx as a parent for cx
      soc: qcom: update config dependencies for QCOM_RPMPD

Raju P.L.S.S.S.N (1):
      drivers: qcom: rpmh: avoid sending sleep/wake sets immediately

Stefan Wahren (3):
      soc: bcm2835: sync firmware properties with downstream
      firmware: raspberrypi: notify VC4 firmware of a reboot
      soc: bcm: Make PM driver default for BCM2835

Stephen Boyd (1):
      soc: qcom: rpmh: Avoid accessing freed memory from batch API

Sumit Garg (5):
      tee: add supp_nowait flag in tee_context struct
      tee: add bus driver framework for TEE based devices
      tee: optee: add TEE bus device enumeration support
      hwrng: add OP-TEE based rng driver
      tee: fix possible error pointer ctx dereferencing

Sven Van Asbroeck (3):
      dt-bindings: bus: imx-weim: document multiple address ranges per
child node
      bus: imx-weim: support multiple address ranges per child node
      bus: imx-weim: guard against timing configuration conflicts

Thierry Reding (9):
      soc/tegra: pmc: Use TEGRA186_ prefix for GPIO names
      soc/tegra: pmc: Sort includes alphabetically
      soc/tegra: pmc: Add missing kerneldoc
      firmware: tegra: bpmp-tegra186: Remove unused includes
      soc/tegra: pmc: Pass struct tegra_pmc * where possible
      soc/tegra: pmc: Make alignment consistent
      soc/tegra: pmc: Explicitly initialize all fields
      firmware: tegra: Conditionally support SoC generations
      firmware/tegra: Enable Tegra186 BPMP support on Tegra194

Timo Alho (4):
      soc/tegra: fuse: Fix illegal free of IO base address
      firmware: tegra: Reword messaging terminology
      firmware: tegra: Refactor BPMP driver
      firmware: tegra: add bpmp driver for Tegra210

Wei Yongjun (3):
      soc: bcm: bcm2835-pm: Make local symbol static
      clk: tegra: dfll: Make symbol 'tegra210_cpu_cvb_tables' static
      hwrng: make symbol 'optee_rng_id_table' static

Yangtao Li (1):
      firmware: ti_sci: Change to use DEFINE_SHOW_ATTRIBUTE macro

YueHaibing (2):
      hwrng: Fix unsigned comparison with less than zero
      tee: optee: Fix unsigned comparison with less than zero

wen yang (1):
      soc: amlogic: add missing of_node_put()

 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt         |   8 +-
 Documentation/devicetree/bindings/bus/imx-weim.txt                  |  32 ++-
 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt       |  46 ++++
 Documentation/devicetree/bindings/opp/opp.txt                       |   3 +
 Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt           |   3 +
 Documentation/devicetree/bindings/power/qcom,rpmpd.txt              |
145 +++++++++++++
 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt |  25 +++
 Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt       |  34 +++
 Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt      |  27 +++
 Documentation/devicetree/bindings/reset/fsl,imx7-src.txt            |   7 +-
 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt       |  52 +++++
 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt       |   2 +
 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt       |  46 ++++
 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt         |   1 +
 MAINTAINERS                                                         |  38 +++-
 arch/arm/boot/dts/bcm2835-rpi.dtsi                                  |   4 -
 arch/arm/boot/dts/bcm283x.dtsi                                      |  17 +-
 arch/arm/mach-bcm/Kconfig                                           |   1 +
 arch/arm/mach-socfpga/socfpga.c                                     |   3 +-
 arch/arm/mach-sunxi/sunxi.c                                         |   2 +-
 drivers/bus/fsl-mc/fsl-mc-allocator.c                               |  11 +
 drivers/bus/fsl-mc/mc-io.c                                          |  13 ++
 drivers/bus/hisi_lpc.c                                              |   5 +-
 drivers/bus/imx-weim.c                                              |
 70 ++++--
 drivers/char/hw_random/Kconfig                                      |  15 ++
 drivers/char/hw_random/Makefile                                     |   1 +
 drivers/char/hw_random/optee-rng.c                                  |
306 ++++++++++++++++++++++++++
 drivers/clk/tegra/Kconfig                                           |   5 +
 drivers/clk/tegra/Makefile                                          |   2 +-
 drivers/clk/tegra/clk-dfll.c                                        |
459 +++++++++++++++++++++++++++++++++------
 drivers/clk/tegra/clk-dfll.h                                        |   6 +-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c                          |
520 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/clk/tegra/cvb.c                                             |  12 +-
 drivers/clk/tegra/cvb.h                                             |   7 +-
 drivers/cpufreq/Kconfig.arm                                         |   4 +-
 drivers/cpufreq/cpufreq-dt-platdev.c                                |   1 +
 drivers/cpufreq/tegra124-cpufreq.c                                  |  44 +---
 drivers/crypto/caam/caamalg_qi2.c                                   |   6 +-
 drivers/firmware/imx/misc.c                                         |  38 ++++
 drivers/firmware/imx/scu-pd.c                                       |   1 +
 drivers/firmware/raspberrypi.c                                      |  11 +
 drivers/firmware/tegra/Makefile                                     |   3 +
 drivers/firmware/tegra/bpmp-private.h                               |  34 +++
 drivers/firmware/tegra/bpmp-tegra186.c                              |
305 ++++++++++++++++++++++++++
 drivers/firmware/tegra/bpmp-tegra210.c                              |
243 +++++++++++++++++++++
 drivers/firmware/tegra/bpmp.c                                       |
376 +++++++++++++-------------------
 drivers/firmware/ti_sci.c                                           |  21 +-
 drivers/firmware/xilinx/Kconfig                                     |   1 +
 drivers/firmware/xilinx/zynqmp.c                                    |
166 ++++++++++++++
 drivers/mfd/Makefile                                                |   1 +
 drivers/mfd/bcm2835-pm.c                                            |
 92 ++++++++
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c                    |  16 +-
 drivers/nvmem/Kconfig                                               |  10 +
 drivers/nvmem/Makefile                                              |   2 +
 drivers/nvmem/zynqmp_nvmem.c                                        |
 86 ++++++++
 drivers/opp/core.c                                                  |  18 ++
 drivers/opp/of.c                                                    |   2 +
 drivers/opp/opp.h                                                   |   2 +
 drivers/reset/Kconfig                                               |  12 +-
 drivers/reset/Makefile                                              |   2 +
 drivers/reset/reset-brcmstb.c                                       |
132 +++++++++++
 drivers/reset/reset-imx7.c                                          |
172 +++++++++++++--
 drivers/reset/reset-socfpga.c                                       |   2 +-
 drivers/reset/reset-sunxi.c                                         |   1 +
 drivers/reset/reset-zynqmp.c                                        |
114 ++++++++++
 drivers/soc/amlogic/meson-canvas.c                                  |  18 +-
 drivers/soc/amlogic/meson-clk-measure.c                             |
196 +++++++++++++++++
 drivers/soc/bcm/Kconfig                                             |  12 +
 drivers/soc/bcm/Makefile                                            |   1 +
 drivers/soc/bcm/bcm2835-power.c                                     |
661 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/soc/fsl/Kconfig                                             |   1 +
 drivers/soc/fsl/dpio/dpio-cmd.h                                     |   6 +
 drivers/soc/fsl/dpio/dpio-driver.c                                  |
 93 ++++++--
 drivers/soc/fsl/dpio/dpio-service.c                                 |  46 +++-
 drivers/soc/fsl/dpio/dpio.c                                         |  39 ++++
 drivers/soc/fsl/dpio/dpio.h                                         |   9 +
 drivers/soc/fsl/dpio/qbman-portal.c                                 |   5 +-
 drivers/soc/fsl/guts.c                                              |  10 +-
 drivers/soc/imx/Kconfig                                             |   2 +-
 drivers/soc/imx/gpcv2.c                                             |
 76 ++++++-
 drivers/soc/qcom/Kconfig                                            |  18 ++
 drivers/soc/qcom/Makefile                                           |   2 +
 drivers/soc/qcom/llcc-sdm845.c                                      |   6 +
 drivers/soc/qcom/llcc-slice.c                                       |
101 ++++++---
 drivers/soc/qcom/qcom_gsbi.c                                        |   7 +-
 drivers/soc/qcom/rmtfs_mem.c                                        |  32 ++-
 drivers/soc/qcom/rpmh.c                                             |  37 ++--
 drivers/soc/qcom/rpmhpd.c                                           |
406 ++++++++++++++++++++++++++++++++++
 drivers/soc/qcom/rpmpd.c                                            |
315 +++++++++++++++++++++++++++
 drivers/soc/qcom/smd-rpm.c                                          |   1 +
 drivers/soc/tegra/fuse/fuse-tegra.c                                 |  12 +-
 drivers/soc/tegra/fuse/speedo-tegra210.c                            |   2 +-
 drivers/soc/tegra/pmc.c                                             |
424 ++++++++++++++++++++++++------------
 drivers/soc/ti/knav_dma.c                                           |   2 +-
 drivers/soc/xilinx/Kconfig                                          |  20 ++
 drivers/soc/xilinx/Makefile                                         |   2 +
 drivers/soc/xilinx/zynqmp_pm_domains.c                              |
321 +++++++++++++++++++++++++++
 drivers/soc/xilinx/zynqmp_power.c                                   |
178 +++++++++++++++
 drivers/tee/optee/Makefile                                          |   1 +
 drivers/tee/optee/core.c                                            |   4 +
 drivers/tee/optee/device.c                                          |
160 ++++++++++++++
 drivers/tee/optee/optee_msg.h                                       |  26 +--
 drivers/tee/optee/optee_private.h                                   |   3 +
 drivers/tee/optee/optee_smc.h                                       |  26 +--
 drivers/tee/optee/supp.c                                            |  10 +-
 drivers/tee/tee_core.c                                              |
 78 ++++++-
 drivers/watchdog/bcm2835_wdt.c                                      |  26 +--
 include/dt-bindings/power/qcom-rpmpd.h                              |  39 ++++
 include/dt-bindings/power/xlnx-zynqmp-power.h                       |  39 ++++
 include/dt-bindings/reset/amlogic,meson-g12a-reset.h                |
134 ++++++++++++
 include/dt-bindings/reset/imx8mq-reset.h                            |
 64 ++++++
 include/dt-bindings/reset/xlnx-zynqmp-resets.h                      |
130 +++++++++++
 include/dt-bindings/soc/bcm2835-pm.h                                |  28 +++
 include/linux/firmware/imx/svc/misc.h                               |   3 +
 include/linux/firmware/xlnx-zynqmp.h                                |
184 ++++++++++++++++
 include/linux/fsl/guts.h                                            |   2 -
 include/linux/fsl/mc.h                                              |   1 +
 include/linux/mfd/bcm2835-pm.h                                      |  14 ++
 include/linux/mod_devicetable.h                                     |   9 +
 include/linux/pm_opp.h                                              |   7 +
 include/linux/reset/socfpga.h                                       |   7 +
 include/linux/reset/sunxi.h                                         |   7 +
 include/linux/soc/qcom/llcc-qcom.h                                  |   6 +
 include/linux/tee_drv.h                                             |  50 ++++-
 include/soc/bcm2835/raspberrypi-firmware.h                          |   4 +
 include/soc/fsl/dpaa2-io.h                                          |  15 +-
 include/soc/tegra/bpmp.h                                            |  13 +-
 include/soc/tegra/pmc.h                                             |   6 -
 scripts/mod/devicetable-offsets.c                                   |   3 +
 scripts/mod/file2alias.c                                            |  19 ++
 130 files changed, 7252 insertions(+), 773 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
 create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
 create mode 100644
Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
 create mode 100644
Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
 create mode 100644
Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt
 create mode 100644
Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
 create mode 100644
Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
 create mode 100644 drivers/char/hw_random/optee-rng.c
 create mode 100644 drivers/firmware/tegra/bpmp-private.h
 create mode 100644 drivers/firmware/tegra/bpmp-tegra186.c
 create mode 100644 drivers/firmware/tegra/bpmp-tegra210.c
 create mode 100644 drivers/mfd/bcm2835-pm.c
 create mode 100644 drivers/nvmem/zynqmp_nvmem.c
 create mode 100644 drivers/reset/reset-brcmstb.c
 create mode 100644 drivers/reset/reset-zynqmp.c
 create mode 100644 drivers/soc/bcm/bcm2835-power.c
 create mode 100644 drivers/soc/qcom/rpmhpd.c
 create mode 100644 drivers/soc/qcom/rpmpd.c
 create mode 100644 drivers/soc/xilinx/zynqmp_pm_domains.c
 create mode 100644 drivers/soc/xilinx/zynqmp_power.c
 create mode 100644 drivers/tee/optee/device.c
 create mode 100644 include/dt-bindings/power/qcom-rpmpd.h
 create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h
 create mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-reset.h
 create mode 100644 include/dt-bindings/reset/imx8mq-reset.h
 create mode 100644 include/dt-bindings/reset/xlnx-zynqmp-resets.h
 create mode 100644 include/dt-bindings/soc/bcm2835-pm.h
 create mode 100644 include/linux/mfd/bcm2835-pm.h
 create mode 100644 include/linux/reset/socfpga.h
 create mode 100644 include/linux/reset/sunxi.h
