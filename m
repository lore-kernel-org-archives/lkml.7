Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266EAC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F109121881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567431536;
	bh=heMUBBn1VmHQA+UUK6lYTaqAilPCncSMIH9k/McQKNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RjJZByCU/tW4f5NVojcgdLyQ5KeyNyWW/2UT+91V+Z/A+91NjPfShGhdRTrN6JA+j
	 D3PdylZ+76t31dLC/hf29EbG9Bad9D1vupizl+3oDAEVA4wGk/u/YVl8SkMr2fwRb2
	 agpFGP4F18+ll9F80W7tNtBXruaPcMTcpHpu1aqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbfIBNiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:38:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33716 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730958AbfIBNiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:38:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id r17so11990603wme.0;
        Mon, 02 Sep 2019 06:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5MMBpvJ5ak+IZknDtorRR/rkjPkRZoS5gxFedreuzhc=;
        b=aFo869wyv57JxFWoYUcvJgDY8bCQqp8LBs2mn9pBaVKOqp6wG/S9cg7ldNe7PcQbAw
         w62RcRl+qQI+TYKhmcRYbvWva6VSUBODZZDTL5xeBNlqLP1pm0xVR+2dXz0e+ZDm1DQv
         4mVGhZVvXD+P79/qgrYjOOs3huI/PimE4Hz9LgF4e8uSY3UPVl/Gd2yrHRQPtyWVGD6E
         9nQ5bEjY6LEVYdg209yJnaBX7PfZKAo7vd5OkfLNgMPo+9pdNw9Lf2EfY2zp6tWbDDu6
         tUpYD2qrDC2HqR5PRX23fDcVz9qZAOpWJBQgucvXY5DtU1TTQzOSXpF7tHYRxs3MTiOJ
         oVgA==
X-Gm-Message-State: APjAAAVaiLq4FF1LhMoPSjscKzwa5ZafZtTx8b7MSXCE/ihD5NfnY4ty
        WzQjE07S5VqALRcZKMmGDQ==
X-Google-Smtp-Source: APXvYqxkSYTyJVOm1kEmsLdzVUIPWIBKnjcj/Qgs1eL8yDgaJyWDqCGNj9qXbty9MsVthW0txy3PJw==
X-Received: by 2002:a1c:720e:: with SMTP id n14mr27039475wmc.54.1567431528402;
        Mon, 02 Sep 2019 06:38:48 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id 12sm11631057wmi.34.2019.09.02.06.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:38:47 -0700 (PDT)
Date:   Mon, 02 Sep 2019 14:38:47 +0100
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: intel-sdxc-phy: Add YAML schema
 for LGM SDXC PHY
Message-ID: <20190902033716.GA18092@bogus>
References: <20190828124315.48448-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190828124315.48448-2-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828124315.48448-2-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mutt-References: <20190828124315.48448-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 08:43:14PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add a YAML schema to use the host controller driver with the
> SDXC PHY on Intel's Lightning Mountain SoC.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  .../bindings/phy/intel,lgm-sdxc-phy.yaml           | 52 ++++++++++++++++++++++
>  .../devicetree/bindings/phy/intel,syscon.yaml      | 33 ++++++++++++++
>  2 files changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,syscon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
> new file mode 100644
> index 000000000000..99647207b414
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/intel,lgm-sdxc-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel Lightning Mountain(LGM) SDXC PHY Device Tree Bindings
> +
> +maintainers:
> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> +
> +allOf:
> +  - $ref: "intel,syscon.yaml"

You don't need this. It should be selected and applied by the compatible 
string matching.

> +
> +description: Binding for SDXC PHY
> +
> +properties:
> +  compatible:
> +    const: intel,lgm-sdxc-phy
> +
> +  intel,syscon:
> +    description: phandle to the sdxc through syscon
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - "#phy-cells"
> +  - compatible
> +  - intel,syscon
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sdxc_phy: sdxc_phy {
> +        compatible = "intel,lgm-sdxc-phy";
> +        intel,syscon = <&sysconf>;

Make this a child of the below node and then you don't need this.

If there's a register address range associated with this, then add a reg 
property.

> +        clocks = <&sdxc>;
> +        clock-names = "sdxcclk";
> +        #phy-cells = <0>;
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/phy/intel,syscon.yaml b/Documentation/devicetree/bindings/phy/intel,syscon.yaml
> new file mode 100644
> index 000000000000..d0b78805e49f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/intel,syscon.yaml
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/intel,syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Syscon for eMMC/SDXC PHY Device Tree Bindings

Nothing else in this h/w block? If there are other functions, then this 
should not be in bindings/phy/.

> +
> +maintainers:
> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> +
> +properties:
> +  compatible:
> +    const: intel,syscon

Needs to be more specific and reflect h/w blocks. 'syscon' is a Linux 
thing to some extent.

> +
> +  reg:
> +    maxItems: 1
> +
> +  "#reset-cells":
> +   const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#reset-cells"
> +
> +examples:
> +  - |
> +    sysconf: chiptop@e0020000 {
> +       compatible = "intel,syscon", "syscon";
> +       reg = <0xe0020000 0x100>;
> +       #reset-cells = <1>;
> +    };
> -- 
> 2.11.0
> 

