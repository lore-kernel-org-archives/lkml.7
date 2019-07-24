Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD159C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D81521841
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfGXKBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 06:01:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49933 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfGXKBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 06:01:10 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D6A6A8026B; Wed, 24 Jul 2019 12:00:56 +0200 (CEST)
Date:   Wed, 24 Jul 2019 12:01:07 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: doc: mds: nitpicking and typo fix
Message-ID: <20190724100107.GA7206@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Consistently end sentences, fix typo.

Signed-off-by: Pavel Machek <pavel@denx.de>

commit 310cb17613f46db97cebbd9dc11187961e4b1c69
Author: Pavel <pavel@ucw.cz>
Date:   Mon May 20 10:46:35 2019 +0200

    doc: typo fix, consistency in mds.

diff --git a/Documentation/x86/mds.rst b/Documentation/x86/mds.rst
index 5d4330b..9983b50 100644
--- a/Documentation/x86/mds.rst
+++ b/Documentation/x86/mds.rst
@@ -54,13 +54,13 @@ needed for exploiting MDS requires:
  - to control the load to trigger a fault or assist
=20
  - to have a disclosure gadget which exposes the speculatively accessed
-   data for consumption through a side channel.
+   data for consumption through a side channel
=20
  - to control the pointer through which the disclosure gadget exposes the
    data
=20
 The existence of such a construct in the kernel cannot be excluded with
-100% certainty, but the complexity involved makes it extremly unlikely.
+100% certainty, but the complexity involved makes it extremely unlikely.
=20
 There is one exception, which is untrusted BPF. The functionality of
 untrusted BPF is limited, but it needs to be thoroughly investigated


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl04LGMACgkQMOfwapXb+vKy/ACggc8/sFAL3XP7h6R6psFKzRJG
99YAnRiMp8OlMfPZS3VgT7gExi+V8kkc
=+kD3
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
