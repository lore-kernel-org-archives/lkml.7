Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE12C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3134120652
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CnMhLfzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfFXCrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 22:47:25 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56141 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbfFXCrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:47:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45X91r5q3Hz9sBr;
        Mon, 24 Jun 2019 10:21:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561335665;
        bh=LsJYm2shRM7LwoHE6XZAh2/rVUWiyUrU41fclTA7RUg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CnMhLfzkf/Z5PWXtxD5DelHCkvmsS3IVaO1bsPpCPs1p+QQUZyR0Y14NAsVIrFNJW
         za2/d9Wr/1n3juJ0tkfo6FH7cKqrvJeazZgKLl1efmQe7s7mg7NoZmBTBfQaaGPahF
         i7va/lDvVzwXjP5tpFcgGAHL8z5866rvPFkPmKxzXYkTUQ08jbBPC1uxhosqTIB5c/
         iWTTPsMoqZEN/PXR5WDaEjuBAape32+mnTIw2VpG1UcpyLxbgZC79h0qlBKu6Xy+Gq
         +s00aAmj0vLlN0KpPqXJA6xnBRBvJ6MACTP6g934+OdTxkVr0UR5lpyuAeGIOTCP7n
         cUHn6ff0IYkDA==
Date:   Mon, 24 Jun 2019 10:20:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>, jaegeuk@kernel.org,
        yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net,
        Qiuyang Sun <sunqiuyang@huawei.com>
Subject: Re: Next 20190621: fails to link f2fs in x86-32
Message-ID: <20190624101844.50e4c4ff@canb.auug.org.au>
In-Reply-To: <20190622174945.GA30317@amd>
References: <20190621110311.GF24145@amd>
        <20190621214657.1624e5a4@canb.auug.org.au>
        <20190622174945.GA30317@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Wb7ooV2y5t6ph2TKs7tq9B/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Wb7ooV2y5t6ph2TKs7tq9B/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Sat, 22 Jun 2019 19:49:45 +0200 Pavel Machek <pavel@ucw.cz> wrote:
>
> ld: fs/f2fs/gc.o: in function `f2fs_resize_fs':
> gc.c:(.text+0x3a91): undefined reference to `__umoddi3'
> ld: gc.c:(.text+0x3b70): undefined reference to `__udivdi3'
> make: *** [Makefile:1052: vmlinux] Error 1

This should be fixed in today's linux-next.

--=20
Cheers,
Stephen Rothwell

--Sig_/Wb7ooV2y5t6ph2TKs7tq9B/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0QF2QACgkQAVBC80lX
0GxbTAf/SO1zcjwMF8BYrgo+9HrcqV5Z1qaT8zq2nIV7DM38Jeqw9zrCreqkaeFN
JQR1BchCJKA9SFUQYGGjmK1A5+/EbMo03tYfumEjuS4QP18wObXnZuriMGxm+HuJ
ovFiNJmmMuKMaew2Wlao/aNRiHPnUBJGzuBlz+hTr7wDt6MQ90+8phmXa2TTCINL
lKc8qaqJt+kvCgUasD7y2ogtDBWixr9Gh6yKq7JCA8veoQhHlHFLLwO+ZDQVTKHU
in2ZkiDXNgQ95G4O5aAP76kn1/Uf0mpCFlKUy2Qm1EKNZ6EPdwohOpGAaWl2AEBU
RXL7tkY5OvIfuzarF0mPlp9fDTM0ZQ==
=GvQV
-----END PGP SIGNATURE-----

--Sig_/Wb7ooV2y5t6ph2TKs7tq9B/--
