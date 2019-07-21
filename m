Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C636DC76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 21:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A657520693
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 21:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfGUVnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 17:43:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52835 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfGUVnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 17:43:15 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A9D51803E5; Sun, 21 Jul 2019 23:43:01 +0200 (CEST)
Date:   Sun, 21 Jul 2019 23:43:11 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jacek.anaszewski@gmail.com, dmurphy@ti.com,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] leds: ktd2692: Fix a typo in the name of a constant
Message-ID: <20190721214311.GB13062@amd>
References: <20190721210539.25669-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <20190721210539.25669-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2019-07-21 23:05:39, Christophe JAILLET wrote:
> There is a typo in KTD2962_MM_MIN_CURR_THRESHOLD_SCALE. 6 and 9 are
> switched in 2962.
>=20
> Define and use KTD2692_MM_MIN_CURR_THRESHOLD_SCALE instead.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Pavel Machek <pavel@ucw.cz>
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl003G8ACgkQMOfwapXb+vK4BgCgpSLX/vZZJrlrNm0aYtQcGSUv
vYwAoIrPZVugmomaKRZqSJABzny7ge3i
=xOVv
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
