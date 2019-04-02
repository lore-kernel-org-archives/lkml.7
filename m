Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF83C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E9921473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LsDUPXlj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q4+C2Gi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbfDBMG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:06:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38984 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfDBMG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:06:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3C43A608D4; Tue,  2 Apr 2019 12:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554206785;
        bh=E38wJWho9XPAkeZhkDa0W/onLQDfnEWSSet6ozfgVfM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LsDUPXljcqDio9Y4CgQ+CGrtSoPTb9tbuGWBslXJrIhzn0TRZD5f1D9s30VKx0UqN
         zoB4i6HDgsrJ2BuqxxCa/7YloXBGAitKs71319j3cB8kKXTjFmBWcsUo1MN/l6gXBT
         wlTkAOwKcY5qAFmrFyGSzGcYwdK10wB6rHlKzbxo=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7821960350;
        Tue,  2 Apr 2019 12:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554206783;
        bh=E38wJWho9XPAkeZhkDa0W/onLQDfnEWSSet6ozfgVfM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Q4+C2Gi/RN7yoJJ885Z+HvSXVf10ZeyGnz7qfmEYu6ZCB7De1x46c3vaLTRbEqWxF
         bu3Hre3XuSf9h5U1aLY6QxgZwn9LV5VyJ/GefuOGH6TY8kLCI3R2IH0Uh9j6xs/hqZ
         9fqDud9Hp6ry38uqK0v7qXUCdLqJjKqL1TtcPoqM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7821960350
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 02/16] staging: add missing SPDX lines to Makefile files
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org
References: <20190402103203.14959-1-gregkh@linuxfoundation.org>
 <20190402103203.14959-3-gregkh@linuxfoundation.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <78c7ffbe-0e2b-8dbd-021a-d05a84d3f88c@codeaurora.org>
Date:   Tue, 2 Apr 2019 17:36:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402103203.14959-3-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/2/2019 4:01 PM, Greg Kroah-Hartman wrote:
> There are a few remaining drivers/staging/*/Makefile files that do not
> have SPDX identifiers in them.  Add the correct GPL-2.0 identifier to
> them to make scanning tools happy.
>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Lesson learnt :-)

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>


Cheers,
-Mukesh
> ---
>   drivers/staging/android/Makefile                         | 1 +
>   drivers/staging/axis-fifo/Makefile                       | 1 +
>   drivers/staging/board/Makefile                           | 1 +
>   drivers/staging/clocking-wizard/Makefile                 | 1 +
>   drivers/staging/comedi/drivers/ni_routing/tools/Makefile | 1 +
>   drivers/staging/comedi/kcomedilib/Makefile               | 1 +
>   drivers/staging/emxx_udc/Makefile                        | 1 +
>   drivers/staging/fsl-dpaa2/Makefile                       | 1 +
>   drivers/staging/fwserial/Makefile                        | 1 +
>   drivers/staging/gasket/Makefile                          | 1 +
>   drivers/staging/goldfish/Makefile                        | 1 +
>   drivers/staging/gs_fpgaboot/Makefile                     | 1 +
>   drivers/staging/iio/accel/Makefile                       | 1 +
>   drivers/staging/iio/addac/Makefile                       | 1 +
>   drivers/staging/iio/cdc/Makefile                         | 1 +
>   drivers/staging/iio/frequency/Makefile                   | 1 +
>   drivers/staging/iio/impedance-analyzer/Makefile          | 1 +
>   drivers/staging/iio/resolver/Makefile                    | 1 +
>   drivers/staging/ks7010/Makefile                          | 1 +
>   drivers/staging/media/bcm2048/Makefile                   | 1 +
>   drivers/staging/media/davinci_vpfe/Makefile              | 1 +
>   drivers/staging/media/ipu3/Makefile                      | 1 +
>   drivers/staging/media/mt9t031/Makefile                   | 1 +
>   drivers/staging/media/rockchip/vpu/Makefile              | 1 +
>   drivers/staging/media/sunxi/Makefile                     | 1 +
>   drivers/staging/media/sunxi/cedrus/Makefile              | 1 +
>   drivers/staging/media/tegra-vde/Makefile                 | 1 +
>   drivers/staging/most/cdev/Makefile                       | 1 +
>   drivers/staging/most/dim2/Makefile                       | 1 +
>   drivers/staging/most/i2c/Makefile                        | 1 +
>   drivers/staging/most/net/Makefile                        | 1 +
>   drivers/staging/most/sound/Makefile                      | 1 +
>   drivers/staging/most/usb/Makefile                        | 1 +
>   drivers/staging/most/video/Makefile                      | 1 +
>   drivers/staging/mt7621-dma/Makefile                      | 1 +
>   drivers/staging/mt7621-dts/Makefile                      | 1 +
>   drivers/staging/mt7621-pci-phy/Makefile                  | 1 +
>   drivers/staging/mt7621-pci/Makefile                      | 1 +
>   drivers/staging/mt7621-pinctrl/Makefile                  | 1 +
>   drivers/staging/mt7621-spi/Makefile                      | 1 +
>   drivers/staging/netlogic/Makefile                        | 1 +
>   drivers/staging/olpc_dcon/Makefile                       | 1 +
>   drivers/staging/pi433/Makefile                           | 1 +
>   drivers/staging/ralink-gdma/Makefile                     | 1 +
>   drivers/staging/rtlwifi/Makefile                         | 1 +
>   drivers/staging/rtlwifi/btcoexist/Makefile               | 1 +
>   drivers/staging/rtlwifi/rtl8822be/Makefile               | 1 +
>   drivers/staging/rts5208/Makefile                         | 1 +
>   drivers/staging/sm750fb/Makefile                         | 1 +
>   drivers/staging/unisys/Makefile                          | 1 +
>   drivers/staging/unisys/visorhba/Makefile                 | 1 +
>   drivers/staging/unisys/visorinput/Makefile               | 1 +
>   drivers/staging/unisys/visornic/Makefile                 | 1 +
>   drivers/staging/vc04_services/bcm2835-audio/Makefile     | 1 +
>   drivers/staging/vme/Makefile                             | 1 +
>   drivers/staging/vme/devices/Makefile                     | 1 +
>   56 files changed, 56 insertions(+)
>
> diff --git a/drivers/staging/android/Makefile b/drivers/staging/android/Makefile
> index 90e6154f11a4..14bd9c6ce10d 100644
> --- a/drivers/staging/android/Makefile
> +++ b/drivers/staging/android/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   ccflags-y += -I$(src)			# needed for trace events
>   
>   obj-y					+= ion/
> diff --git a/drivers/staging/axis-fifo/Makefile b/drivers/staging/axis-fifo/Makefile
> index fe62cd1ac5de..c626005c99db 100644
> --- a/drivers/staging/axis-fifo/Makefile
> +++ b/drivers/staging/axis-fifo/Makefile
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_XIL_AXIS_FIFO) += axis-fifo.o
> diff --git a/drivers/staging/board/Makefile b/drivers/staging/board/Makefile
> index 6842745feb94..ed7839752e12 100644
> --- a/drivers/staging/board/Makefile
> +++ b/drivers/staging/board/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-y	:= board.o
>   obj-$(CONFIG_ARCH_EMEV2)	+= kzm9d.o
>   obj-$(CONFIG_ARCH_R8A7740)	+= armadillo800eva.o
> diff --git a/drivers/staging/clocking-wizard/Makefile b/drivers/staging/clocking-wizard/Makefile
> index 5ad352f521fe..b1f915224d96 100644
> --- a/drivers/staging/clocking-wizard/Makefile
> +++ b/drivers/staging/clocking-wizard/Makefile
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_COMMON_CLK_XLNX_CLKWZRD)	+= clk-xlnx-clock-wizard.o
> diff --git a/drivers/staging/comedi/drivers/ni_routing/tools/Makefile b/drivers/staging/comedi/drivers/ni_routing/tools/Makefile
> index 1966850584d2..6e92a06a44cb 100644
> --- a/drivers/staging/comedi/drivers/ni_routing/tools/Makefile
> +++ b/drivers/staging/comedi/drivers/ni_routing/tools/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   # this make file is simply to help autogenerate these files:
>   # 	ni_route_values.h
>   #	ni_device_routes.h
> diff --git a/drivers/staging/comedi/kcomedilib/Makefile b/drivers/staging/comedi/kcomedilib/Makefile
> index 3aff8ed08e2d..8031142a105f 100644
> --- a/drivers/staging/comedi/kcomedilib/Makefile
> +++ b/drivers/staging/comedi/kcomedilib/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   ccflags-$(CONFIG_COMEDI_DEBUG)		:= -DDEBUG
>   
>   obj-$(CONFIG_COMEDI_KCOMEDILIB)	+= kcomedilib.o
> diff --git a/drivers/staging/emxx_udc/Makefile b/drivers/staging/emxx_udc/Makefile
> index 6352724c0b57..569c5e9a9bae 100644
> --- a/drivers/staging/emxx_udc/Makefile
> +++ b/drivers/staging/emxx_udc/Makefile
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_USB_EMXX)	:= emxx_udc.o
> diff --git a/drivers/staging/fsl-dpaa2/Makefile b/drivers/staging/fsl-dpaa2/Makefile
> index c92ab98c27d9..9645db7689c9 100644
> --- a/drivers/staging/fsl-dpaa2/Makefile
> +++ b/drivers/staging/fsl-dpaa2/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   #
>   # Freescale DataPath Acceleration Architecture Gen2 (DPAA2) drivers
>   #
> diff --git a/drivers/staging/fwserial/Makefile b/drivers/staging/fwserial/Makefile
> index 2170869a19b1..1cd5c5c7e805 100644
> --- a/drivers/staging/fwserial/Makefile
> +++ b/drivers/staging/fwserial/Makefile
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_FIREWIRE_SERIAL) += firewire-serial.o
>   firewire-serial-objs := fwserial.o dma_fifo.o
> diff --git a/drivers/staging/gasket/Makefile b/drivers/staging/gasket/Makefile
> index cec813ece678..ce03e256f501 100644
> --- a/drivers/staging/gasket/Makefile
> +++ b/drivers/staging/gasket/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   #
>   #  Makefile for Gasket framework and dependent drivers.
>   #
> diff --git a/drivers/staging/goldfish/Makefile b/drivers/staging/goldfish/Makefile
> index 054eeb82151e..f7cee15529c3 100644
> --- a/drivers/staging/goldfish/Makefile
> +++ b/drivers/staging/goldfish/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   #
>   # Makefile for the Goldfish audio driver
>   #
> diff --git a/drivers/staging/gs_fpgaboot/Makefile b/drivers/staging/gs_fpgaboot/Makefile
> index d2f0211ba540..33e238be63d6 100644
> --- a/drivers/staging/gs_fpgaboot/Makefile
> +++ b/drivers/staging/gs_fpgaboot/Makefile
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
>   gs_fpga-y	+= gs_fpgaboot.o io.o
>   obj-$(CONFIG_GS_FPGABOOT)	+= gs_fpga.o
> diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
> index 773212e0c859..094cc9be35bd 100644
> --- a/drivers/staging/iio/accel/Makefile
> +++ b/drivers/staging/iio/accel/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   #
>   # Makefile for industrial I/O accelerometer drivers
>   #
> diff --git a/drivers/staging/iio/addac/Makefile b/drivers/staging/iio/addac/Makefile
> index 4c7686133692..8fdbd8cab21f 100644
> --- a/drivers/staging/iio/addac/Makefile
> +++ b/drivers/staging/iio/addac/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   #
>   # Makefile for industrial I/O ADDAC drivers
>   #
> diff --git a/drivers/staging/iio/cdc/Makefile b/drivers/staging/iio/cdc/Makefile
> index 1466bc31f244..ab8222579e7e 100644
> --- a/drivers/staging/iio/cdc/Makefile
> +++ b/drivers/staging/iio/cdc/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   #
>   # Makefile for industrial I/O DAC drivers
>   #
> diff --git a/drivers/staging/iio/frequency/Makefile b/drivers/staging/iio/frequency/Makefile
> index e5dbcfce44f9..b8c5cf98aa5e 100644
> --- a/drivers/staging/iio/frequency/Makefile
> +++ b/drivers/staging/iio/frequency/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   #
>   # Makefile for Direct Digital Synthesis drivers
>   #
> diff --git a/drivers/staging/iio/impedance-analyzer/Makefile b/drivers/staging/iio/impedance-analyzer/Makefile
> index 7604d786583e..b4e657a1ac18 100644
> --- a/drivers/staging/iio/impedance-analyzer/Makefile
> +++ b/drivers/staging/iio/impedance-analyzer/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   #
>   # Makefile for Impedance Converter, Network Analyzer drivers
>   #
> diff --git a/drivers/staging/iio/resolver/Makefile b/drivers/staging/iio/resolver/Makefile
> index b2049f2ce36e..398631f7e79b 100644
> --- a/drivers/staging/iio/resolver/Makefile
> +++ b/drivers/staging/iio/resolver/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   #
>   # Makefile for Resolver/Synchro drivers
>   #
> diff --git a/drivers/staging/ks7010/Makefile b/drivers/staging/ks7010/Makefile
> index 412e2105a3a5..009851a32310 100644
> --- a/drivers/staging/ks7010/Makefile
> +++ b/drivers/staging/ks7010/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_KS7010) += ks7010.o
>   
>   ks7010-y	:= ks_hostif.o ks_wlan_net.o ks7010_sdio.o
> diff --git a/drivers/staging/media/bcm2048/Makefile b/drivers/staging/media/bcm2048/Makefile
> index b4f5663d1408..f42056848dc6 100644
> --- a/drivers/staging/media/bcm2048/Makefile
> +++ b/drivers/staging/media/bcm2048/Makefile
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_I2C_BCM2048) += radio-bcm2048.o
> diff --git a/drivers/staging/media/davinci_vpfe/Makefile b/drivers/staging/media/davinci_vpfe/Makefile
> index 9268e507f791..0ae8c5014f74 100644
> --- a/drivers/staging/media/davinci_vpfe/Makefile
> +++ b/drivers/staging/media/davinci_vpfe/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_VIDEO_DM365_VPFE) += davinci-vfpe.o
>   
>   davinci-vfpe-objs := \
> diff --git a/drivers/staging/media/ipu3/Makefile b/drivers/staging/media/ipu3/Makefile
> index fa7fa3372bcb..cc288ae6d5f2 100644
> --- a/drivers/staging/media/ipu3/Makefile
> +++ b/drivers/staging/media/ipu3/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   #
>   # Makefile for the IPU3 ImgU drivers
>   #
> diff --git a/drivers/staging/media/mt9t031/Makefile b/drivers/staging/media/mt9t031/Makefile
> index bfd24c442b33..f663f73a5474 100644
> --- a/drivers/staging/media/mt9t031/Makefile
> +++ b/drivers/staging/media/mt9t031/Makefile
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_SOC_CAMERA_MT9T031)		+= mt9t031.o
> diff --git a/drivers/staging/media/rockchip/vpu/Makefile b/drivers/staging/media/rockchip/vpu/Makefile
> index e9d733bb7632..ae5d143a0bfa 100644
> --- a/drivers/staging/media/rockchip/vpu/Makefile
> +++ b/drivers/staging/media/rockchip/vpu/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_VIDEO_ROCKCHIP_VPU) += rockchip-vpu.o
>   
>   rockchip-vpu-y += \
> diff --git a/drivers/staging/media/sunxi/Makefile b/drivers/staging/media/sunxi/Makefile
> index cee2846c3ecf..b87140b0e15f 100644
> --- a/drivers/staging/media/sunxi/Makefile
> +++ b/drivers/staging/media/sunxi/Makefile
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_VIDEO_SUNXI_CEDRUS)	+= cedrus/
> diff --git a/drivers/staging/media/sunxi/cedrus/Makefile b/drivers/staging/media/sunxi/cedrus/Makefile
> index e9dc68b7bcb6..808842f0119e 100644
> --- a/drivers/staging/media/sunxi/cedrus/Makefile
> +++ b/drivers/staging/media/sunxi/cedrus/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_VIDEO_SUNXI_CEDRUS) += sunxi-cedrus.o
>   
>   sunxi-cedrus-y = cedrus.o cedrus_video.o cedrus_hw.o cedrus_dec.o cedrus_mpeg2.o
> diff --git a/drivers/staging/media/tegra-vde/Makefile b/drivers/staging/media/tegra-vde/Makefile
> index 444c1d62daa1..7f9020e634f3 100644
> --- a/drivers/staging/media/tegra-vde/Makefile
> +++ b/drivers/staging/media/tegra-vde/Makefile
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_TEGRA_VDE)	+= tegra-vde.o
> diff --git a/drivers/staging/most/cdev/Makefile b/drivers/staging/most/cdev/Makefile
> index 21b0bd72c01d..9f4a8b8c9c27 100644
> --- a/drivers/staging/most/cdev/Makefile
> +++ b/drivers/staging/most/cdev/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_MOST_CDEV) += most_cdev.o
>   
>   most_cdev-objs := cdev.o
> diff --git a/drivers/staging/most/dim2/Makefile b/drivers/staging/most/dim2/Makefile
> index 6d15f045a767..116f04d69244 100644
> --- a/drivers/staging/most/dim2/Makefile
> +++ b/drivers/staging/most/dim2/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_MOST_DIM2) += most_dim2.o
>   
>   most_dim2-objs := dim2.o hal.o sysfs.o
> diff --git a/drivers/staging/most/i2c/Makefile b/drivers/staging/most/i2c/Makefile
> index c032fea979b3..2b3769dc19e7 100644
> --- a/drivers/staging/most/i2c/Makefile
> +++ b/drivers/staging/most/i2c/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_MOST_I2C) += most_i2c.o
>   
>   most_i2c-objs := i2c.o
> diff --git a/drivers/staging/most/net/Makefile b/drivers/staging/most/net/Makefile
> index 820faec6b296..f0ac64dee71b 100644
> --- a/drivers/staging/most/net/Makefile
> +++ b/drivers/staging/most/net/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_MOST_NET) += most_net.o
>   
>   most_net-objs := net.o
> diff --git a/drivers/staging/most/sound/Makefile b/drivers/staging/most/sound/Makefile
> index 5bb55bb108fb..a3d086c6ca70 100644
> --- a/drivers/staging/most/sound/Makefile
> +++ b/drivers/staging/most/sound/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_MOST_SOUND) += most_sound.o
>   
>   most_sound-objs := sound.o
> diff --git a/drivers/staging/most/usb/Makefile b/drivers/staging/most/usb/Makefile
> index 910cd08bad7c..83cf2ead7122 100644
> --- a/drivers/staging/most/usb/Makefile
> +++ b/drivers/staging/most/usb/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_MOST_USB) += most_usb.o
>   
>   most_usb-objs := usb.o
> diff --git a/drivers/staging/most/video/Makefile b/drivers/staging/most/video/Makefile
> index c6e01b6ecfe6..2d857d3cbcc8 100644
> --- a/drivers/staging/most/video/Makefile
> +++ b/drivers/staging/most/video/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_MOST_VIDEO) += most_video.o
>   
>   most_video-objs := video.o
> diff --git a/drivers/staging/mt7621-dma/Makefile b/drivers/staging/mt7621-dma/Makefile
> index c9e3e1619ab0..66da1bf10c32 100644
> --- a/drivers/staging/mt7621-dma/Makefile
> +++ b/drivers/staging/mt7621-dma/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_MTK_HSDMA) += mtk-hsdma.o
>   
>   ccflags-y += -I$(srctree)/drivers/dma
> diff --git a/drivers/staging/mt7621-dts/Makefile b/drivers/staging/mt7621-dts/Makefile
> index 195eba4a5c65..aeec48a4edc7 100644
> --- a/drivers/staging/mt7621-dts/Makefile
> +++ b/drivers/staging/mt7621-dts/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   dtb-$(CONFIG_DTB_GNUBEE1)      += gbpc1.dtb
>   
>   obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> diff --git a/drivers/staging/mt7621-pci-phy/Makefile b/drivers/staging/mt7621-pci-phy/Makefile
> index a970056f05c1..b4d99b9119e0 100644
> --- a/drivers/staging/mt7621-pci-phy/Makefile
> +++ b/drivers/staging/mt7621-pci-phy/Makefile
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_PCI_MT7621_PHY)       += pci-mt7621-phy.o
> diff --git a/drivers/staging/mt7621-pci/Makefile b/drivers/staging/mt7621-pci/Makefile
> index d4655a726b61..f4e651cf7ce3 100644
> --- a/drivers/staging/mt7621-pci/Makefile
> +++ b/drivers/staging/mt7621-pci/Makefile
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_PCI_MT7621)       += pci-mt7621.o
> diff --git a/drivers/staging/mt7621-pinctrl/Makefile b/drivers/staging/mt7621-pinctrl/Makefile
> index 856102137a1e..49445f40c3cd 100644
> --- a/drivers/staging/mt7621-pinctrl/Makefile
> +++ b/drivers/staging/mt7621-pinctrl/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_PINCTRL_RT2880)   += pinctrl-rt2880.o
>   
>   ccflags-y += -I$(srctree)/drivers/pinctrl
> diff --git a/drivers/staging/mt7621-spi/Makefile b/drivers/staging/mt7621-spi/Makefile
> index 3be508f63bac..8577ea3fd4a1 100644
> --- a/drivers/staging/mt7621-spi/Makefile
> +++ b/drivers/staging/mt7621-spi/Makefile
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_SPI_MT7621)		+= spi-mt7621.o
> diff --git a/drivers/staging/netlogic/Makefile b/drivers/staging/netlogic/Makefile
> index f7355e3e9c4c..7e2902af26a3 100644
> --- a/drivers/staging/netlogic/Makefile
> +++ b/drivers/staging/netlogic/Makefile
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_NETLOGIC_XLR_NET) += xlr_net.o platform_net.o
> diff --git a/drivers/staging/olpc_dcon/Makefile b/drivers/staging/olpc_dcon/Makefile
> index 36c7e67fec20..cb1248c5c162 100644
> --- a/drivers/staging/olpc_dcon/Makefile
> +++ b/drivers/staging/olpc_dcon/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   olpc-dcon-objs += olpc_dcon.o
>   olpc-dcon-$(CONFIG_FB_OLPC_DCON_1)	+= olpc_dcon_xo_1.o
>   olpc-dcon-$(CONFIG_FB_OLPC_DCON_1_5)	+= olpc_dcon_xo_1_5.o
> diff --git a/drivers/staging/pi433/Makefile b/drivers/staging/pi433/Makefile
> index 417f3e4d12b1..051132fe4dae 100644
> --- a/drivers/staging/pi433/Makefile
> +++ b/drivers/staging/pi433/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_PI433) += pi433.o
>   
>   pi433-objs := pi433_if.o rf69.o
> diff --git a/drivers/staging/ralink-gdma/Makefile b/drivers/staging/ralink-gdma/Makefile
> index 5d917e0729bb..5c4566b2e405 100644
> --- a/drivers/staging/ralink-gdma/Makefile
> +++ b/drivers/staging/ralink-gdma/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_DMA_RALINK) += ralink-gdma.o
>   
>   ccflags-y += -I$(srctree)/drivers/dma
> diff --git a/drivers/staging/rtlwifi/Makefile b/drivers/staging/rtlwifi/Makefile
> index 0d738c18b29c..b223692a6794 100644
> --- a/drivers/staging/rtlwifi/Makefile
> +++ b/drivers/staging/rtlwifi/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_R8822BE) 		+= r8822be.o
>   
>   r8822be-objs	:=		\
> diff --git a/drivers/staging/rtlwifi/btcoexist/Makefile b/drivers/staging/rtlwifi/btcoexist/Makefile
> index f600bcc38a15..dda3779b84b1 100644
> --- a/drivers/staging/rtlwifi/btcoexist/Makefile
> +++ b/drivers/staging/rtlwifi/btcoexist/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   btcoexist-objs :=				\
>   			halbtc8822b1ant.o	\
>   			halbtc8822b2ant.o	\
> diff --git a/drivers/staging/rtlwifi/rtl8822be/Makefile b/drivers/staging/rtlwifi/rtl8822be/Makefile
> index d535ff8febf1..6ef094faa78e 100644
> --- a/drivers/staging/rtlwifi/rtl8822be/Makefile
> +++ b/drivers/staging/rtlwifi/rtl8822be/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   rtl8822be-objs :=		\
>   		fw.o		\
>   		hw.o		\
> diff --git a/drivers/staging/rts5208/Makefile b/drivers/staging/rts5208/Makefile
> index 17b4471c4d6d..6a934c41c738 100644
> --- a/drivers/staging/rts5208/Makefile
> +++ b/drivers/staging/rts5208/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_RTS5208) := rts5208.o
>   
>   ccflags-y := -Idrivers/scsi
> diff --git a/drivers/staging/sm750fb/Makefile b/drivers/staging/sm750fb/Makefile
> index 4d781f78b95c..1cf3849cef23 100644
> --- a/drivers/staging/sm750fb/Makefile
> +++ b/drivers/staging/sm750fb/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_FB_SM750)	+= sm750fb.o
>   
>   sm750fb-objs		:= sm750.o sm750_hw.o sm750_accel.o sm750_cursor.o ddk750_chip.o ddk750_power.o ddk750_mode.o
> diff --git a/drivers/staging/unisys/Makefile b/drivers/staging/unisys/Makefile
> index e45f44b64202..c0f76cc196a6 100644
> --- a/drivers/staging/unisys/Makefile
> +++ b/drivers/staging/unisys/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   #
>   # Makefile for Unisys SPAR drivers
>   #
> diff --git a/drivers/staging/unisys/visorhba/Makefile b/drivers/staging/unisys/visorhba/Makefile
> index 97e48757944a..b613a7dcdae9 100644
> --- a/drivers/staging/unisys/visorhba/Makefile
> +++ b/drivers/staging/unisys/visorhba/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   #
>   # Makefile for Unisys channel
>   #
> diff --git a/drivers/staging/unisys/visorinput/Makefile b/drivers/staging/unisys/visorinput/Makefile
> index 6e4bfa059a1f..68ced7c8a65f 100644
> --- a/drivers/staging/unisys/visorinput/Makefile
> +++ b/drivers/staging/unisys/visorinput/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   #
>   # Makefile for Unisys visorinput
>   #
> diff --git a/drivers/staging/unisys/visornic/Makefile b/drivers/staging/unisys/visornic/Makefile
> index 336a746f793b..f2984880c340 100644
> --- a/drivers/staging/unisys/visornic/Makefile
> +++ b/drivers/staging/unisys/visornic/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   #
>   # Makefile for Unisys channel
>   #
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/Makefile b/drivers/staging/vc04_services/bcm2835-audio/Makefile
> index 536bd0c11ddb..13fa6d7d9745 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/Makefile
> +++ b/drivers/staging/vc04_services/bcm2835-audio/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_SND_BCM2835)	+= snd-bcm2835.o
>   snd-bcm2835-objs		:= bcm2835.o bcm2835-ctl.o bcm2835-pcm.o bcm2835-vchiq.o
>   
> diff --git a/drivers/staging/vme/Makefile b/drivers/staging/vme/Makefile
> index accdb72e39e2..cf2f686ccffe 100644
> --- a/drivers/staging/vme/Makefile
> +++ b/drivers/staging/vme/Makefile
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-y				+= devices/
> diff --git a/drivers/staging/vme/devices/Makefile b/drivers/staging/vme/devices/Makefile
> index 459742a75283..5380115139b0 100644
> --- a/drivers/staging/vme/devices/Makefile
> +++ b/drivers/staging/vme/devices/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   #
>   # Makefile for the VME device drivers.
>   #
