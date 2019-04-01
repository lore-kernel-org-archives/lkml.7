Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBFEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BF82084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfDALfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:35:50 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:56641 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDALfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:35:50 -0400
X-Originating-IP: 90.88.32.136
Received: from localhost (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 5CBC2E0010;
        Mon,  1 Apr 2019 11:35:47 +0000 (UTC)
Date:   Mon, 1 Apr 2019 13:35:46 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Cc:     ARM-SoC Maintainers <arm@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: cpu: Fix JSON schema
Message-ID: <20190401113546.d6p2mg2y47abhumz@flea>
References: <20190318100521.29109-1-maxime.ripard@bootlin.com>
 <CAL_JsqJ_LYycXazkdP2Q=e-jynKiX+z5En0bz0AWpDjsevwQTg@mail.gmail.com>
 <20190401091050.cwph7xlpv3pmkwnq@flea>
 <78bb248e-56b8-b825-e763-583f75148eb3@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mrhlaajohf3mazqc"
Content-Disposition: inline
In-Reply-To: <78bb248e-56b8-b825-e763-583f75148eb3@socionext.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mrhlaajohf3mazqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Apr 01, 2019 at 07:52:06PM +0900, Sugaya, Taichi wrote:
> On 2019/04/01 18:10, Maxime Ripard wrote:
> > Hi Sugaya, Arnd, Olof,
> >
> > On Thu, Mar 28, 2019 at 02:35:54PM -0500, Rob Herring wrote:
> > > +arm-soc
> > >
> > > On Mon, Mar 18, 2019 at 5:05 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > >
> > > > Commit fd73403a4862 ("dt-bindings: arm: Add SMP enable-method for
> > > > Milbeaut") added support for a new cpu enable-method, but did so using
> > > > tabulations to ident. This is however invalid in the syntax, and resulted
> > > > in a failure when trying to use that schemas for validation.
> > > >
> > > > Use spaces instead of tabs to indent to fix this.
> > > >
> > > > Fixes: fd73403a4862 ("dt-bindings: arm: Add SMP enable-method for Milbeaut")
> > > > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > > ---
> > > >   Documentation/devicetree/bindings/arm/cpus.yaml | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > >
> > > This should be applied to arm-soc tree having the commit.
> >
> > Could you pick up that patch?
>
> I got it.
> My mission is to resubmit your fix-patch added my singned-off tag and
> Rob's reviewed tag...right?

If you are part of arm-soc and send your pull requests to Arnd and
Olof, simply pick it up in the same branch than the initial patch was
in. And when you apply that patch, you indeed need to add your
Signed-off-by (note that most commands to commit have an option to do
that automatically: -s and that includes git am) and the Rob's
reviewed-by.

Then, send a new pull request to arm-soc.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--mrhlaajohf3mazqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKH3kgAKCRDj7w1vZxhR
xSL3AQDrgfZOkHK4T4gxJF6v0mtZCGaGa8Yc76ZGGit66rqfywEA4kvj9lAQXzXB
/zdngK0XDtuXe4MeZLh3Sju4MTz6iQc=
=25qQ
-----END PGP SIGNATURE-----

--mrhlaajohf3mazqc--
