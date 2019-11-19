Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278BFC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E981121823
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BMpuAWKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfKSJ21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 04:28:27 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:41275 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfKSJ20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:28:26 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47HL9404w9z9sPf;
        Tue, 19 Nov 2019 20:28:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1574155704;
        bh=YMFrh8YlQ68brQ4Kvhp8ilikFa87CO3FLVUOiOrXPvc=;
        h=Date:From:To:Cc:Subject:From;
        b=BMpuAWKFkBl2iyqkdrFnF25p7Ebw/H/sAoS3OG6GMzUoC5OCi5i+Hf2tCAZIF4jaI
         DQlnV003dw06/6i9X+OKM63oWPU41IQE9mk+M7aqjdyTazxr8RQVPf16G/6wfxQLiP
         HadymRKzpbl7DmW7APzqqAYgzSbAPXl6etr3ip5Wkch2gz32AaeYnegCAiTBdX92Yv
         Bup0+p8zKwNQp/3sjscHhpWZi28k4Mj+DBXb382GkHfOJ9dTIjMdoXjEmI6UbfpQ6w
         EaItK9FF0YaFCXo7+OXXuCO62w/oC+JFdErRgBvN6zWOButAFhu3rpC05Rn209UqG7
         QxUuCVrJP9xDg==
Date:   Tue, 19 Nov 2019 20:28:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pan Bian <bianpan2016@163.com>
Subject: linux-next: Fixes tag needs some work in the scsi-mkp tree
Message-ID: <20191119202821.2283a14c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aqWTkfC.FmDIKdCUDz.J5T.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aqWTkfC.FmDIKdCUDz.J5T.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  250f3cd01313 ("scsi: qla4xxx: fix double free bug")

Fixes tag

  Fixes: 2a49a78ed3c ("[SCSI] qla4xxx: added IPv6 support.")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/aqWTkfC.FmDIKdCUDz.J5T.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3TtbUACgkQAVBC80lX
0GzrGQf/Rod3EsfNLfqLIQCUrmQOvVaa/LGkH4f1I60sXWx+lQBzPDNzzX3lVCKb
iO8zdSdUUnConoPpkaxKLAUJOOCqxFkqPdvO8102KNVU2ayKgs9adPGIpepTLpNM
MZMwmqHUrG2uQhAYotQVYqCQjiWtMyenimh1/TLba36wIvuVaEFfXU46vw5Ftu4G
plZE7coguItRRWdGT4NXNhl5n0YoonTrSXgLS5F0ZZHHHt73E8BeJU5NRPTpste4
zT+5XXeNByoBkPOOGrmUkD54ySqv0MgnTwaqb/59tIInMwZzFbtvHkPkpCftTsE/
3hhtF3ffpn5ZgV/9VBEUie0TU5IMUg==
=rEcX
-----END PGP SIGNATURE-----

--Sig_/aqWTkfC.FmDIKdCUDz.J5T.--
