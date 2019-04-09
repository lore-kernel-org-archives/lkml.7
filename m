Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CE1C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E07C20857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfDIHnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:43:22 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:43747 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDIHnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:43:21 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 093EE24000E;
        Tue,  9 Apr 2019 07:43:14 +0000 (UTC)
Date:   Tue, 9 Apr 2019 09:43:14 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     mark.rutland@arm.com, robh@kernel.org, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ziping Chen <techping.chan@gmail.com>,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com, wens@csie.org,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND v4 3/4] ARM: dts: sunxi: Add R_LRADC support for
 A83T
Message-ID: <20190409074314.zd5yqilq7h4tvlzo@flea>
References: <20190327023339.25975-1-megous@megous.com>
 <20190327023339.25975-4-megous@megous.com>
 <20190408080056.lfzjxfkvs65oabuu@flea>
 <20190408120901.v46rdhqvobr5vuks@core.my.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tjctminwmf5gzanx"
Content-Disposition: inline
In-Reply-To: <20190408120901.v46rdhqvobr5vuks@core.my.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tjctminwmf5gzanx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 02:09:01PM +0200, Ond=C5=99ej Jirman wrote:
> Hello Maxime,
>
> On Mon, Apr 08, 2019 at 10:00:56AM +0200, Maxime Ripard wrote:
> > On Wed, Mar 27, 2019 at 03:33:38AM +0100, megous@megous.com wrote:
> > > From: Ziping Chen <techping.chan@gmail.com>
> > >
> > > Allwinner A83T SoC has a low res adc like the one in Allwinner A10 So=
C.
> > > Now the driver has been modified to support it.
> > >
> > > Add support for it.
> > >
> > > Signed-off-by: Ziping Chen <techping.chan@gmail.com>
> >
> > It's missing your SoB.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
>
> Please add it when aplying he patch.

Done, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--tjctminwmf5gzanx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKxNEgAKCRDj7w1vZxhR
xS28AQDOEtO1YFUToVj+PAMD2kE/9JgzxyN3fAy+eJHAl59w7AEAtn2BCB9n11YT
W0a1aY30aL9aqoH+fU8xS2oxS0Ypzg4=
=DGSP
-----END PGP SIGNATURE-----

--tjctminwmf5gzanx--
