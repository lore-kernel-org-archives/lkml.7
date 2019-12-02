Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65699C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD9A20718
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575312482;
	bh=DZobwyVTMIk2P8F6Y7+zlO1hthfFR4W+Are7ELcMZNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0wc6MEtiDS9iG7FFE8PKyfIi8DNAHYJfgED9xOv0+XivZpXdwTDzQJeFnzhipMkC8
	 HwRGXaUL0a7L3nutRT0wQCWDEFdRrCpwnLjSAum4WIsTOZAxXR0KOVBRC+DThLSm5f
	 gLr9W2GEFVd+dbSt7lQBT/yDHKb7YXcP33136OBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfLBSsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:48:01 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38345 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbfLBSsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:48:01 -0500
Received: by mail-oi1-f195.google.com with SMTP id b8so659021oiy.5;
        Mon, 02 Dec 2019 10:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mBpJM7Zj2wSiQOjSDmwoTTIZ3KSKjAbhhQOqtWInyn8=;
        b=A7aMOrXpKhJy4fk39+qi/ANYq/TUy3hJ06XneZJ5oUT0OFi6rhHC9yRUlq9vS9iAFR
         mHzY8wyQTwwGj2fVHFWlHn2l0PiT3mGWgVNMXxnPXTUC0y1MVqBKX7+nTMutffctrpd2
         x8JOeWWdqz65qRlfbS25GyyDioj7MNgdSMp3VUIG9zri8nRaGJ7jn4y8n1Asprwfofrv
         vDP9wBKSFeoybGjyfoHV+EwJHX/7iWbpZh/AHZgehJFNa9bpOdNBv5N/mbOdmgVhwjz1
         YRXP7Xlyi2SQat1hID0fUq721cXvoRXXGYmntZ3ZdwGj10+rdZn9v0nEs3bw7CHW92SS
         RwQA==
X-Gm-Message-State: APjAAAX4YTCRhzP5CNeDWGhYr9adWNRwanVIknLUrT/UuKud7yTM4XRB
        ieIV2x6UGNTVqSf8lpjJjQ==
X-Google-Smtp-Source: APXvYqzdzdPrzk+OWMWznQdm93ETxyP6UWwf6N3cCEdAYlYM58GRWWErDRTEF83uYELHa89BF49evQ==
X-Received: by 2002:aca:c38c:: with SMTP id t134mr354494oif.175.1575312479937;
        Mon, 02 Dec 2019 10:47:59 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m133sm104652oia.29.2019.12.02.10.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 10:47:59 -0800 (PST)
Date:   Mon, 2 Dec 2019 12:47:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wen He <wen.he_1@nxp.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Walle <michael@walle.cc>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v10 1/2] dt/bindings: clk: Add YAML schemas for LS1028A Display
 Clock bindings
Message-ID: <20191202184758.GA8408@bogus>
References: <20191127101525.44516-1-wen.he_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127101525.44516-1-wen.he_1@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 06:15:24PM +0800, Wen He wrote:
> LS1028A has a clock domain PXLCLK0 used for provide pixel clocks to Display
> output interface. Add a YAML schema for this.
> 
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> change in v10:
>         - Add optional feild 'vco-frequency'.
> 
>  .../devicetree/bindings/clock/fsl,plldig.yaml | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,plldig.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/fsl,plldig.yaml b/Documentation/devicetree/bindings/clock/fsl,plldig.yaml
> new file mode 100644
> index 000000000000..ee5b5c61a471
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/fsl,plldig.yaml
> @@ -0,0 +1,54 @@
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
> +  vco-frequency:

Needs vendor prefix and unit suffix:

fsl,vco-hz

Or you could perhaps just use 'clock-frequency'.

> +     $ref: '/schemas/types.yaml#/definitions/uint32'
> +     description: Optional for VCO frequency of the PLL in Hertz.
> +        The VCO frequency of this PLL cannot be changed during runtime
> +        only at startup. Therefore, the output frequencies are very
> +        limited and might not even closely match the requested frequency.
> +        To work around this restriction the user may specify its own
> +        desired VCO frequency for the PLL. The frequency has to be in the
> +        range of 650000000 to 1300000000.
> +        If not set, the default frequency is 1188000000.

A bunch of constraints you've listed here that should be schema rather 
than freeform text:

minimum: 650000000
maximum: 1300000000
default: 1188000000

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
