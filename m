Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CB6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 18:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EEE20870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 18:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbfCaSiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 14:38:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47744 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfCaSiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 14:38:23 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 86F9D8043E; Sun, 31 Mar 2019 20:38:12 +0200 (CEST)
Date:   Sun, 31 Mar 2019 20:38:22 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Colin King <colin.king@canonical.com>
Cc:     Jan-Simon Moeller <jansimon.moeller@gmx.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: blinkm: clean up double assignment to
 data->i2c_addr
Message-ID: <20190331183822.GA7642@amd>
References: <20190330203757.8877-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20190330203757.8877-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2019-03-30 20:37:57, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Currently data->i2c_addr is being assigned twice, first with the
> value 0x09 and then immediately afterwards with the value 0x08.
> The first assignment is redundant and can be removed.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyhCR4ACgkQMOfwapXb+vIs9wCfSrbnqR8+G1kt7IDQ4GohkC+Y
Fb8AoLZDxEbCOlhvhnD0E/a1kGA7v1Fx
=YKgB
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
