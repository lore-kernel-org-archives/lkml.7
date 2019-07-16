Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB31C76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 04:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8EE720880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 04:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NZZw+mma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbfGPEyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 00:54:35 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46511 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfGPEyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 00:54:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45np3D1Sv8z9s8m;
        Tue, 16 Jul 2019 14:54:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563252873;
        bh=2XWH8qIY1CIIR3ml+Ox9a821mFuxSlD/1oeUNyofL5c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NZZw+mmaArU0ZuWgKvt2IGyKksQFDsE+vKnNAzl3keoAseDstJmRnJ3DGmq7I/Ly4
         SI59CGFZsU6tawjKHwYGrOFGDezEGATVHTF/DHiipDRGuex8ipdGuKRgaAN4x2AXzN
         nh3Gq4GAUceHRyxJDs5AuzrH96Vzyr/Ky2yO3FZL5cpJ2yCeB4eRyh+YodNnEHuaX6
         4rQcX7UsjE+h8F2HUPj9w6rO9LEIiFAH48kYohGVW1t81gM4ZXsCikgEj7guQ9jeRo
         z95+t6cSMYOxgfoChJB1nwOzQS/vZ6DLyBb2iHNn0k9y8drmIBz3Yy4vZvRVZsgKyf
         EPur1y72PZtZg==
Date:   Tue, 16 Jul 2019 14:54:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jon Mason <jdmason@kudzu.us>,
        NTB Mailing List <linux-ntb@googlegroups.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the ntb tree
Message-ID: <20190716145431.26da7a75@canb.auug.org.au>
In-Reply-To: <7ec45bb7-4e72-2415-21f7-44dadaa0fada@deltatee.com>
References: <20190716130341.03b02792@canb.auug.org.au>
        <7ec45bb7-4e72-2415-21f7-44dadaa0fada@deltatee.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6wNty9WHNNpLB=upKszJLxs"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6wNty9WHNNpLB=upKszJLxs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Logan,

On Mon, 15 Jul 2019 21:46:42 -0600 Logan Gunthorpe <logang@deltatee.com> wr=
ote:
>
> I renamed the ntb.c file to core.c so we could add more files to build
> ntb.ko. See [1].

But that was last changed in June, so I assume that some change to the
build system has caused this warning to be produced now.

--=20
Cheers,
Stephen Rothwell

--Sig_/6wNty9WHNNpLB=upKszJLxs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0tWIcACgkQAVBC80lX
0GzAEwf+Kilbh4hmWSH4gsjN7AcjrvhLIzGrDTEzWyIHM6XLba1XNBOHCMFgT2w1
v5eMjG03GH4nQikQO8eaYwAlsiDWM15thNUGqF/sld235ZCW/w17XIVbwXzrvsLF
ErvmrWyZEoArrEFy1Js6dMCDvbuUJQkKBLIDd+x13q/Cf8ZAzVsguXQN5hSbLq87
Wz2GWXNB53lyfV+NttjkdZj7W12H6df2IHqny3qe7OxGipbsNWFTIRHJkWI/xpsd
e9Ofh61XkKXgiHdQWlNZyHyk8iWMdLfMkl+x854+6CElPiniFRdfyjYACsC06YEn
Gjt5uvPhnEbjYyrBIOlTEIfADAvSgA==
=hXRI
-----END PGP SIGNATURE-----

--Sig_/6wNty9WHNNpLB=upKszJLxs--
