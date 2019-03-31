Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E657C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E349218A1
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014511;
	bh=4YMCA/poLtus0nzdxiVxLaH2AGoh4AzSqi9Rv9JGhT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j70QEw0B19mcL7D+mxZLLsi57mdHN9mcdsdclaT7EmCTuleXPgelCBquycuMnBXi3
	 qimHphIrOwAWWunq2pfu5xT5c2/TE02CX93GJFcXZOxJ1b/KBSpcZX5ctwcImhvOid
	 ysc5ztGBdu1c6+O61kcEepBti2myGuOkJMSuTMxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbfCaGlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:41:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37066 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731235AbfCaGlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:41:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id 8so2986757pfr.4;
        Sat, 30 Mar 2019 23:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=SsZ4KwDXHUe9yAwtcCPN9T6J+3rt4KvkO7HGJZiWgdw=;
        b=nbw1ao7CYmpBJvI5gERSYaWObs8Puimps4MPKFyLearP84T8z+0IdaZi3QR6AhkgD0
         7s1MerHr6EHoA+jwq+/yALIUHkyKayfWqjbKeQkRa2djUlNZCyTRdVUaLDEpxM1zwHux
         XdMND6SPfXJT7HvX1Ay7ywhkgt8y4LLvHRU2sL4rCx0aIuE+kttoESyh/fvLwkfLMWoc
         yJgJhjhllFH52UHQTpvrTKECrWb5DNneqIQmVEnTWLuvUn500RoZycIx3lk1HsV9IvMl
         TDinsRA59eYoh4xRyIEXA1Fl28rT78TSEuworpkg1ZjvzoIjCjS0Jvwvw7QBVREcX1QY
         1IlQ==
X-Gm-Message-State: APjAAAWUcGUhKUrHyj/HvOSwHPc1GXzjX4KbKta9Fstbq/Q/KLZ8MJHR
        RkudUWpn3VUJY1LEB5eyJUR8fVMu1A==
X-Google-Smtp-Source: APXvYqz8JELpHa5PBPd/C1OK99D01avHGMkNry3bt8UAU4Kr7W2QMn1oqmaqPDYy2uXwWIlCPlHxmA==
X-Received: by 2002:a62:293:: with SMTP id 141mr55215144pfc.245.1554014504934;
        Sat, 30 Mar 2019 23:41:44 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id 18sm3280635pfp.18.2019.03.30.23.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:41:44 -0700 (PDT)
Message-ID: <5ca06128.1c69fb81.10beb.8b9d@mx.google.com>
Date:   Sun, 31 Mar 2019 01:41:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     qiaozhou <qiaozhou@asrmicro.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] arm64: dts: add dts files for asr Aquilac SoC
References: <1553349688-1946-1-git-send-email-qiaozhou@asrmicro.com>
 <1553349688-1946-8-git-send-email-qiaozhou@asrmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553349688-1946-8-git-send-email-qiaozhou@asrmicro.com>
X-Mutt-References: <1553349688-1946-8-git-send-email-qiaozhou@asrmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 10:01:28PM +0800, qiaozhou wrote:
> From: Qiao Zhou <qiaozhou@asrmicro.com>
> 
> Add initial dtsi file to support ASR Aquilac SoC. It has two clusters.
> Cluster0 has 4 * Cortex-A53 and Cluster1 has 4 * Cortex-A73.
> 
> Also add dts file to support ASR Aquilac SoC development board which is
> based on ASR AquilaC SoC.
> 
> Signed-off-by: qiaozhou <qiaozhou@asrmicro.com>
> ---
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  arch/arm64/boot/dts/asr/Makefile              |   2 +
>  arch/arm64/boot/dts/asr/asr8751c-aquilac.dts  |  58 ++++
>  arch/arm64/boot/dts/asr/asr8751c-pinctrl.dtsi | 400 ++++++++++++++++++++++
>  arch/arm64/boot/dts/asr/asr8751c.dtsi         | 460 ++++++++++++++++++++++++++
>  5 files changed, 921 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/asr/Makefile
>  create mode 100644 arch/arm64/boot/dts/asr/asr8751c-aquilac.dts
>  create mode 100644 arch/arm64/boot/dts/asr/asr8751c-pinctrl.dtsi
>  create mode 100644 arch/arm64/boot/dts/asr/asr8751c.dtsi
> 
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index 5bc7533..38f3db0 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -27,3 +27,4 @@ subdir-y += synaptics
>  subdir-y += ti
>  subdir-y += xilinx
>  subdir-y += zte
> +subdir-y += asr
> diff --git a/arch/arm64/boot/dts/asr/Makefile b/arch/arm64/boot/dts/asr/Makefile
> new file mode 100644
> index 0000000..b1f31c8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/asr/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_ASR)	+= asr8751c-aquilac.dtb
> diff --git a/arch/arm64/boot/dts/asr/asr8751c-aquilac.dts b/arch/arm64/boot/dts/asr/asr8751c-aquilac.dts
> new file mode 100644
> index 0000000..076642f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/asr/asr8751c-aquilac.dts
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dts file for ASR8751C AquilaC SoC
> + * Copyright (c) 2019, ASR Microelectronics(Shanghai) Co., Ltd.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  publishhed by the Free Software Foundation.

Drop the boilerplate.

> + */
> +
> +/dts-v1/;
> +#include "asr8751c.dtsi"
> +#include "asr8751c-pinctrl.dtsi"
> +#include <dt-bindings/input/linux-event-codes.h>
> +
> +/ {
> +	model = "ASR AquilaC Development Board";
> +	compatible = "asr,aquilac-evb", "asr,8751c";
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +	};
> +
> +	chosen {
> +		/*
> +		 * initrd parameters not set in dts file since the ramdisk.img
> +		 * size need to check in uboot, and the initrd load address and
> +		 * size will set in uboot stage.
> +		 */
> +		bootargs = "clk_ignore_unused";
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@0 {

unit address doesn't match.

> +		/* address-cell = 2, size-cell = 2 */
> +		device_type = "memory";
> +		/* start address: 0x100000000, size = 0xC0000000 */
> +		reg = <0x1 0x00000000 0x0 0xC0000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		ramoops@10c000000 {
> +			compatible = "ramoops";
> +			reg = <0x1 0x0c000000 0x0 0x0040000>;
> +			record-size = <0x7000>;
> +			console-size = <0x30000>;
> +			ftrace-size = <0x1000>;
> +			pmsg-size = <0x1000>;
> +			dump-oops = <0>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/asr/asr8751c-pinctrl.dtsi b/arch/arm64/boot/dts/asr/asr8751c-pinctrl.dtsi
> new file mode 100644
> index 0000000..047049f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/asr/asr8751c-pinctrl.dtsi
> @@ -0,0 +1,400 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Copyright (C) 2019 ASR Microelectronics(Shanghai) Co., Ltd.
> + *  Author: Tim Wang <timwang@asrmicro.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  publishhed by the Free Software Foundation.

Drop the boilerplate.

> + */
> +#include <dt-bindings/pinctrl/asr8751c-pinfunc.h>
> +
> +&pmx {
> +	evb_mfp_pins_group_0: evb_mfp_pins_group_0 {
> +		pinctrl-single,pins = <
> +			GPIO_124	AF0
> +		>;
> +		MFP_PULL_DOWN;
> +	};
> +
> +	/* aquilac evb config group */
> +	evb_mfp_pins_group_1: evb_mfp_pins_group_1 {
> +		pinctrl-single,pins = <
> +			GPIO_07		AF0
> +			/* I2C */
> +			GPIO_03		AF1 /* I2C5 */
> +			GPIO_04		AF1
> +			GPIO_45		AF1 /* I2C7 */
> +			GPIO_46		AF1
> +			GPIO_22		AF1 /* I2C2 */
> +			GPIO_23		AF1
> +			GPIO_112	AF1 /* I2C6 */
> +			GPIO_113	AF1
> +			GPIO_63		AF1
> +			GPIO_64		AF1
> +
> +			/* I2S */
> +			GPIO_31		AF1
> +			GPIO_32		AF1
> +			GPIO_33		AF1
> +			GPIO_34		AF1
> +			GPIO_102	AF1
> +			GPIO_103	AF1
> +			GPIO_104	AF1
> +			GPIO_105	AF1
> +			/* SH_SSP */
> +			GPIO_82		AF1
> +			GPIO_83		AF1
> +			GPIO_84		AF1
> +			GPIO_85		AF1
> +			GPIO_86		AF1
> +			GPIO_87		AF1
> +			GPIO_88		AF1
> +			GPIO_89		AF1
> +			/* SH_UART */
> +			GPIO_61		AF1
> +			GPIO_62		AF1
> +			/* SSP */
> +			GPIO_41		AF1
> +			GPIO_42		AF1
> +			GPIO_43		AF1
> +			GPIO_44		AF1
> +			/* UART */
> +			GPIO_24		AF0 /* VSP UART */
> +			GPIO_25		AF0
> +			GPIO_08		AF0
> +			GPIO_92		AF1 /* BT_UART */
> +			GPIO_93		AF1
> +			GPIO_94		AF1
> +			GPIO_95		AF1
> +			/* CAMERA */
> +			GPIO_09		AF0
> +			GPIO_10		AF0
> +			GPIO_11		AF0
> +			GPIO_12		AF0
> +			GPIO_13		AF0
> +			GPIO_14		AF0
> +			GPIO_15		AF1
> +			GPIO_16		AF1
> +			GPIO_17		AF1
> +		>;
> +		MFP_DEFAULT;
> +	};
> +
> +	/* TWSI0 GPIO */
> +	twsi0_pmx_func0: twsi0_pmx_func0 {
> +		pinctrl-single,pins = <
> +			GPIO_18 AF0
> +			GPIO_19 AF0
> +		>;
> +		MFP_DEFAULT;
> +	};
> +
> +	/* AP I2C0 */
> +	twsi0_pmx_func1: twsi0_pmx_func1 {
> +		pinctrl-single,pins = <
> +			GPIO_18 AF1
> +			GPIO_19 AF1
> +		>;
> +		MFP_DEFAULT;
> +	};
> +
> +	/* OVT I2C 0 */
> +	twsi0_pmx_func2: twsi0_pmx_func2 {
> +		pinctrl-single,pins = <
> +			GPIO_18 AF2
> +			GPIO_19 AF2
> +		>;
> +		MFP_DEFAULT;
> +	};
> +
> +	/* TWSI1 GPIO */
> +	twsi1_pmx_func0: twsi1_pmx_func0 {
> +		pinctrl-single,pins = <
> +			GPIO_20 AF0
> +			GPIO_21 AF0
> +		>;
> +		MFP_DEFAULT;
> +	};
> +
> +	/* AP I2C 1 */
> +	twsi1_pmx_func1: twsi1_pmx_func1 {
> +		pinctrl-single,pins = <
> +			GPIO_20 AF1
> +			GPIO_21 AF1
> +		>;
> +		MFP_DEFAULT;
> +	};
> +
> +	/* OVT I2C 1 */
> +	twsi1_pmx_func2: twsi1_pmx_func2 {
> +		pinctrl-single,pins = <
> +			GPIO_20 AF2
> +			GPIO_21 AF2
> +		>;
> +		MFP_DEFAULT;
> +	};
> +
> +	/* AP I2C 4 */
> +	twsi4_pmx_func1: twsi4_pmx_func1 {
> +		pinctrl-single,pins = <
> +			GPIO_35 AF1
> +			GPIO_36 AF1
> +		>;
> +		MFP_DEFAULT;
> +	};
> +
> +	ccic1_pmx_func1: ccic1_pmx_func1 {
> +		pinctrl-single,pins = <
> +			GPIO_09 AF0
> +			GPIO_12 AF0
> +			GPIO_15 AF1
> +		>;
> +		MFP_DEFAULT;
> +	};
> +
> +	ccic2_pmx_func1: ccic2_pmx_func1 {
> +		pinctrl-single,pins = <
> +			GPIO_10 AF0
> +			GPIO_13 AF0
> +			GPIO_16 AF1
> +		>;
> +		MFP_DEFAULT;
> +	};
> +
> +	ccic3_pmx_func1: ccic3_pmx_func1 {
> +		pinctrl-single,pins = <
> +			GPIO_11 AF0
> +			GPIO_14 AF0
> +			GPIO_17 AF1
> +		>;
> +		MFP_DEFAULT;
> +	};
> +
> +	/* MFP_LPM_PULL_UP */
> +	gpio126_pmx_func0: gpio126_pmx_func0 {
> +		pinctrl-single,pins = <
> +			GPIO_126 AF0
> +		>;
> +		MFP_LPM_PULL_UP;
> +	};
> +
> +	/* MFP_DEFAULT */
> +	gpio126_pmx_func2: gpio126_pmx_func2 {
> +		pinctrl-single,pins = <
> +			GPIO_126 AF2
> +		>;
> +		MFP_DEFAULT;
> +	};
> +
> +	/* MFP_LPM_PULL_UP */
> +	gpio51_pmx_func0: gpio51_pmx_func0 {
> +		pinctrl-single,pins = <
> +			GPIO_51 AF0
> +		>;
> +		MFP_LPM_PULL_UP;
> +	};
> +
> +	/* MFP_DEFAULT */
> +	gpio51_pmx_func2: gpio51_pmx_func2 {
> +		pinctrl-single,pins = <
> +			GPIO_51 AF2
> +		>;
> +		MFP_DEFAULT;
> +	};
> +
> +	/* SD card */
> +	sdcard_pmx_func0: sdcard_pmx_func0 {
> +		pinctrl-single,pins = <
> +			MMC1_DAT3 AF0
> +			MMC1_DAT2 AF0
> +			MMC1_DAT1 AF0
> +			MMC1_DAT0 AF0
> +			MMC1_CMD AF0
> +		>;
> +		MFP_DEFAULT;
> +	};
> +
> +	/* MFP_LPM_DRIVE_LOW */
> +	sdcard_clk_pmx_func0: sdcard_clk_pmx_func0 {
> +		pinctrl-single,pins = <
> +			MMC1_CLK AF0
> +		>;
> +		MFP_LPM_DRIVE_LOW;
> +	};
> +
> +	/* ds fast, no pull, no LPM */
> +	sdcard_pmx_func0_fast: sdcard_pmx_func0_fast {
> +		pinctrl-single,pins = <
> +			MMC1_DAT3 AF0
> +			MMC1_DAT2 AF0
> +			MMC1_DAT1 AF0
> +			MMC1_DAT0 AF0
> +			MMC1_CMD AF0
> +		>;
> +		DS_FAST;PULL_NONE;EDGE_NONE;LPM_NONE;
> +	};
> +
> +	/* ds fast, LPM_DRIVE_LOW */
> +	sdcard_clk_pmx_func0_fast: sdcard_clk_pmx_func0_fast {
> +		pinctrl-single,pins = <
> +			MMC1_CLK AF0
> +		>;
> +		DS_FAST;PULL_NONE;EDGE_NONE;LPM_DRIVE_LOW;
> +	};
> +
> +	/* JTAG */
> +	sdcard_pmx_func2: sdcard_pmx_func2 {
> +		pinctrl-single,pins = <
> +			MMC1_DAT3 AF2
> +			MMC1_DAT2 AF2
> +			MMC1_DAT1 AF2
> +			MMC1_DAT0 AF2
> +			MMC1_CMD AF2
> +			MMC1_CLK AF2
> +		>;
> +		MFP_DEFAULT;
> +	};
> +
> +	/* SDIO card */
> +	sdio_pmx_func1: sdio_pmx_func1 {
> +		pinctrl-single,pins = <
> +			GPIO_96 AF1 //MMC2_DAT3
> +			GPIO_97 AF1 //MMC2_DAT2
> +			GPIO_98 AF1 //MMC2_DAT1
> +			GPIO_99 AF1 //MMC2_DAT0
> +			GPIO_100 AF1 //MMC2_CMD
> +		>;
> +		MFP_DEFAULT;
> +	};
> +
> +	/* MFP_LPM_DRIVE_LOW */
> +	sdio_clk_pmx_func1: sdio_clk_pmx_func1 {
> +		pinctrl-single,pins = <
> +			GPIO_101 AF1 //MMC2_CLK
> +		>;
> +		MFP_LPM_DRIVE_LOW;
> +	};
> +
> +	/* ds fast, no pull, no LPM */
> +	sdio_pmx_func1_fast: sdio_pmx_func1_fast {
> +		pinctrl-single,pins = <
> +			GPIO_96 AF1 //MMC2_DAT3
> +			GPIO_97 AF1 //MMC2_DAT2
> +			GPIO_98 AF1 //MMC2_DAT1
> +			GPIO_99 AF1 //MMC2_DAT0
> +			GPIO_100 AF1 //MMC2_CMD
> +		>;
> +		DS_FAST;PULL_NONE;EDGE_NONE;LPM_NONE;
> +	};
> +
> +	/* ds fast, LPM_DRIVE_LOW */
> +	sdio_clk_pmx_func1_fast: sdio_clk_pmx_func1_fast {
> +		pinctrl-single,pins = <
> +			GPIO_101 AF1 //MMC2_CLK
> +		>;
> +		DS_FAST;PULL_NONE;EDGE_NONE;LPM_DRIVE_LOW;
> +	};
> +
> +	/* ssp0 default state */
> +	ssp0_pmx_func0: ssp0_pmx_func0 {
> +		pinctrl-single,pins = <
> +			GPIO_118 AF1	/* clk */
> +			GPIO_120 AF1	/* tx */
> +			GPIO_121 AF1	/* rx */
> +		>;
> +		MFP_PULL_DOWN;
> +	};
> +
> +	ssp0_pmx_func1: ssp0_pmx_func1 {
> +		pinctrl-single,pins = <
> +			GPIO_119 AF1	/* cs */
> +		>;
> +		MFP_PULL_UP;
> +	};
> +
> +	/* uart2 */
> +	uart2_pmx_func1: uart2_pmx_func1 {
> +		pinctrl-single,pins = <
> +			GPIO_120 AF2	/* tx */
> +			GPIO_121 AF2	/* rx */
> +		>;
> +		MFP_DEFAULT;
> +	};
> +
> +	uart2_pmx_func2: uart2_pmx_func2 {
> +		pinctrl-single,pins = <
> +			GPIO_118 AF2	/* CTS */
> +			GPIO_119 AF2	/* RTS */
> +		>;
> +		MFP_PULL_DOWN;
> +	};
> +
> +	fp_pmx_func1: fp_pmx_func1 {
> +		pinctrl-single,pins = <
> +			GPIO_76 AF0
> +			GPIO_81 AF0
> +		>;
> +		MFP_DEFAULT;
> +	};
> +
> +	/* AP I2C 8 */
> +	twsi8_pmx_func1: twsi8_pmx_func1 {
> +		pinctrl-single,pins = <
> +			GPIO_47 AF1
> +			GPIO_48 AF1
> +		>;
> +		MFP_DEFAULT;
> +	};
> +
> +	nfc_pmx_func0: nfc_pmx_func0 {
> +		pinctrl-single,pins = <
> +			GPIO_124 AF0
> +			GPIO_123 AF0
> +			GPIO_115 AF0
> +			VCXO_REQ1 AF1
> +		>;
> +		MFP_LPM_FLOAT;
> +	};
> +
> +	nfc_pmx_func0_n3_1: nfc_pmx_func0_n3_1 {
> +		pinctrl-single,pins = <
> +			GPIO_116 AF0
> +			GPIO_115 AF0
> +			GPIO_60  AF0
> +		>;
> +		MFP_DEFAULT;
> +	};
> +
> +	nfc_pmx_func0_n3_2: nfc_pmx_func0_n3_2 {
> +		pinctrl-single,pins = <
> +			GPIO_107 AF0
> +		>;
> +		MFP_PULL_DOWN;
> +	};
> +
> +	goodix_ts_pmx_func0: goodix_ts_pmx_func0 {
> +		pinctrl-single,pins = <
> +			GPIO_05 AF0
> +			GPIO_06 AF0
> +		>;
> +		MFP_PULL_DOWN;
> +	};
> +
> +
> +	/* Not used pin, pull down and set input in lpm */
> +	evb_sensor_pmx_func0: evb_sensor_pmx_func0 {
> +		pinctrl-single,pins = <
> +			GPIO_78 AF0
> +		>;
> +		MFP_PULL_DOWN;
> +	};
> +
> +	/* EVB reset pin for mag sensor, GPIO */
> +	evb_sensor_pmx_func1: evb_sensor_pmx_func1 {
> +		pinctrl-single,pins = <
> +			GPIO_80 AF0
> +		>;
> +		MFP_PULL_UP;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/asr/asr8751c.dtsi b/arch/arm64/boot/dts/asr/asr8751c.dtsi
> new file mode 100644
> index 0000000..c7222eb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/asr/asr8751c.dtsi
> @@ -0,0 +1,460 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dtsi file for ASR8751C
> + * Copyright (c) 2019, ASR Microelectronics(Shanghai) Co., Ltd.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  publishhed by the Free Software Foundation.
> + */
> +
> +#include <dt-bindings/clock/asr8751c-clk.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		idle-states {
> +			entry-method = "psci";
> +
> +			CPU_C1: cpu-c1 {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x0000002>;
> +				entry-latency-us = <20>;
> +				exit-latency-us = <20>;
> +				min-residency-us = <100>;
> +			};
> +
> +			CPU_C2: cpu-c2 {
> +				compatible = "arm,idle-state";
> +				local-timer-stop;
> +				arm,psci-suspend-param = <0x0010005>;
> +				entry-latency-us = <40>;
> +				exit-latency-us = <40>;
> +				min-residency-us = <200>;
> +			};
> +
> +			CLUSTER_MP2: cluster-mp2 {
> +				compatible = "arm,idle-state";
> +				local-timer-stop;
> +				arm,psci-suspend-param = <0x1010055>;
> +				entry-latency-us = <80>;
> +				exit-latency-us = <80>;
> +				min-residency-us = <400>;
> +				wakeup-latency-us = <40>;
> +			};
> +
> +			CHIP_D1P: chip-d1p {
> +				compatible = "arm,idle-state";
> +				local-timer-stop;
> +				arm,psci-suspend-param = <0x2010355>;
> +				entry-latency-us = <200>;
> +				exit-latency-us = <200>;
> +				min-residency-us = <1000>;
> +				wakeup-latency-us = <80>;
> +			};
> +
> +			CHIP_D1: chip-d1 {
> +				compatible = "arm,idle-state";
> +				local-timer-stop;
> +				arm,psci-suspend-param = <0x2010455>;
> +				entry-latency-us = <300>;
> +				exit-latency-us = <300>;
> +				min-residency-us = <1200>;
> +				wakeup-latency-us = <160>;
> +			};
> +
> +			CHIP_D2: chip-d2 {
> +				compatible = "arm,idle-state";
> +				local-timer-stop;
> +				arm,psci-suspend-param = <0x2010555>;
> +				entry-latency-us = <400>;
> +				exit-latency-us = <400>;
> +				min-residency-us = <1500>;
> +				wakeup-latency-us = <200>;
> +			};
> +		};
> +
> +		clst0_core_opp_table: opp_table0 {

Use '-' rather than '_':

opp-table0


> +			compatible = "operating-points-v2";
> +			opp-shared;
> +
> +			opp624000000 {
> +				opp-hz = /bits/ 64 <624000000>;
> +				opp-microvolt = <1000000>;
> +				clock-latency-ns = <200000>;
> +			};
> +			opp832000000 {
> +				opp-hz = /bits/ 64 <832000000>;
> +				opp-microvolt = <1000000>;
> +				clock-latency-ns = <200000>;
> +			};
> +			opp1000000000 {
> +				opp-hz = /bits/ 64 <1000000000>;
> +				opp-microvolt = <1500000>;
> +				clock-latency-ns = <200000>;
> +			};
> +			opp1248000000 {
> +				opp-hz = /bits/ 64 <1248000000>;
> +				opp-microvolt = <1500000>;
> +				clock-latency-ns = <200000>;
> +			};
> +			opp1400000000 {
> +				opp-hz = /bits/ 64 <1400000000>;
> +				opp-microvolt = <1500000>;
> +				clock-latency-ns = <200000>;
> +			};
> +			opp1600000000 {
> +				opp-hz = /bits/ 64 <1600000000>;
> +				opp-microvolt = <1500000>;
> +				clock-latency-ns = <200000>;
> +			};
> +		};
> +
> +		clst1_core_opp_table: opp_table1 {
> +			compatible = "operating-points-v2";
> +			opp-shared;
> +
> +			opp1000000000 {
> +				opp-hz = /bits/ 64 <1000000000>;
> +				opp-microvolt = <1500000>;
> +				clock-latency-ns = <200000>;
> +			};
> +			opp1248000000 {
> +				opp-hz = /bits/ 64 <1248000000>;
> +				opp-microvolt = <1500000>;
> +				clock-latency-ns = <200000>;
> +			};
> +			opp1600000000 {
> +				opp-hz = /bits/ 64 <1600000000>;
> +				opp-microvolt = <1500000>;
> +				clock-latency-ns = <200000>;
> +			};
> +			opp1900000000 {
> +				opp-hz = /bits/ 64 <1900000000>;
> +				opp-microvolt = <1500000>;
> +				clock-latency-ns = <200000>;
> +			};
> +		};
> +
> +		cpu-map {
> +			cluster0: cluster0 {
> +				#cooling-cells = <2>; /* min followed by max */
> +				dynamic-pwr-coeff = <89>;
> +				static-pwr-base-coeff = <1335>;
> +				static-pwr-temp-coeff =
> +					<2225 27650 (-286) 10>;
> +				enable_ipa_vmin_control;

Not documented.

> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +				core2 {
> +					cpu = <&cpu2>;
> +				};
> +				core3 {
> +					cpu = <&cpu3>;
> +				};
> +			};
> +
> +			cluster1: cluster1 {
> +				#cooling-cells = <2>;
> +				dynamic-pwr-coeff = <115>;
> +				static-pwr-base-coeff = <2157>;
> +				static-pwr-temp-coeff =
> +					<52330 32960 (-603) 13>;
> +				enable_ipa_vmin_control;
> +				core0 {
> +					cpu = <&cpu4>;
> +				};
> +				core1 {
> +					cpu = <&cpu5>;
> +				};
> +				core2 {
> +					cpu = <&cpu6>;
> +				};
> +				core3 {
> +					cpu = <&cpu7>;
> +				};
> +			};
> +		};
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";

'arm,armv8' is only valid for s/w models.

> +			reg = <0 0x0>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&CPU_C2 &CLUSTER_MP2 &CHIP_D1P &CHIP_D1>;
> +			sched-energy-costs = <&CPU_COST_0 &CLUSTER_COST_0>;
> +			clocks = <&soc_clocks ASR_CLK_CLST0>;
> +			operating-points-v2 = <&clst0_core_opp_table>;
> +		};
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";
> +			reg = <0 0x1>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&CPU_C2 &CLUSTER_MP2 &CHIP_D1P &CHIP_D1>;
> +			sched-energy-costs = <&CPU_COST_0 &CLUSTER_COST_0>;
> +			clocks = <&soc_clocks ASR_CLK_CLST0>;
> +			operating-points-v2 = <&clst0_core_opp_table>;
> +		};
> +		cpu2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";
> +			reg = <0 0x2>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&CPU_C2 &CLUSTER_MP2 &CHIP_D1P &CHIP_D1>;
> +			sched-energy-costs = <&CPU_COST_0 &CLUSTER_COST_0>;
> +			clocks = <&soc_clocks ASR_CLK_CLST0>;
> +			operating-points-v2 = <&clst0_core_opp_table>;
> +		};
> +		cpu3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";
> +			reg = <0 0x3>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&CPU_C2 &CLUSTER_MP2 &CHIP_D1P &CHIP_D1>;
> +			sched-energy-costs = <&CPU_COST_0 &CLUSTER_COST_0>;
> +			clocks = <&soc_clocks ASR_CLK_CLST0>;
> +			operating-points-v2 = <&clst0_core_opp_table>;
> +		};
> +		cpu4: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";
> +			reg = <0 0x100>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&CPU_C2 &CLUSTER_MP2 &CHIP_D1P &CHIP_D1>;
> +			sched-energy-costs = <&CPU_COST_1 &CLUSTER_COST_1>;
> +			clocks = <&soc_clocks ASR_CLK_CLST1>;
> +			operating-points-v2 = <&clst1_core_opp_table>;
> +		};
> +		cpu5: cpu@101 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";
> +			reg = <0 0x101>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&CPU_C2 &CLUSTER_MP2 &CHIP_D1P &CHIP_D1>;
> +			sched-energy-costs = <&CPU_COST_1 &CLUSTER_COST_1>;
> +			clocks = <&soc_clocks ASR_CLK_CLST1>;
> +			operating-points-v2 = <&clst1_core_opp_table>;
> +		};
> +		cpu6: cpu@102 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";
> +			reg = <0 0x102>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&CPU_C2 &CLUSTER_MP2 &CHIP_D1P &CHIP_D1>;
> +			sched-energy-costs = <&CPU_COST_1 &CLUSTER_COST_1>;
> +			clocks = <&soc_clocks ASR_CLK_CLST1>;
> +			operating-points-v2 = <&clst1_core_opp_table>;
> +		};
> +		cpu7: cpu@103 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";
> +			reg = <0 0x103>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&CPU_C2 &CLUSTER_MP2 &CHIP_D1P &CHIP_D1>;
> +			sched-energy-costs = <&CPU_COST_1 &CLUSTER_COST_1>;
> +			clocks = <&soc_clocks ASR_CLK_CLST1>;
> +			operating-points-v2 = <&clst1_core_opp_table>;
> +		};
> +
> +	};
> +
> +	energy-costs {

None of this node is documented.

> +		/* cpu 0 data is magic data without any evidence */
> +		CPU_COST_0: core-cost0 {
> +			busy-cost-data = <
> +				195	35	/* 624mhz */
> +				260	48	/* 832mhz */
> +				312	64	/* 1000mhz */
> +				390	95	/* 1248mhz */
> +				438	118	/* 1400mhz */
> +				501	149	/* 1600mhz */
> +			>;
> +			idle-cost-data = <
> +				6
> +				0
> +				0
> +				0
> +				0
> +				0
> +				0
> +			>;
> +		};
> +		CPU_COST_1: core-cost1 {
> +			busy-cost-data = <
> +				538	195	/* 1000mhz */
> +				672	292	/* 1248mhz */
> +				862	441	/* 1600mhz */
> +				1024	640	/* 1900mhz */
> +
> +			>;
> +			idle-cost-data = <
> +				8
> +				0
> +				0
> +				0
> +				0
> +				0
> +				0
> +			>;
> +		};
> +		CLUSTER_COST_0: cluster-cost0 {
> +			busy-cost-data = <
> +				195	7	/* 624mhz */
> +				260	10	/* 832mhz */
> +				312	13	/* 1000mhz */
> +				390	22	/* 1248mhz */
> +				438	29	/* 1400mhz */
> +				501	39	/* 1600mhz */
> +			>;
> +			idle-cost-data = <
> +				40
> +				50
> +				0
> +				0
> +				0
> +				0
> +				0
> +			>;
> +		};
> +		CLUSTER_COST_1: cluster-cost1 {
> +			busy-cost-data = <
> +				538	20	/* 1000mhz */
> +				672	33	/* 1248mhz */
> +				862	54	/* 1600mhz */
> +				1024	86	/* 1900mhz */
> +			>;
> +			idle-cost-data = <
> +				50
> +				60
> +				0
> +				0
> +				0
> +				0
> +				0
> +			>;
> +		};
> +	};
> +
> +	psci {
> +		compatible      = "arm,psci-1.0";
> +		method          = "smc";
> +		cpu_suspend     = <0xc4000001>;
> +		cpu_off         = <0x84000002>;
> +		cpu_on          = <0xc4000003>;

I believe specifying the numbers is deprecated.

> +	};
> +
> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <1 7 0x8>; /* PMU PPI, Level low type */
> +	};
> +
> +	gic: interrupt-controller@d8000000 {
> +		compatible = "arm,gic-v3";
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +		reg = <0x0 0xd8000000 0x0 0x200000>,
> +		      <0x0 0xd8100000 0x0 0x200000>;
> +		interrupts = <1 9 0x8>;
> +	};
> +
> +	generic-timer {
> +		compatible = "arm,armv8-timer";
> +		/* PPI secure/nonsecure IRQ, active low level-sensitive */
> +		interrupts = <1 13 0x8>,
> +			     <1 14 0x8>,
> +				 <1 11 0x8>,
> +				 <1 10 0x8>;
> +		clock-frequency = <26000000>;
> +	};
> +
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		interrupt-parent = <&gic>;
> +		ranges;

You can remove this level and move axi and apb up to the root.

> +
> +		axi@d4200000 {	/* AXI */
> +			compatible = "asr,axi-bus", "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0 0xd4200000 0 0x00200000>;
> +			ranges = <0 0 0 0xffffffff>;
> +
> +		}; /* AXI */
> +
> +		apb@d4000000 {	/* APB */
> +			compatible = "asr,apb-bus", "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0 0xd4000000 0 0x00200000>;
> +			ranges = <0 0 0 0xffffffff>;
> +
> +			uart0: uart@d4017000 {
> +				compatible = "asr,uart";
> +				reg = <0xd4017000 0x1000>;
> +				interrupts = <0 32 0x4>;
> +				clock-frequency = <13000000>;
> +				clocks = <&soc_clocks ASR_CLK_UART0>;
> +			};
> +
> +			uart1: uart@d4018000 {
> +				compatible = "asr,uart";
> +				reg = <0xd4018000 0x1000>;
> +				interrupts = <0 33 0x4>;
> +				clock-frequency = <13000000>;
> +				clocks = <&soc_clocks ASR_CLK_UART1>;
> +			};
> +
> +			uart2: uart@d4017800 {
> +				compatible = "asr,uart";
> +				reg = <0xd4017800 0x1000>;
> +				interrupts = <0 34 0x4>;
> +				clock-frequency = <13000000>;
> +				clocks = <&soc_clocks ASR_CLK_UART2>;
> +			};
> +
> +			pmx: pinmux@d401e000 {
> +				compatible = "pinconf-single";
> +				reg = <0xd401e000 0x400>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				#gpio-range-cells = <3>;
> +				ranges;
> +
> +				pinctrl-single,register-width = <32>;
> +				pinctrl-single,function-mask = <7>;
> +
> +				range: gpio-range {
> +					#pinctrl-single,gpio-range-cells = <3>;
> +				};
> +			};
> +		}; /* APB */
> +	}; /* soc */
> +
> +	soc_clocks: clocks@d4050000{
> +		compatible = "asr,8751c-clock";
> +		reg = <0x0 0xd4050000 0x0 0x209c>,
> +		      <0x0 0xd4282800 0x0 0x400>,
> +		      <0x0 0xd4015000 0x0 0x1000>,
> +		      <0x0 0xd4090000 0x0 0x1000>,
> +		      <0x0 0xd4282c00 0x0 0x400>,
> +		      <0x0 0xd8440000 0x0 0x98>,
> +		      <0x0 0xd4200000 0x0 0x4280>;
> +		reg-names = "mpmu", "apmu", "apbc", "apbs", "ciu", "dciu", "ddrc";
> +		interrupts = <0 96 IRQ_TYPE_LEVEL_HIGH>;
> +		#clock-cells = <1>;
> +	};
> +};
> -- 
> 2.7.4
> 

