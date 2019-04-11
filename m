Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88851C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBAC217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfDKHtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:49:45 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:42547 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfDKHtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:49:45 -0400
Received: from localhost (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id C3C96100016;
        Thu, 11 Apr 2019 07:49:38 +0000 (UTC)
Date:   Thu, 11 Apr 2019 09:49:38 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Chen-Yu Tsai <wens@csie.org>, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.ferre@microchip.com, Linux PM <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: cpufreq: Document
 operating-points-v2-sunxi-cpu
Message-ID: <20190411074938.z6gygxfcj43giz57@flea>
References: <20190409172558.18778-1-tiny.windzz@gmail.com>
 <20190409172558.18778-3-tiny.windzz@gmail.com>
 <20190410145659.62nl4o2jvkuggmpe@flea>
 <CAEExFWu60DZ2xY7qxpjGFq3f_u2G4p7y-wqmsj0HR7CQy24r7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ar5gkwcb4uiazh5y"
Content-Disposition: inline
In-Reply-To: <CAEExFWu60DZ2xY7qxpjGFq3f_u2G4p7y-wqmsj0HR7CQy24r7w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ar5gkwcb4uiazh5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 11, 2019 at 01:49:39AM +0800, Frank Lee wrote:
> On Wed, Apr 10, 2019 at 10:57 PM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > On Tue, Apr 09, 2019 at 01:25:58PM -0400, Yangtao Li wrote:
> > > Allwinner Process Voltage Scaling Tables defines the voltage and
> > > frequency value  based on the speedbin blown in the efuse combination.
> > > The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> > > provide the OPP framework with required information.
> > > This is used to determine the voltage and frequency value for each
> > > OPP of operating-points-v2 table when it is parsed by the OPP framework.
> > >
> > > The "operating-points-v2-sunxi-cpu" DT extends the "operating-points-v2"
> > > with following parameters:
> > > - nvmem-cells (NVMEM area containig the speedbin information)
> > > - opp-microvolt-<name>: voltage in micro Volts.
> > >   At runtime, the platform can pick a <name> and matching
> > >   opp-microvolt-<name> property
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > ---
> > >  .../bindings/opp/sunxi-nvmem-cpufreq.txt      | 166 ++++++++++++++++++
> > >  1 file changed, 166 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> > > new file mode 100644
> > > index 000000000000..c81a2075b974
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> > > @@ -0,0 +1,166 @@
> > > +Allwinner Technologies, Inc. NVMEM CPUFreq and OPP bindings
> > > +===================================
> > > +
> > > +For some SoCs, the CPU frequency subset and voltage value of each OPP
> > > +varies based on the silicon variant in use. Allwinner Process Voltage
> > > +Scaling Tables defines the voltage and frequency value  based on the
> > > +speedbin blown in the efuse combination. The sunxi-cpufreq-nvmem driver
> > > +reads the efuse value from the SoC to provide the OPP framework with
> > > +required information.
> > > +
> > > +Required properties:
> > > +--------------------
> > > +In 'cpus' nodes:
> > > +- operating-points-v2: Phandle to the operating-points-v2 table to use.
> > > +
> > > +In 'operating-points-v2' table:
> > > +- compatible: Should be
> > > +     - 'operating-points-v2-sunxi-cpu'.
> >
> > Vendor-specific compatibles should have the vendor mentionned.
> >
> > Also, even though the H6 is the only SoC so far that has needed this,
> > we can't really assume that it will be the only SoC to use it, or that
> > it will always behave like that.
>
> There is no doubt that many platforms need this.

That many platform *may* need this, yeah, sure. We can probably even
share the same driver for them.

That all of those theretical platform will have the exact same
behaviour, down to how the data is stored in the nvmem, and how many
bins you have? I seriously doubt so.

> > So having something like allwinner,sun50i-h6-operating-points would be
> > great.
> allwinner,cpu-operating-points-v2 Maybe better?

No. You need to have the SoC name in there, and you can drop the
v2. There's never been a v1.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ar5gkwcb4uiazh5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXK7xkgAKCRDj7w1vZxhR
xaAhAP9mCtA9PL96fROyWgoWeKqRtTOzgxofM1fFfIWQI0WIYgEAjKbvK2Xm9ckT
sy+VyxscwMnLi1Fb5bC3INUKJVbhhw8=
=T5TI
-----END PGP SIGNATURE-----

--ar5gkwcb4uiazh5y--
