Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C76FC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420D620643
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kedEkGgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbfDVV0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 17:26:39 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46071 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfDVV0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 17:26:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44p0576914z9s71;
        Tue, 23 Apr 2019 07:26:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555968396;
        bh=ze5jlR+b0FQ8nb+Jj7pswMzdJCwgqEhgs/mclfEV7Qc=;
        h=Date:From:To:Cc:Subject:From;
        b=kedEkGgKSN4Q7zqUo/pDvr2XDpIkoZnPB6EYitmMp4dIl1lzsSHH+3ZtzVAff+dTh
         1rTSD7IAwdtDTzlnzZdPF8GjYcQT1HLzo5iCvL6TsW2p9FjN9zAiITZTKoJHjxARJC
         ZRtL/2jOCjOuWjZeA9uIOyKfjleOQOkWd9K/iR4kl+M7zMJJjZvu6sEUikag4M0wxI
         wEwW3R4nh7cIMxMVJpe9PB+wktd82RVi1c7QL+oyaPGUjIwbq0aMmtbtnXNPGO1+12
         +PuxXmaNdTQsppGBqvl5uHZny+/ja2OQX/57p1fQyfBzc5yGeZNTM6l9KBV8I5ix/Y
         5IZ0g6OZdH0qg==
Date:   Tue, 23 Apr 2019 07:26:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hurley <john.hurley@netronome.com>
Subject: linux-next: Fixes tag needs some work in the net-next tree
Message-ID: <20190423072634.57cdf8b0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/tsgWxA3BKl85cM3aDU7WR=/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tsgWxA3BKl85cM3aDU7WR=/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  7d26c96052cd ("nfp: flower: fix size_t compile warning")

Fixes tag

  Fixes: a6156a6ab0f9 ("nfp: flower: handle merge hint messages")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: dbc2d68edc98 ("nfp: flower: handle merge hint messages")

--=20
Cheers,
Stephen Rothwell

--Sig_/tsgWxA3BKl85cM3aDU7WR=/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly+MYoACgkQAVBC80lX
0GyxBAf/fSvY50YswnL5EHL0gGOHrxiidhu5XHP+FRdqSUvNBz41wzTzhyTaokVV
TYcGJItf2n06jbyGMNhhA75NIIor8xaDbepJZ27rqimb4g1XMm/mTGnkfDGdBRR0
Fv0S/ApnkAKvtuztEmeJLaCq/BSwweU86VynVIhmdABhKmGo4ENyiNe2+v7b+nLT
U3nkoQCq/s/lKi9+dY+sTaUNlDiIXKk0gEcdnbAUcnmYCYtDtfRiMSmsGvnGewKN
oPcV5VOL7Li4xbMMCgrWwtXct1K/N6SK8xJ8EozBQAv3duQAqX5wxDRXjWMl0Zqu
/JzWU8KECIe/fUPZJXUaounXt9EFbQ==
=sIOX
-----END PGP SIGNATURE-----

--Sig_/tsgWxA3BKl85cM3aDU7WR=/--
