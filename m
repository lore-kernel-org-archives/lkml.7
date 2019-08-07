Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2370C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89A8214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="A7VK3IFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfHGAZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 20:25:21 -0400
Received: from ozlabs.org ([203.11.71.1]:35029 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfHGAZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 20:25:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 463C2Q0DVvz9s7T;
        Wed,  7 Aug 2019 10:25:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565137518;
        bh=MxPnXiVpVHv5pOhWDrLpFtTAa8gxOoDCEQlgiuKHuqc=;
        h=Date:From:To:Cc:Subject:From;
        b=A7VK3IFZtlxXbzww1RW1N64/VxaUtm6UXgVKVnFrJWJ7GseDO3GDcKnbQ0B0GtUgm
         BYM9oiIUll9vrBUaTPtDldFCwjHrq/XVegvfqjjx69AatOUq3MRvkBLHPVb3mDHI5V
         SxQOp5k80sgJa+TUYA7EvUIZIfWz42MpJLMTXGYk6igyLm6NLKYnRpam+Ix/n+PV0K
         RaOysu1yLnS9ERFH/5aKC7ubxbHqEflZCTj+W8CzsIfVD1EHzvq/i+ECOZLK4iK8z2
         UD1+7AYcKbhYbf5/k78FEULh0bChAziPrGrWgdvRzf2BgRq04XsBPsgxjE9fkONItQ
         rdoottDN5tp+g==
Date:   Wed, 7 Aug 2019 10:25:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Burton <paul.burton@mips.com>
Subject: linux-next: manual merge of the mips tree with Linus' tree
Message-ID: <20190807102517.5d2c2873@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pXZ.F3ztuz3ew6gcWzR0tPV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pXZ.F3ztuz3ew6gcWzR0tPV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mips tree got a conflict in:

  arch/mips/include/asm/vdso/vdso.h
( arch/mips/vdso/vdso.h in Linus' tree)

between commit:

  ee38d94a0ad8 ("page flags: prioritize kasan bits over last-cpuid")

from Linus' tree and commit:

  6393e6064486 ("mips: fix vdso32 build, again")

from the mips tree.

I fixed it up (I just used the mips tree version) and can carry the fix
as necessary. This is now fixed as far as linux-next is concerned, but
any non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/pXZ.F3ztuz3ew6gcWzR0tPV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1KGm0ACgkQAVBC80lX
0GwWcgf+LqZUdcLs8mTMpz+BUvetCo//HU/ToZ1x8AaRTgLIMEjFiGN6EKCteBJ6
BXwu32DOY2a1h05d1z0McipPwuYSgBO4IpTRdaYQGvIRmvgmE5Jr+aIXneaqBYIU
8eDqg7+y7WxHHQb59Y6oBx9I/SNBt0TqQP78+uP8m3MUL2II3lF+/v6vs36X8Cwt
Rv8ndGEK5sSLUUnsh6kyd4HGyveh7wGmDObV+59DmBuBT+ncdZmJyftjTSkbPju7
nc5vLi2CE/n3+eKKl1WTR1LBNuNOzYHvHPLJChzt0e8OPbgrsrwPJISmnQPw/a/8
WRYQd4gTB2J9OLcwWtP0hdSdzjdnQA==
=1QCd
-----END PGP SIGNATURE-----

--Sig_/pXZ.F3ztuz3ew6gcWzR0tPV--
