Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86165C80D30
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DBD24773
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576269654;
	bh=fg7QJPewVvSWQeQMYgoaqZSHSqt6u5zynRDl8PJ15Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mBXmyfJCgI6CbJCyzTg5hwKILLeIBOW9VqnObxJcl1bPuOi3S7UkC4F32gUeg5fLe
	 4iz1/nyr/Xu97Bj/R83pRVwf8q2v2T/pEHBcaZREutqTQPTmNwC34Y84cq6d2dcsLM
	 omPN8/EKCCAqrMuwrsIS0p59u5Bk1RYMzSs3ZKIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbfLMTIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 14:08:22 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38344 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbfLMTIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 14:08:22 -0500
Received: by mail-ot1-f68.google.com with SMTP id h20so318307otn.5;
        Fri, 13 Dec 2019 11:08:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KJzuDD0sBx2lePcpDmxYWTvEn9GcdeWOo5ZChsyIqJU=;
        b=JtbD4vZ107RusKFy+4BqIvwfX8/p9Vc2/Jj0ov29KfLElCM73EbcxI7d32PzZ2BISn
         3w51Oy53hlEu4pO3KI3FHcvDNIGqYSAWTZjK5nZBI0X6clT925ePM8sZarVcg0NgHY7a
         47o0YDIlqh3RIKplmVOrpEUyfmunqAk/puC3kDfqzEtafH5dNSrrpnEFbn6ep0JgJUyE
         1w5pdC1n4TfrcAciL1bAIPOSmJPmiYoFY5+2iebCGbsLGt1x9Djr/360/qCNagA3krkN
         cRtAku6qBZX3y1/58iOhRMr7M8NRsWfPGHpZav8TAZWcY2f8gLnppuSoM1zB4C1Lf1OX
         2FMw==
X-Gm-Message-State: APjAAAUA/UOuXMWlMcMm50x7k26+dQlbHknqN2o+LcDDwix0VNVhWzG9
        D9R5R9wdy+eNI0KYDEFrlg==
X-Google-Smtp-Source: APXvYqynI97aUq/1r02pZB3brO8e3XvOeNj9z63BQVINfUG5Q+t0EkTjDb9P5FatkhlZ1zLJW8if2g==
X-Received: by 2002:a05:6830:2116:: with SMTP id i22mr17156164otc.0.1576264101295;
        Fri, 13 Dec 2019 11:08:21 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f1sm3653214otq.4.2019.12.13.11.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 11:08:19 -0800 (PST)
Date:   Fri, 13 Dec 2019 13:08:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
Subject: Re: [PATCH v8 1/2] dt-bindings: phy: intel-emmc-phy: Add YAML schema
 for LGM eMMC PHY
Message-ID: <20191213190819.GA19560@bogus>
References: <20191212015320.20969-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191212015320.20969-2-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212015320.20969-2-vadivel.muruganx.ramuthevar@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 09:53:19AM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add a YAML schema to use the host controller driver with the
> eMMC PHY on Intel's Lightning Mountain SoC.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  .../bindings/phy/intel,lgm-emmc-phy.yaml           | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
> new file mode 100644
> index 000000000000..aed11258d96d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
> @@ -0,0 +1,62 @@
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
> +    contains:

You need to drop 'contains'. That implies other strings can also be 
present.

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
> +  clock-names:
> +    maxItems: 1

Drop maxItems. It should be:

const: emmcclk

Or just drop clock-names because you don't really need *-names when 
there is only 1.

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
