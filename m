Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC683C2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F9224679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576780568;
	bh=XcAIK+KVii8ys60FiiNiKDqvuFG99k8ByyXR0pYwnTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BRr3KODE+WbMbYiJ0Tua2QHTfuo5L/qta7OFG8Uw/rokYgk+NYjV8zXC867NMlll5
	 mZ2VUTZ5R9+8NKJjea0PQOzaahstnsUcBza0qJA8eV5vEPadmPHDTlchZfSoU6KqfK
	 Oddy6JFr/4I4J5x/Ot3PsKUYugjgfAklFDY7aPcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfLSSgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:36:07 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35703 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbfLSSgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:36:05 -0500
Received: by mail-oi1-f196.google.com with SMTP id k4so3470350oik.2;
        Thu, 19 Dec 2019 10:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4OsvmAuY75E+vu9jghg3GThqB5YS2TizfBTomdGepIQ=;
        b=OzkYYn2Id7SfaGJQHSZ8WcMwCT8t4SY7ryY/Q8P0oxbT38K2D0l3Zx2620KDVVpzqA
         nrxn1H5AVJZ4EpswOcax0nMhjj0Om1qhUWqIcp5BfmINOYdJf+59fhtjhQeKNXfXlLYa
         4e+8xdrGLeeqkdLMAHFKAjpXiF/4uJP+BAJJKyAAn08KROiyDik3p8y1qfDYiIH1bGtX
         6RzjkU0jYx6U+EBiOUlihBxjrhUrN2P/0PCgFquuPQByuGPuuaxY/2flH9pSAAuI5LcO
         B8YpNir75BM+BUr7MbQM4bWxfeZJCDlIYgoEf9VMG6x9T4zEE76m6ihxC+6T3VMO54wS
         h5HA==
X-Gm-Message-State: APjAAAVIA9TUzVWjKpqN5eZ4BSAUK2WMBzifprx+WGKsLanxQCy1tn5O
        HgbEAV8JO3K3u4WZsAp/vTIMeNTsbg==
X-Google-Smtp-Source: APXvYqyvbDBw02JZD0mbOg+mPYLDYThtKsrGFMhEk+PHRiDggZXhdjnWXDKdBY76zsy4T+PrEuPsKA==
X-Received: by 2002:aca:c494:: with SMTP id u142mr2956136oif.86.1576780564540;
        Thu, 19 Dec 2019 10:36:04 -0800 (PST)
Received: from localhost ([2607:fb90:bdf:98e:3549:d84c:9720:edb4])
        by smtp.gmail.com with ESMTPSA id q18sm1745728otk.38.2019.12.19.10.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 10:36:03 -0800 (PST)
Date:   Thu, 19 Dec 2019 12:36:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: Add Unisoc's SC9863A SoC support
Message-ID: <20191219183602.GA31035@bogus>
References: <20191209114404.22483-1-zhang.lyra@gmail.com>
 <20191209114404.22483-4-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209114404.22483-4-zhang.lyra@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 07:44:04PM +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Add basic DT to support Unisoc's SC9863A, with this patch,
> the board sp9863a-1h10 can run into console.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  arch/arm64/boot/dts/sprd/Makefile         |   3 +-
>  arch/arm64/boot/dts/sprd/sc9863a.dtsi     | 523 ++++++++++++++++++++++
>  arch/arm64/boot/dts/sprd/sharkl3.dtsi     | 148 ++++++
>  arch/arm64/boot/dts/sprd/sp9863a-1h10.dts |  39 ++
>  4 files changed, 712 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/sprd/sc9863a.dtsi
>  create mode 100644 arch/arm64/boot/dts/sprd/sharkl3.dtsi
>  create mode 100644 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts


> diff --git a/arch/arm64/boot/dts/sprd/sharkl3.dtsi b/arch/arm64/boot/dts/sprd/sharkl3.dtsi
> new file mode 100644
> index 000000000000..3b5a94560481
> --- /dev/null
> +++ b/arch/arm64/boot/dts/sprd/sharkl3.dtsi
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Unisoc Sharkl3 platform DTS file
> + *
> + * Copyright (C) 2019, Unisoc Inc.
> + */
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	soc: soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		ap_ahb_regs: syscon@20e00000 {
> +			compatible = "sprd,sc9863a-glbregs", "syscon";
> +			reg = <0 0x20e00000 0 0x4000>;
> +		};
> +
> +		pub_ctrl_regs: syscon@300e0000 {
> +			compatible = "sprd,sc9863a-glbregs", "syscon";

Having a bunch of the same compatible doesn't look right. I assume by 
the label names each of these are a different set of registers. The 
compatible should be specific enough the OS can match to a driver that 
knows the register details.

Doesn't look like you use all these, so maybe drop until you do and/or 
figure out if you can use common bindings for some of these.

> +			reg = <0 0x300e0000 0 0x4000>;
> +		};
> +
> +		pub_wrap_regs: syscon@300f0000 {
> +			compatible = "sprd,sc9863a-glbregs", "syscon";
> +			reg = <0 0x300f0000 0 0x1000>;
> +		};
> +
> +		pmu_regs: syscon@402b0000 {
> +			compatible = "sprd,sc9863a-glbregs", "syscon";
> +			reg = <0 0x402b0000 0 0x4000>;
> +		};
> +
> +		aon_apb_regs: syscon@402e0000 {
> +			compatible = "sprd,sc9863a-glbregs", "syscon";
> +			reg = <0 0x402e0000 0 0x4000>;
> +		};
> +
> +		anlg_phy_g1_regs: syscon@40350000 {
> +			compatible = "sprd,sc9863a-glbregs", "syscon";
> +			reg = <0 0x40350000 0 0x3000>;
> +		};
> +
> +		anlg_phy_g2_regs: syscon@40353000 {
> +			compatible = "sprd,sc9863a-glbregs", "syscon";
> +			reg = <0 0x40353000 0 0x3000>;
> +		};
> +
> +		anlg_phy_g4_regs: syscon@40359000 {
> +			compatible = "sprd,sc9863a-glbregs", "syscon";
> +			reg = <0 0x40359000 0 0x3000>;
> +		};
> +
> +		anlg_phy_g5_regs: syscon@4035c000 {
> +			compatible = "sprd,sc9863a-glbregs", "syscon";
> +			reg = <0 0x4035c000 0 0x3000>;
> +		};
> +
> +		anlg_phy_g7_regs: syscon@40363000 {
> +			compatible = "sprd,sc9863a-glbregs", "syscon";
> +			reg = <0 0x40363000 0 0x3000>;
> +		};
> +
> +		anlg_wrap_wcn_regs: syscon@40366000 {
> +			compatible = "sprd,sc9863a-glbregs", "syscon";
> +			reg = <0 0x40366000 0 0x3000>;
> +		};
> +
> +		mm_ahb_regs: syscon@60800000 {
> +			compatible = "sprd,sc9863a-glbregs", "syscon";
> +			reg = <0 0x60800000 0 0x1000>;
> +		};
> +
> +		mm_vsp_ahb_regs: syscon@62000000 {
> +			compatible = "sprd,sc9863a-glbregs", "syscon";
> +			reg = <0 0x62000000 0 0x1000>;
> +		};
> +
> +		ap_apb_regs: syscon@71300000 {
> +			compatible = "sprd,sc9863a-glbregs", "syscon";
> +			reg = <0 0x71300000 0 0x4000>;
> +		};
> +
> +		apb@70000000 {
> +			compatible = "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0x0 0x70000000 0x10000000>;
> +
> +			uart0: serial@0 {
> +				compatible = "sprd,sc9863a-uart",
> +					     "sprd,sc9836-uart";
> +				reg = <0x0 0x100>;
> +				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&ext_26m>;
> +				status = "disabled";
> +			};
> +
> +			uart1: serial@100000 {
> +				compatible = "sprd,sc9863a-uart",
> +					     "sprd,sc9836-uart";
> +				reg = <0x100000 0x100>;
> +				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&ext_26m>;
> +				status = "disabled";
> +			};
> +
> +			uart2: serial@200000 {
> +				compatible = "sprd,sc9863a-uart",
> +					     "sprd,sc9836-uart";
> +				reg = <0x200000 0x100>;
> +				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&ext_26m>;
> +				status = "disabled";
> +			};
> +
> +			uart3: serial@300000 {
> +				compatible = "sprd,sc9863a-uart",
> +					     "sprd,sc9836-uart";
> +				reg = <0x300000 0x100>;
> +				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&ext_26m>;
> +				status = "disabled";
> +			};
> +
> +			uart4: serial@400000 {
> +				compatible = "sprd,sc9863a-uart",
> +					     "sprd,sc9836-uart";
> +				reg = <0x400000 0x100>;
> +				interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&ext_26m>;
> +				status = "disabled";
> +			};
> +		};
> +	};
> +
> +	ext_26m: ext-26m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <26000000>;
> +		clock-output-names = "ext-26m";
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts b/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
> new file mode 100644
> index 000000000000..5c32c1596337
> --- /dev/null
> +++ b/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Unisoc SP9863A-1h10 boards DTS file
> + *
> + * Copyright (C) 2019, Unisoc Inc.
> + */
> +
> +/dts-v1/;
> +
> +#include "sc9863a.dtsi"
> +
> +/ {
> +	model = "Spreadtrum SP9863A-1H10 Board";
> +
> +	compatible = "sprd,sp9863a-1h10", "sprd,sc9863a";
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x0 0x80000000>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial1:115200n8";
> +		bootargs = "earlycon";
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> -- 
> 2.20.1
> 
