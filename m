Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84142C28D1E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EC82083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfFFJw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 05:52:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45405 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfFFJw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:52:57 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id EFB7E80344; Thu,  6 Jun 2019 11:52:44 +0200 (CEST)
Date:   Thu, 6 Jun 2019 11:52:54 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, broonie@kernel.org,
        lgirdwood@gmail.com, lee.jones@linaro.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/5] mfd: ti-lmu: Add LM36274 support to the ti-lmu
Message-ID: <20190606095254.GD975@amd>
References: <20190605125634.7042-1-dmurphy@ti.com>
 <20190605125634.7042-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="W5WqUoFLvi1M7tJE"
Content-Disposition: inline
In-Reply-To: <20190605125634.7042-3-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W5WqUoFLvi1M7tJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-06-05 07:56:31, Dan Murphy wrote:
> Add the LM36274 register support to the ti-lmu MFD driver.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--W5WqUoFLvi1M7tJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlz44nYACgkQMOfwapXb+vIBfQCdGk9xzjbE/vpGRQZQMv7ssEGl
3SEAn2M45JHgQNJh7SsqvBboBx6h5iHt
=WjkQ
-----END PGP SIGNATURE-----

--W5WqUoFLvi1M7tJE--
