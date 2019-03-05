Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8DDC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CED20675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rapqTwKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfCEVg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:36:56 -0500
Received: from ozlabs.org ([203.11.71.1]:40341 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfCEVgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 16:36:55 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44DVb91z6pz9sBF;
        Wed,  6 Mar 2019 08:36:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551821813;
        bh=MTBGuORnKbmGMDj7OZUQ9GPFGkgs7/K2y35EZwqI79A=;
        h=Date:From:To:Cc:Subject:From;
        b=rapqTwKBvtjlxuYRx3fxQsQGo7RqSCojL5GrLoEqJxB6KbSS3/D4uuFW4NqK2Z8Bw
         zsAmlcxYWHVC1ZzklAWOxdF814Df/Tj67UKSMKvnETfcDqq5h3PwgXv9Yw5JTUhwH8
         YX0hgF4amSWj9xGaY8r1wxeMG+aAnC3Gi+WeOarYvzYGNVy/ETdDLKfC/uJxrxeYdc
         q1doDymaLCKf/ORUlJVa0Inlc/yU8WVtbaQBKY+UPO5XyNXH8bxwsl287mSIwgz/LM
         L3HzEPyAZPmp7nS3jyQmDyMEaLovUqW+0m9TxKKtt6W3r2MaeSLHSl/iBCfVRE95tx
         doHxRQWLNiE9A==
Date:   Wed, 6 Mar 2019 08:36:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: linux-next: manual merge of the dma-mapping tree with Linus' tree
Message-ID: <20190306083651.6670648b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/v1vOyBJJA5R=Tdj5kr6T=qm"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/v1vOyBJJA5R=Tdj5kr6T=qm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the dma-mapping tree got a conflict in:

  arch/x86/Kconfig

between commit:

  eac616557050 ("x86: Deprecate a.out support")

from Linus' tree and commit:

  ff4c25f26a71 ("dma-mapping: improve selection of dma_declare_coherent ava=
ilability")

from the dma-mapping tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/Kconfig
index ade12ec4224b,0e33dede053e..000000000000
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@@ -14,7 -14,7 +14,6 @@@ config X86_3
  	select ARCH_WANT_IPC_PARSE_VERSION
  	select CLKSRC_I8253
  	select CLONE_BACKWARDS
- 	select HAVE_GENERIC_DMA_COHERENT
 -	select HAVE_AOUT
  	select MODULES_USE_ELF_REL
  	select OLD_SIGACTION
 =20

--Sig_/v1vOyBJJA5R=Tdj5kr6T=qm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx+6/MACgkQAVBC80lX
0Gy0sQf/f1qIoI2QcYN8Ng9uTeCpY6cuhwm5vWZjfG4kFyW1Mwc5LCsWdBukj7PS
/3IRuIvhb4wm1RgEmLo/sL0P+LJIi2vDMFigiUpu+3wq9CGMPxTUjDMMtXWT6xuZ
6cSpZBZ2vo8p0bKug8l7QRppPg0jxUOKQ3XixTc91VdPINBhweDPtP8pfTOsiYxt
r6lBrJvZJaeX3nFdReiLG2ZF8ejrpMiktiLx17BAPvBlXrZUItynsvgHmdjZu5Ca
Lw6xyrwGfQp2GTJm7vDaPEERJyCRBY0kZ8t4npDozSpYG74BxSVSVMhJQu4FLF4f
6p8iITEM3zwD7t1dNluQ5XTX64ylsA==
=FeMr
-----END PGP SIGNATURE-----

--Sig_/v1vOyBJJA5R=Tdj5kr6T=qm--
