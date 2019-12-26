Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A1CC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 18:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1D02080D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 18:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577386587;
	bh=qofhvnLir4yXKPBofip7iqoiOfFYbknkV6leA8/zahI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RuZEYkszmOxE0+eDr2yMrfXzLd8jFFzqEmi02nv76UZVd5LYULKmTwlOuF9coj2U0
	 A5d8kIktVilx+UvcTFhuNcVhaIQLvbZqnUid1o9tiqtHMQRjKoKI07wVUWGhsuQLCg
	 saLlXPU8Kkx8qQMb2YbANMiR0jX96vlgv32b9smk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfLZS40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 13:56:26 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43727 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfLZS4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 13:56:25 -0500
Received: by mail-io1-f67.google.com with SMTP id n21so22367750ioo.10;
        Thu, 26 Dec 2019 10:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ToXdYUQkeYDdHoqDRcSS3dTsiT4R5dAKA/kDsRrqbhI=;
        b=DyRW93k64GfJCQ9Ur9RvUBG67m/veso65llrj+T/jvCR/V9VVs2PTR2FFvnRVlO2eT
         YFiwsUMVdHlRgdtL8C+N/ULYR5OYpePn7geayw1it+4IVv4Y23QsWuw7Yuu4XBfNdw4d
         LGehXyd0hQKvySrAkvDPjkGOK9DmrAL4FuRWciQeTZpYlt4euSshNoo0VTEM5pQAj3C8
         LKGsPKEAVmTd1IatKoUX4mo2RlE9kZExJl2eGhhKqIBAuPMTDohdpd5+GEZDzgFxJze1
         bx+vcghylsptPyjbDoFPJUnTtz0v0IW2nhveaNIHDnjZ15rSlVpt+qzDiKibkZSsUf6D
         uhMA==
X-Gm-Message-State: APjAAAULacx2xtqV5v29fktumklCdZGrWr8CSh1+eeKoJz4KDhzzIKsh
        xJ5VQpZwsCJvTYaNxE7R8A==
X-Google-Smtp-Source: APXvYqxcD5zb2ctCYCJ+aegozBi9qaHP8u71SNg/N28coEluOAngGSi0T/I6lyj6OJ3DYPMg8kVJXg==
X-Received: by 2002:a5d:8cd6:: with SMTP id k22mr30642435iot.283.1577386584924;
        Thu, 26 Dec 2019 10:56:24 -0800 (PST)
Received: from localhost ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y9sm8849619ion.54.2019.12.26.10.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 10:56:24 -0800 (PST)
Date:   Thu, 26 Dec 2019 11:56:23 -0700
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH V2 3/6] dt-bindings: clk: sprd: add bindings for sc9863a
 clock controller
Message-ID: <20191226185623.GA4463@bogus>
References: <20191216121932.22967-1-zhang.lyra@gmail.com>
 <20191216121932.22967-4-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216121932.22967-4-zhang.lyra@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 08:19:29PM +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> add a new bindings to describe sc9863a clock compatible string.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../bindings/clock/sprd,sc9863a-clk.yaml      | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
> new file mode 100644
> index 000000000000..881f0a0287e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2019 Unisoc Inc.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/clock/sprd,sc9863a-clk.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: SC9863A Clock Control Unit Device Tree Bindings
> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +properties:
> +  "#clock-cells":
> +    const: 1
> +
> +  compatible :
> +    enum:
> +      - sprd,sc9863a-ap-clk
> +      - sprd,sc9863a-pmu-gate
> +      - sprd,sc9863a-pll
> +      - sprd,sc9863a-mpll
> +      - sprd,sc9863a-rpll
> +      - sprd,sc9863a-dpll
> +      - sprd,sc9863a-aon-clk
> +      - sprd,sc9863a-apahb-gate
> +      - sprd,sc9863a-aonapb-gate
> +      - sprd,sc9863a-mm-gate
> +      - sprd,sc9863a-mm-clk
> +      - sprd,sc9863a-vspahb-gate
> +      - sprd,sc9863a-apapb-gate

These will probably need to be split to separate schemas for the reasons 
below...

> +
> +  clocks:
> +    description: |
> +      The input parent clock(s) phandle for this clock, only list fixed
> +      clocks which are decleared in devicetree.

typo.

You need to define how many clocks.

> +
> +  clock-names:
> +    description: |
> +      Clock name strings used for driver to reference.

You need to list out the names.

> +
> +  reg:
> +    description: |
> +      Contain the registers base address and length. It must be configured
> +      only if no 'sprd,syscon' under the node.
> +
> +  sprd,syscon:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +    description: |
> +      The phandle to the syscon which is in the same address area with
> +      the clock, and so we can get regmap for the clocks from the
> +      syscon device.

It is preferred to make the clock node a child of the syscon and then 
you don't need this property.

> +
> +required:
> +  - compatible
> +  - '#clock-cells'
> +
> +examples:
> +  - |
> +    ap_clk: clock-controller@21500000 {
> +      compatible = "sprd,sc9863a-ap-clk";
> +      reg = <0 0x21500000 0 0x1000>;
> +      clocks = <&ext_32k>, <&ext_26m>;
> +      clock-names = "ext-32k", "ext-26m";
> +      #clock-cells = <1>;
> +    };
> +
> +  - |
> +    apahb_gate: apahb-gate {
> +      compatible = "sprd,sc9863a-apahb-gate";
> +      sprd,syscon = <&ap_ahb_regs>;
> +      #clock-cells = <1>;
> +    };
> +
> +...
> -- 
> 2.20.1
> 
