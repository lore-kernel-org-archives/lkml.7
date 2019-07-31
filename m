Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50499C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 01:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B39206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 01:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cgTvd0V7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfGaBfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 21:35:11 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52377 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfGaBfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 21:35:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45ywwC3Y7hz9sBF;
        Wed, 31 Jul 2019 11:35:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564536908;
        bh=U+0oStk4fqlrdWvDvsNj+synI4I7Bk845MdkuW6gz8g=;
        h=Date:From:To:Cc:Subject:From;
        b=cgTvd0V72RJXLcMiMMy+1xc2q+q9M260B7zynEfosMmS2Hvp+hlfwuvYRnxUqyM3f
         dAdVEycR/0Gs2ZDKYJMpFnpzhn0I0LP6h2Vzoql5a9k5yt8mzwqW4Kop9ob2ye/o57
         wcwHxff9Uln3i3f7IvHfbxKdaSAC8lTT26Zd0IS6M1cgeuitXMA2ICVh1QzbmWyXWW
         eO7dnEweyay46kA1C+LWPTwcpxWix6LNGpX/EndtUfMTRLSbFXibCx/HYZNtbpA3BL
         Le6cICwtKtCBlDH64VBVEG61D4qVcYpNzYbPdwOT/u3uKILkI8lkB2yVUDfQ7HWiw+
         1s0yW4hKc6EbQ==
Date:   Wed, 31 Jul 2019 11:35:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Stephen Boyd <swboyd@chromium.org>
Subject: linux-next: manual merge of the hwmon-staging tree with the mips
 tree
Message-ID: <20190731113500.62e2eaef@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wG+LLzs7SmwXry35m9wBr/0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wG+LLzs7SmwXry35m9wBr/0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the hwmon-staging tree got a conflict in:

  drivers/hwmon/jz4740-hwmon.c

between commit:

  d202742058b2 ("hwmon: Drop obsolete JZ4740 driver")

from the mips tree and commit:

  8d91bfd06bc1 ("hwmon: Remove dev_err() usage after platform_get_irq()")

from the hwmon-staging tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/wG+LLzs7SmwXry35m9wBr/0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1A8EQACgkQAVBC80lX
0Gxpegf7BZV+Ghq5XStYN8z5j0EgygL26AcnGn4DsxJY7bqeSWv8qcZxPw38Enim
HX4v7jwEgDKDXhQyHSZRUnn/nHAmNmcBGBiwAFo6TDPG36SL46kOyaGlPr8DQACo
XCUj1SUuwVmoqLP3sGMUH2ftbbYdCJFszo52KJTIhVFpTBBM/aQzE1I3ruUGumqQ
iU3uDh6glUEHFh5V3b5Bv7hgGI3D+iJ1o7oWIfEvbfzAu9O7VicXq2NXOHH2qacB
7sxuEm3zPqehcMJJKKegGpp8c6N6I7tDuD8S4EmebG/oenwGAhTvZP73zGjnMXNm
dSRqNocQ0abXgeR/nX7kovJUddrWlA==
=yXVO
-----END PGP SIGNATURE-----

--Sig_/wG+LLzs7SmwXry35m9wBr/0--
