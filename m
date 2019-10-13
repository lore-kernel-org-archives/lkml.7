Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750B0C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 12:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9B92084D
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 12:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfJMMK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 08:10:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41952 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbfJMMK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 08:10:29 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id AA7C780262; Sun, 13 Oct 2019 14:10:11 +0200 (CEST)
Date:   Sun, 13 Oct 2019 14:10:20 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/6] ad5820: Multiple fixes
Message-ID: <20191013121020.GM5653@amd>
References: <20191007132856.27948-1-ribalda@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="iUV/lbBrmPtUT9dM"
Content-Disposition: inline
In-Reply-To: <20191007132856.27948-1-ribalda@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iUV/lbBrmPtUT9dM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-10-07 15:28:50, Ricardo Ribalda Delgado wrote:
> -Support for enable-pin, of-autoload, enable-gpios and ad5821 and ad5823
>=20
> For some reason these patchset was lost in translation for a year ;)
>=20
>=20
> v8: I screwed up sending v7, I sent it from a dirty directory
> and clicked on send-all without checking what was under v7*. Sorry :(
> This made patchwork very unhappy. I send v8 to make patchwork happy and
> hopefuly also the maintainer. Sorry again

Ok, this is a LED, but I assume it needs to go in using media
tree. Good luck! :-).

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--iUV/lbBrmPtUT9dM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2jFCwACgkQMOfwapXb+vKumwCeLBeJP9ErxUe2GUYsar2FhSYt
fq8AoMH87mnqnjYtBSgq9pJMjtITnYEC
=PuDS
-----END PGP SIGNATURE-----

--iUV/lbBrmPtUT9dM--
