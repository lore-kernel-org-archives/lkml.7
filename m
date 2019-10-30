Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA824CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77AAE204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572463586;
	bh=rgkCxbTtubSpGlNM5+6ni7VjRGclEinCGXgFs9KPxAI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=abEtQg8SON6VyPDINt0BAOEfvpveEyWQD7uuvxziIIm4BiuZ0TbLyYS0VG6rCL0jr
	 Dtp+modGEpQMAY66R0ijWT4WtLlh8wm07Y4TcIYAA2pXU6jpIBHeQdjbJvQi7ijDCz
	 9Ss5Yvqk6ISSO5cdJBhKQu+atY25ZU43Yuzx+6m4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfJ3T0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 15:26:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfJ3T0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 15:26:24 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EE092080F;
        Wed, 30 Oct 2019 19:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572463583;
        bh=rgkCxbTtubSpGlNM5+6ni7VjRGclEinCGXgFs9KPxAI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jam9KHrkTWJh5RsFHqROt7WvSpfdJqwG2Vi6LAHl4uz2fRiym0UC28qJI/g96x2Fv
         nYHBp0enwHTDx+y19TG0F22bvZQtVVDpBkAX46DpCYpK8EeP2fbc0PturITpCdnLcD
         YwBFVk5kcF95jfB02O0HDfg01YYJyW4scYLpVgIs=
Received: by mail-qt1-f176.google.com with SMTP id c26so4825357qtj.10;
        Wed, 30 Oct 2019 12:26:23 -0700 (PDT)
X-Gm-Message-State: APjAAAVRn+aIRLUprUh9IEqix4RPmBHCz6h66Pw1OS0NlJn+O7X1Vk5i
        9rN+r6zphIEDYVlFp+MJFcvphXjdr9Bgnh++AA==
X-Google-Smtp-Source: APXvYqyJQUSiynwU12MKLzAaMllzK+Z3lTZyL909tt2/9YyljRwGSuqUhPmHL2rXAGaLkE9tuswbeeBeIJaVWZMdyCw=
X-Received: by 2002:ac8:48c5:: with SMTP id l5mr1862835qtr.110.1572463582140;
 Wed, 30 Oct 2019 12:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191023125735.4713-1-kishon@ti.com> <20191023125735.4713-14-kishon@ti.com>
 <20191029190816.GA27884@bogus> <b3e8f037-3af3-2720-037c-73d6fc2a4c2b@ti.com>
In-Reply-To: <b3e8f037-3af3-2720-037c-73d6fc2a4c2b@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 30 Oct 2019 14:26:10 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL4dnx0o0cRQmiHU7qVcB5x5DO707JNpVrcmBs6VgsxuQ@mail.gmail.com>
Message-ID: <CAL_JsqL4dnx0o0cRQmiHU7qVcB5x5DO707JNpVrcmBs6VgsxuQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] dt-bindings: phy: Document WIZ (SERDES wrapper) bindings
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>,
        Anil Varughese <aniljoy@cadence.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 12:46 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi,
>
> On 30/10/19 12:38 AM, Rob Herring wrote:
> > On Wed, Oct 23, 2019 at 06:27:34PM +0530, Kishon Vijay Abraham I wrote:
> >> Add DT binding documentation for WIZ (SERDES wrapper). WIZ is *NOT* a
> >> PHY but a wrapper used to configure some of the input signals to the
> >> SERDES. It is used with both Sierra(16G) and Torrent(10G) serdes.
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> [jsarha@ti.com: Add separate compatible for Sierra(16G) and Torrent(10G)
> >>  SERDES]
> >> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> >> ---
> >>  .../bindings/phy/ti,phy-j721e-wiz.yaml        | 159 ++++++++++++++++++
> >>  1 file changed, 159 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> >> new file mode 100644
> >> index 000000000000..8a1eccee6c1d
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> >> @@ -0,0 +1,159 @@
> >> +# SPDX-License-Identifier: (GPL-2.0)
> >
> > (GPL-2.0-only OR BSD-2-Clause) for new bindings please.
> >
> >> +# Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> >> +%YAML 1.2
> >> +---
> >> +$id: "http://devicetree.org/schemas/phy/ti,phy-j721e-wiz.yaml#"
> >> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> >> +
> >> +title: TI J721E WIZ (SERDES Wrapper)
> >> +
> >> +maintainers:
> >> +  - Kishon Vijay Abraham I <kishon@ti.com>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    oneOf:
> >> +      - items:
> >> +          - enum:
> >> +              - ti,j721e-wiz-16g
> >> +              - ti,j721e-wiz-10g
> >
> > You can drop oneOf and items.
> >
> >> +
> >> +  power-domains:
> >> +    maxItems: 1
> >> +
> >> +  clocks:
> >> +    maxItems: 3
> >> +    description: clock-specifier to represent input to the WIZ
> >> +
> >> +  clock-names:
> >> +    items:
> >> +      - const: fck
> >> +      - const: core_ref_clk
> >> +      - const: ext_ref_clk
> >> +
> >> +  num-lanes:
> >> +    maxItems: 1
> >> +    minimum: 1
> >> +    maximum: 4
> >
> > You've mixed array and scalar schema keywords. Drop maxItems.
> >
> > Update dtschema and run 'make dt_binding_check'. We should catch that
> > now.
>
> Sure.
> >
> >> +
> >> +  "#address-cells":
> >> +    const: 2
> >> +
> >> +  "#size-cells":
> >> +    const: 2
> >> +
> >> +  "#reset-cells":
> >> +    const: 1
> >> +
> >> +  ranges: true
> >> +
> >> +  assigned-clocks:
> >> +    maxItems: 2
> >> +
> >> +  assigned-clock-parents:
> >> +    maxItems: 2
> >> +
> >> +patternProperties:
> >> +  "^pll[0|1]_refclk$":
> >> +    type: object
> >> +    description: |
> >> +      WIZ node should have subnodes for each of the PLLs present in
> >> +      the SERDES.
> >> +
> >> +  "^cmn_refclk1?$":
> >> +    type: object
> >> +    description: |
> >> +      WIZ node should have subnodes for each of the PMA common refclock
> >> +      provided by the SERDES.
> >> +
> >> +  "^refclk_dig$":
> >> +    type: object
> >> +    description: |
> >> +      WIZ node should have subnode for refclk_dig to select the reference
> >> +      clock source for the reference clock used in the PHY and PMA digital
> >> +      logic.
> >> +
> >> +  "^serdes@[0-9a-f]+$":
> >> +    type: object
> >> +    description: |
> >> +      WIZ node should have '1' subnode for the SERDES. It could be either
> >> +      Sierra SERDES or Torrent SERDES. Sierra SERDES should follow the
> >> +      bindings specified in
> >> +      Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
> >> +      Torrent SERDES should follow the bindings specified in
> >> +      Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
> >> +
> >> +required:
> >> +  - compatible
> >> +  - power-domains
> >> +  - clocks
> >> +  - clock-names
> >> +  - num-lanes
> >> +  - "#address-cells"
> >> +  - "#size-cells"
> >> +  - "#reset-cells"
> >> +
> >> +examples:
> >> +  - |
> >> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> >> +
> >> +    wiz@5000000 {
> >> +           compatible = "ti,j721e-wiz-16g";
> >> +           #address-cells = <2>;
> >> +           #size-cells = <2>;
> >
> > Really need 64-bits of address space for the child nodes?
>
> hmm, the register space for the child nodes are in the 32-bit address space
> region. I'll fix this.
> >
> >> +           power-domains = <&k3_pds 292 TI_SCI_PD_EXCLUSIVE>;
> >> +           clocks = <&k3_clks 292 5>, <&k3_clks 292 11>, <&dummy_cmn_refclk>;
> >> +           clock-names = "fck", "core_ref_clk", "ext_ref_clk";
> >> +           assigned-clocks = <&k3_clks 292 11>, <&k3_clks 292 0>;
> >> +           assigned-clock-parents = <&k3_clks 292 15>, <&k3_clks 292 4>;
> >> +           num-lanes = <2>;
> >> +           #reset-cells = <1>;
> >
> > Unless you have additional registers, I'm not a fan of wrapper nodes.
>
> The wrapper node has TI specific registers while the child node has Cadence
> Sierra specific registers. It also has clock nodes which are input to the
> Sierra IP.

Yeah? Where's 'reg'?

> >
> >> +
> >> +           pll0_refclk {
> >> +                  clocks = <&k3_clks 293 13>, <&dummy_cmn_refclk>;
> >> +                  clock-output-names = "wiz1_pll0_refclk";
> >> +                  #clock-cells = <0>;
> >> +                  assigned-clocks = <&wiz1_pll0_refclk>;
> >> +                  assigned-clock-parents = <&k3_clks 293 13>;
> >> +           };
> >> +
> >> +           pll1_refclk {
> >> +                  clocks = <&k3_clks 293 0>, <&dummy_cmn_refclk1>;
> >> +                  clock-output-names = "wiz1_pll1_refclk";
> >> +                  #clock-cells = <0>;
> >> +                  assigned-clocks = <&wiz1_pll1_refclk>;
> >> +                  assigned-clock-parents = <&k3_clks 293 0>;
> >> +           };
> >> +
> >> +           cmn_refclk {
> >> +                  clocks = <&wiz1_refclk_dig>;
> >> +                  clock-output-names = "wiz1_cmn_refclk";
> >> +                  #clock-cells = <0>;
> >> +           };
> >> +
> >> +           cmn_refclk1 {
> >> +                  clocks = <&wiz1_pll1_refclk>;
> >> +                  clock-output-names = "wiz1_cmn_refclk1";
> >> +                  #clock-cells = <0>;
> >> +           };
> >> +
> >> +           refclk_dig {
> >> +                  clocks = <&k3_clks 292 11>, <&k3_clks 292 0>, <&dummy_cmn_refclk>, <&dummy_cmn_refclk1>;
> >> +                  clock-output-names = "wiz0_refclk_dig";
> >> +                  #clock-cells = <0>;
> >> +                  assigned-clocks = <&wiz0_refclk_dig>;
> >> +                  assigned-clock-parents = <&k3_clks 292 11>;
> >> +           };
> >
> > How are all these clocks programmed?
>
> All these are programmed in the WIZ driver which is implemented in 14/14 of
> this series.

Not what I meant... How does one access the h/w because there's
nothing defined here to do so.

Rob
