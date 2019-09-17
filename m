Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257B9C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB89D20678
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568730221;
	bh=y8uSFQ8LF4ZaelD1TudZ0ccrIbKzpafl0z6Fxci9itY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Md3M5FBmJGJx50x3654KiUNKOlYS211Eyr49kbjYO2SyUTKqgnn0CigFiVAf9i0wR
	 iapuu3dm25DdBrZ4WnMAyiXkTSU/LV9yZ6RGiBH+g/Tc6zjBRJQlTo+E84mrUaGKon
	 9J0bhq3uSEBJyFGSBjUIBtt+KWRZoZg3TeRoH3dI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfIQOXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:23:40 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45522 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfIQOXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 10:23:40 -0400
Received: by mail-ot1-f68.google.com with SMTP id 41so3155690oti.12;
        Tue, 17 Sep 2019 07:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X9xy3wm83YouZRo1BB7hVE9u2ONh+tQ6r8bXgR1pEJk=;
        b=gKH9iJf9xqQ5oW+X3Es9rQXVr32RejsamqbpWodwTw1YzFNsvZAc3imilPsbWRUIvn
         QLzmwMdJhfhakczrS1wxJdGRPRY1L37FGfkfQXWDUWs59HxnfmzLGcje8NiNGKuevVyx
         iWK2S10/2+A1VaLQYo82lf7Hfp0kbGidxcshr03kokyuJP1cEkvLOi/zKrqEofNVmRl7
         iBg7e7nnDPuY++xFH9mlM5hglXLfiER1ifarzRM0TEAq7V6L567UhKi5yJAFhmIuHLNj
         FDvF1F8TOQrkpfwin99x5L4PoWLF7G2rUvLiDpN+bGFXlSJbV2mFVYxqv0jH+mHzxhfr
         JLCw==
X-Gm-Message-State: APjAAAUPOsEKebZFzCjbMjjRtupN7Dq3x8/WiyjRmysKVpv9RJ8e9Zti
        +rWdGtO5EFjDe7k6WLYO7+iNu+Y=
X-Google-Smtp-Source: APXvYqyaAe3Lj7n1XQ6rADdcFVMnrIySwzJZK2S8u5m58lGkDCBzdMCtct7mjDV66iOGvEhR0T7ihg==
X-Received: by 2002:a05:6830:1357:: with SMTP id r23mr2940766otq.91.1568730218619;
        Tue, 17 Sep 2019 07:23:38 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b5sm757007otp.36.2019.09.17.07.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 07:23:38 -0700 (PDT)
Date:   Tue, 17 Sep 2019 09:23:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
Subject: Re: [PATCH v5 1/2] dt-bindings: phy: intel-emmc-phy: Add YAML schema
 for LGM eMMC PHY
Message-ID: <20190917142337.GA27151@bogus>
References: <20190904055344.25512-1-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904055344.25512-1-vadivel.muruganx.ramuthevar@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 01:53:43PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add a YAML schema to use the host controller driver with the
> eMMC PHY on Intel's Lightning Mountain SoC.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
> changes in v5:
>   - earlier Review-by tag given by Rob
>   - rework done with syscon parent node.
> 
> changes in v4:
>   - As per Rob's review: validate 5.2 and 5.3
>   - drop unrelated items.
> 
> changes in v3:
>   - resolve 'make dt_binding_check' warnings
> 
> changes in v2:
>   As per Rob Herring review comments, the following updates
>  - change GPL-2.0 -> (GPL-2.0-only OR BSD-2-Clause)
>  - filename is the compatible string plus .yaml
>  - LGM: Lightning Mountain
>  - update maintainer
>  - add intel,syscon under property list
>  - keep one example instead of two
> ---
>  .../bindings/phy/intel,lgm-emmc-phy.yaml           | 69 ++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
> new file mode 100644
> index 000000000000..8f6ac8b3da42
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
> @@ -0,0 +1,69 @@
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
> +description: Bindings for eMMC PHY on Intel's Lightning Mountain SoC, syscon
> +  node is used to reference the base address of eMMC phy registers.
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: intel,lgm-syscon

This, plus...

> +
> +    reg:
> +      maxItems: 1
> +
> +  required:
> +    - compatible
> +    - reg
> +
> +properties:
> +  "#phy-cells":
> +    const: 0
> +
> +  compatible:
> +    contains:
> +      const: intel,lgm-emmc-phy

...this should not pass validation as they contradict each other.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    maxItems: 1
> +
> +required:
> +  - "#phy-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    sysconf: chiptop@e0200000 {
> +      compatible = "intel,lgm-syscon";
> +      reg = <0xe0200000 0x100>;

I'm still waiting for a complete description of what all is in this 
block.

> +
> +      emmc-phy: emmc-phy {
> +        compatible = "intel,lgm-emmc-phy";
> +        reg = <0x00a8 0x4>,
> +              <0x00ac 0x4>,
> +              <0x00b0 0x4>,
> +              <0x00b4 0x4>;

Looks contiguous and can be a single entry:

<0xa8 0x10>

> +        clocks = <&emmc>;
> +        clock-names = "emmcclk";
> +        #phy-cells = <0>;
> +      };
> +    };
> +...
> -- 
> 2.11.0
> 
