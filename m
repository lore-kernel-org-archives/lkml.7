Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7B1CA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C182120856
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572364126;
	bh=YEhvTQM/h1o4Eqp6z8QmkHY1BruBJoevL45cbhUFX+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iV/MOZGT7lKS/44EtbXYUgXE7ya9JoqQOozZyLAB3Jkan1vnpSqbeQHIdDXGwRW8y
	 08jQd4AE/zCpC//jC9dLLiDVRyDgRdx0lyIvcP8Z3UJw2fMGrMaPSWKsgqVzNOoDNm
	 qdQRwV6XCTlPwIEPq1rYr/JavetjHbDdB5D0zHlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390152AbfJ2Psp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 11:48:45 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44123 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390030AbfJ2Psp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 11:48:45 -0400
Received: by mail-oi1-f193.google.com with SMTP id s71so9303329oih.11;
        Tue, 29 Oct 2019 08:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TryK/eyILmB78QJ89L2r4cOQt0zEf3Bg2PoDdQZ9/H4=;
        b=KRHayXkCUW9N0hs3ekiV8o545nYQY7a4vFpqqdLlrrJZGkPn7/6+6Sss1krKz9JmJ3
         bSTjYdT2BBwkNUdD9qvbqPDBJDT8CtcYWuewDZL4dQIz/57bCuqpYB2FgYWOgoipFcYy
         9g3uw39cNc17q64rDd6vfVdFu6UwKuPVQw8EbWsISaw37WrOP5cZOqvqwZ6D1AjIAAUU
         NxlKI1UxYhO/+3GXnRrdyiMAKAfcsXCYtywPshHCByK7x9ZLcoILKefWbT2WX5GWHRe8
         jHznn5TRcJFK6ZB+RZqvMdOE3KvA7ChLJPUTnV0n+BggxEjUhJr2soaB48u8InXcOFY0
         Ra7g==
X-Gm-Message-State: APjAAAWswigyemWhJDlEplL9m6gfTxyhEspE+vRAqoZB6WZvDjbBZPRI
        T6ImXErvVGPfzaVHkLcMoA==
X-Google-Smtp-Source: APXvYqylLrKV+vF7Y9CNIH/jGCvYxzyF50ECw7PNA5lUdOFheLB0VvuqCwC4Ttil6vV9pnSJSgLBSA==
X-Received: by 2002:aca:1a0b:: with SMTP id a11mr4858966oia.138.1572364124337;
        Tue, 29 Oct 2019 08:48:44 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o22sm4619317otk.47.2019.10.29.08.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 08:48:43 -0700 (PDT)
Date:   Tue, 29 Oct 2019 10:48:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
Subject: Re: [PATCH v6 1/2] dt-bindings: phy: intel-emmc-phy: Add YAML schema
 for LGM eMMC PHY
Message-ID: <20191029154842.GA3526@bogus>
References: <20191021095436.50303-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191021095436.50303-2-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021095436.50303-2-vadivel.muruganx.ramuthevar@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 05:54:35PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add a YAML schema to use the host controller driver with the
> eMMC PHY on Intel's Lightning Mountain SoC.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
> ---
>  .../bindings/phy/intel,lgm-emmc-phy.yaml           | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
> new file mode 100644
> index 000000000000..bc1285be31f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
> @@ -0,0 +1,63 @@
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

You don't need a 'select'.

> +  properties:
> +    compatible:
> +      items:
> +       - const: intel,lgm-syscon
> +       - const: intel,lgm-emmc-phy

This is not right. You are saying 'compatible' must be:

compatible = "intel,lgm-syscon", "intel,lgm-emmc-phy";

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
> +
> +      emmc-phy: emmc-phy {

phy@a8

What else in in the chiptop block?

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
