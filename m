Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176C4C35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E234B21D7B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569855378;
	bh=mass8G56g/o9CSMtYsOQYCaSJVssk7Mw3979ytF3GDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sIKka1YCmeGaBJSpVcPwXzSvCvJFefpK+DFpAwULqp15cM7B2VTT8OIjfK16iOniE
	 SpNpAUoyy5fJOe9CxC6ljzAoQ+hgODEmi/q/xARfx5V6zCfkAaqRz3hApbKFCg0oea
	 dfHTnVSTXJZNFkOAA/BrS+ZnF5BvKjQGBKLdVlms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbfI3O4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:56:17 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46402 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbfI3O4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:56:15 -0400
Received: by mail-oi1-f194.google.com with SMTP id k25so11334762oiw.13;
        Mon, 30 Sep 2019 07:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BwA681HhYis/Fwr6rUVisbTJS/OHBKxj8dYqASkfvtk=;
        b=nNGJWCt2GmMvPMWf9HKrphztJpVphoypi7Ty/BOKB1GXjEhlQbwYbksGSGpD8OjbNM
         JLCobcRSC5uYW5HW5EBY8QeLHLbv04/ckaCmsOguF2bcpjERj1qTS1WsmdehhY3yCGy0
         blPS8nWR2P3DUU8cFWA0FuGD+B7IDmF9H3wWXdqxNWmuTfr2CoRZwAXArDUMOxwyT43N
         ajTDQXH8+At5TfcOIRmrMKFM90AYx88PWLBQrnp1iajngG+XBIE5ZmXMP+S2veKFByNF
         pbAnRAbBEa3KOmh/gHFn7JG1W4YepUjLWtLH8zeYlC/6nXaU7qP3RofBH9aRs3nnbauB
         d7gw==
X-Gm-Message-State: APjAAAW78+aLeAv6oHZNupOeDM/JGFCsL1qhkc2oAmUnjjgsy5wD1dhB
        dJ4OdGLx5lnRcD0HUSdCrg==
X-Google-Smtp-Source: APXvYqwLv4Y/czSKwivg0BhTvGD0JVI63oHqc+uuK2t3KytVcKxUUzmm4XvHqY6SDRpQT9booAv6KA==
X-Received: by 2002:a54:410f:: with SMTP id l15mr17456048oic.92.1569855374801;
        Mon, 30 Sep 2019 07:56:14 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d194sm4443581oib.47.2019.09.30.07.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 07:56:14 -0700 (PDT)
Date:   Mon, 30 Sep 2019 09:56:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        nicolas.ferre@microchip.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        claudiu.beznea@microchip.com
Subject: Re: [PATCH 1/3] dt-bindings: sdhci-of-at91: new compatible string
 and update properties
Message-ID: <20190930145613.GA11254@bogus>
References: <20190912200908.31318-1-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912200908.31318-1-ludovic.desroches@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 10:09:06PM +0200, Ludovic Desroches wrote:
> There is a new compatible string for the SAM9X60 sdhci device. It involves
> an update of the properties about the clocks stuff.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
>  .../devicetree/bindings/mmc/sdhci-atmel.txt   | 25 ++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> index 1b662d7171a0..364ceea330b6 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> @@ -5,12 +5,19 @@ Documentation/devicetree/bindings/mmc/mmc.txt and the properties used by the
>  sdhci-of-at91 driver.
>  
>  Required properties:
> -- compatible:		Must be "atmel,sama5d2-sdhci".
> +- compatible:		Must be "atmel,sama5d2-sdhci" or "microchip,sam9x60-sdhci".
>  - clocks:		Phandlers to the clocks.
> -- clock-names:		Must be "hclock", "multclk", "baseclk";
> +- clock-names:		Must be "hclock", "multclk", "baseclk" for
> +			"atmel,sama5d2-sdhci".
> +			Must be "hclock", "multclk" for "microchip,sam9x60-sdhci".
>  
> +Optional properties:
> +- assigned-clocks:	The same with "multclk".
> +- assigned-clock-rates	The rate of "multclk" in order to not rely on the
> +			gck configuration set by previous components.
>  
> -Example:
> +
> +Examples:
>  
>  sdmmc0: sdio-host@a0000000 {
>  	compatible = "atmel,sama5d2-sdhci";
> @@ -18,4 +25,16 @@ sdmmc0: sdio-host@a0000000 {
>  	interrupts = <31 IRQ_TYPE_LEVEL_HIGH 0>;
>  	clocks = <&sdmmc0_hclk>, <&sdmmc0_gclk>, <&main>;
>  	clock-names = "hclock", "multclk", "baseclk";
> +	assigned-clocks = <&sdmmc0_gclk>;
> +	assigned-clock-rates = <480000000>;
> +};
> +
> +sdmmc0: sdio-host@80000000 {

mmc@...

Though I don't see much value in a second example. Examples are not a 
complete enumeration of all possible dts entries.

> +	compatible = "microchip,sam9x60-sdhci";
> +	reg = <0x80000000 0x300>;
> +	interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
> +	clocks = <&pmc PMC_TYPE_PERIPHERAL 12>, <&pmc PMC_TYPE_GCK 12>;
> +	clock-names = "hclock", "multclk";
> +	assigned-clocks = <&pmc PMC_TYPE_GCK 12>;
> +	assigned-clock-rates = <100000000>;
>  };
> -- 
> 2.23.0
> 
