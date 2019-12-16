Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56C8C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E97206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576518838;
	bh=yjiQnM+DiLOl9/dLE+ps0ETJFM9psMggkN5gVCSGycY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ONF7qpcEGsp6BnAUKvBHJb7EwZ/BRSumvfdA4q3MtSeDxYh0fB+iNZfGQ3FEE7pP6
	 x8ZjDL6u7HyCaQtxDXM6pOw8yH8BW6Obg1OayoK7PNnGAwkwDh4jH832GrUYx+wWqw
	 KR/gI1X83vlu5FVcVcEFmzwoImwXw5A41xSbzj/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfLPRx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:53:57 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41206 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbfLPRxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:53:50 -0500
Received: by mail-ot1-f68.google.com with SMTP id r27so10123833otc.8;
        Mon, 16 Dec 2019 09:53:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aBXY62WKg7TVrV/PrvfxtQolVM/NjuBDVHTt/R6DLuE=;
        b=UgHxp/5nS1XO/xpYRPc8yH795Td/Hb0q1sdMrfCiQD2pONJNXoxOFeTKNAX1Ome5za
         9fNsbsHK1TI04xhedLMhBFHGsfchft/k2a684a74LEb/nsf62r/yRCew6p3BHoFTg7Ee
         7uKUJBnml+pYd3pouslQzwgaV4Lc6Uwp/5xvSKd9Cr5GFUgHGTnHpac4/GORRvRe1TKK
         +25CkaVnuoowu2/uygN7j8wBoU4SDBIYV5ksjH1KTW/naNwlocIufZ5W8yp9TOMgDT3j
         mNrc7lkpoG5+EF0i8Q+EnQL43S7NuTWp34ojTcl3aaMLtYx6wu2rnUXbEie8dXQ/+9wA
         W88A==
X-Gm-Message-State: APjAAAXnauYDfYbn+kE+3TBT+JsENo+xGSylvx/H3OmEn4EP0t9YIB0C
        GN+F+/KbExDqtGjbkIX+KA==
X-Google-Smtp-Source: APXvYqyvQQhFHfBUrNhwpcX+S7tO+0IFqa6VhHfOEkR78UZtjxvAtAexqLGRaE8IhXrJrj6Fbo87yg==
X-Received: by 2002:a9d:65cf:: with SMTP id z15mr34322760oth.238.1576518829512;
        Mon, 16 Dec 2019 09:53:49 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r10sm6964864otn.37.2019.12.16.09.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 09:53:49 -0800 (PST)
Date:   Mon, 16 Dec 2019 11:53:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
Subject: Re: [PATCH v9 1/2] dt-bindings: phy: intel-emmc-phy: Add YAML schema
 for LGM eMMC PHY
Message-ID: <20191216175348.GA18405@bogus>
References: <20191216034838.21875-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191216034838.21875-2-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216034838.21875-2-vadivel.muruganx.ramuthevar@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 11:48:37AM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add a YAML schema to use the host controller driver with the
> eMMC PHY on Intel's Lightning Mountain SoC.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  .../bindings/phy/intel,lgm-emmc-phy.yaml           | 58 ++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
> new file mode 100644
> index 000000000000..a7d4224b2001
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/intel,lgm-emmc-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel Lightning Mountain(LGM) eMMC PHY Device Tree Bindings
> +
> +maintainers:
> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> +
> +description: |+
> +  Bindings for eMMC PHY on Intel's Lightning Mountain SoC, syscon
> +  node is used to reference the base address of eMMC phy registers.
> +
> +  The eMMC PHY node should be the child of a syscon node with the
> +  required property:
> +
> +  - compatible:         Should be one of the following:
> +                        "intel,lgm-syscon", "syscon"
> +  - reg:
> +      maxItems: 1
> +
> +properties:
> +  compatible:
> +      const: intel,lgm-emmc-phy
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - "#phy-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names

Need to drop clock-names here too and in the example.

> +
> +examples:
> +  - |
> +    sysconf: chiptop@e0200000 {
> +      compatible = "intel,lgm-syscon", "syscon";
> +      reg = <0xe0200000 0x100>;
> +
> +      emmc-phy: emmc-phy@a8 {
> +        compatible = "intel,lgm-emmc-phy";
> +        reg = <0x00a8 0x10>;
> +        clocks = <&emmc>;
> +        clock-names = "emmcclk";
> +        #phy-cells = <0>;
> +      };
> +    };
> +...
> -- 
> 2.11.0
> 
