Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E98BC2D0D3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 19:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D04C206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 19:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfLUTD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:03:59 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:41280 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfLUTD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 14:03:58 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D27E31C24DF; Sat, 21 Dec 2019 20:03:56 +0100 (CET)
Date:   Sat, 21 Dec 2019 20:03:56 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] led: max77650: add of_match table
Message-ID: <20191221190356.GD4199@amd>
References: <20191210100832.11186-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline
In-Reply-To: <20191210100832.11186-1-brgl@bgdev.pl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-12-10 11:08:32, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> We need the of_match table if we want to use the compatible string in
> the pmic's child node and get the led driver loaded automatically.

Thanks, applied.
							Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl3+bJwACgkQMOfwapXb+vLEDACeIi09/3lMc+hye8FSYDtzuxhc
NzUAnRIWVrRwFUgpoiYmPmf9nrOn3jYj
=ogyL
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
