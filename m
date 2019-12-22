Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ED0C2D0D4
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 18:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870122070A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 18:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfLVSfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 13:35:25 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:54804 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfLVSfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 13:35:25 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id DBB8F1C2453; Sun, 22 Dec 2019 19:35:23 +0100 (CET)
Date:   Sun, 22 Dec 2019 19:35:23 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v17 19/19] leds: lp55xx-common: Remove extern from
 lp55xx-common header
Message-ID: <20191222183523.GH23369@amd>
References: <20191114133023.32185-1-dmurphy@ti.com>
 <20191114133023.32185-20-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OpLPJvDmhXTZE4Lg"
Content-Disposition: inline
In-Reply-To: <20191114133023.32185-20-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OpLPJvDmhXTZE4Lg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-11-14 07:30:23, Dan Murphy wrote:
> extern is implied and is not needed in the common header file.
> Remove the extern keyword and re-align the code.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

Lets not do this.

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OpLPJvDmhXTZE4Lg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl3/t2oACgkQMOfwapXb+vK7ngCgplr/QI77DCpwzm2O/p8FCuRu
YgIAoLJic74HVsOc+21FBN01/Lv0H+/K
=uO9y
-----END PGP SIGNATURE-----

--OpLPJvDmhXTZE4Lg--
