Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB4EC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE65A21743
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfFULAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:00:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51985 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfFULAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:00:49 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id BCFB98057B; Fri, 21 Jun 2019 13:00:36 +0200 (CEST)
Date:   Fri, 21 Jun 2019 13:00:36 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 2/2] f2fs: set SBI_NEED_FSCK for xattr corruption case
Message-ID: <20190621110036.GB24145@amd>
References: <20190620033615.32284-1-yuchao0@huawei.com>
 <20190620033615.32284-2-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <20190620033615.32284-2-yuchao0@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-06-20 11:36:15, Chao Yu wrote:
> If xattr is corrupted, let's print kernel message and set SBI_NEED_FSCK
> for further repair.
>=20
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0MuNQACgkQMOfwapXb+vLoWACcCqLfYuyH4Mi2IWSNlk01yEZj
rT0An11pJWjLh+asN4CZ0b6XALv+BN70
=Rpu9
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
