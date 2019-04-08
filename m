Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C0DC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E12320833
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="unTPajCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfDHVnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:43:37 -0400
Received: from ozlabs.org ([203.11.71.1]:46875 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727300AbfDHVne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:43:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44dP770mcmz9sR6;
        Tue,  9 Apr 2019 07:43:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554759811;
        bh=9xzjUSXGt7ADCgYz7gsriNNa7oF9NYyoYlh6kg7Rif8=;
        h=Date:From:To:Cc:Subject:From;
        b=unTPajCHPw/CxFiU0bdfbhsEGk3TiGr0GR2Mlr7iGh2uvtxx6EEehZ66ethxQHYi1
         JYLfHXdldrBqE0Pt9Ccp9eSGz9I2fLeyO7Q1G3hVSAlZoBsW65iCuGkyYgXpjvqXIG
         qOLIeQ6WJxjwznIlEbh/iFvBd7eIXxYNQzdU2zt5QgYcRDvvuyaqr58+wceDIYkTiE
         wX45GUhAo1AtJNLIaCdCUh5711f+g4d20BQ9aTHevLjFP0W0r5vK/GA8CocwhkEQl+
         p16djpbONXl+2843FgUCDk5/H3RrlRMrpoYYiLzHOU2dXnYnp9zTDWlDCxZKtBRnGV
         ry8K4eNSZRfpg==
Date:   Tue, 9 Apr 2019 07:43:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Murphy Zhou <jencce.kernel@gmail.com>
Subject: linux-next: Fixes tag needs some work in the nfsd tree
Message-ID: <20190409074329.26801b64@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9e/4N1PA4V9e9d4qymNxMLY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9e/4N1PA4V9e9d4qymNxMLY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  3c86794ac0e6 ("nfsd/nfsd3_proc_readdir: fix buffer count and page pointer=
s")

Fixes tag

  Fixes: f875a79 "nfsd: allow nfsv3 readdir request to be larger"

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").
  - Missing parentheses around the subject

--=20
Cheers,
Stephen Rothwell

--Sig_/9e/4N1PA4V9e9d4qymNxMLY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyrwIEACgkQAVBC80lX
0GwU0Qf9H6glBzH4VbccEdwi1wq4IHb9hE69dtBYsU2F6JgbiBOCrYWekKoAkCNu
Kn7XcXfKZhwmmtC+1JmgqkURf+BGCn+Fl3Gw4MSmpDEvQn2HP8cTC8dMD2P2AbKe
HngGZGtWlW58uDePlSybDMi5y+2Frqb/jsgjkOD3yKebD7Jfnsdnv/iGW+Eqs33e
3QODl2RFg1nG7DyX9nRiHiVNxs+Ih/DyNQ60Hq3bQzlT8iTc+Cpoq2AHYzTYB+Ug
a8t0J7WG+p9mbQJ9KaFwSXZbY8CuZYCEqyFokFiwmku7iRyqEElBxAjhfmkWp12n
65cGXcyy2Vab4m/T4rYGzREuVmK22g==
=DMCd
-----END PGP SIGNATURE-----

--Sig_/9e/4N1PA4V9e9d4qymNxMLY--
