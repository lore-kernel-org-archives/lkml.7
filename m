Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1B8C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91632206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="S8Njr2r1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbfDYVJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:09:57 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48403 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfDYVJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:09:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44qqZS3Rs7z9s5c;
        Fri, 26 Apr 2019 07:09:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556226594;
        bh=eDrA27bWziI+RtnAYWh5D6GL8N7pfO8VviRqOKikLss=;
        h=Date:From:To:Cc:Subject:From;
        b=S8Njr2r1rYqHFILCAksqBp8XGwjrIyEbLBr1TzFd9lq3wDjZmmNEugaSPm93JHSgm
         tMoJBsmhYCBItYxcdwdibCSQslL1ILf62vI5Nz+YYN2lCa0+OwmzCvwTq5/V4Hv1qr
         tXIc2MVZKIsSex0befLHcJsHUagS7/mQrJEZDysCiHOHz+sDBlnLUWzxCDZkH33z5b
         Qcj30CSd8L+YZaa5/O4cR2mcS+ZKhuSYpUZbd4r5BBvXwZiYv5yKzwUkgKMJB2zsO3
         gJXKSLpj2QXdOfpOpPF5xXNRLQWqC/Bl9p5H2TVAEEybg4E/Qe9gXwYDnHyK5cWVUt
         JaQBFdDg8K5pw==
Date:   Fri, 26 Apr 2019 07:09:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jkosina@suse.cz>
Subject: linux-next: Fixes tag needs some work in the tip tree
Message-ID: <20190426070949.154c425b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jriS=yWeCbcqQe.lU7wK+0P"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jriS=yWeCbcqQe.lU7wK+0P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  a65c88e16f32 ("x86/mm: Remove in_nmi() warning from 64-bit implementation=
 of vmalloc_fault()")

Fixes tag

  Fixes: 6863ea0cda8 ("x86/mm: Remove in_nmi() warning from vmalloc_fault()=
")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/jriS=yWeCbcqQe.lU7wK+0P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzCIh4ACgkQAVBC80lX
0Gw5YwgAn4RgAek2q+sj783FVvVZanql+32VfGuw8iJ4dVMBUN4n8tTHcI16YBRR
birZ1xrtJdrouhnNete3Yo/e8A/rN5ptGiQxCR1aAUzdLfM6olG6gRDCkd4LZDVg
MKjTN3Hxr+pjbP18iE/L3+U0CDTJiP+xCjvvwAC0D3QIrND6GOGiA8Ho7sM6sI54
bpdyONSnyYtbuJ1tiIuoYHB/GfmbokCg2G94mvqv+zoAxZNRvadjpiRtnze9+UFZ
GJ+KlJKRMbj2VFnI3Wfs1vn7fSlRUS9kz8cCSaa3e+/ltbY2erJjYukW7GYzdQWB
utM4pkFN99xHPkv6oRMsFkfV2sTzWA==
=CgRx
-----END PGP SIGNATURE-----

--Sig_/jriS=yWeCbcqQe.lU7wK+0P--
