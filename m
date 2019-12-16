Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D574BC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA63207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521257;
	bh=3B/xY3EwSSqZ4KRIPY2Ks0+ZNevGFMiaNyRoFEJVXfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MyASXvtB3XUN+BLXkTH4J4b3w8D2eCcYO8H4XLN5jycMmnuyzBpjBh4ep7rnrYGv/
	 f/woRjUG7Y/zLJSmzGjNO+ZQcUy45XEk3/7f5sTVts+QwMXdFELTrtNd0YppUK2pJO
	 XS9i7i/wzWdizj78MoBpvd8xtUIuwkkGoe4Q9bDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbfLPSeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:34:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727330AbfLPSeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:34:13 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80EC2206EC;
        Mon, 16 Dec 2019 18:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576521253;
        bh=3B/xY3EwSSqZ4KRIPY2Ks0+ZNevGFMiaNyRoFEJVXfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lEUGZ0qHZo+CVeE5WsVgQhI7P2irPvdQQdvpMgxYvGTSp1kwZc3UY1nH28TmfQwXF
         VNmlZ6HSmQKZiCCqF6fT4KzAArKVHd/uGAZlo48DHA2Y7y+VFeZL0lJIo4ooiEmRzI
         n05Cczd68EE7ioFDM6k6mV3KJahfqsKGnqjwqA5s=
Date:   Mon, 16 Dec 2019 19:34:10 +0100
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
Message-ID: <20191216183410.akrmytbvaeg37wms@gilmour.lan>
References: <20191203134816.5319-1-jagan@amarulasolutions.com>
 <20191203134816.5319-2-jagan@amarulasolutions.com>
 <20191204133600.gnv6dnhk6upe7xod@gilmour.lan>
 <CAMty3ZDU57Hj3ZSBC6sSMFWN9-HQadA03hmXUNUVS1W0UQQ3DA@mail.gmail.com>
 <20191216112042.f4xvlgnbm4dk6wkq@gilmour.lan>
 <CAMty3ZBU-XaxR_vM5L2yVbhR5ftfbtDn3jP00qCxBF+owVyqDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mp32uvvqn4k2266y"
Content-Disposition: inline
In-Reply-To: <CAMty3ZBU-XaxR_vM5L2yVbhR5ftfbtDn3jP00qCxBF+owVyqDQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mp32uvvqn4k2266y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 16, 2019 at 10:29:08PM +0530, Jagan Teki wrote:
> On Mon, Dec 16, 2019 at 4:50 PM Maxime Ripard <mripard@kernel.org> wrote:
> >
> > On Mon, Dec 16, 2019 at 04:37:20PM +0530, Jagan Teki wrote:
> > > On Wed, Dec 4, 2019 at 7:06 PM Maxime Ripard <mripard@kernel.org> wrote:
> > > >
> > > > On Tue, Dec 03, 2019 at 07:18:10PM +0530, Jagan Teki wrote:
> > > > > The MIPI DSI controller in Allwinner A64 is similar to A33.
> > > > >
> > > > > But unlike A33, A64 doesn't have DSI_SCLK gating so it is valid
> > > > > to have separate compatible for A64 on the same driver.
> > > > >
> > > > > DSI_SCLK uses mod clock-names on dt-bindings, so the same
> > > > > is not required for A64.
> > > > >
> > > > > On that note
> > > > > - A64 require minimum of 1 clock like the bus clock
> > > > > - A33 require minimum of 2 clocks like both bus, mod clocks
> > > > >
> > > > > So, update dt-bindings so-that it can document both A33,
> > > > > A64 bindings requirements.
> > > > >
> > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > ---
> > > > > Changes for v12:
> > > > > - Use 'enum' instead of oneOf+const
> > > > >
> > > > >  .../display/allwinner,sun6i-a31-mipi-dsi.yaml | 20 +++++++++++++++++--
> > > > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> > > > > index dafc0980c4fa..b91446475f35 100644
> > > > > --- a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> > > > > +++ b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> > > > > @@ -15,7 +15,9 @@ properties:
> > > > >    "#size-cells": true
> > > > >
> > > > >    compatible:
> > > > > -    const: allwinner,sun6i-a31-mipi-dsi
> > > > > +    enum:
> > > > > +      - allwinner,sun6i-a31-mipi-dsi
> > > > > +      - allwinner,sun50i-a64-mipi-dsi
> > > > >
> > > > >    reg:
> > > > >      maxItems: 1
> > > > > @@ -24,6 +26,8 @@ properties:
> > > > >      maxItems: 1
> > > > >
> > > > >    clocks:
> > > > > +    minItems: 1
> > > > > +    maxItems: 2
> > > > >      items:
> > > > >        - description: Bus Clock
> > > > >        - description: Module Clock
> > > > > @@ -63,13 +67,25 @@ required:
> > > > >    - reg
> > > > >    - interrupts
> > > > >    - clocks
> > > > > -  - clock-names
> > > > >    - phys
> > > > >    - phy-names
> > > > >    - resets
> > > > >    - vcc-dsi-supply
> > > > >    - port
> > > > >
> > > > > +allOf:
> > > > > +  - if:
> > > > > +      properties:
> > > > > +         compatible:
> > > > > +           contains:
> > > > > +             const: allwinner,sun6i-a31-mipi-dsi
> > > > > +      then:
> > > > > +        properties:
> > > > > +          clocks:
> > > > > +            minItems: 2
> > > > > +        required:
> > > > > +          - clock-names
> > > > > +
> > > >
> > > > Your else condition should check that the number of clocks items is 1
> > > > on the A64
> > >
> > > But the minItems mentioned as 1 in clocks, which is unchanged number
> > > by default. doesn't it sufficient?
> >
> > In the main schema, it's said that the clocks property can have one or
> > two elements (to cover the A31 case that has one, and the A64 case
> > that has 2).
> >
> > This is fine.
> >
> > Later on, you enforce that the A64 has two elements, and this is fine
> > too.
>
> Actually A31 case has 2 and A64 case has 1.
>
> >
> > However, you never check that on the A31 you only have one clock, and
> > you could very well have two and no one would notice.
>
> I did check A31 case for 2 but not in A64. this is what you mean? so
> adding A64 check like below would fine?
>
> allOf:
>   - if:
>       properties:
>          compatible:
>            contains:
>              const: allwinner,sun6i-a31-mipi-dsi

You need a new line here

>       then:

This is the wrong level of indentation, it needs to be at the same level than if

>         properties:
>           clocks:
>             minItems: 2

Newline

>         required:
>           - clock-names

Newline

>   - if:
>       properties:
>          compatible:
>            contains:
>              const: allwinner,sun50i-a64-mipi-dsi
>       then:
>         properties:
>           clocks:
>             minItems: 1

(and same thing here).

But yeah, otherwise that's what I meant

Maxime

--mp32uvvqn4k2266y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXffOIgAKCRDj7w1vZxhR
xeCTAPwKh1UHnjrREIv+Ip48UOc+A2n/MnUOkDPNQizA9EusMgD/RunnzYlmm6CU
wsu3s/XV5XJ3nmdYaKKmSIlQ7HZmEAs=
=RcnJ
-----END PGP SIGNATURE-----

--mp32uvvqn4k2266y--
