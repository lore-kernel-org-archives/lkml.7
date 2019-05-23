Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D09C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BF72168B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Cennxv+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388347AbfEWVpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 17:45:05 -0400
Received: from ozlabs.org ([203.11.71.1]:51169 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387709AbfEWVpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 17:45:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4593262lktz9sBV;
        Fri, 24 May 2019 07:45:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558647902;
        bh=0fqq/VjZxiQ6Ps9zKvjLFM+hm3dSkH61b5GFgXg7JWI=;
        h=Date:From:To:Cc:Subject:From;
        b=Cennxv+TnouTunwRIsL2HsPP2U3OYUjIOn6dvUquWEJV5SKAd0fwYnqJhGEx7vYel
         TrmqGeQI0W8mYkwaMuubekkLltUVpGC/7SpxNaReLHelgwy/5n/KOzyJhY1IOlmskt
         +rRF/Zrh/CX46ZylL+x8tLgEI5L4uSnhy+/cyb9QcaGwd4spRBS3RYKXeL1koIHjtf
         /52o7U+vGVjAMi3KDjEbx0/kIDTUYApssMokqykI4Ag4J7baMAIAfbn0CA8L2L/PXj
         ChhMyELvp38PMsrgxlJv1NykzzT9LHgRYu8JPbJ43jLxbzcMr9dZskDbPeaDpj+jNO
         m4VOE38JNusUw==
Date:   Fri, 24 May 2019 07:45:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>
Subject: linux-next: Signed-off-by missing for commits in the block tree
Message-ID: <20190524074500.1fde68d6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/y52rQ8z3mv4S7FteBgWEXIL"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/y52rQ8z3mv4S7FteBgWEXIL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  5fb4aac756ac ("nvme: release namespace SRCU protection before performing =
controller ioctls")
  90ec611adcf2 ("nvme: merge nvme_ns_ioctl into nvme_ioctl")
  3f98bcc58cd5 ("nvme: remove the ifdef around nvme_nvm_ioctl")
  100c815cbd56 ("nvme: fix srcu locking on error return in nvme_get_ns_from=
_disk")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/y52rQ8z3mv4S7FteBgWEXIL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlznFFwACgkQAVBC80lX
0GxJDwf+LIxpoR/eFcibFlWjjBAc2m0IQd6BX0EANi8555org0lHg3NcfLOaWpOZ
zppotatVeqqhFv2prL/VbWPnkM9GsMIS+HRvln6m57rPw2l2L1a5WOBsLmToqUpP
+YToAqakRbAWJ9EuU041AMoDyc8kbOLohDsgIYBpxM9gKKhT1g8jjSEmHE9/3sBM
gI2/d7DZhcxO0jCvGFoxqzAIRpwCGk+TnQUwRz30C2ywxcaSxlnk7IWrIb17gPSg
Ro9C5n0FzwsJCmQSzPD1RQvwqQQmUZnSLga+2TDvnCHE234Q289KCarioshTQH/5
MbmENvJTYnL/douFsSfAZcHuvp7Fig==
=OivL
-----END PGP SIGNATURE-----

--Sig_/y52rQ8z3mv4S7FteBgWEXIL--
