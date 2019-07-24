Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637BDC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C787229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfGXKDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 06:03:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49971 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfGXKDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 06:03:37 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 87FD88026D; Wed, 24 Jul 2019 12:03:24 +0200 (CEST)
Date:   Wed, 24 Jul 2019 12:03:35 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] coresight: fix typos
Message-ID: <20190724100335.GA7373@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Fix typos in comments.

Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/co=
resight/coresight.c
index 55db77f641..1d66191 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -1001,7 +1001,7 @@ static int coresight_orphan_match(struct device *dev,=
 void *data)
 	if (!i_csdev->orphan)
 		return 0;
 	/*
-	 * Circle throuch all the connection of that component.  If we find
+	 * Circle through all the connections of that component.  If we find
 	 * an orphan connection whose name matches @csdev, link it.
 	 */
 	for (i =3D 0; i < i_csdev->pdata->nr_outport; i++) {
@@ -1021,7 +1021,7 @@ static int coresight_orphan_match(struct device *dev,=
 void *data)
 	i_csdev->orphan =3D still_orphan;
=20
 	/*
-	 * Returning '0' ensures that all known component on the
+	 * Returning '0' ensures that all known components on the
 	 * bus will be checked.
 	 */
 	return 0;


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl04LPcACgkQMOfwapXb+vJUawCfe3B/JW0/QIiiRbvk/coaNJ2K
3tMAmgJ0BH4BEwlIbP17oRtQ//otl9UC
=yR5u
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
