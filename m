Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F07C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BFF32173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390069AbfGRKwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 06:52:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55889 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389762AbfGRKwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 06:52:38 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id AD2C18027C; Thu, 18 Jul 2019 12:52:23 +0200 (CEST)
Date:   Thu, 18 Jul 2019 12:52:34 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, dmurphy@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, dtor@google.com, linux@roeck-us.net
Subject: Re: [PATCH v5 00/26] Add generic support for composing LED class
 device name
Message-ID: <20190718105233.GA3859@amd>
References: <20190609190803.14815-1-jacek.anaszewski@gmail.com>
 <405b2806-342a-952d-67ab-47516225c54e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <405b2806-342a-952d-67ab-47516225c54e@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Hi all,
>=20
> I need explicit acks for some patches from this series, that
> were either requested improvements or I modified them by myself
> after v4.
>=20
> The patches I am talking about are the following:
>=20
> 1/26
> 21/26
> 23/26
> 25/26

Acked-by: Pavel Machek <pavel@ucw.cz>

> 26/26 would be nice to have but I presume it needs more discussion
> and analysis.

Idea is good, but I'd sort the file in different way.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0wT3EACgkQMOfwapXb+vI1tACcCTFYaHPYF4l3AuLVbz3Ti/Pn
+nQAniCt8QUkaqGmg4Y5QMHqfyVCFSzD
=7Pli
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
