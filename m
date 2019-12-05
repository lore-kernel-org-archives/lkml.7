Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5EDC2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D12A21835
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575556013;
	bh=fA/W+GlBHxPpmRALmc4GGsh/PVzpNgy54K013xZZ1iQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PN1zXCaQkV8QPRy5dnKF5ZcHjT69iuTzhxgErNtu+kCbrrG/Vi1n+XRHJhowWMhA6
	 sNgEzEogd5Q9xwnBczJgATa15gKl6alVkDCv3XyYYfk33VdtE6bn9RHX1gBSO1GKau
	 Bdkhlr9djNZG0i8YimcFgxPHKDCI6PrMS8EyJCFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbfLEO0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:26:52 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40412 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbfLEO0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:26:52 -0500
Received: by mail-oi1-f196.google.com with SMTP id 6so2872732oix.7;
        Thu, 05 Dec 2019 06:26:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VgcMhS0MdRQ8HUeMUuCAybmGz2xDw/Z2U63rVP/mjCQ=;
        b=MMw7etlmAshHJRhuii0E/xbvMVkjaV9hFeosld/A8ABpc0DGzbh/jYlJy++jjcHxeh
         3N/zpJbcVuT/qywWt5CaFBG/IqprwWMPTQW9cy/lbuzzDXs4S/EkPPb7F15IBbZXOP/n
         tdWZTX7Huhxgf7uKZ49BjmGIukx3t6Uo0fdq5NIbIt41V08ZtIfqabCpOTdKlwu34fpF
         oDgz2yPL03Yszz2KmrvfyR5DCTjZkzasHCKtzoKHfZckuN/cT8hYTP597j2UmgOghFz7
         +YpBoiD4mIL64W5a2bgSAmxl275MGDDcKiB9FLEhE2iA9Gfybxjyjw66U+cvROJizyAJ
         MG9A==
X-Gm-Message-State: APjAAAUflBLNRVNHesbbfyaT6NQzovy632WpRBPKPJoqQ8cEX1nGLHci
        fERlgnwDbj/TSTCjXiUamKoquJo=
X-Google-Smtp-Source: APXvYqxSoqus5d/8hi2Eh1B0hQRpz/laIuyUQk/92iXppMEV2M1B8bHnUSOymfzoB4Z1Y+EgwWSgnA==
X-Received: by 2002:aca:fdd7:: with SMTP id b206mr7068593oii.35.1575556010979;
        Thu, 05 Dec 2019 06:26:50 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t203sm1446494oig.39.2019.12.05.06.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 06:26:50 -0800 (PST)
Date:   Thu, 5 Dec 2019 08:26:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wen He <wen.he_1@nxp.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Walle <michael@walle.cc>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v11 1/2] dt/bindings: clk: Add YAML schemas for LS1028A Display
 Clock bindings
Message-ID: <20191205142649.GA22738@bogus>
References: <20191205072653.34701-1-wen.he_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205072653.34701-1-wen.he_1@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 03:26:52PM +0800, Wen He wrote:
> LS1028A has a clock domain PXLCLK0 used for provide pixel clocks to Display
> output interface. Add a YAML schema for this.
> 
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> change in v11:
> 	- renamed 'vco-frequency' to 'fsl,vco-hz' to clearly feild definiation
> 
>  .../devicetree/bindings/clock/fsl,plldig.yaml | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,plldig.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/fsl,plldig.yaml b/Documentation/devicetree/bindings/clock/fsl,plldig.yaml
> new file mode 100644
> index 000000000000..23cce65b3a93
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/fsl,plldig.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/clock/fsl,plldig.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP QorIQ Layerscape LS1028A Display PIXEL Clock Binding
> +
> +maintainers:
> +  - Wen He <wen.he_1@nxp.com>
> +
> +description: |
> +  NXP LS1028A has a clock domain PXLCLK0 used for the Display output
> +  interface in the display core, as implemented in TSMC CLN28HPM PLL.
> +  which generate and offers pixel clocks to Display.
> +
> +properties:
> +  compatible:
> +    const: fsl,ls1028a-plldig
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 0
> +
> +  fsl,vco-hz:
> +     $ref: '/schemas/types.yaml#/definitions/uint32'

Drop this as '*-hz' already has a type.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +     description: Optional for VCO frequency of the PLL in Hertz.
> +        The VCO frequency of this PLL cannot be changed during runtime
> +        only at startup. Therefore, the output frequencies are very
> +        limited and might not even closely match the requested frequency.
> +        To work around this restriction the user may specify its own
> +        desired VCO frequency for the PLL.
> +     minimum: 650000000
> +     maximum: 1300000000
> +     default: 1188000000
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - '#clock-cells'
> +
> +examples:
> +  # Display PIXEL Clock node:
> +  - |
> +    dpclk: clock-display@f1f0000 {
> +        compatible = "fsl,ls1028a-plldig";
> +        reg = <0x0 0xf1f0000 0x0 0xffff>;
> +        #clock-cells = <0>;
> +        clocks = <&osc_27m>;
> +    };
> +
> +...
> -- 
> 2.17.1
> 
