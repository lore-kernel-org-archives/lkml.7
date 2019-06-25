Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C8AC48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F76520645
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fkb9QrRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfFYXdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 19:33:18 -0400
Received: from ozlabs.org ([203.11.71.1]:42747 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbfFYXdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 19:33:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45YMsl1ysYz9s3Z;
        Wed, 26 Jun 2019 09:33:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561505595;
        bh=y1eG32qua6PhqAiVuAO6P1kOZFtVSk/MwLtTyC8MGsE=;
        h=Date:From:To:Cc:Subject:From;
        b=fkb9QrRbj//LRsIu9lXOvOrUiRoYIiFQsZPa6pgCLWNYPOp2dnEXnEZPzUiUKGeqQ
         yimmxbMVdCiYo2XAR5lu+a6/w9HUk5dTFDcqNkZzC1LOqLsK15NS438bPUGUPOCUOi
         CfKRf6J+blJVUs33h22MPwYdkZOr8ll6+xnrOIruD7Q9ei5RcuQuvov+G+7z2xlCwy
         lGjyKbCEKAIw8X/jZ2mfpu56q/z+CjyRmO3lBPEyGey8DvQ1GlvgNZt5treR4xInI1
         /p4wDeaOtA5cKhV0Lpv15cBCjPEQSk5OfcJQAonYj9BGY8V3zZLnbn4LRafRRN+Xm8
         zOeRcedZyjTGg==
Date:   Wed, 26 Jun 2019 09:32:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the tip tree
Message-ID: <20190626093250.5c7cc243@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_cU8wxQxL6QxmCi4sLWZT8C"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_cU8wxQxL6QxmCi4sLWZT8C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  53d87b37a2a4 ("arm64: compat: No need for pre-ARMv7 barriers on an ARMv8 =
system")
  b4b12aca00d5 ("arm64: vdso: Remove unnecessary asm-offsets.c definitions")
  4d33ebb02c45 ("vdso: Remove superfluous #ifdef __KERNEL__ in vdso/datapag=
e.h")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/_cU8wxQxL6QxmCi4sLWZT8C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0SryIACgkQAVBC80lX
0GzxMQf/eUQTd1yP/D/HkdDSZaDGjSCXKjoIYk2l85WVbYglhdqFQgI7hjhCHKNT
tQb2pZSFVQR22LTrk0ijvbo6s2bvc5rO6aBm2GQI/Wrp99PcTIEga07ZEwlcpddt
QR0Re+b9Bf2RxquSBVh4KgdvdOKaZF9N17gKJRys9wIyyklAVXkvDtkyeEIkvdS3
yNzd/eVKNya+v8JSdBmz/0WRsI0DaGj1IWDqBWU6eJZFD+cSliVdsduA6oQB3xsi
jTn5wuW98xJDygXHWS/PxyEPQwN5+roQ1vgeQ5AOnnr4BkTd9xxOAaL22U8IQ7gk
wEfrU7r5INEvlRvXYPKESM/DjwBPLA==
=M3K1
-----END PGP SIGNATURE-----

--Sig_/_cU8wxQxL6QxmCi4sLWZT8C--
