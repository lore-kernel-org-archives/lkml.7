Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53016C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E7E2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbfG2WAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:00:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42541 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfG2WAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 18:00:34 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D1F298025F; Tue, 30 Jul 2019 00:00:19 +0200 (CEST)
Date:   Tue, 30 Jul 2019 00:00:31 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        jacek.anaszewski@gmail.com, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: Backlight in motorola Droid 4
Message-ID: <20190729220030.GA20100@amd>
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20190722205921.GA24787@amd>
 <b8fbc94f-c087-2c9d-4532-ea423f1626e6@ti.com>
 <20190724124530.GA30211@amd>
 <ca69f627-96e2-f982-3a29-18b0127ac6e5@ti.com>
 <edde330e-516b-ecaa-4139-0bfa766a9c08@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <edde330e-516b-ecaa-4139-0bfa766a9c08@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >Looking at the rest of the code.
> >
> >The DT doc indicated that this was a required child property so this is
> >why it
> >
> >errors out.
> >
> >Dan
> >
> ><snip>
> >
>=20
> Did you want me to fix up the LM3532 and send the patch?

If you could do that, that would be nice :-).

> Or do you have a patch ready to go?

No progress there, I'm busy with other stuff...

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0/bH4ACgkQMOfwapXb+vJbZwCeOsEnECGW7XgsYHjDkAvi9ZHy
Rd4Anjl6meti7Dn9fgRfk1KrcIy28Ueo
=J4oU
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
