Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CCCC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BF1233A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="N+huXPqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfH1WGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:06:39 -0400
Received: from ozlabs.org ([203.11.71.1]:57203 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbfH1WGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:06:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46JfwC0X4qz9sMr;
        Thu, 29 Aug 2019 08:06:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1567029997;
        bh=PTTFXV1q8UF5UNG1JCDCm6SA8sLX3LbSw0/ECbtcDdM=;
        h=Date:From:To:Cc:Subject:From;
        b=N+huXPqMqqG7I5uO7l9j2DWPXshWrM362tAujQft2NpuG5e9U5w54XYyrfMiwycka
         yLR8aYvve/YIdguMvs4xDU/Qlar/6pLUs0T+VuQzbjd5M1TBuhqy3CWncdnaD5foVu
         3K1eca3SE/dlEU4J2OVYRgbdcKUHJQZNpE0FxivyxcO1QeaBVQphOcHT3jdlp/efvq
         LcPyi0ez7W2f3OjOfRdtIMsxna4zaAkmCxJ8IFUdSoyMhAixdTtZ46QfUaO08cnYyN
         IrLUpxfEPhoCgYhapoRr5kG62RYNjEcqoW1nPDc14sgUoolhWrcPO+Vqo+KX+LFbGB
         cGYqQGWABWiOQ==
Date:   Thu, 29 Aug 2019 08:06:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bandan Das <bsd@redhat.com>
Subject: linux-next: Fixes tag needs some work in the tip tree
Message-ID: <20190829080633.07c7a422@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zoEpqVYIPki7=lLLI8vgyUT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zoEpqVYIPki7=lLLI8vgyUT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  bae3a8d3308e ("x86/apic: Do not initialize LDR and DFR for bigsmp")

Fixes tag

  Fixes: db7b9e9f26b8 ("[PATCH] Clustered APIC setup for >8 CPU systems")

has these problem(s):

  - Target SHA1 does not exist

I could not quickly find an obvious match.

--=20
Cheers,
Stephen Rothwell

--Sig_/zoEpqVYIPki7=lLLI8vgyUT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1m+ukACgkQAVBC80lX
0GwVvQf/bzc1pRdnrmRabdGa59x9DXi8fGvhNmsXeh1P6/pzg9txVInrxMTeo3W+
Gr36Qw7lJ3JqoztUM37lhcSeqmwRvXv2U4kcwOdOleXKkbf+BhGj/lAbZ91FWWVG
iQ4lQ3QAOdV1JbjhLRd5S8X0XsHyQr5vz32dzJLm75/dS6TsyfeDvA+d5oszE1F5
BxDepB+HuWEd0hbEM8kqmW7dAXLz1RKhdRNXvv3XcePXEAy4d75cI1bUDYtRBn1w
jKf4sB253urLCTF0xgJiZ+d65EsPSX0HnCWaUPMxQ9QEihDMAU6HCw92xhSQSUnI
d20F8FCqSN3nZ9DtdlT/gnh85MN49g==
=y/zS
-----END PGP SIGNATURE-----

--Sig_/zoEpqVYIPki7=lLLI8vgyUT--
