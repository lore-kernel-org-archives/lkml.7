Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117C9C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C188620883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbfDIIKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:10:52 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:57907 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDIIKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:10:52 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id B2F591C0018;
        Tue,  9 Apr 2019 08:10:43 +0000 (UTC)
Date:   Tue, 9 Apr 2019 10:09:31 +0200
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
Subject: Re: [PATCH 2/2] dt-bindings: cpufreq: Document
 operating-points-v2-sunxi-cpu
Message-ID: <20190409080931.5x36pgtwhdjh2lkq@flea>
References: <20190405102455.15311-1-tiny.windzz@gmail.com>
 <20190405102455.15311-3-tiny.windzz@gmail.com>
 <20190405145532.cstvbv3mxbzrmpxp@flea>
 <CAEExFWuDjD2Ur6UuCPD_m=hvUYJj7Z=NqQ7KXXR+tmnVtDqfbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2k2xiuosmbkit26j"
Content-Disposition: inline
In-Reply-To: <CAEExFWuDjD2Ur6UuCPD_m=hvUYJj7Z=NqQ7KXXR+tmnVtDqfbQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2k2xiuosmbkit26j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 09, 2019 at 12:13:58AM +0800, Frank Lee wrote:
> On Fri, Apr 5, 2019 at 10:55 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Hi,
> >
> > On Fri, Apr 05, 2019 at 06:24:55AM -0400, Yangtao Li wrote:
> > > Allwinner Process Voltage Scaling Tables defines the voltage and
> > > frequency value  based on the speedbin blown in the efuse combination.
> > > The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> > > provide the OPP framework with required information.
> > > This is used to determine the voltage and frequency value for each
> > > OPP of operating-points-v2 table when it is parsed by the OPP framework.
> > >
> > > This change adds documentation for the DT bindings.
> > > The "operating-points-v2-sunxi-cpu" DT extends the "operating-points-v2"
> > > with following parameters:
> > > - nvmem-cells (NVMEM area containig the speedbin information)
> > > - opp-supported-hw: A single 32 bit bitmap value,
> > >   representing compatible HW:
> > >                       0:      speedbin 0
> > >                       1:      speedbin 1
> > >                       2:      speedbin 2
> > >                       3-31:   unused
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > ---
> > >  .../bindings/opp/sunxi-nvmem-cpufreq.txt      | 235 ++++++++++++++++++
> > >  1 file changed, 235 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> > > new file mode 100644
> > > index 000000000000..80201d4e5147
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> > > @@ -0,0 +1,235 @@
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
> > > +- nvmem-cells: A phandle pointing to a nvmem-cells node representing the
> > > +             efuse registers that has information about the
> > > +             speedbin that is used to select the right frequency/voltage
> > > +             value pair.
> > > +             Please refer the for nvmem-cells
> > > +             bindings Documentation/devicetree/bindings/nvmem/nvmem.txt
> > > +             and also examples below.
> > > +
> > > +In every OPP node:
> > > +- opp-supported-hw: A single 32 bit bitmap value, representing compatible HW.
> > > +                 Bitmap:
> > > +                     0:      speedbin 0
> > > +                     1:      speedbin 1
> > > +                     2:      speedbin 2
> > > +                     3-31:   unused
> >
> > I'm wondering if that's the right approach.
> >
> > I guess we could also have three different OPP tables, and pass them
> > all three through a phandle array, and have the kernel code select
> > which one is relevant based on the SID content
>
> It's ok. But why not use the way we already have?
> Is it necessary to introduce new helper?

My main concern is that it becomes quite difficult to differentiate
the various OPPs, and to which bin a particular OPP is belonging to,
while the more traditional OPPv2 makes it much more obvious.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--2k2xiuosmbkit26j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKxTOwAKCRDj7w1vZxhR
xWNqAQDPFhLTiR0NkLqFqcKZWJXT38kLj7cIcY+efjoMW85wMgEA14xBMv/Zlsr7
GwlrayWZvCDX9kk4EUEZ8kI2gCMqogc=
=D09V
-----END PGP SIGNATURE-----

--2k2xiuosmbkit26j--
