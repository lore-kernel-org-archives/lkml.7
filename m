Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FA3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A4B20657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505687;
	bh=hTs/q180V5x0qVQ0yCi2hICourD8vnBxb5LAjfpUGNQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=c5dUVtwvHiB2ADVeAATuxz+6RR1EG3K6Ivin8JGASKqdT+5EZsk347a9LPRD/ZRVa
	 VNdNQh4KqXu8gUK6Zq2jSJn4PiDusjAaPRqIZ6EBaxOLNtb/niu/lf/N2KtDCV2AA4
	 ESJpf3nK7yZ1iRHN3DWYielLDjExiDI4xE7iyn2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfCMTeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfCMTeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:34:44 -0400
Received: from localhost (unknown [106.201.122.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92C3A20657;
        Wed, 13 Mar 2019 19:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552505683;
        bh=hTs/q180V5x0qVQ0yCi2hICourD8vnBxb5LAjfpUGNQ=;
        h=Date:From:To:Cc:Subject:From;
        b=ZRTNl6qy0kiXSkJRCpmBaVE8cWWnOmzt3zMowq8PZoPfG6MKPouBye0TWj+LialEY
         Z2oWo1ihOf2s6mlVdSgmy3bzhNWEBh+tnPOUcaUNd0KkMrQZtjldUzj9qmvHTP1+UO
         ImRExQL6dDqhV7ysIfWMwJumFpqepRTaFrBuyyjg=
Date:   Thu, 14 Mar 2019 01:04:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dma <dmaengine@vger.kernel.org>
Subject: [PULL REQUEST] dmaengine updates for v5.1-rc1
Message-ID: <20190313193437.GD18228@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here is the pull request for dmaengine. Please pull to receive update
mostly on the drivers.

Please note, as reported by SFR, we have a merge conflict in dmatest,
the fix is already in linux-next. Since, you like to see and resolve
conflicts yourself, I have left it for you.

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-5.1-rc1

for you to fetch changes up to feb59d77a46d5df93864471ca926b6701479091b:

  Merge branch 'topic/xilinx' into for-linus (2019-03-12 12:05:47 +0530)

----------------------------------------------------------------
dmaengine updates for v5.1-rc1

 - dmatest updates for modularizing common struct and code
 - remove SG support for VDMA xilinx IP and updates to driver
 - Update to dw driver to support Intel iDMA controllers
   multi-block support
 - tegra updates for proper reporting of residue
 - Add Snow Ridge ioatdma device id and support for IOATDMA v3.4
 - struct_size() usage and useless LIST_HEAD cleanups in subsystem.
 - qDMA controller driver for Layerscape SoCs
 - stm32-dma PM Runtime support
 - And usual updates to imx-sdma, sprd, Documentation, fsl-edma,
   bcm2835, qcom_hidma etc

----------------------------------------------------------------
Aditya Pakki (3):
      dmaengine: mv_xor: Fix a missing check in mv_xor_channel_add
      dmaengine: qcom_hidma: Check for driver register failure
      dmaengine: stm32-mdma: Add a check on read_u32_array

Alexandru Ardelean (3):
      dmaengine: dmatest: wrap src & dst data into a struct
      dmaengine: dmatest: add short-hand `buf_size` var in dmatest_func()
      dmaengine: dmatest: move test data alloc & free into functions

Anders Roxell (1):
      dmaengine: imx-dma: fix warning comparison of distinct pointer types

Andrea Merello (6):
      dmaengine: xilinx_dma: commonize DMA copy size calculation
      dmaengine: xilinx_dma: in axidma slave_sg and dma_cyclic mode align s=
plit descriptors
      dt-bindings: dmaengine: xilinx_dma: add optional xlnx,sg-length-width=
 property
      dmaengine: xilinx_dma: autodetect whether the HW supports scatter-gat=
her
      dt-bindings: dmaengine: xilinx_dma: drop include-sg property
      dmaengine: xilinx_dma: Drop SG support for VDMA IP

Andy Duan (1):
      dmaengine: imx-sdma: pass ->dev to dma_alloc_coherent() API

Andy Shevchenko (8):
      dmaengine: dw: Add missed multi-block support for iDMA 32-bit
      dmaengine: dw: Remove misleading is_private property
      dmaengine: dw: Remove unused internal property
      dmaengine: dw: Split DW and iDMA 32-bit operations
      dmaengine: dw: Reset DRAIN bit when resume the channel
      dmaengine: dw: Don't pollute CTL_LO on iDMA 32-bit
      dmaengine: dw: convert to SPDX identifiers
      dmaengine: dw-axi-dmac: Fix trivia typo

Angus Ainslie (Purism) (3):
      dmaengine: imx-sdma: add clock ratio 1:1 check
      dmaengine: imx-sdma: add a test for imx8mq multi sdma devices
      dmaengine: imx-sdma: fix consistent dma test failures

Arnd Bergmann (1):
      dmaengine: fsl-qdma: add MODULE_LICENSE

Baolin Wang (2):
      dt-bindings: dmaengine: sprd: Change channel id to slave id for DMA c=
ell specifier
      dmaengine: sprd: Change channel id to slave id for DMA cell specifier

Ben Dooks (5):
      dmaengine: tegra: avoid overflow of byte tracking
      dmaengine: tegra: make byte counters unsigned int
      dmaengine: tegra: fix incorrect case of DMA
      dmaengine: tegra: reduce channel name field size
      dmaengine: tegra: add tracepoints to driver

Dave Jiang (4):
      dmaengine: ioatdma: Add Snow Ridge ioatdma device id
      dmaengine: ioatdma: disable DCA enabling on IOATDMA v3.4
      dmaengine: ioatdma: add descriptor pre-fetch support for v3.4
      dmaengine: ioatdma: support latency tolerance report (LTR) for v3.4

Federico Vaga (1):
      Documentation :dmaengine: clarify DMA desc. pointer after submission

Gustavo A. R. Silva (9):
      dmaengine: bcm2835: Use struct_size() in kzalloc()
      dmaengine: dma-jz4780: Use struct_size() in devm_kzalloc()
      dmaengine: st_fdma: use struct_size() in kzalloc()
      dmaengine: qcom: bam_dma: use struct_size() in kzalloc()
      dmaengine: tegra-apb: Use struct_size() in devm_kzalloc()
      dmaengine: fsl-edma: use struct_size() in kzalloc()
      dmaengine: tegra210-adma: Use struct_size() in devm_kzalloc()
      dmaengine: timb_dma: Use struct_size() in kzalloc()
      dmaengine: axi-dmac: Use struct_size() in kzalloc()

John Stultz (1):
      Documentation: bindings: dma: Add binding for dma-channel-mask

Julia Lawall (5):
      dmaengine: at_hdmac: drop useless LIST_HEAD
      dmaengine: dw: drop useless LIST_HEAD
      dmaengine: st_fdma: drop useless LIST_HEAD
      dmaengine: pl330: drop useless LIST_HEAD
      dmaengine: sa11x0: drop useless LIST_HEAD

Laurentiu Tudor (1):
      dmaengine: fsl-edma: dma map slave device address

Li Yu (2):
      dmaengine: k3dma: Delete axi_config
      dmaengine: k3dma: Add support for dma-channel-mask

Lukas Wunner (6):
      dmaengine: bcm2835: Fix interrupt race on RT
      dmaengine: bcm2835: Fix abort of transactions
      dmaengine: bcm2835: Return void from abort of transactions
      dmaengine: bcm2835: Enforce control block alignment
      dmaengine: bcm2835: Drop gratuitous list deletion
      dmaengine: bcm2835: Drop outdated comment on supported transactions

Peng Ma (3):
      dmaengine: fsldma: Adding macro FSL_DMA_IN/OUT implement for ARM plat=
form
      dmaengine: fsl-qdma: Add qDMA controller driver for Layerscape SoCs
      dt-bindings: fsl-qdma: Add NXP Layerscpae qDMA controller bindings

Phuong Nguyen (1):
      dmaengine: usb-dmac: Make DMAC system sleep callbacks explicit

Pierre-Yves MORDRET (4):
      dmaengine: stm32-dma: check FIFO error interrupt enable
      dmaengine: stm32-dma: Add PM Runtime support
      dmaengine: stm32-dmamux: Add PM Runtime support
      dmaengine: stm32-mdma: Add PM Runtime support

Radhey Shyam Pandey (1):
      dmaengine: xilinx_dma: program hardware supported buffer length

Randy Dunlap (1):
      Documentation: dmaengine: fix dmatest.rst warning

Robin Gong (1):
      dmaengine: imx-sdma: refine to load context only once

Robin Murphy (1):
      dmaengine: mv_xor: Use correct device for DMA API

Scott Wood (1):
      dmaengine: fsldma: Add 64-bit I/O accessors for powerpc64

Shunyong Yang (2):
      dmaengine: qcom_hidma: initialize tx flags in hidma_prep_dma_*
      dmaengine: qcom_hidma: assign channel cookie correctly

Vinod Koul (13):
      Merge branch 'topic/qcom' into for-linus
      dmaengine: imx-dma: change variable 'now' type to size_t
      dmaengine: imx-dma: change return of 'imxdma_sg_next' to void
      Merge branch 'topic/brcm' into for-linus
      Merge branch 'topic/dw' into for-linus
      Merge branch 'topic/fsl' into for-linus
      Merge branch 'topic/imx' into for-linus
      Merge branch 'topic/k3dma' into for-linus
      Merge branch 'topic/mv' into for-linus
      Merge branch 'topic/sh' into for-linus
      Merge branch 'topic/stm' into for-linus
      Merge branch 'topic/tegra' into for-linus
      Merge branch 'topic/xilinx' into for-linus

Wen He (1):
      dmaengine: fsldma: Replace DMA_IN/OUT by FSL_DMA_IN/OUT

Youlin Wang (2):
      Documentation: bindings: k3dma: Extend the k3dma driver binding to su=
pport hisi-asp
      dmaengine: k3dma: Upgrade k3dma driver to support hisi_asp_dma hardwa=
re

YueHaibing (1):
      dmaengine: xilinx_dma: remove set but not used variable 'tail_segment'

 Documentation/devicetree/bindings/dma/dma.txt      |    4 +
 Documentation/devicetree/bindings/dma/fsl-qdma.txt |   57 +
 Documentation/devicetree/bindings/dma/k3dma.txt    |    4 +-
 Documentation/devicetree/bindings/dma/snps-dma.txt |    2 -
 Documentation/devicetree/bindings/dma/sprd-dma.txt |    2 +-
 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |    7 +-
 Documentation/driver-api/dmaengine/client.rst      |    7 +
 Documentation/driver-api/dmaengine/dmatest.rst     |    1 +
 drivers/dma/Kconfig                                |   14 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/at_hdmac.c                             |    5 -
 drivers/dma/bcm2835-dma.c                          |   95 +-
 drivers/dma/dma-axi-dmac.c                         |    3 +-
 drivers/dma/dma-jz4780.c                           |    5 +-
 drivers/dma/dmatest.c                              |  269 +++--
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h              |    2 +-
 drivers/dma/dw/Kconfig                             |    2 +
 drivers/dma/dw/Makefile                            |    2 +-
 drivers/dma/dw/core.c                              |  245 +---
 drivers/dma/dw/dw.c                                |  138 +++
 drivers/dma/dw/idma32.c                            |  160 +++
 drivers/dma/dw/internal.h                          |   15 +-
 drivers/dma/dw/pci.c                               |   53 +-
 drivers/dma/dw/platform.c                          |   22 +-
 drivers/dma/dw/regs.h                              |   30 +-
 drivers/dma/fsl-edma-common.c                      |   70 +-
 drivers/dma/fsl-edma-common.h                      |    4 +
 drivers/dma/fsl-edma.c                             |    1 +
 drivers/dma/fsl-qdma.c                             | 1259 ++++++++++++++++=
++++
 drivers/dma/fsldma.c                               |   16 +-
 drivers/dma/fsldma.h                               |   68 +-
 drivers/dma/imx-dma.c                              |    8 +-
 drivers/dma/imx-sdma.c                             |   47 +-
 drivers/dma/ioat/dma.c                             |   12 +
 drivers/dma/ioat/dma.h                             |    2 +-
 drivers/dma/ioat/hw.h                              |    3 +
 drivers/dma/ioat/init.c                            |   40 +-
 drivers/dma/ioat/registers.h                       |   24 +
 drivers/dma/k3dma.c                                |   61 +-
 drivers/dma/mcf-edma.c                             |    1 +
 drivers/dma/mv_xor.c                               |    7 +-
 drivers/dma/pl330.c                                |    1 -
 drivers/dma/qcom/bam_dma.c                         |    4 +-
 drivers/dma/qcom/hidma.c                           |   19 +-
 drivers/dma/qcom/hidma_mgmt.c                      |    3 +-
 drivers/dma/sa11x0-dma.c                           |    2 -
 drivers/dma/sh/usb-dmac.c                          |    2 +
 drivers/dma/sprd-dma.c                             |   19 +-
 drivers/dma/st_fdma.c                              |    6 +-
 drivers/dma/stm32-dma.c                            |   71 +-
 drivers/dma/stm32-dmamux.c                         |   58 +-
 drivers/dma/stm32-mdma.c                           |   56 +-
 drivers/dma/tegra20-apb-dma.c                      |   45 +-
 drivers/dma/tegra210-adma.c                        |    5 +-
 drivers/dma/timb_dma.c                             |    4 +-
 drivers/dma/xilinx/xilinx_dma.c                    |  170 +--
 drivers/tty/serial/8250/8250_lpss.c                |    1 -
 include/linux/dma/dw.h                             |    9 +-
 include/linux/platform_data/dma-dw.h               |   12 +-
 include/linux/platform_data/dma-imx.h              |    1 +
 include/trace/events/tegra_apb_dma.h               |   61 +
 61 files changed, 2621 insertions(+), 696 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-qdma.txt
 create mode 100644 drivers/dma/dw/dw.c
 create mode 100644 drivers/dma/dw/idma32.c
 create mode 100644 drivers/dma/fsl-qdma.c
 create mode 100644 include/trace/events/tegra_apb_dma.h

Thanks
--=20
~Vinod

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJciVtNAAoJEHwUBw8lI4NH8ZwP/Rkdb2cglHNvrEm8ZvsxtnOu
8g8HkPMfyTJx65Y4NZcr6VWZXI7FxRjMGG/j+GA2EsZCcKcG4JlHgIOK1z+f/PMY
xOOTeWauTLisSVzvdjOdYFuOcZYWbEKVZD6EFTuYeuzvnD6O5I/+B2rLFEDLlJfI
FJzqZfdXC5myRAiJqPqTi93bB4yP26qHf5vVcndzFKQu3kZt0jUzSC31NDjJKGbX
ykZV4JVnvvn/pcZG48Q7r9DJo66Nh/MOfDPxrK1JQ7rnz3kpNYGLctKT/SR0TfLI
WkIfrsQCUI8M/ju+rKlj5tY5MO7ql8S2s7tPeM9Ads7JkYkD1FUnMRCoycnemeGo
3tXypKvr2Rgttc4u7ZeN/OK9BM3z/9UtkAL7jomsN9ki24Ns5yD/yGj1Zov89Btx
l5goqRWyl3iGxzzydC4azHHLR45toIiOVCgO05DbKDf8ibyxqsiMf6XdCmANqwBt
sBJRFiQE36SoX6hSni+W0a2U4nyJCusW19hzYlI+4n/IyQ5xN28lcH/EcHw6CMAZ
NCu7s7pO0E4cGKuQT97uzoy3ElVyS9bnfLx16CG/91+8jo938VBCT3iOmkws7fii
bRQEnqACwT7ZCzMJlFzI6bTuDrJO0zFkB7ul+Ehn3np7n0rEPXnG4IevB1/v/d+q
89o9UfKIwwxYwqhKT/9U
=Jaz7
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
