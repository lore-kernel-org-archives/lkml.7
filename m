Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5ACC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BFC218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576702780;
	bh=uO0fvBA/TQ/FWcNNRJRphlk+aAyco9Mn2xTARpXNSsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0jBmpJDMbdMyFAD2LvAY7tuw9dN/5uPcLoHSVngNTQgT7hSMuICPVkvDtIZolapYM
	 7JsV4HONF0Q/ZLDICVV50SEaGgWCzZFVO7oMcm4MnWQPdHU0T1vuaCzxBvr5Nvt7GG
	 aRgZmOKtF4wHCZWSybhBDts0GWVcANrs0RX2J/Kc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLRU7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:59:39 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32862 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfLRU7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:59:37 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so4144982otp.0;
        Wed, 18 Dec 2019 12:59:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EOIM5ohVJuG8WUM6Uv/kRMmOO7OZqxuzI2GR/19vjz4=;
        b=Tzr3BonCLAZmhMEMXl6+MTt0ld+jUvMkvxs+1E7NqQdopHhuoFbLSSvzTus6zKqX5I
         OowaHY36+ojWkrFGQSyrdoZL0ow6niD/rm2h83trJDmYfr9/W3UCzGmvfne6rw/87zOT
         62/KPApAxomYu4sCRkrxx6og4GT6GhqxpCpkPI6/nUm1KGv4+7Ed5wdatkxA45p5Tzt1
         E85OTZ5a6kAHBKJYh9BsNuCADL2ccUEOoNdyKhR+dtF/Pa+S52mziZ/efEe5HK9vNnzD
         3Y6vMMSuZVpN7F47oXrkrsRnXUZTcge9V/djF9stVsORrLqfDWh6i6Yy5+B5kBWcVA58
         kw7A==
X-Gm-Message-State: APjAAAWRMTM77Z67eCDHVkx6waUbeAYjhHVo3FIOrVOltpnBG5JQWKCv
        gf6mOZzsbM/T2TjIGuGwWQ==
X-Google-Smtp-Source: APXvYqwdDGZoTBaty9DPSZdgYwCiElye4wqTApby9V2QTSges2/6Tjk/aNfYOvQ1w6UuiKIOxv/y9A==
X-Received: by 2002:a05:6830:2361:: with SMTP id r1mr4543788oth.88.1576702777020;
        Wed, 18 Dec 2019 12:59:37 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n22sm1230679otj.36.2019.12.18.12.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:59:36 -0800 (PST)
Date:   Wed, 18 Dec 2019 14:59:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Anil Varughese <aniljoy@cadence.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 13/14] dt-bindings: phy: Document WIZ (SERDES wrapper)
 bindings
Message-ID: <20191218205935.GA5162@bogus>
References: <20191216095712.13266-1-kishon@ti.com>
 <20191216095712.13266-14-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216095712.13266-14-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 03:27:11PM +0530, Kishon Vijay Abraham I wrote:
> Add DT binding documentation for WIZ (SERDES wrapper). WIZ is *NOT* a
> PHY but a wrapper used to configure some of the input signals to the
> SERDES. It is used with both Sierra(16G) and Torrent(10G) serdes.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> [jsarha@ti.com: Add separate compatible for Sierra(16G) and Torrent(10G)
>  SERDES]
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  .../bindings/phy/ti,phy-j721e-wiz.yaml        | 204 ++++++++++++++++++
>  1 file changed, 204 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> new file mode 100644
> index 000000000000..fd4204a960a9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> @@ -0,0 +1,204 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/ti,phy-j721e-wiz.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: TI J721E WIZ (SERDES Wrapper)
> +
> +maintainers:
> +  - Kishon Vijay Abraham I <kishon@ti.com>
> +
> +properties:
> +  compatible:
> +      enum:
> +          - ti,j721e-wiz-16g
> +          - ti,j721e-wiz-10g

Tab size is 2 spaces.

> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 3
> +    description: clock-specifier to represent input to the WIZ
> +
> +  clock-names:
> +    items:
> +      - const: fck
> +      - const: core_ref_clk
> +      - const: ext_ref_clk
> +
> +  num-lanes:
> +    minimum: 1
> +    maximum: 4
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  "#reset-cells":
> +    const: 1
> +
> +  ranges: true
> +
> +  assigned-clocks:
> +    maxItems: 2
> +
> +  assigned-clock-parents:
> +    maxItems: 2
> +
> +patternProperties:
> +   "^pll[0|1]-refclk$":

Indentation

> +    type: object
> +    description: |

Don't need the '|' unless there's formatting or multiple paragraphs.

> +      WIZ node should have subnodes for each of the PLLs present in
> +      the SERDES.
> +    properties:
> +      clocks:
> +        maxItems: 2
> +        description: Phandle to clock nodes representing the two inputs to PLL.
> +
> +      "#clock-cells":
> +        const: 0
> +
> +      assigned-clocks:
> +        maxItems: 1
> +
> +      assigned-clock-parents:
> +        maxItems: 1
> +
> +    required:
> +      - clocks
> +      - "#clock-cells"
> +      - assigned-clocks
> +      - assigned-clock-parents
> +
> +   "^cmn-refclk1?-dig-div$":

Indentation

> +    type: object
> +    description: |
> +      WIZ node should have subnodes for each of the PMA common refclock
> +      provided by the SERDES.
> +    properties:
> +      clocks:
> +        maxItems: 1
> +        description: Phandle to the clock node representing the input to the
> +          divider clock.
> +
> +      "#clock-cells":
> +        const: 0
> +
> +    required:
> +      - clocks
> +      - "#clock-cells"
> +
> +   "^refclk-dig$":

Indentation

> +    type: object
> +    description: |
> +      WIZ node should have subnode for refclk_dig to select the reference
> +      clock source for the reference clock used in the PHY and PMA digital
> +      logic.
> +    properties:
> +      clocks:
> +        maxItems: 4
> +        description: Phandle to four clock nodes representing the inputs to
> +          refclk_dig
> +
> +      "#clock-cells":
> +        const: 0
> +
> +      assigned-clocks:
> +        maxItems: 1
> +
> +      assigned-clock-parents:
> +        maxItems: 1
> +
> +    required:
> +      - clocks
> +      - "#clock-cells"
> +      - assigned-clocks
> +      - assigned-clock-parents
> +
> +   "^serdes@[0-9a-f]+$":

...

> +    type: object
> +    description: |
> +      WIZ node should have '1' subnode for the SERDES. It could be either
> +      Sierra SERDES or Torrent SERDES. Sierra SERDES should follow the
> +      bindings specified in
> +      Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
> +      Torrent SERDES should follow the bindings specified in
> +      Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
> +
> +required:
> +  - compatible
> +  - power-domains
> +  - clocks
> +  - clock-names
> +  - num-lanes
> +  - "#address-cells"
> +  - "#size-cells"
> +  - "#reset-cells"
> +  - ranges
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +
> +    wiz@5000000 {
> +           compatible = "ti,j721e-wiz-16g";
> +           #address-cells = <1>;
> +           #size-cells = <1>;
> +           power-domains = <&k3_pds 292 TI_SCI_PD_EXCLUSIVE>;
> +           clocks = <&k3_clks 292 5>, <&k3_clks 292 11>, <&dummy_cmn_refclk>;
> +           clock-names = "fck", "core_ref_clk", "ext_ref_clk";
> +           assigned-clocks = <&k3_clks 292 11>, <&k3_clks 292 0>;
> +           assigned-clock-parents = <&k3_clks 292 15>, <&k3_clks 292 4>;
> +           num-lanes = <2>;
> +           #reset-cells = <1>;
> +           ranges = <0x5000000 0x0 0x5000000 0x10000>;
> +
> +           pll0-refclk {
> +                  clocks = <&k3_clks 293 13>, <&dummy_cmn_refclk>;
> +                  #clock-cells = <0>;
> +                  assigned-clocks = <&wiz1_pll0_refclk>;
> +                  assigned-clock-parents = <&k3_clks 293 13>;
> +           };
> +
> +           pll1-refclk {
> +                  clocks = <&k3_clks 293 0>, <&dummy_cmn_refclk1>;
> +                  #clock-cells = <0>;
> +                  assigned-clocks = <&wiz1_pll1_refclk>;
> +                  assigned-clock-parents = <&k3_clks 293 0>;
> +           };
> +
> +           cmn-refclk-dig-div {
> +                  clocks = <&wiz1_refclk_dig>;
> +                  #clock-cells = <0>;
> +           };
> +
> +           cmn-refclk1-dig-div {
> +                  clocks = <&wiz1_pll1_refclk>;
> +                  #clock-cells = <0>;
> +           };
> +
> +           refclk-dig {
> +                  clocks = <&k3_clks 292 11>, <&k3_clks 292 0>, <&dummy_cmn_refclk>, <&dummy_cmn_refclk1>;
> +                  #clock-cells = <0>;
> +                  assigned-clocks = <&wiz0_refclk_dig>;
> +                  assigned-clock-parents = <&k3_clks 292 11>;
> +           };
> +
> +           serdes@5000000 {
> +                  compatible = "cdns,ti,sierra-phy-t0";
> +                  reg-names = "serdes";
> +                  reg = <0x5000000 0x10000>;
> +                  #address-cells = <1>;
> +                  #size-cells = <0>;
> +                  resets = <&serdes_wiz0 0>;
> +                  reset-names = "sierra_reset";
> +                  clocks = <&wiz0_cmn_refclk_dig_div>, <&wiz0_cmn_refclk1_dig_div>;
> +                  clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div";
> +           };
> +    };
> -- 
> 2.17.1
> 
