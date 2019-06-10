Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D4DC43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C413F20820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="r5drR4Kj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388336AbfFJShf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 14:37:35 -0400
Received: from ozlabs.org ([203.11.71.1]:43457 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387500AbfFJShe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 14:37:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45N21Q5Lkqz9sBp;
        Tue, 11 Jun 2019 04:37:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560191852;
        bh=tyRH81QZ/gsIDJcqGVSsCOmInqosEBxW8vFciGK1or8=;
        h=Date:From:To:Cc:Subject:From;
        b=r5drR4KjryR9IFH0ovwWVYQNX3vLb6U9QvKpTfeispz7+E+4bwJjK860RonPvV9yv
         n3AnxM47dN37CoMS+fNjmt/uonGjbnQiKjv3eSZ1Hcp6YCSf5b+NqSGWZ6GSvpwV3r
         vGuLFN8vP9VdT7IWC+cXIwNo2eS3EdKApD3/hlJR6+Ki2LoCuMxWdnY6/3oPeGWxzB
         3pWiG5GpzuiA5AAKOusLdtcSSd8C6rqd2nU75WZK9dYQ1Hg0i7vsyr2W21Rb1GKVXH
         4QXxGjHctUZgqXXwAX4xlQJeUjHFwEhQeNTLdllY7xbTXpsD6mDxYU4cJbNXxqO9xm
         3Yd4eAtTmBNag==
Date:   Tue, 11 Jun 2019 04:37:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Dahl <ada@thorsis.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: linux-next: Fixes tag needs some work in the net tree
Message-ID: <20190611043722.54fb0099@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gzw/5FfKffZHbXx6xgzXs_="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gzw/5FfKffZHbXx6xgzXs_=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  0ed89d777dd6 ("can: usb: Kconfig: Remove duplicate menu entry")

Fixes tag

  Fixes: ffbdd9172ee2f53020f763574b4cdad8d9760a4f

has these problem(s):

  - missing subject

--=20
Cheers,
Stephen Rothwell

--Sig_/gzw/5FfKffZHbXx6xgzXs_=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz+o2IACgkQAVBC80lX
0GysQgf8DK/UXPAcRct4iFO5E0pt9iPWy5+BB0NC/8CDqr9L30x4WcZf2rsqm0r3
46RBVamnlgzepeENM18u6KErLPF53EWdt32n28BxGup+gcEuir7QVb4pFPr/foNg
Vf2W/gN6lYibSyf5wEcHoq5/h0r8kjx2CjyS6a9uulvmxLJ7JSJFQ1LUUfQxP8FH
GYQU8c9VY4c4Yk30RSf/IBigpgI3fvXfPYgiigcKV3D6RPQyXgqDg0vokVEfYXSz
vZyYB+XrPzdCspV1glmEIHvc8UWOvK+VWT3bv0BPOwMyWjEANO+4ryqg0elmymTg
8KUEpH86/6HT09Ibm07BjWsAfmAoQA==
=YM4m
-----END PGP SIGNATURE-----

--Sig_/gzw/5FfKffZHbXx6xgzXs_=--
