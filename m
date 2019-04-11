Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EB4C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD322184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eHV0RX9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfDKVNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:13:06 -0400
Received: from ozlabs.org ([203.11.71.1]:50899 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbfDKVNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:13:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44gDJb3wXsz9s47;
        Fri, 12 Apr 2019 07:13:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555017183;
        bh=MhHmtJNJaf+aPkU4Q+axvSu34vpYhvVe6WAN5fJqCjU=;
        h=Date:From:To:Cc:Subject:From;
        b=eHV0RX9SAX/SJGTXC6YLfnhijiXsJ7U+NW1Po/j4D7tcf+4gsY/Fj81pNH0HqeaPa
         6Ue1HJyWYRsKSq8WfYrSh7PXFLLEJMTgkK04kzw9kK4UNI6XBCukV6JvDV8KJ8Dxg3
         rg79GXhWPjRY6oAEqkmDwbsu7Do7QKmJPIZmi0p3LekRPbL9+iD7amunUt56FbHlwN
         gqCrfytm7IwhVXGlfS7IJj3ESlmmF3q/7INbA1SO7o2MPYPww7cLoD5nGO203bLE+F
         3YambPsjuA2fz05XY80LbM3c7ICgyTpUGbloo0D4nB47OAbd+gYVSKXXFtfxwizbfV
         0kvtaCJkePv7g==
Date:   Fri, 12 Apr 2019 07:12:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>
Subject: linux-next: Fixes tag needs some work in the net tree
Message-ID: <20190412071257.6938724c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UZUhTazmj94X+MvEKmN=W.h"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UZUhTazmj94X+MvEKmN=W.h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  8ef659f1a840 ("net/smc: fix return code from FLUSH command")

Fixes tag

  Fixes: a9d8b0b1e3d6 ("net/smc: add pnet table namespace support")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: 64e28b52c7a6 ("net/smc: add pnet table namespace support")

--=20
Cheers,
Stephen Rothwell

--Sig_/UZUhTazmj94X+MvEKmN=W.h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyvrdkACgkQAVBC80lX
0GxSiQf8DinySrDzTx9Ich9P/QxAn+gvzs+VRuXVnYI2tgPNPp7WyhcOyW1/BQ+g
lz/2L107TmrnZuGgryboNJP/Mvr2j1O4AbgeBfi1rnb8c535CaJaizd53EXSGeJK
jhgMhLwdioAy8GMrbnxE9Zrf7x/buT0VOdkeu4gHEn2VDV/5J5hwn1qQFtLVfqqs
yol6oUhHvUD1YlCDtT87prtArMJFYolQAeufXdcCS2LktG97j8VSukxNb08m46Eo
mt3H4IBG799Iyt+YgAYgQbH88fHwr4Ikk/CrdlwVo3VrHy7qkwyaBr6tCl259rJ2
lzPVIkIQeGLx8I6G7SSzo3HmZ4c9pg==
=4GTJ
-----END PGP SIGNATURE-----

--Sig_/UZUhTazmj94X+MvEKmN=W.h--
