Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352B9C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08B0206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfDPIA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:00:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39639 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfDPIA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:00:26 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8810F808E2; Tue, 16 Apr 2019 10:00:16 +0200 (CEST)
Date:   Tue, 16 Apr 2019 10:00:24 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>,
        Trivial patch monkey <trivial@kernel.org>
Subject: Re: [PATCH] Fix warning and undefined behavior in mmc voltage
 handling
Message-ID: <20190416080024.GD14538@amd>
References: <20190412093434.GA24516@amd>
 <CAPDyKFo2cZOqyCqBaZJzReaWfMenn6zgHcpCpf+XfegwqwNKxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="g7w8+K/95kPelPD2"
Content-Disposition: inline
In-Reply-To: <CAPDyKFo2cZOqyCqBaZJzReaWfMenn6zgHcpCpf+XfegwqwNKxQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g7w8+K/95kPelPD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-04-16 09:48:51, Ulf Hansson wrote:
> On Fri, 12 Apr 2019 at 11:34, Pavel Machek <pavel@ucw.cz> wrote:
> >
> > !voltage_ranges is tested for too late, allowing warning and undefined
> > behavior. Fix that.
> >
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
>=20
> Pavel, thanks for your patch.
>=20
> Would you mind re-posting to linux-mmc so I can get it into the
> patchtracker. Please also change the prefix of the header to "mmc:
> core:".

Done.

> > Plus I guess author should add parenthesis in the expression. a / b /
> > c is _not_ common idiom.

Can you do something about the a / b / c situation?

> > -       num_ranges =3D num_ranges / sizeof(*voltage_ranges) / 2;
> > +       num_ranges =3D num_ranges / sizeof(*voltage_ranges) / 2;

I guess it is:
       num_ranges =3D (num_ranges / sizeof(*voltage_ranges)) / 2;

=2E..but...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--g7w8+K/95kPelPD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAly1i5gACgkQMOfwapXb+vJb9wCfUnhHSefCg42Sqd44nIzVQ1FK
LS4AoIrI25uy2m2oROGyhbYCiE2D2Mcp
=fbQG
-----END PGP SIGNATURE-----

--g7w8+K/95kPelPD2--
