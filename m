Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7A2C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF4B20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfCFOPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:15:33 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:48919 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfCFOPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:15:33 -0500
X-Originating-IP: 90.88.150.179
Received: from localhost (aaubervilliers-681-1-31-179.w90-88.abo.wanadoo.fr [90.88.150.179])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 716DE1C000D;
        Wed,  6 Mar 2019 14:15:30 +0000 (UTC)
Date:   Wed, 6 Mar 2019 15:15:29 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Eric Anholt <eric@anholt.net>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Eben Upton <eben@raspberrypi.org>,
        David Airlie <airlied@linux.ie>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 0/3] drm/vc4: Add a load tracker
Message-ID: <20190306141529.a6xas3b63dn36o6l@flea>
References: <20190220155124.25022-1-paul.kocialkowski@bootlin.com>
 <87sgwie42w.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m6dmrx72wi3buuqy"
Content-Disposition: inline
In-Reply-To: <87sgwie42w.fsf@anholt.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m6dmrx72wi3buuqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2019 at 09:56:39AM -0800, Eric Anholt wrote:
> Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
>=20
> > Hi,
> >
> > Here is a fourth iteration of the VC4 load tracking series, which was
> > initially developed by Boris Brezillon and that I have now taken over.
> >
> > This new iteration takes in account comments from v3 and comes with a
> > new approach for avoiding underrun reports when reconfiguring the
> > pipeline. It is now based on detection instead of delaying the underrun
> > interrupt unmasking.
> >
> > It can be tested with a dedicated IGT GPU Tools series:
> >   VC4 load tracker testing
>=20
> Series is:
>=20
> Reviewed-by: Eric Anholt <eric@anholt.net>
>=20
> Thanks for persisting on this!

Applied all three patches to drm-misc-next.

Maxime


--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--m6dmrx72wi3buuqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXH/WAQAKCRDj7w1vZxhR
xUs2AP0f+FfZXQ3TMHgu2xsEUttkmQhuPu/z+1tt0jVC4dFvmQEAvSEX/es6lHgY
kaFX9cgTqGjoZf7klp40FlFP76U3fAw=
=Fl0T
-----END PGP SIGNATURE-----

--m6dmrx72wi3buuqy--
