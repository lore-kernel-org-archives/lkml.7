Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BECC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D87622387
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfGXLrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:47:05 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52385 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfGXLrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:47:05 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id BABA580262; Wed, 24 Jul 2019 13:46:51 +0200 (CEST)
Date:   Wed, 24 Jul 2019 13:47:02 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     mathieu.poirier@linaro.org, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: fix typos
Message-ID: <20190724114702.GB26116@amd>
References: <20190724100335.GA7373@amd>
 <7ae7157b-1336-f4a6-59a3-b1ac6307bd8d@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
In-Reply-To: <7ae7157b-1336-f4a6-59a3-b1ac6307bd8d@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-07-24 11:36:23, Suzuki K Poulose wrote:
>=20
>=20
> On 24/07/2019 11:03, Pavel Machek wrote:
> >
> >Fix typos in comments.
> >
> >Signed-off-by: Pavel Machek <pavel@denx.de>
> >
> >diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing=
/coresight/coresight.c
> >index 55db77f641..1d66191 100644
> >--- a/drivers/hwtracing/coresight/coresight.c
> >+++ b/drivers/hwtracing/coresight/coresight.c
> >@@ -1001,7 +1001,7 @@ static int coresight_orphan_match(struct device *d=
ev, void *data)
> >  	if (!i_csdev->orphan)
> >  		return 0;
> >  	/*
> >-	 * Circle throuch all the connection of that component.  If we find
> >+	 * Circle through all the connections of that component.  If we find
> >  	 * an orphan connection whose name matches @csdev, link it.
>=20
> We have stopped using name to match the csdev and switched to fwnode
> handles. Please could you update the comment to reflect this, while you a=
re
> at it ?
> Otherwise looks fine to me.

I guess best way would be to apply this and then fix up the facts in a
comment... or feel free to just fix it up. I am not best person to fix
facts there...

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl04RTYACgkQMOfwapXb+vJ1FACgr4BSo2yIxKfIP9Y0yZCav2IT
IE8AoLECqSdWmO2GfVfvl7/0bVwXZPqa
=RqVT
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
