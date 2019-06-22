Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72876C48BE8
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 14:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A08520862
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 14:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nXGuwGjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfFVOGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 10:06:53 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57943 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfFVOGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 10:06:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45WHRQ5csGz9s00;
        Sun, 23 Jun 2019 00:06:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561212404;
        bh=nyyZNKPjdAVEfM3o+DcLOT4yBfjBHhyr55uRD/kVHRQ=;
        h=Date:From:To:Cc:Subject:From;
        b=nXGuwGjppXK4Bqr7DhLwzIvqwt71TcUQR9bwCej25A15/5pdIPKYIZfWw/6VJRAgr
         z8iRooGrmTVPZ8I2skZa2uLNzGD0J5dHJAG7e7nFvUY22KAzLYcJ3Jii+FBf58Z/nZ
         QqbEhNh8LRRZvLYPDFPYT7DwW95TxBR5VighRjR8/MMnxIKWTZoDEcbLn+ZYWUp8Xr
         lmi8NRmlhhA4RkvpZXTFSJZ/tFWEZdt69n4TH4Uv3OD1yHjjC7adAHzronNBNIwvMf
         h6q20DryOqMicjN+J14Klfg5qINaQwhOvsQAmDJzQmV56c3pPQL4Aq0lb9Vu8jcjmh
         KKYBRaqhGmlSA==
Date:   Sun, 23 Jun 2019 00:06:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: linux-next: Fixes tag needs some work in the tip tree
Message-ID: <20190623000641.0aa61abf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.SjaB+vDItcgt.MR10ESk94"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.SjaB+vDItcgt.MR10ESk94
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  5f4318c1b1d2 ("perf/x86: Add Intel Ice Lake NNPI uncore support")

Fixes tag

  Fixes: e39875d15ad6 ("perf/x86: add Intel Icelake uncore support")

has these problem(s):

  - Target SHA1 does not exist.

Did you mean

Fixes: 6e394376ee89 ("perf/x86/intel/uncore: Add Intel Icelake uncore suppo=
rt")

In commit

  36edfb940195 ("perf data: Fix perf.data documentation for HEADER_CPU_TOPO=
LOGY")

Fixes tag

  Fixes: c9cb12c5ba08 ("perf header: Add die information in CPU topology")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: acae8b36cded ("perf header: Add die information in CPU topology")

--=20
Cheers,
Stephen Rothwell

--Sig_/.SjaB+vDItcgt.MR10ESk94
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0ONfEACgkQAVBC80lX
0Gxa9QgAlz6GyUKe4OibyBVL6Ry2cmo6B+RJuMdLBy0KJNsG5yLwzdJDerrTiQdJ
9+UNItn0ZjVmRIMc0GDZdTyXXGpXtubvXm2dMrhO0SFPrqaOeo+pDuu2UguXK/6n
m1nxXERluHcN5JLFRG6ca130jYzWB5LdbyqBy8yCfV/rYC/zVcrA6Mm9lbALyAoP
3xXiFkQkJIxVt5nuxSjlUSbKqip6zH0xxDmyXVfGNL5hDtNIEo78RuFBwcLaiVQ3
+nDvi1ggwBPa/SovObxyiqtQF+5N3i1G9TpusDyM/Wr9m/qZbxQF3SMT2fNIOmev
9uRjSH2OSdPg0ZUdvJqt/kllsjWdsg==
=2CpO
-----END PGP SIGNATURE-----

--Sig_/.SjaB+vDItcgt.MR10ESk94--
