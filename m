Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81EBC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 23:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EC020665
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 23:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565652577;
	bh=cer7IE2RRNr2t1gNqlu4qGmm3HJXNOA7allDIe3zKOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sJlhDGiOrBy5Y9psF9/gJr8kNemduPxMFabZtxrrx83sBUpbmHXEwA0F2K2thny+O
	 zvvSHkF/vSZCTs/XwNkhSCoLUYNcpt0/s1xqTRkdUfxohJQfPGjVcDiKqJ5f0Qu5IL
	 a5/f1rxJPt/fex83Osxb1Xy9SkhZ1pWAJFjIQ6TU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfHLX3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 19:29:36 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43119 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfHLX3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 19:29:36 -0400
Received: by mail-ot1-f65.google.com with SMTP id e12so21328095otp.10;
        Mon, 12 Aug 2019 16:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4yxOmFc8mjrzQ7FT1CRXemmXNTDbbde5+76CCWY9y9w=;
        b=aG7cwCOJUCfJBYEJb0q6C4GrFHXDKQpt/0p04oyzQ9CzeCKToFiE8dWRjU9nG10qLk
         IhbMQCKAL3Sqszp/2MyJWFtMnI4iam07l2ynLlnaeOw0+1I2xcO2QNzoomZ+E5abcMjU
         1OnJ18bCJ9ZZvHQXIvk1UMkaMy72uzhx7oiUe6VoiMQznWMjX2tsd/WiV7VG0eGU99M6
         3mvaFjYQwKU8N4C5hEgCO6PFMDCyLoP0ua2Sq9xmIasXnl0ZfKrMVzN8MQ+3voogLrym
         qkeaWej0cvDH169dT0/66xKnd3be8LAuM0qWBefL4cZZsRkbnNVnlLnT44kfh/Ku+ZDH
         lXnw==
X-Gm-Message-State: APjAAAU1/Q69rBWUMFjyVjE00DgnXiK74qyEoBO4aZuOPi6vuxX6cugl
        ssUUJtXf7zZqZLwWb7sN5g==
X-Google-Smtp-Source: APXvYqwMVgFEMJqzgRQCjE77n0TRXXJZ+evINUqzU+d3BirD/mE1ZLx1bMt8mhMDISlggMrsS6Hamw==
X-Received: by 2002:a6b:7619:: with SMTP id g25mr631364iom.92.1565652575408;
        Mon, 12 Aug 2019 16:29:35 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id j25sm151097051ioj.67.2019.08.12.16.29.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 16:29:34 -0700 (PDT)
Date:   Mon, 12 Aug 2019 17:29:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wen He <wen.he_1@nxp.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com
Subject: Re: [v2 1/4] dt-bindings: display: Add DT bindings for LS1028A
 HDP-TX PHY.
Message-ID: <20190812232934.GA1219@bogus>
References: <20190719100942.12016-1-wen.he_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719100942.12016-1-wen.he_1@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 06:09:39PM +0800, Wen He wrote:
> Add DT bindings documentmation for the HDP-TX PHY controller. The describes
> which could be found on NXP Layerscape ls1028a platform.

Not required, but please consider converting to DT schema (YAML) format.

> 
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> ---
> change in v2:
>         - correction the node name.
> 
>  .../devicetree/bindings/display/fsl,hdp.txt   | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/fsl,hdp.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/fsl,hdp.txt b/Documentation/devicetree/bindings/display/fsl,hdp.txt
> new file mode 100644
> index 000000000000..53ca08337587
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/fsl,hdp.txt
> @@ -0,0 +1,56 @@
> +NXP Layerscpae ls1028a HDP-TX PHY Controller

typo

> +============================================
> +
> +The following bindings describe the Cadence HDP TX PHY on ls1028a that
> +offer multi-protocol support of standars such as eDP and Displayport,

s/offer/offers/

and another typo.

> +supports for 25-600MHz pixel clock and up to 4k2k at 60MHz resolution.
> +The HDP transmitter is a Cadence HDP TX controller IP with a companion
> +PHY IP.
> +
> +Required properties:
> +  - compatible:   Should be "fsl,ls1028a-dp" for ls1028a.
> +  - reg:          Physical base address and size of the block of registers used
> +  by the processor.

The example shows 2 regions, what are they?

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

'clk_' is redundant.

> +
> +Required sub-nodes:
> +  - port: The HDP connection to an encoder output port. The connection
> +    is modelled using the OF graph bindings specified in
> +    Documentation/devicetree/bindings/graph.txt

I'm still confused as to what this block does? The 'encoder output' is 
DisplayPort? If this is just a phy, then use the phy binding.

Normally, a DisplayPort encoder/bridge OF graph output would be 
connected to a DP connector node or a panel.

Rob
