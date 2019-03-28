Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB411C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961D82183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553788626;
	bh=pglBRp9hQw1e3kkpxs2H7sVawl43ieLl503ItVTaJZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qiFv7KDHVS4rLMfnHoXGHCDLDF2EOz44B4iOn+qUEUMW4Bg9OPGRPg1s06PakVeG7
	 rjSxsAjDCFy61WJgT7R2eiYv8uB7NOYMhl5vdVCkJ8StYUqDnNeJ3soYuOr7/QKiSN
	 mBnfwlQneO/mInjIHlO1NeEjiyM/Ud07bk+nnybo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfC1P5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:57:05 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40228 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfC1P5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:57:05 -0400
Received: by mail-oi1-f195.google.com with SMTP id 3so16165482oir.7;
        Thu, 28 Mar 2019 08:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FOI49pDZMyZISM61Z22Wl52hNCM0SzoJZZ0IhhKXih8=;
        b=FR9PIW10jHsHde16Kb7H4dcq1VBEGvgGViAEgY5p7Y0R+IALubIBo09JvuJmHgZtDY
         7wPKVSgmR1/areORACADoSzg0FjenMaVB9mfzCiLBU/BQnzt6EnsR/UKd3ulBdfHAO7i
         FSErvggIRyVElqkxXjbJRs8+dHH+EYK6shCt5B90h9GlZhzqM87K6vR8jH62a4gMDYvT
         UcYh0tdPHVqNnANIWSG+XcGzuediLR1ROZkDjZNPrw5InAKdJvUuACHlxYadggSdXbNg
         fBCRSsbfWScCnZfqiPkZz0zTgxxdYW83oyikzSvTdvRb3zEVWoCuD3vpOwTvhl0ByU5A
         8siw==
X-Gm-Message-State: APjAAAUjZKErq+FpbI/tLffR95XRu3mcm53y66R0EYbDeqfnUjlHjpIS
        5N8KmrGfr1vpX3PdJhd4Bg==
X-Google-Smtp-Source: APXvYqw2SUVj3FhgfmK8kV6bMrrp2YrFuJ1ePANJ6jTfJAK2WVM8Gs64eQ9px5qJB3weSsGFshLE5w==
X-Received: by 2002:aca:3dc4:: with SMTP id k187mr531387oia.40.1553788624078;
        Thu, 28 Mar 2019 08:57:04 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r25sm9828605otk.37.2019.03.28.08.57.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 08:57:03 -0700 (PDT)
Date:   Thu, 28 Mar 2019 10:57:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Hilman <khilman@baylibre.com>, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: phy: add g12a mdio mux
 documentation
Message-ID: <20190328155702.GA24696@bogus>
References: <20190314140135.19184-1-jbrunet@baylibre.com>
 <20190314140135.19184-2-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314140135.19184-2-jbrunet@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 03:01:33PM +0100, Jerome Brunet wrote:
> Add documentation for the device tree bindings of the MDIO mux of Amlogic
> g12a SoC family
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../bindings/net/mdio-mux-meson-g12a.txt      | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/mdio-mux-meson-g12a.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/mdio-mux-meson-g12a.txt b/Documentation/devicetree/bindings/net/mdio-mux-meson-g12a.txt
> new file mode 100644
> index 000000000000..e738bba6a9de
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/mdio-mux-meson-g12a.txt
> @@ -0,0 +1,48 @@
> +Properties for the MDIO bus multiplexer/glue of Amlogic G12a SoC family.
> +
> +This is a special case of a MDIO bus multiplexer. It allows to choose between
> +the internal mdio bus leading to the embedded 10/100 PHY or the external
> +MDIO bus.
> +
> +Required properties in addition to the generic multiplexer properties:
> +- compatible : amlogic,g12a-mdio-mux
> +- reg: physical address and length of the multiplexer/glue registers
> +- clocks: list of clock phandle, one for each entry clock-names.
> +- clock-names: should contain the following:
> +  * "pclk"   : peripheral clock.
> +  * "clkin0" : platform crytal
> +  * "clkin1" : SoC 50MHz MPLL
> +
> +Example :
> +
> +mdio-mux: mdio-multiplexer@4c000 {
> +	compatible = "amlogic,g12a-mdio-mux";
> +	reg = <0x0 0x4c000 0x0 0xa4>;
> +	clocks = <&clkc CLKID_ETH_PHY>,
> +		 <&xtal>,
> +		 <&clkc CLKID_MPLL_5OM>;
> +	clock-names = "pclk", "clkin0", "clkin1";
> +	mdio-parent-bus = <&mdio0>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	ext_mdio: mdio@0 {
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +	int_mdio: mdio@1 {
> +		reg = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		internal_ephy: ethernet_phy@8 {

ethernet-phy@8

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +			compatible = "ethernet-phy-id0180.3301",
> +				     "ethernet-phy-ieee802.3-c22";
> +			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			reg = <8>;
> +			max-speed = <100>;
> +		};
> +	};
> +};
> -- 
> 2.20.1
> 
