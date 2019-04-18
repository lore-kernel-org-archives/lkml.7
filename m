Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_RHS_DOB,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE243C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C0E206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388898AbfDROvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:51:19 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:58699 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbfDROvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:51:19 -0400
X-Originating-IP: 90.88.160.238
Received: from localhost (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id DDF13FF80F;
        Thu, 18 Apr 2019 14:51:14 +0000 (UTC)
Date:   Thu, 18 Apr 2019 16:51:14 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v3 1/2] arm64: dts: allwinner: a64-amarula-relic: Add
 GT5663 CTP node
Message-ID: <20190418145114.jjt4ouulzkf2bwy2@flea>
References: <20190418134838.8806-1-jagan@amarulasolutions.com>
 <20190418140423.ch43fz2xuk5teqyl@flea>
 <CAMty3ZAGWOtkGRXLLZ14XgNYDX7-XtEbt+y53eqCJJKgfxwNuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2ek6fkqp3kfa4mc4"
Content-Disposition: inline
In-Reply-To: <CAMty3ZAGWOtkGRXLLZ14XgNYDX7-XtEbt+y53eqCJJKgfxwNuQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2ek6fkqp3kfa4mc4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 18, 2019 at 07:39:28PM +0530, Jagan Teki wrote:
> On Thu, Apr 18, 2019 at 7:34 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Thu, Apr 18, 2019 at 07:18:37PM +0530, Jagan Teki wrote:
> > > Add Goodix GT5663 capacitive touch controller node on
> > > Amarula A64-Relic board.
> > >
> > > The CTP connected to board with,
> > > - SDA, SCK from i2c1
> > > - GPIO-LD0 as AVDD28 supply
> > > - PH4 gpio as interrupt pin
> > > - PH8 gpio as reset pin
> > > - X axis is inverted
> > > - Y axis is inverted
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Changes for v3:
> > > - Use 2.8v for reg_ldo_io0
> > > Changes for v2:
> > > - drop i2c1, bias-pull-up
> > >
> > >  .../allwinner/sun50i-a64-amarula-relic.dts    | 25 +++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> > > index 3575db216016..bd31a4385bc1 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> > > @@ -49,6 +49,24 @@
> > >       bias-pull-up;
> > >  };
> > >
> > > +&i2c1 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&i2c1_pins>;
> >
> > You haven't fixed this, and you didn't either in the second patch.
>
> Sorry, I interpreted previous comment to keep this pinctrl.
>
> Since i2c1 node in sun50i-a64.dtsi doesn't have pinctrl attached to
> it, added here like i2c0 is it something wrong?

If that's the only muxing option, it should be in the DTSI. If it's
not the only muxing option, then the name is wrong.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--2ek6fkqp3kfa4mc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLiO4gAKCRDj7w1vZxhR
xS0mAQD4IVU/86937ZZmemkvkJR7fyQmmvDJLYb1Xkg+8dzUIwD/Tw2+o/9iJa5a
nIldDvlMqJmaZp2Lf5nbZN+vzwjiFA0=
=5EIs
-----END PGP SIGNATURE-----

--2ek6fkqp3kfa4mc4--
