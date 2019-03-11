Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF74C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A9262075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfCKKYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:24:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52807 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfCKKYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 06:24:30 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1B017806B8; Mon, 11 Mar 2019 11:23:19 +0100 (CET)
Date:   Mon, 11 Mar 2019 11:23:25 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, baolin.wang@linaro.org,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com
Cc:     sre@kernel.org
Subject: Re: 5.0-rc1 Open circuit voltage tables -- 3afb50d7125bc
Message-ID: <20190311102325.GB14118@amd>
References: <20190107190555.GA18865@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <20190107190555.GA18865@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-01-07 20:05:55, Pavel Machek wrote:
> Hi!
>=20
> Can we do something with that code?
>=20
> First -- tables should not be necceessary. Formula for li-ion open
> circuit voltage is well-known, and does not really depend on the
> device -- only on the chemistry of battery.
>=20
> state of charge =3D f( voltage, current, internal resistance )
>=20
> (And yes, internal resistance depends on temperature and health of the
> battery).
>=20
> Second, even if we need tables, why is it doing multiple allocations?
>=20
> info->ocv_temp[index]        =3D -EINVAL;
>=20
> That's just wrong. Ocv_temp is temperature in celsius. Temperatures go
> below zero.

Ping? That code is just bad. Does someone care?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyGNx0ACgkQMOfwapXb+vKi3ACgnh+XSnldfD3xL/4BOi3FrAbw
f2MAn227qHA1R8DedL1Annml947YNIl7
=abzA
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
