Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B597C28EB2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 10:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646B520684
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 10:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfFFKIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 06:08:02 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45897 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbfFFKIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 06:08:02 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 2E461803DB; Thu,  6 Jun 2019 12:07:50 +0200 (CEST)
Date:   Thu, 6 Jun 2019 12:07:59 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, broonie@kernel.org,
        lgirdwood@gmail.com, lee.jones@linaro.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/5] leds: lm36274: Introduce the TI LM36274 LED driver
Message-ID: <20190606100759.GB1825@amd>
References: <20190605125634.7042-1-dmurphy@ti.com>
 <20190605125634.7042-6-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <20190605125634.7042-6-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-06-05 07:56:34, Dan Murphy wrote:
> Introduce the LM36274 LED driver.  This driver uses the ti-lmu
> MFD driver to probe this LED driver.  The driver configures only the
> LED registers and enables the outputs according to the config file.
>=20
> The driver utilizes the TI LMU (Lighting Management Unit) LED common
> framework to set the brightness bits.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

Actually, one more thing. Not too important, but.. how did Jacek's
signoff get there? He should add his signoff when he applies it to the
git...

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlz45f8ACgkQMOfwapXb+vKL+gCeMex2PG2Uitc6YIKYv/eT33nC
btgAmwXJiiYzEKZ+X1ldCmbovfr8/JtA
=dGFR
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
