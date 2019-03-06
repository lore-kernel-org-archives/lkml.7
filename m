Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43775C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0B620684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfCFXKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:10:17 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57547 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCFXKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:10:16 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id EE73280244; Thu,  7 Mar 2019 00:10:07 +0100 (CET)
Date:   Thu, 7 Mar 2019 00:10:14 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>
Subject: Re: [PATCH] devfreq: Suspend all devices on system shutdown
Message-ID: <20190306231014.GE7915@amd>
References: <CGME20190125135414eucas1p2ffc71c63f1a27f67d076dec889954b40@eucas1p2.samsung.com>
 <20190125135403.10228-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="h56sxpGKRmy85csR"
Content-Disposition: inline
In-Reply-To: <20190125135403.10228-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h56sxpGKRmy85csR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-01-25 14:54:03, Marek Szyprowski wrote:
> This way devfreq core ensures that all its devices will be set to safe
> operation points before reboot operation. There are board on which some
> aggressive power saving operation points are behind the capabilities of
> the bootloader to properly reset the hardware and boot the board. This
> way one can avoid board crash early after reboot.
>=20
> Similar pattern is used in CPUfreq subsystem.

This looks somehow dangerous to me. I guess this will break someone's
shutdown, and on battery-powered devices, that's quite bad thing to
do.

Could we explicitely do it only for devices that need it?
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--h56sxpGKRmy85csR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyAU1YACgkQMOfwapXb+vLpVgCgxNfYJNgv05kCYb+TXTPK9KxX
iY4An3feW6xYMNG8mtqu/hUR6pIuhtUY
=UcWr
-----END PGP SIGNATURE-----

--h56sxpGKRmy85csR--
