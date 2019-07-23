Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A170FC76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB262253D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FbF9DqpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392172AbfGWVmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 17:42:33 -0400
Received: from ozlabs.org ([203.11.71.1]:53763 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731707AbfGWVmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 17:42:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45tX5156jzz9s3l;
        Wed, 24 Jul 2019 07:42:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563918150;
        bh=lm7xmoLkDfwu2hVAaeTt/n/ESlb3raTFQiF/+8lCoU0=;
        h=Date:From:To:Cc:Subject:From;
        b=FbF9DqpODFSiDUoCKmbfB+xKXAuwknHWWhi9g14BRR9WMTpAhV0tdDsJg5kJ9VyQO
         F1gUQV6xp0ihTPTlhRYpzSkFrrNYrZqEtYFkJ/sheAilh1KqNRNw2HO5Hd+2Tv4aos
         c3/xcIenoyH9UGxIRJYUOZSN/zwFx6HzJBp/hJ6HzEduPn8fPdBW/vmDMRmedTUIWK
         G7rer1hGlhpb1BltahRB5/7lo45UgNVSad5KUOVDe5uT74G0EccpUNJ98YLK3nogtY
         LVyhos5PdA/lX9Znf+dJkDbJD16MtqfD7W1FJi95Ey0VJHtRdx8HEsPYoWgTNAyoLS
         bUOxndO/XiDZw==
Date:   Wed, 24 Jul 2019 07:42:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Farhan Ali <alifm@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: linux-next: Fixes tag needs some work in the s390-fixes tree
Message-ID: <20190724074227.63abe116@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zatS8ihIl.B42ap/.cz0Fmj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zatS8ihIl.B42ap/.cz0Fmj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  8b515be512a2 ("vfio-ccw: Fix memory leak and don't call cp_free in cp_ini=
t")

Fixes tag

  Fixes: 812271b910 ("s390/cio: Squash cp_free() and cp_unpin_free()")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/zatS8ihIl.B42ap/.cz0Fmj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl03f0MACgkQAVBC80lX
0GzCzAf/dpK6XzP2k0Hpekq1mvhHboS5unctqnB5e9t+rgXu6zxIvaxeph3exUiu
Yoiq20pmkkIl4VrckfDlcCLhekWFols0/zC3+DyZfzk3gV7uZMV4xM54Q6+XZpmF
T+bx8oxOjX1x7acFW60iOEp6nycTlp3AnBUkFjXmV3FpNSPxgebDj7JjNHJ21zuy
YbA90x9d4sEjTcYFL5ZhObtI/smIFF2plSlGmVpIIflg7VbJ1XfbuEi6tM+sPhlK
ePZI31O9YeJK0z4g1icFAt0KMdWad9SVVsFqpm8KzOaZDzECCMdIfSIvwBUTvPoK
VekJY73Ep9yygPMKWy2buS4KD8sn4g==
=QymM
-----END PGP SIGNATURE-----

--Sig_/zatS8ihIl.B42ap/.cz0Fmj--
