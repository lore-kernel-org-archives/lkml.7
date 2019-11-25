Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EA4C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC9E20740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfKYPHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:07:33 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:53374 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbfKYPHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:07:33 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 902251C2004; Mon, 25 Nov 2019 16:07:31 +0100 (CET)
Date:   Mon, 25 Nov 2019 16:07:30 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 06/19] leds: lp50xx: Add the LP50XX family of the RGB
 LED driver
Message-ID: <20191125150730.GA3816@amd>
References: <20191028183629.11779-7-dmurphy@ti.com>
 <201910302027.2hNdR993%lkp@intel.com>
 <29321f74-8200-90cd-40f9-8f5bdb86e34e@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <29321f74-8200-90cd-40f9-8f5bdb86e34e@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-10-30 11:43:10, Dan Murphy wrote:
> Pavel
>=20
> On 10/30/19 7:07 AM, kbuild test robot wrote:
> >Hi Dan,
> >
> >I love your patch! Yet something to improve:
> >
> >[auto build test ERROR on j.anaszewski-leds/for-next]
>=20
> You might want to get your tree to be the base now.

Do you have an idea who I need to contact?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl3b7jEACgkQMOfwapXb+vLTOwCglq9KPhyea7434BrqlmjBsyZP
xd8Ani0pFe1+R2RyEcQJRtb48OGM3Fpf
=F0xF
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
