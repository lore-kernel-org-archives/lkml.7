Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E1AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198DD20700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553796483;
	bh=2aylp+pk6sBrP21SRZiDZx8g6RoObKL2KLYOEsUu6bM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EQwBcSgoNcLP8mFVIE4jIkylIp085Cjf23yBAEYwLlrsNKLbvaCzkjnYw7VRYkDpu
	 4bUzYmc0TovBNsxFdb6zf5pxbn8wrJm+AROaigFUH4SLZs6w9PQOJTp82JAKxIdP7i
	 1++mNzl8trieLWr4ZyU1ZXxC9l2cAq0A6+iOtfDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfC1SIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:08:01 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36005 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfC1SIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:08:01 -0400
Received: by mail-ot1-f65.google.com with SMTP id o74so19231376ota.3;
        Thu, 28 Mar 2019 11:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0dsbo0Q/KwQwk3JS1+GgpOJMFXA7Qqo7AiSYtNCgn2o=;
        b=KuiG8NCtLGr9h+dYrTDoP8AsJs2NYCihDkD211fUzu/hRbcjD+OqZyJV7a3KUxx25B
         k/xKW9KZZlK939ubYYYben+vnNPcNweDi9Yr0KDHog8OWvYYXsSzf9k5BNmmJtVQye9s
         kOU7f5wkS47XNrFqFZWn9xoRPqj9fjMnTvaMogIbkLNKNwQB0q+KHULbIY4UpeIzKHVe
         prGT0mFCvsEj43P4L+1tnDZLqhrEIgScGZBMpuoSX8LXcBxbcnpNe153e9pbmnb1BJEM
         xlqRdLgUbElwg0/QYqYgPJL/Kg/ahSJEmmEFA5nKLR8RkA5vQAa9b9cIHPJiv312BKuX
         x+rw==
X-Gm-Message-State: APjAAAV6rZ/DsBceY0rNypaZIHmW9h4/LxQUSom/REmIcvBamIj+6jnl
        +vJubkLGUwHi69Qa68iLAQ==
X-Google-Smtp-Source: APXvYqwNBrVM7LQ69VdEE5Qs82nZZaVO2+HDzsalffVE8xKUm6oqRy/GblWPtjpMj+Xvpda5i9QA+A==
X-Received: by 2002:a05:6830:1017:: with SMTP id a23mr6277805otp.120.1553796480660;
        Thu, 28 Mar 2019 11:08:00 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s185sm9910738oif.30.2019.03.28.11.07.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 11:07:59 -0700 (PDT)
Date:   Thu, 28 Mar 2019 13:07:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Roger Quadros <rogerq@ti.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/5] dt-bindings: phy: ti: Add dt binding
 documentation for SERDES in AM654x SoC
Message-ID: <20190328180759.GA32679@bogus>
References: <20190325080815.6056-1-kishon@ti.com>
 <20190325080815.6056-4-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190325080815.6056-4-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 01:38:13PM +0530, Kishon Vijay Abraham I wrote:
> AM654x has two SERDES instances. Each instance has three input clocks
> (left input, externel reference clock and right input) and two output
> clocks (left output and right output) in addition to a PLL mux clock
> which the SERDES uses for Clock Multiplier Unit (CMU refclock).
> The PLL mux clock can select from one of the three input clocks.
> The right output can select between left input and external reference
> clock while the left output can select between the right input and
> external reference clock.
> 
> The left and right input reference clock of SERDES0 and SERDES1
> respectively are connected to the SoC clock. In the case of two lane
> SERDES personality card, the left input of SERDES1 is connected to
> the right output of SERDES0 in a chained fashion.
> 
> See section "Reference Clock Distribution" of AM65x Sitara Processors
> TRM (SPRUID7 – April 2018) for more details.
> 
> Add dt-binding documentation in order to represent all these different
> configurations in device tree.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/phy/ti,phy-am654-serdes.txt      | 81 +++++++++++++++++++
>  include/dt-bindings/phy/phy-am654-serdes.h    | 13 +++
>  2 files changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt
>  create mode 100644 include/dt-bindings/phy/phy-am654-serdes.h
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt b/Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt
> new file mode 100644
> index 000000000000..25a9206147ad
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt
> @@ -0,0 +1,81 @@
> +TI AM654 SERDES
> +
> +Required properties:
> + - compatible: Should be "ti,phy-am654-serdes"
> + - reg : Address and length of the register set for the device.
> + - reg-names: Should be "serdes" which corresponds to the register space
> +	populated in "reg".

*-names is kind of pointless with only 1 entry.

> + - #phy-cells: determine the number of cells that should be given in the
> +	phandle while referencing this phy. Should be "2". The 1st cell
> +	corresponds to the phy type (should be one of the types specified in
> +	include/dt-bindings/phy/phy.h) and the 2nd cell should be the serdes
> +	lane function.
> +	If SERDES0 is referenced 2nd cell should be:
> +		0 - USB3
> +		1 - PCIe0 Lane0
> +		2 - ICSS2 SGMII Lane0
> +	If SERDES1 is referenced 2nd cell should be:
> +		0 - PCIe1 Lane0
> +		1 - PCIe0 Lane1
> +		2 - ICSS2 SGMII Lane1
> + - clocks: List of clock-specifiers representing the input to the SERDES.
> +	Should have 3 items representing the left input clock, external
> +	reference clock and right input clock in that order.
> + - clock-output-names: List of clock names for each of the clock outputs of
> +	SERDES. Should have 3 items for CMU reference clock,
> +	left output clock and right output clock in that order.
> + - assigned-clocks: As defined in
> +	Documentation/devicetree/bindings/clock/clock-bindings.txt
> + - assigned-clock-parents: As defined in
> +	Documentation/devicetree/bindings/clock/clock-bindings.txt
> + - #clock-cells: Should be <1> to choose between the 3 output clocks.
> +	Defined in Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +   The following macros are defined in dt-bindings/phy/phy-am654-serdes.h
> +   for selecting the correct reference clock. This can be used while
> +   specifying the clocks created by SERDES.
> +	=> AM654_SERDES_CMU_REFCLK
> +	=> AM654_SERDES_LO_REFCLK
> +	=> AM654_SERDES_RO_REFCLK
> +
> + - mux-controls: phandle to the multiplexer

What does this mux?

> +
> +Example:
> +
> +Example for SERDES0 is given below. It has 3 clock inputs;
> +left input reference clock as indicated by <&k3_clks 153 4>, external
> +reference clock as indicated by <&k3_clks 153 1> and right input
> +reference clock as indicated by <&serdes1 AM654_SERDES_LO_REFCLK>. (The
> +right input of SERDES0 is connected to the left output of SERDES1).
> +
> +SERDES0 registers 3 clock outputs as indicated in clock-output-names. The
> +first refers to the CMU reference clock, second refers to the left output
> +reference clock and the third refers to the right output reference clock.
> +
> +The assigned-clocks and assigned-clock-parents is used here to set the
> +parent of left input reference clock to MAINHSDIV_CLKOUT4 and parent of
> +CMU reference clock to left input reference clock.
> +
> +serdes0: serdes@900000 {
> +	compatible = "ti,phy-am654-serdes";
> +	reg = <0x0 0x900000 0x0 0x2000>;
> +	reg-names = "serdes";

> +	#phy-cells = <2>;
> +	power-domains = <&k3_pds 153>;

Not documented.

> +	clocks = <&k3_clks 153 4>, <&k3_clks 153 1>,
> +			<&serdes1 AM654_SERDES_LO_REFCLK>;
> +	clock-output-names = "serdes0_cmu_refclk", "serdes0_lo_refclk",
> +				"serdes0_ro_refclk";
> +	assigned-clocks = <&k3_clks 153 4>, <&serdes0 AM654_SERDES_CMU_REFCLK>;
> +	assigned-clock-parents = <&k3_clks 153 8>, <&k3_clks 153 4>;
> +	ti,serdes-clk = <&serdes0_clk>;
> +	mux-controls = <&serdes_mux 0>;
> +	#clock-cells = <1>;
> +};
> +
> +Example for PCIe consumer node using the SERDES PHY specifier is given below.
> +&pcie0_rc {
> +        num-lanes = <2>;
> +        phys = <&serdes0 PHY_TYPE_PCIE 1>, <&serdes1 PHY_TYPE_PCIE 1>;
> +        phy-names = "pcie-phy0", "pcie-phy1";
> +};
> diff --git a/include/dt-bindings/phy/phy-am654-serdes.h b/include/dt-bindings/phy/phy-am654-serdes.h
> new file mode 100644
> index 000000000000..e8d901729ed9
> --- /dev/null
> +++ b/include/dt-bindings/phy/phy-am654-serdes.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This header provides constants for AM654 SERDES.
> + */
> +
> +#ifndef _DT_BINDINGS_AM654_SERDES
> +#define _DT_BINDINGS_AM654_SERDES
> +
> +#define AM654_SERDES_CMU_REFCLK	0
> +#define AM654_SERDES_LO_REFCLK	1
> +#define AM654_SERDES_RO_REFCLK	2
> +
> +#endif /* _DT_BINDINGS_AM654_SERDES */
> -- 
> 2.17.1
> 
