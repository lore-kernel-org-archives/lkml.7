Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C32C04AA8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE93B20866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VE8QSTtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfEAVpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 17:45:25 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54131 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfEAVpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 17:45:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44vX4d50ZSz9s9y;
        Thu,  2 May 2019 07:45:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556747121;
        bh=Bsw32OJ7r12VV192rzOnvs7PeeB1/zzU5dXXeD713Tg=;
        h=Date:From:To:Cc:Subject:From;
        b=VE8QSTtLwo11z1uTHWtHAsG17Q2avaxfn/NPETopH2DBAv8y6dJEQNcbITcUqQ9aH
         hO2w9K25fsNiA8qRt09J9MZIFW0YhFtjDv+rPo6vTOY/r4ogRpMWPWDWlhynH8a+gu
         0Q023GnGpB603n7a/f6Vihl7nmzT1e9OR7OHQmO1xEiqeAztwR/p8hsuFPqQKKaSLf
         2AYiFE0EoNIIc9ZjtRugM/T1F3+5upCxqFWrXvOYgPaw416j0eRBi87NcbLcgZKAhC
         c66Eesli0HSKUWMTAG37NGfiKuGUE91Je41yK5pNKN6yWu140Ek9ztUjKF66m19VRx
         K3zmjfGCZaihw==
Date:   Thu, 2 May 2019 07:45:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the parisc-hd tree
Message-ID: <20190502074519.61272b42@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UxZFVieJsY9lj86GqzTCcoc"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UxZFVieJsY9lj86GqzTCcoc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  2b731a920986 ("parisc: Update huge TLB page support to use per-pagetable =
spinlock")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/UxZFVieJsY9lj86GqzTCcoc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzKE28ACgkQAVBC80lX
0GxRxwf8DHQTsHKRnH90QXbQDqi1m+thimy1aXVksY17/7RdZZU/tR8JSJ8yX1uc
pEimJuBWfIbwieTRDx4wXHtehGKB39hK3WwxL7hfmWwR5nOK0iDgjA1MCD3c0K36
USoqsNHAKuh971K0kG2i73sdVdlaur199k+VfjFL+4tX8hG4YrylluxjJAUgMjFU
OB3X5dcMWyxuYrK6KX9WQkj1dvVR1YgF7ZMMnS/8XnP8retWcpcap0ZjKh9L/5Yf
CHWYIST/jlNgrEDRZceSH5jwmyb6h5EzBFpjFhtqmRJHsva0yYoM+OZB5Fs+uLvQ
ruDSMPCnBKSsnzYoTU+xO1lozVUk6g==
=+BOR
-----END PGP SIGNATURE-----

--Sig_/UxZFVieJsY9lj86GqzTCcoc--
