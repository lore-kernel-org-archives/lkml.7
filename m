Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8F7C48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70373208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="l5hKRq1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfFXDl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 23:41:56 -0400
Received: from ozlabs.org ([203.11.71.1]:58317 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727591AbfFXDlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 23:41:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45XFTT53Ppz9s4Y;
        Mon, 24 Jun 2019 13:41:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561347711;
        bh=cgZrHxNz9vn4rcX8WT5IEz3w+4jbHRYMfWBxIvIlDjM=;
        h=Date:From:To:Cc:Subject:From;
        b=l5hKRq1c5WEyAM3WF2Ec5V02VUf4077RvAXNlWq/5W9ywXUIHsoYOOfTjdT4W+2NA
         T4L8UCev1xw2dZdv9xPo6DBIqZMLrgc0G/qboeKWm9Sh02OIkETpNfbvUVFz2yfX1z
         BUiMmdfhEwOVqHUEJFrNnc3sYY3s1RmWC65qF5IZf23yc35m2iXwZ2paNuYWAwzRK5
         7kBQmPLae7gzGK+Rw1j4KUWZgFU9L6UAnDpu96xcua26ZcOSZ8IeKGV8xMd9h5KXgr
         etJF/N4H8ZcSbqIKtwB66xDVy9j5yZheITsVHyt0mKVQ/dVcyZ9ZeC10DDRmG1+56b
         51fj4squ4n6Vw==
Date:   Mon, 24 Jun 2019 13:41:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: linux-next: manual merge of the drm tree with the jc_docs tree
Message-ID: <20190624134147.4950d388@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/E6I3n5WWx4soXp1+CCk8fqA"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/E6I3n5WWx4soXp1+CCk8fqA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  Documentation/fb/modedb.rst

between commit:

  ab42b818954c ("docs: fb: convert docs to ReST and rename to *.rst")

from the jc_docs tree and commit:

  1bf4e09227c3 ("drm/modes: Allow to specify rotation and reflection on the=
 commandline")

from the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/fb/modedb.rst
index 3c2397293977,1dd5a52f9390..000000000000
--- a/Documentation/fb/modedb.rst
+++ b/Documentation/fb/modedb.rst
@@@ -45,18 -45,29 +45,32 @@@ signals (e.g. HDMI and DVI-I). For othe
  is specified the output is disabled.
 =20
  You can additionally specify which output the options matches to.
 -To force the VGA output to be enabled and drive a specific mode say:
 +To force the VGA output to be enabled and drive a specific mode say::
 +
      video=3DVGA-1:1280x1024@60me
 =20
 -Specifying the option multiple times for different ports is possible, e.g=
.:
 +Specifying the option multiple times for different ports is possible, e.g=
.::
 +
      video=3DLVDS-1:d video=3DHDMI-1:D
 =20
+ Options can also be passed after the mode, using commas as separator.
+=20
+        Sample usage: 720x480,rotate=3D180 - 720x480 mode, rotated by 180 =
degrees
+=20
+ Valid options are:
+=20
+   - margin_top, margin_bottom, margin_left, margin_right (integer):
+     Number of pixels in the margins, typically to deal with overscan on T=
Vs
+   - reflect_x (boolean): Perform an axial symmetry on the X axis
+   - reflect_y (boolean): Perform an axial symmetry on the Y axis
+   - rotate (integer): Rotate the initial framebuffer by x
+     degrees. Valid values are 0, 90, 180 and 270.
+=20
+=20
 -***** oOo ***** oOo ***** oOo ***** oOo ***** oOo ***** oOo ***** oOo ***=
**
 +-------------------------------------------------------------------------=
----
 =20
  What is the VESA(TM) Coordinated Video Timings (CVT)?
 +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
 =20
  From the VESA(TM) Website:
 =20

--Sig_/E6I3n5WWx4soXp1+CCk8fqA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0QRnsACgkQAVBC80lX
0Gx0cwf3fCk0CQmL2h2Rgzc6JZL2t9sBQDJbkWLPJVPZGyxnZ0D+TcCPlTWftKvI
2peumOz0dWq8p7TQxyfqIPCNwTQoCWRTV73N2EpIpq5auz6TVD5b6joRj1e7avqi
Dqt9bc7SImm0yzq/LI+/5+lNV4vmKi4ZWeadx4R1xzKj1el1T9tMEyHCAf8kKmTt
gU0GTgyrNfiHtxqpmRazNkqC6eMZWiZJjs9I6AD3tauwWOxEP5JVrPo8MtK3o0N0
lQrhzlZM/GVCweKT3qnf7qs0kP2o9wffUyb7DNQzRH1p02wKNLrhONcx6wH76kGo
yOOuwXims8FCK7AkbT/Sj56I90U1
=1y4c
-----END PGP SIGNATURE-----

--Sig_/E6I3n5WWx4soXp1+CCk8fqA--
