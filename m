Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCFDC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B87F25EFF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MwFQC0UI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389169AbfE3Eze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:55:34 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48881 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389159AbfE3Ez2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 00:55:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45DwHy1HfMz9s5c;
        Thu, 30 May 2019 14:55:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559192126;
        bh=u6qX2YcuuXUCj/6CtLWX3CJivrXavFG+g3vTC3MYfAc=;
        h=Date:From:To:Cc:Subject:From;
        b=MwFQC0UI8ucaEuuFqT5vif7bsig8REJxHLJjTwdpysfmXDzHBsd+c90jQQ9Eeu3xj
         mJCgs3itT/0eovrlyNSDloRzfbglDsAJCSOqJCFo1vAmAHtlmFWizmY0j3ft8sW+Vz
         CDqY54mnIT5cucBWn8DtEfK12V+vo5KkHLk0AlXNe/SwGPj/d6BcpvBMDhxi/9YQqW
         DCkSyR9DPw3U/CYlPmyYdatHaJQpiDQFxtODblzgk4UUWctpnROXOk/CoyDMj8ILiv
         jl1N814XoOGvgsd4K3CSiHrGWM7zJraRNlXHseqXzXMLA5ZuPqE7K9Ep6PkM5a6BwA
         tYfg6n6xDcefA==
Date:   Thu, 30 May 2019 14:55:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matteo Croce <mcroce@redhat.com>
Subject: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20190530145525.3cca17cb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8aSEcKm1n18JLWopbjCv0hG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8aSEcKm1n18JLWopbjCv0hG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

net/tipc/sysctl.c:42:12: warning: 'one' defined but not used [-Wunused-vari=
able]
 static int one =3D 1;
            ^~~
net/tipc/sysctl.c:41:12: warning: 'zero' defined but not used [-Wunused-var=
iable]
 static int zero;
            ^~~~

Introduced by commit

  6a33853c5773 ("proc/sysctl: add shared variables for range check")

--=20
Cheers,
Stephen Rothwell

--Sig_/8aSEcKm1n18JLWopbjCv0hG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzvYj0ACgkQAVBC80lX
0GwB6wgAmmW1oDLUmcW6Jc2Q79FQC0TF/nrsmwrnrFajk64ae3ZfZYJpfRZn++9p
QyqqPNyEIKbIeFEZ2TG30LPZ6NgKStitxF4MhgnUr25NEmp1WjoCbniZhxNy4YG/
7VezifgRRiWkaTEHWutSDvdyiq3y6lR9K6flYYr2oQhpCnvqlAWLVyn6gJNTh9Vu
boELoEuJsePyiayxjK/Hryp4QW2b2QVMlU3uooueo7mVRUsxzeNd/nwiEgLFmmEO
e/3rDYA8yhCNKSy2zWw+40bSjpVY5MTm0moLBOM9Gnw4aTZcVyPtG+Pq4fpnED+T
w8ClR4AEddix/9uKLHAAw4mDvuSQFA==
=kH6a
-----END PGP SIGNATURE-----

--Sig_/8aSEcKm1n18JLWopbjCv0hG--
