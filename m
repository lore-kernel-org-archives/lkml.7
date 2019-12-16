Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD0DC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927AA207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576495250;
	bh=Mpc6KplCorpdPPjd389Z2K1v+WF0Ie2Wk28APYU3EIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eOQQ/9ERQWxZ0YcPpeJh6Lt9rHrfj7ihHkiJLrMwtbeeo5rauThPk1+s5iWWUrNJE
	 VadheNpLuazO351dsHpXv5JgSSS/2s5crvbPHwDO9x/F2v/5r15exCNBvp6AG+Xo++
	 GezgmzLhhBIW/12oNVUkD3gcOMVfcnbZejKNubbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfLPLUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 06:20:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:40488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727086AbfLPLUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:20:47 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77993206CB;
        Mon, 16 Dec 2019 11:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576495247;
        bh=Mpc6KplCorpdPPjd389Z2K1v+WF0Ie2Wk28APYU3EIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UGMeVmTnoijpaXf0URFSEnCAv2QMv1w4vRp1RBYhvOjr4CWEskkLNUgDf2fd+/91T
         u9eHV45b6wdXZsbDBv6MufHf+l5akQjQKX51yICGrGeVg8jgDQZilSbp6BAom+IqcC
         Y7wsZm3BFQcwZ8XuLl9OoumuAFnRAITIuNShN1oI=
Date:   Mon, 16 Dec 2019 12:20:42 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Subject: Re: [PATCH v12 1/7] dt-bindings: sun6i-dsi: Document A64 MIPI-DSI
 controller
Message-ID: <20191216112042.f4xvlgnbm4dk6wkq@gilmour.lan>
References: <20191203134816.5319-1-jagan@amarulasolutions.com>
 <20191203134816.5319-2-jagan@amarulasolutions.com>
 <20191204133600.gnv6dnhk6upe7xod@gilmour.lan>
 <CAMty3ZDU57Hj3ZSBC6sSMFWN9-HQadA03hmXUNUVS1W0UQQ3DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j7bmzwiznwnaw3ax"
Content-Disposition: inline
In-Reply-To: <CAMty3ZDU57Hj3ZSBC6sSMFWN9-HQadA03hmXUNUVS1W0UQQ3DA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j7bmzwiznwnaw3ax
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 16, 2019 at 04:37:20PM +0530, Jagan Teki wrote:
> On Wed, Dec 4, 2019 at 7:06 PM Maxime Ripard <mripard@kernel.org> wrote:
> >
> > On Tue, Dec 03, 2019 at 07:18:10PM +0530, Jagan Teki wrote:
> > > The MIPI DSI controller in Allwinner A64 is similar to A33.
> > >
> > > But unlike A33, A64 doesn't have DSI_SCLK gating so it is valid
> > > to have separate compatible for A64 on the same driver.
> > >
> > > DSI_SCLK uses mod clock-names on dt-bindings, so the same
> > > is not required for A64.
> > >
> > > On that note
> > > - A64 require minimum of 1 clock like the bus clock
> > > - A33 require minimum of 2 clocks like both bus, mod clocks
> > >
> > > So, update dt-bindings so-that it can document both A33,
> > > A64 bindings requirements.
> > >
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Changes for v12:
> > > - Use 'enum' instead of oneOf+const
> > >
> > >  .../display/allwinner,sun6i-a31-mipi-dsi.yaml | 20 +++++++++++++++++--
> > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> > > index dafc0980c4fa..b91446475f35 100644
> > > --- a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> > > +++ b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> > > @@ -15,7 +15,9 @@ properties:
> > >    "#size-cells": true
> > >
> > >    compatible:
> > > -    const: allwinner,sun6i-a31-mipi-dsi
> > > +    enum:
> > > +      - allwinner,sun6i-a31-mipi-dsi
> > > +      - allwinner,sun50i-a64-mipi-dsi
> > >
> > >    reg:
> > >      maxItems: 1
> > > @@ -24,6 +26,8 @@ properties:
> > >      maxItems: 1
> > >
> > >    clocks:
> > > +    minItems: 1
> > > +    maxItems: 2
> > >      items:
> > >        - description: Bus Clock
> > >        - description: Module Clock
> > > @@ -63,13 +67,25 @@ required:
> > >    - reg
> > >    - interrupts
> > >    - clocks
> > > -  - clock-names
> > >    - phys
> > >    - phy-names
> > >    - resets
> > >    - vcc-dsi-supply
> > >    - port
> > >
> > > +allOf:
> > > +  - if:
> > > +      properties:
> > > +         compatible:
> > > +           contains:
> > > +             const: allwinner,sun6i-a31-mipi-dsi
> > > +      then:
> > > +        properties:
> > > +          clocks:
> > > +            minItems: 2
> > > +        required:
> > > +          - clock-names
> > > +
> >
> > Your else condition should check that the number of clocks items is 1
> > on the A64
>
> But the minItems mentioned as 1 in clocks, which is unchanged number
> by default. doesn't it sufficient?

In the main schema, it's said that the clocks property can have one or
two elements (to cover the A31 case that has one, and the A64 case
that has 2).

This is fine.

Later on, you enforce that the A64 has two elements, and this is fine
too.

However, you never check that on the A31 you only have one clock, and
you could very well have two and no one would notice.

Maxime

--j7bmzwiznwnaw3ax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXfdoigAKCRDj7w1vZxhR
xeS/AP9UV7Xns9t5VOhLEF+tbuQ+jcstzHVAz1d0xXveWqK7uAEAqK1mC/scTm09
qaYD48OkBiF38cUHEBrXBJdLGSE9gQI=
=7xiu
-----END PGP SIGNATURE-----

--j7bmzwiznwnaw3ax--
