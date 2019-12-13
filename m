Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371DDC00454
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B412465E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576270879;
	bh=O91bS9L0PAjFU/M21nzt7sD7JV7VWCq7UrLe6/jWLCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1PH25zx4tTEabQG272xZDk6VoH8KDOnJ8Yi8ld4lFJaQhcibmzpwqnwfhAMYc9AVh
	 EgcPSUk2cWumxlKailU9UgouzHLcKyH0EzSAcG7TgmH6sGY+D5as7kEZWOnWoC3/Zm
	 fR+CzeTmpVYdFHFLeR4oWJacNLF70U4b6Eah+U3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfLMVBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:01:19 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45594 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfLMVBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 16:01:18 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so597530otp.12;
        Fri, 13 Dec 2019 13:01:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iXvK/DgUAVIQ/iP0u6siJXqf038De/0OUOXTVFOApf0=;
        b=KeMTZZYrQHeRmdI8xFFPqIGzd2XJEyD1kNpg2w3RRPfWNIyAKv6+cYEPslGMmXaosE
         rTl3osaY7y7arTwSGI6Xf8Rby1y35+dGTiSvo0nNh95De2ui3kjeAHO8RQIqBesZ1jJl
         g7weCcMf6AAtLFh+VT3FALY+IoqOkuIvFR83ZRyN+EwDg76PUFfNFy2arKmKKOpWY8tb
         SOtfaNZf4gTXgJvaDCDoygBaQwptJuB+6xTeCaQaf7NmcV5mCgD1B7hyN3KgblE0lZg+
         IIU14YOOZpi1gcdWh4IVjC8+M1wxlx2JLdf9LXMB8LeHs506Hwzu+kCKaSAGYq7ufLjG
         53fA==
X-Gm-Message-State: APjAAAWRsrmVOvcw/K/VfOIafSDYpPCfvRqyY59/HMknPhkUwfHRzvVa
        rN2Jh2GxpRKB5twEZ2G+vw==
X-Google-Smtp-Source: APXvYqzDrki2Ich1+AgVwEniyn9x2SLFG1dDLqDCkZ0aNNzbXybs6tahFd54zRXO08pSf6Z5Ui/OCA==
X-Received: by 2002:a9d:708f:: with SMTP id l15mr17597671otj.286.1576270877204;
        Fri, 13 Dec 2019 13:01:17 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f1sm3760838otq.4.2019.12.13.13.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 13:01:16 -0800 (PST)
Date:   Fri, 13 Dec 2019 15:01:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Anil Varughese <aniljoy@cadence.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 13/14] dt-bindings: phy: Document WIZ (SERDES wrapper)
 bindings
Message-ID: <20191213210116.GA8975@bogus>
References: <20191128104648.21894-1-kishon@ti.com>
 <20191128104648.21894-14-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128104648.21894-14-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 04:16:47PM +0530, Kishon Vijay Abraham I wrote:
> Add DT binding documentation for WIZ (SERDES wrapper). WIZ is *NOT* a
> PHY but a wrapper used to configure some of the input signals to the
> SERDES. It is used with both Sierra(16G) and Torrent(10G) serdes.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> [jsarha@ti.com: Add separate compatible for Sierra(16G) and Torrent(10G)
>  SERDES]
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  .../bindings/phy/ti,phy-j721e-wiz.yaml        | 158 ++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> new file mode 100644
> index 000000000000..5cd6f907f6af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> @@ -0,0 +1,158 @@
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
> +  "^pll[0|1]_refclk$":

Use '-' rather than '_' in node names.

> +    type: object
> +    description: |
> +      WIZ node should have subnodes for each of the PLLs present in
> +      the SERDES.

No properties in each of these nodes? They need to be defined.

> +
> +  "^cmn_refclk1?_dig_div$":
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
> +           pll0_refclk {
> +                  clocks = <&k3_clks 293 13>, <&dummy_cmn_refclk>;
> +                  clock-output-names = "wiz1_pll0_refclk";

Kind of pointless with only 1 output.

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
> +           cmn_refclk_dig_div {
> +                  clocks = <&wiz1_refclk_dig>;
> +                  clock-output-names = "wiz1_cmn_refclk_dig_div";
> +                  #clock-cells = <0>;
> +           };
> +
> +           cmn_refclk1_dig_div {
> +                  clocks = <&wiz1_pll1_refclk>;
> +                  clock-output-names = "wiz1_cmn_refclk1_dig_div";
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
