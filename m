Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954A9C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73EF321773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfEUIKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:10:11 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:35789 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfEUIKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:10:11 -0400
X-Originating-IP: 90.88.22.185
Received: from localhost (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 4598620025;
        Tue, 21 May 2019 08:10:02 +0000 (UTC)
Date:   Tue, 21 May 2019 10:10:01 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH] arm64: dts: allwinner: a64-oceanic-5205-5inmfd: Enable
 CAN
Message-ID: <20190521081001.zjq3gnlvyuyexz6m@flea>
References: <20190418141658.10868-1-jagan@amarulasolutions.com>
 <20190418145641.q23tupopz2czjzc5@flea>
 <CAOf5uwn8CtRs8cx0KC-bxNoRP4TiDrHi8F83QfjsZhueLDYFJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xwglcbrmgqk6xsau"
Content-Disposition: inline
In-Reply-To: <CAOf5uwn8CtRs8cx0KC-bxNoRP4TiDrHi8F83QfjsZhueLDYFJg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xwglcbrmgqk6xsau
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 21, 2019 at 08:47:02AM +0200, Michael Nazzareno Trimarchi wrote:
> > > +     };
> > > +
> > >  };
> > >
> > >  &ehci0 {
> > > @@ -77,6 +95,31 @@
> > >       status = "okay";
> > >  };
> > >
> > > +&pio {
> > > +     can_pins: can-pins {
> > > +             pins = "PD6",                   /* RX_BUF1_CAN0 */
> > > +                    "PD7";                   /* RX_BUF0_CAN0 */
> > > +             function = "gpio_in";
> > > +     };
> > > +};
> >
> > That isn't needed. What are they used for, you're not tying them to
> > anything?
>
> Mux of their function is correct. They are connected in the schematics
> but not used right now.

Then describe the whole thing or don't?

And that's kind of missing my point. If that pin group isn't related
to any device, the pin muxing will not be changed. So that group, in
itself, has strictly no effect.

Moreover, you don't need a pin group in the first place to mux pins in
GPIOs, the GPIO API will make sure that is the case when you request
it.

> I can garantee that kernel wlll always configurred in the right way
> and if I want I can export in userspace
> for debug purpose

Yes, because the API does it, not your change

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--xwglcbrmgqk6xsau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOOyWQAKCRDj7w1vZxhR
xVrXAP461PPKE8+N+fcEtV7h6ivucRpYH0qSu/7rhCb1pnto4gEAkjCJYIuq90Qb
VJVC85qKFQVFJBnSNhfkOi8Eoh8IaAM=
=KuKJ
-----END PGP SIGNATURE-----

--xwglcbrmgqk6xsau--
