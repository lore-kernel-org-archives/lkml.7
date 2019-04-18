Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_RHS_DOB,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F065C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4853721479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388430AbfDRM5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:57:34 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:57899 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfDRM5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:57:33 -0400
X-Originating-IP: 90.88.160.238
Received: from localhost (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 7E10840003;
        Thu, 18 Apr 2019 12:57:29 +0000 (UTC)
Date:   Thu, 18 Apr 2019 14:57:29 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v2 1/2] arm64: dts: allwinner: a64-amarula-relic: Add
 GT5663 CTP node
Message-ID: <20190418125729.ihsdhtclcv7loftm@flea>
References: <20190418083543.11695-1-jagan@amarulasolutions.com>
 <20190418112357.qic227rdwordmzyh@flea>
 <CAMty3ZDwhB+63i_Cy90n0Y_Ra6XdTXbsX+z5q6swnj=FLH976g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fqcutytxrihg6l4f"
Content-Disposition: inline
In-Reply-To: <CAMty3ZDwhB+63i_Cy90n0Y_Ra6XdTXbsX+z5q6swnj=FLH976g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fqcutytxrihg6l4f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 18, 2019 at 06:00:27PM +0530, Jagan Teki wrote:
> On Thu, Apr 18, 2019 at 4:54 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Thu, Apr 18, 2019 at 02:05:42PM +0530, Jagan Teki wrote:
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
> > > Changes for v2:
> > > - drop i2c1, bias-pull-up
> > >
> > >  .../allwinner/sun50i-a64-amarula-relic.dts    | 25 +++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> > > index 3575db216016..3819ce396073 100644
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
> > That's the default already
>
> Yes, and i2c1 node in sun50i-a64.dtsi is not attaching pinctrl. So I
> attached here.

If that's the only muxing option, it should then.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--fqcutytxrihg6l4f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLh0OQAKCRDj7w1vZxhR
xXUFAP90TQofLCGvEH4XjS5PMg99z8RKJ6oVSIdJa2nJk5v/eQEA7surluc2rFnp
dimL+VhNIlxTgQvD4IUcX9UO80Ij8ww=
=pU/7
-----END PGP SIGNATURE-----

--fqcutytxrihg6l4f--
