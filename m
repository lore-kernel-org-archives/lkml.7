Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A712DC10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DAE421783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfJBTQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 15:16:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47399 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfJBTQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:16:50 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D84DF80300; Wed,  2 Oct 2019 21:16:33 +0200 (CEST)
Date:   Wed, 2 Oct 2019 21:16:47 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dan Murphy <dmurphy@ti.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.2 121/185] leds: lm3532: Fixes for the driver
 for stability
Message-ID: <20191002191647.GE13492@amd>
References: <20190922184924.32534-1-sashal@kernel.org>
 <20190922184924.32534-121-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zjcmjzIkjQU2rmur"
Content-Disposition: inline
In-Reply-To: <20190922184924.32534-121-sashal@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zjcmjzIkjQU2rmur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Dan Murphy <dmurphy@ti.com>
>=20
> [ Upstream commit 6559ac32998248182572e1ccae79dc2eb40ac7c6 ]
>=20
> Fixed misspelled words, added error check during probe
> on the init of the registers, and fixed ALS/I2C control
> mode.

lm3532 is under development, and this will not make it fully
usable. There are no users at the moment. I don't think we need to fix
it.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zjcmjzIkjQU2rmur
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2U958ACgkQMOfwapXb+vLidgCgk4Q7O2562NN7oCzfA/rNOS8v
QmMAoJ/dlhQjAmnkUHSFjCm+N/Un7SM2
=o/KP
-----END PGP SIGNATURE-----

--zjcmjzIkjQU2rmur--
