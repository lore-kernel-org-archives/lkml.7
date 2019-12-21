Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD4AC2D0D2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 20:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93FE206D3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 20:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfLUU2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 15:28:00 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:50242 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfLUU2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 15:28:00 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id ED6E61C24A9; Sat, 21 Dec 2019 21:27:55 +0100 (CET)
Date:   Sat, 21 Dec 2019 21:27:55 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org, linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 22/25] leds: tm1826: Add combined glyph support
Message-ID: <20191221202755.GN32732@amd>
References: <20191212033952.5967-1-afaerber@suse.de>
 <20191212033952.5967-23-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SqfawxHnX56H7Ukl"
Content-Disposition: inline
In-Reply-To: <20191212033952.5967-23-afaerber@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SqfawxHnX56H7Ukl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-12-12 04:39:49, Andreas F=E4rber wrote:
> Allow to squeeze the text "HEllO" into a 4-digit display,
> as seen on MeLE V9 TV box.
>=20
> Enable this combining mode only if the text would overflow.

"HEll,nO"!

:-)

Ok, it is kind of cool, but... Can you take a look at
drivers/auxdisplay/charlcd.c ? It seems to support some kind of text
displays...

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SqfawxHnX56H7Ukl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl3+gEsACgkQMOfwapXb+vKK3ACfVq3b4sY2SeAWp3klGsyflcuZ
Sj0AnRfKrSM5NY59RyJTDgkcQrhrSqhF
=zSWs
-----END PGP SIGNATURE-----

--SqfawxHnX56H7Ukl--
