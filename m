Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7AFC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35F620B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560456499;
	bh=Eotn74x1zRC/0EseWUhBVg+AzUh3VCeG9bTL7CvwUP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WV23hsM05wJJI7EG/ZdvalVZQNRStFaAM5eyenxMUPGs2SXditZ0KfI9nPFNiBzLY
	 mJkzqlAovwylHtEJYOQJsO+nab5XubRoyaztApTCjA1tg0ESlZH6xYlM0hWaR0D3G8
	 3JCoaKpVtu3xxTTSPMs5zHVLG+pgE0ZFbtNhD8pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfFMUIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 16:08:18 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39199 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFMUIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 16:08:18 -0400
Received: by mail-qt1-f196.google.com with SMTP id i34so24069632qta.6;
        Thu, 13 Jun 2019 13:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UwChhjSzjeOfvvnEfR7YJU7oQ/qodwbm5JIdXsqXlRo=;
        b=civSKFH0kxQmDhv/mbgH20UxiBrqbBEeP5oyYx2nz3ka23nYb7o0rXiZZYu35rzCg/
         2cMBLKTD7v+aHYHJBd52+l8X9jONcCSYxcPQ843bmwPPZZQwcY0/VJvCCiTVVpH0Yfc3
         2rIOsAGvaKNvePV06dPtI8mk7trY2Qm8ZYR173HxqLQNCI2h8YKfLkimog9dXbAVrp8h
         53tzJR3mpcsnHFUr2uimJVosqFykVeSHE1/sh3iYdbBZeaxIBWeRc7nWsem6cCReXlAe
         1Aa70YB1Jb88KtgEPersUsfGQxszsE/WHy+1ZwzIoPIQOdpPHxmarrSLCHjy40YcTzbp
         Rw3A==
X-Gm-Message-State: APjAAAUY4HwsSdHDYJc/+8JDzUQ0BDbzT0fPBd866+icqiLdHlvR6VhQ
        ooWFsXXcDgAbWEysuCj5zw==
X-Google-Smtp-Source: APXvYqxlMoVZh97RRGXb4sVgHdetYuU+vA47kS1FGVMnu6eGCEIfvRk5fRpKmQ3WZnBR9tg5KwicmA==
X-Received: by 2002:a0c:d91b:: with SMTP id p27mr5042508qvj.236.1560456496941;
        Thu, 13 Jun 2019 13:08:16 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id j62sm248574qte.89.2019.06.13.13.08.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 13:08:16 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:08:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wen He <wen.he_1@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>
Subject: Re: [v1 1/4] dt-bindings: display: Add DT bindings for LS1028A
 HDP-TX PHY.
Message-ID: <20190613200813.GA895@bogus>
References: <20190508103703.40885-1-wen.he_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508103703.40885-1-wen.he_1@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 10:35:25AM +0000, Wen He wrote:
> Add DT bindings documentmation for the HDP-TX PHY controller. The describes
> which could be found on NXP Layerscape ls1028a platform.

Drop the hard stop (.) from the subject.

> 
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> ---
>  .../devicetree/bindings/display/fsl,hdp.txt   | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/fsl,hdp.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/fsl,hdp.txt b/Documentation/devicetree/bindings/display/fsl,hdp.txt
> new file mode 100644
> index 000000000000..36b5687a1261
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/fsl,hdp.txt
> @@ -0,0 +1,56 @@
> +NXP Layerscpae ls1028a HDP-TX PHY Controller
> +============================================
> +
> +The following bindings describe the Cadence HDP TX PHY on ls1028a that
> +offer multi-protocol support of standars such as eDP and Displayport,
> +supports for 25-600MHz pixel clock and up to 4k2k at 60MHz resolution.
> +The HDP transmitter is a Cadence HDP TX controller IP with a companion
> +PHY IP.

I'm confused. This binding covers both blocks or is just one of them?

> +
> +Required properties:
> +  - compatible:   Should be "fsl,ls1028a-dp" for ls1028a.
> +  - reg:          Physical base address and size of the block of registers used
> +  by the processor.
> +  - interrupts:   HDP hotplug in/out detect interrupt number
> +  - clocks:       A list of phandle + clock-specifier pairs, one for each entry
> +  in 'clock-names'
> +  - clock-names:  A list of clock names. It should contain:
> +      - "clk_ipg": inter-Integrated circuit clock
> +      - "clk_core": for the Main Display TX controller clock
> +      - "clk_pxl": for the pixel clock feeding the output PLL of the processor
> +      - "clk_pxl_mux": for the high PerfPLL bypass clock
> +      - "clk_pxl_link": for the link rate pixel clock
> +      - "clk_apb": for the APB interface clock
> +      - "clk_vif": for the Video pixel clock

The 'clk_' part is redundant.

> +
> +Required sub-nodes:
> +  - port: The HDP connection to an encoder output port. The connection
> +    is modelled using the OF graph bindings specified in
> +    Documentation/devicetree/bindings/graph.txt
> +
> +
> +Example:
> +
> +/ {
> +        ...
> +
> +	hdp: display@f200000 {
> +                compatible = "fsl,ls1028a-dp";
> +		reg = <0x0 0xf1f0000 0x0 0xffff>,
> +		    <0x0 0xf200000 0x0 0xfffff>;
> +                interrupts = <0 221 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&sysclk>, <&hdpclk>, <&dpclk>,
> +                         <&dpclk>, <&dpclk>, <&pclk>, <&dpclk>;
> +		clock-names = "clk_ipg", "clk_core", "clk_pxl",
> +                              "clk_pxl_mux", "clk_pxl_link", "clk_apb",
> +                              "clk_vif";
> +
> +		port {
> +			dp1_output: endpoint {
> +				remote-endpoint = <&dp0_input>;
> +			};
> +		};
> +        };
> +
> +        ...
> +};
> -- 
> 2.17.1
> 
