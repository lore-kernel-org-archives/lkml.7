Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C371CC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899702075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Soc0Dmki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfDPVdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:33:54 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47781 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728000AbfDPVdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:33:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44kJXH0jvQz9s4Y;
        Wed, 17 Apr 2019 07:33:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555450431;
        bh=WA4X48/y4gHPSxjKB296UyeI0xWtSiJD25fniiXMjNM=;
        h=Date:From:To:Cc:Subject:From;
        b=Soc0DmkiuhU68ZcsxPNwRHDMldtMs9IxjO2eiuqbZJdcR2GJW2N/4T7VCjNTLyrll
         cqeMk8r37JIdHyWYvMk08Na9JsP4bFIJo33HFaH9Q+TbOOdJ35+mEgfKln24+RFfmG
         zcAS8nz7XKRsLDa9+fDsuKmPbc3aRt0LTdgtfQMzYNKTWcVjoEdD0nt/ItrRkjmzBL
         z6wY6o5aq87aED+gs3NQDtg1H2jsJIUkCjMXGf5WKhOpboC8WA+gkTnrukGLnEHOru
         2L38j0wTxqO+2FdxelKedYngPec/ahRsNZyGwUk411WzoEOtK39PZ6b0UW8qixZ9AM
         jGgEuNeMVVX/g==
Date:   Wed, 17 Apr 2019 07:33:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: linux-next: Fixes tag needs some work in the drivers-x86 tree
Message-ID: <20190417073349.3fadd192@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/MtS/Z8_SxH.4Z12.q1J3aeX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MtS/Z8_SxH.4Z12.q1J3aeX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  6cc13c28da5b ("platform/x86: dell-laptop: fix rfkill functionality")

Fixes tag

  Fixes: 549b49 ("platform/x86: dell-smbios: Introduce dispatcher for SMM c=
alls")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/MtS/Z8_SxH.4Z12.q1J3aeX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly2Sj0ACgkQAVBC80lX
0GzBFggAo6r0WhMdvUg5ZQyb8D4rTe81gwO/cIU61IQEsI39OOW8Wuhd3NVxwc9V
8BDhEP/wT25VsnhRkOTDEC4KACAHNIU5SGV1paLT0slGgK/+J5iTpvO/svBIgjNp
DJRLgWkrgFGAZRWZsg/H+GJoOgdnHrvynYKRLNxh7tQ49cu4MEKU/IxkQFvjQjKi
32FRKtYN5WhWqJzlWT0Z1Xuk8mW+usX+bByxwlpybp+ta7gMBcmIXHrpzkknYfoz
HCOufbtfwd9SZDQa+ZaPeBpdwZJFj9kwOlJ2mocEUgMMRZ4CYVDD92hg0arCG7iY
Lw3onaItBDDCSVDypNC5koWe0Wpulg==
=8Pbd
-----END PGP SIGNATURE-----

--Sig_/MtS/Z8_SxH.4Z12.q1J3aeX--
