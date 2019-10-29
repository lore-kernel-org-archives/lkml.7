Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77B5CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9481020679
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572376100;
	bh=sUs+OEpTAXMqmlLi5UAN/vwKlJhl5KNTIOdZHnRPRlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vA1k/y/PPKOyG48GHvotJqN5IJRcJLIh52ybhNKjTpKpnJ6SW1qIQJappzr5dMcU0
	 zNtvXBzO1jhLZOBlReKKTK525bM+z+mPwDakq6mpk04HnGtv4yqA9AqfAGXM80P4Ev
	 FdDzshJSGqCCZKUsudf2hWXMIxusKnA+bhWe65+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732296AbfJ2TIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 15:08:19 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34710 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbfJ2TIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 15:08:19 -0400
Received: by mail-ot1-f68.google.com with SMTP id m19so10787239otp.1;
        Tue, 29 Oct 2019 12:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8pA+n21L8La8ITpfrFB0GyWgtr689YFUdyFAidrybGE=;
        b=VT3PwsA++4v225xZwJfOdX5Ydz5rthjjCFkzuGmDc5+SnNco/3/p6j7R1qdN3Yx30n
         fZNJAl6bSXoOkV5jjhF4ilnGQhcRKRNqegn/RpGZc6xNn8pPMatum2j7Uq5WH2hWPegC
         rNQ5h1Idg7y1pHJfVjfNBq7eyD4B5/Ixuh4pVkdsrY+tuoiaCZ6mwzhHJZaTjMLKF/Xs
         KNQb6N4Wg+QqqpYq8G2CBK920mTsj2/2DA69lLwIZJATObQmqRHwx59XUgjp+O4Ai4yX
         UsN/VPgnqiMD9LR0/OP8HM4RbQLHeiM/0wp0abcE434+Ro8d6aQaZkV+jGPCfQ61vBO/
         p5ag==
X-Gm-Message-State: APjAAAX6kpDRg3nqYGW6+v2NM+tprd58jkVZvOYY4VXhMfZ3TH9JqpwM
        QzNme765pmb/SAt2f36inlvyqtE=
X-Google-Smtp-Source: APXvYqxxTnPOwibOvH3qJUKAPtA8dILf5/7X7qHntEuTo8cH50apeG2dzvwvzc2tbmt6rJgcVlkUrw==
X-Received: by 2002:a9d:6c96:: with SMTP id c22mr20012395otr.170.1572376097923;
        Tue, 29 Oct 2019 12:08:17 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p7sm3653220oth.50.2019.10.29.12.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 12:08:17 -0700 (PDT)
Date:   Tue, 29 Oct 2019 14:08:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>,
        Anil Varughese <aniljoy@cadence.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 13/14] dt-bindings: phy: Document WIZ (SERDES wrapper)
 bindings
Message-ID: <20191029190816.GA27884@bogus>
References: <20191023125735.4713-1-kishon@ti.com>
 <20191023125735.4713-14-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023125735.4713-14-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 06:27:34PM +0530, Kishon Vijay Abraham I wrote:
> Add DT binding documentation for WIZ (SERDES wrapper). WIZ is *NOT* a
> PHY but a wrapper used to configure some of the input signals to the
> SERDES. It is used with both Sierra(16G) and Torrent(10G) serdes.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> [jsarha@ti.com: Add separate compatible for Sierra(16G) and Torrent(10G)
>  SERDES]
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  .../bindings/phy/ti,phy-j721e-wiz.yaml        | 159 ++++++++++++++++++
>  1 file changed, 159 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> new file mode 100644
> index 000000000000..8a1eccee6c1d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> @@ -0,0 +1,159 @@
> +# SPDX-License-Identifier: (GPL-2.0)

(GPL-2.0-only OR BSD-2-Clause) for new bindings please.

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
> +    oneOf:
> +      - items:
> +          - enum:
> +              - ti,j721e-wiz-16g
> +              - ti,j721e-wiz-10g

You can drop oneOf and items.

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
> +    maxItems: 1
> +    minimum: 1
> +    maximum: 4

You've mixed array and scalar schema keywords. Drop maxItems.

Update dtschema and run 'make dt_binding_check'. We should catch that 
now.

> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2
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
> +  "^pll[0|1]_refclk$":
> +    type: object
> +    description: |
> +      WIZ node should have subnodes for each of the PLLs present in
> +      the SERDES.
> +
> +  "^cmn_refclk1?$":
> +    type: object
> +    description: |
> +      WIZ node should have subnodes for each of the PMA common refclock
> +      provided by the SERDES.
> +
> +  "^refclk_dig$":
> +    type: object
> +    description: |
> +      WIZ node should have subnode for refclk_dig to select the reference
> +      clock source for the reference clock used in the PHY and PMA digital
> +      logic.
> +
> +  "^serdes@[0-9a-f]+$":
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
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +
> +    wiz@5000000 {
> +           compatible = "ti,j721e-wiz-16g";
> +           #address-cells = <2>;
> +           #size-cells = <2>;

Really need 64-bits of address space for the child nodes?

> +           power-domains = <&k3_pds 292 TI_SCI_PD_EXCLUSIVE>;
> +           clocks = <&k3_clks 292 5>, <&k3_clks 292 11>, <&dummy_cmn_refclk>;
> +           clock-names = "fck", "core_ref_clk", "ext_ref_clk";
> +           assigned-clocks = <&k3_clks 292 11>, <&k3_clks 292 0>;
> +           assigned-clock-parents = <&k3_clks 292 15>, <&k3_clks 292 4>;
> +           num-lanes = <2>;
> +           #reset-cells = <1>;

Unless you have additional registers, I'm not a fan of wrapper nodes.

> +
> +           pll0_refclk {
> +                  clocks = <&k3_clks 293 13>, <&dummy_cmn_refclk>;
> +                  clock-output-names = "wiz1_pll0_refclk";
> +                  #clock-cells = <0>;
> +                  assigned-clocks = <&wiz1_pll0_refclk>;
> +                  assigned-clock-parents = <&k3_clks 293 13>;
> +           };
> +
> +           pll1_refclk {
> +                  clocks = <&k3_clks 293 0>, <&dummy_cmn_refclk1>;
> +                  clock-output-names = "wiz1_pll1_refclk";
> +                  #clock-cells = <0>;
> +                  assigned-clocks = <&wiz1_pll1_refclk>;
> +                  assigned-clock-parents = <&k3_clks 293 0>;
> +           };
> +
> +           cmn_refclk {
> +                  clocks = <&wiz1_refclk_dig>;
> +                  clock-output-names = "wiz1_cmn_refclk";
> +                  #clock-cells = <0>;
> +           };
> +
> +           cmn_refclk1 {
> +                  clocks = <&wiz1_pll1_refclk>;
> +                  clock-output-names = "wiz1_cmn_refclk1";
> +                  #clock-cells = <0>;
> +           };
> +
> +           refclk_dig {
> +                  clocks = <&k3_clks 292 11>, <&k3_clks 292 0>, <&dummy_cmn_refclk>, <&dummy_cmn_refclk1>;
> +                  clock-output-names = "wiz0_refclk_dig";
> +                  #clock-cells = <0>;
> +                  assigned-clocks = <&wiz0_refclk_dig>;
> +                  assigned-clock-parents = <&k3_clks 292 11>;
> +           };

How are all these clocks programmed?

> +
> +           serdes@5000000 {
> +                  compatible = "cdns,ti,sierra-phy-t0";
> +                  reg-names = "serdes";
> +                  reg = <0x00 0x5000000 0x00 0x10000>;
> +                  #address-cells = <1>;
> +                  #size-cells = <0>;
> +                  resets = <&serdes_wiz0 0>;
> +                  reset-names = "sierra_reset";
> +                  clocks = <&wiz0_cmn_refclk>, <&wiz0_cmn_refclk1>;
> +                  clock-names = "cmn_refclk", "cmn_refclk1";
> +           };
> +    };
> -- 
> 2.17.1
> 
