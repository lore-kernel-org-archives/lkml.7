Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9475EC48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B14208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OoC58Dqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfFULgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:36:21 -0400
Received: from ozlabs.org ([203.11.71.1]:55225 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbfFULgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:36:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Vc8K1P0hz9s4V;
        Fri, 21 Jun 2019 21:36:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561116977;
        bh=RWgnn7Lb1JqkFjRW1o/uVxPqTSzJKyIqEsKU61sD/Q0=;
        h=Date:From:To:Cc:Subject:From;
        b=OoC58DqfcJJui/c9WWL4N6Ep8QeGs94NOeaiDFZvfCIJgCsAVbS1g0tq88y+PmU8H
         dJJEnMKiFmB+WmgyrePLxaxLc4gbpPcyQ7kmwXdTZr0jfPoo7tZHw5DxOgosc/gauU
         eZEfmDIKSE2PpHCHlhBZCmuFVQpBNKZPXo6hL1rfKRGJ6HVWNwmnftQBCFUOpXxIa1
         v1ItdiB4HG/Buwdh+E++xmwVekvpgflqBko5DwV7bYyWjePXzD17s4vsYIMYneJBUz
         jk6X8T/8ehutuoXsDD0WsGgmlugZClBetJ+MFUxI1+nzAEEgjBh8sqTBTnUTTpAyXb
         UYngtjiaNjGLw==
Date:   Fri, 21 Jun 2019 21:36:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Julien Thierry <julien.thierry@arm.com>
Subject: linux-next: Fixes tags need some work in the arm64 tree
Message-ID: <20190621213615.0efd4fa4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/onyy20gn3_Y2vXJ__k78oe9"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/onyy20gn3_Y2vXJ__k78oe9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  86fc32fee888 ("arm64: Fix incorrect irqflag restore for priority masking")

Fixes tag

  Fixes: commit 4a503217ce37 ("arm64: irqflags: Use ICC_PMR_EL1 for interru=
pt masking")

has these problem(s):

  - leading word 'commit' unexpected

In commit

  1500e8ca63f4 ("arm64: Fix interrupt tracing in the presence of NMIs")

Fixes tag

  Fixes: bc3c03ccb ("arm64: Enable the support of pseudo-NMIs")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

In commit

  4a4063a9fbfa ("arm64: irqflags: Add condition flags to inline asm clobber=
 list")

Fixes tag

  Fixes: commit 4a503217ce37 ("arm64: irqflags: Use ICC_PMR_EL1 for interru=
pt masking")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/onyy20gn3_Y2vXJ__k78oe9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0MwS8ACgkQAVBC80lX
0GxN/Af7BDqDnNFzp8CZmjoOEjYQTpYE6DCNdhep4jEU6tdfjTQpJhk/Wqhv1gov
naWv82nvT1cemLtsHP1PGD5tbIAJingrNHYs0HrtchnWJWS9yBXiuvColNgnZt6e
RbbJOwomI8VWbd9WNEdm6hypbIs//ebNDHUErJWUA32v0Qm1ncOxTk72uJ3QQhsc
w5HIIgfTc66dmK31/Jb9WqRQzuv3YbP0S94bNk41M5z/2cdfemyrxn/Kz6weYyk1
LzNUxFKBClkOHxHfzAlxd+dgqU6Gy9laqjdAOfaeFr36Qk2BX0mlQPQOfsLiZaqN
loX3YGcNYyz01/KXv0NY7VKLq1K7ow==
=hQv/
-----END PGP SIGNATURE-----

--Sig_/onyy20gn3_Y2vXJ__k78oe9--
