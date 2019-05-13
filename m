Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A651DC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB9720879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PrRpceaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfEMPFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:05:43 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53099 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbfEMPFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:05:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 452kdx20Rcz9s4Y;
        Tue, 14 May 2019 01:05:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557759941;
        bh=tqS4kzx2hydYJAX+s68gQPYezEl4dU/R2ruoPAnE1RM=;
        h=Date:From:To:Cc:Subject:From;
        b=PrRpceaI+SqwnzTdPU1p3SiLf0xOKmZMGz885BgBNW7PjKFabzPHMZPOQojs6eZPR
         PVdDEDsRa16DDQ7OpWbbzsEkwHAlc1FqaITIDlMt/HguHdemUqXkQjK3Vh3QdzFxis
         nBzuZ5HpV25MrJ0KzsY3v4HfcLR4fqtmgIgif9g4Gw1SnLpVe6S34Bv/tQvW1UMYve
         WyPUdnvcGJavoBaD4rypjWrPY/SXVQvzRIMMRlQDIOGGju55aPwS6kxxpCOE1CTDbx
         JKmZkaspjH054reLgtaujRxSzDJ0yImOoKEq39vizbNMwoSD5qlpxcDg+ZLr8oi5gZ
         zPuCxEFMUPYvA==
Date:   Tue, 14 May 2019 01:05:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the kselftest tree
Message-ID: <20190514010540.6fbe70e0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/42zB5IixV86pkMF=x7h5+V1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/42zB5IixV86pkMF=x7h5+V1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

In commit

  e64ee1f5dc1a ("selftests: fix bpf build/test workflow regression when KBU=
ILD_OUTPUT is set")

Fixes tag

  Fixes: commit 8ce72dc32578 ("selftests: fix headers_install circular depe=
ndency")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/42zB5IixV86pkMF=x7h5+V1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzZh8QACgkQAVBC80lX
0Gw33Af7BwLykcsFSxaJ4zhM0iYij121ix2a15JOsKMlKLJXEi8IGOd+8vw1CeWQ
z65oEGTieWwIqp0j4YAXiDeRTVKYRV3X0ndcl3zLLW7bz4dKGcK7SRzfrs+nSVOH
y+X/pHke+fQ63bful+d52Os3SSBdjslqq92AxtrJVqIKXkOnDxc2waZqqde/K8Jf
LjlQ7KZ7cMZtLZWq1ZAcWg4LZVMWO7yzhbmnjIWeji+weIwHTYQyBFsLXKwe3ZVz
UhIRDgfJ9WCUvaYai7VrT2jnxCAkxQ0YxKmZGhecfgSv5k04E8bxYQZF9qcnp9zD
5JKQvhknM9OCkD5sM94JmO+MRxrE2Q==
=SyBd
-----END PGP SIGNATURE-----

--Sig_/42zB5IixV86pkMF=x7h5+V1--
