Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06A7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C50D2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553719204;
	bh=g+GpdYE9VXsEIgisQyN2A1NrJJ32XpGjambXFTZ2vH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y6MW8FrJFklK19pN++iGsfeb/Im9M/ZQV7v6qLYcCRqVsxZHT/fAKTZO1eE1AFsyQ
	 9OjfqqBSjvzqHnLg0io5i3h+7KGqQKML0nMlDW37tR0UOFKf0DqQ0eVhZiugUQRltv
	 isSx5Sf2EFRcrZKFps9bRFj+XxJtngHjq9wgbw30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfC0UkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:40:03 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46449 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfC0UkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:40:02 -0400
Received: by mail-oi1-f195.google.com with SMTP id x188so13996693oia.13;
        Wed, 27 Mar 2019 13:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4gs1k9h/r+rR22WgCUHcRbiFNQiFMIAqAW+9dotws5o=;
        b=ivlXsGN+p0T5FvFaEbYdidQpfjsrnLQEugeyh5SgEhpwy7h9nur3h/pbD9FR4fMls5
         LcX1E9neYrTqm10fp0j6mFtJJQZG6AQ43oGSEhlolQNF0kWG4aTU02Au7CEkYuUKfqJv
         bs4xZlEWCyItBz5pew9BvNM4ygKRjv7wI98utNufvRwUKFLS/dBUM+p7cH7aYEoSFWGL
         X0JM/ReQ7F07iIP1h7L2zBg7ZYsy/sTGnNCbh1nLZbNRy4LaFGkcPuHl3JR85VNyFmYc
         2Ez2RmeXM7oyGKTRjdCOFtgyPZQtWziMIcKOVy+/o/zCBW5tl1+sUXrJKCQujPYVWmki
         B9KQ==
X-Gm-Message-State: APjAAAWFm9WOPm0SmG90RT5QRDxXzBS7rj2W1KTnHYnST7Ugih8Z5hjB
        w1twBIQarDD87a5G3P7/Iw==
X-Google-Smtp-Source: APXvYqwiLSwO8LZWbdcBRnH42bGTBkfd4DgaMpEeNCh1wnZaZdD3X72tHIoPAa+g7pIuHz+CxCG+Aw==
X-Received: by 2002:aca:5757:: with SMTP id l84mr21554261oib.155.1553719201655;
        Wed, 27 Mar 2019 13:40:01 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a34sm2067893otc.46.2019.03.27.13.39.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 13:39:59 -0700 (PDT)
Date:   Wed, 27 Mar 2019 15:39:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] dt-bindings: gpu: add bindings for the ARM Mali
 Bifrost GPU
Message-ID: <20190327203959.GA31523@bogus>
References: <20190304105802.6010-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304105802.6010-1-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 11:58:02AM +0100, Neil Armstrong wrote:
> Add the bindings for the Bifrost family of ARM Mali GPUs.
> 
> The Bifrost GPU architecture is similar to the Midgard family,
> but with a different Shader Core & Execution Engine structures.
> 
> Bindings are based on the Midgard family bindings, but the inner
> architectural changes makes it a separate family needing separate
> bindings.
> 
> The Bifrost GPUs are present in a number of recent SoCs, like the
> Amlogic G12A Family, and many other vendors.
> The Amlogic vendor specific compatible is added to handle the
> specific IP integration differences and dependencies.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/gpu/arm,mali-bifrost.txt         | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
> 
> Changes since v2:
> - moved to a single compatible since HW is fully discoverable
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
> new file mode 100644
> index 000000000000..e068fccf4ce9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
> @@ -0,0 +1,90 @@
> +ARM Mali Bifrost GPU
> +====================
> +
> +Required properties:
> +
> +- compatible :
> +  * Must contain one the following:
> +    + "arm,mali-bifrost"

Perhaps a note that the specific model/revision is discoverable.

> +  * which must be preceded by one of the following vendor specifics:
> +    + "amlogic,meson-g12a-mali"
> +
> +- reg : Physical base address of the device and length of the register area.
> +
> +- interrupts : Contains the three IRQ lines required by Mali Bifrost devices.
> +
> +- interrupt-names : Contains the names of IRQ resources in the order they were
> +  provided in the interrupts property. Must contain: "job", "mmu", "gpu".

Please make the order defined.

> +
> +Optional properties:
> +
> +- clocks : Phandle to clock for the Mali Bifrost device.
> +
> +- mali-supply : Phandle to regulator for the Mali device. Refer to
> +  Documentation/devicetree/bindings/regulator/regulator.txt for details.
> +
> +- operating-points-v2 : Refer to Documentation/devicetree/bindings/opp/opp.txt
> +  for details.
> +
> +- resets : Phandle of the GPU reset line.
> +
> +Vendor-specific bindings
> +------------------------
> +
> +The Mali GPU is integrated very differently from one SoC to
> +another. In order to accomodate those differences, you have the option
> +to specify one more vendor-specific compatible, among:
> +
> +- "amlogic,meson-g12a-mali"
> +  Required properties:
> +  - resets : Should contain phandles of :
> +    + GPU reset line
> +    + GPU APB glue reset line
> +
> +Example for a Mali-G31:
> +
> +gpu@ffa30000 {
> +	compatible = "amlogic,meson-g12a-mali", "arm,mali-bifrost";
> +	reg = <0xffe40000 0x10000>;
> +	interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupt-names = "job", "mmu", "gpu";
> +	clocks = <&clk CLKID_MALI>;
> +	mali-supply = <&vdd_gpu>;
> +	operating-points-v2 = <&gpu_opp_table>;
> +	resets = <&reset RESET_DVALIN_CAPB3>, <&reset RESET_DVALIN>;
> +};
> +
> +gpu_opp_table: opp_table0 {
> +	compatible = "operating-points-v2";
> +
> +	opp@533000000 {
> +		opp-hz = /bits/ 64 <533000000>;
> +		opp-microvolt = <1250000>;
> +	};
> +	opp@450000000 {
> +		opp-hz = /bits/ 64 <450000000>;
> +		opp-microvolt = <1150000>;
> +	};
> +	opp@400000000 {
> +		opp-hz = /bits/ 64 <400000000>;
> +		opp-microvolt = <1125000>;
> +	};
> +	opp@350000000 {
> +		opp-hz = /bits/ 64 <350000000>;
> +		opp-microvolt = <1075000>;
> +	};
> +	opp@266000000 {
> +		opp-hz = /bits/ 64 <266000000>;
> +		opp-microvolt = <1025000>;
> +	};
> +	opp@160000000 {
> +		opp-hz = /bits/ 64 <160000000>;
> +		opp-microvolt = <925000>;
> +	};
> +	opp@100000000 {
> +		opp-hz = /bits/ 64 <100000000>;
> +		opp-microvolt = <912500>;
> +	};
> +};
> -- 
> 2.20.1
> 
