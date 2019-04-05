Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4ACC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 05:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6FA206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 05:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uvIgdMlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfDEF62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 01:58:28 -0400
Received: from ozlabs.org ([203.11.71.1]:39359 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfDEF62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 01:58:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44b8J13dTdz9sPS;
        Fri,  5 Apr 2019 16:58:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554443905;
        bh=uSUJVhIm2FfC7VwDwpkHmIuGe5C4VPwlZux6tHIj88s=;
        h=Date:From:To:Cc:Subject:From;
        b=uvIgdMlKjr9Se3x2xeDdoEh2LorI1ew/mTfvdq1Np+JzhFVY1WKMqYPeDnbgH/orJ
         Kfi4crr2hJz7f8DwDBh3FokcOuTk+XrD8FSlenyZg7K3hkBBGF5BtNla8GuERGh7wc
         Vo3ssUiE7JtUU6b4kcq/fScsOuYZJCD2p+KJL2KvKeYH5BCdrcHTKfpK4a44HH1d3s
         BgSBm5ds5xvNl4JS8NopOs8a9EpE/AGgIdygEqZlh38TcCamn2Efvo5EyJQZ75JDHD
         IRvU5PQAQVUMKoGg+LklDORViBfocFTqKDJg9cKgErJfNGLZ2vIwlumEmcgxMOdSu/
         Y2v0kE0vM5Yig==
Date:   Fri, 5 Apr 2019 16:58:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hoang Le <hoang.h.le@dektech.com.au>
Subject: linux-next: Fixes tag needs some work in the net-next tree
Message-ID: <20190405165824.534c5c39@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7Qhfn2+Z5Gc5MXkc92/xL=A"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7Qhfn2+Z5Gc5MXkc92/xL=A
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  e1279ff7aec1 ("tipc: add NULL pointer check")

Fixes tag

  Fixes: c55c8edafa9 ("tipc: smooth change between replicast and broadcast")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/7Qhfn2+Z5Gc5MXkc92/xL=A
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlym7oAACgkQAVBC80lX
0GxNnAf/a4zGB5NFR0St3lnvtnIYoqb/NqjlLhC15g8GSZqBleyouduaOCOVEOT5
+fFd1+inRH4uIi1uuoO1i6qnuSuRap9r7jN6BktugbT3kiI2W72eANUgQI885SUg
Q5+ki+vpH0sVRH5J++LtkMpGVexNgervBH/zvnz+FUa8hTM8U8B/GWdhtGtmpLZF
lLESEF5lRztLjW7YDeEkgEnhIIxmAAS5p0BdfEpdpQorERxW3uepFbm+m3TW1BFH
ZwHxZRFFiSNQbkXsMNapMaJ0D24avxzpYFQlYotKsZqmsEHRI/DFt3xKGB6vCAz2
s3iHJH2lIIODX/ei1nGztEnzseElRw==
=cPma
-----END PGP SIGNATURE-----

--Sig_/7Qhfn2+Z5Gc5MXkc92/xL=A--
