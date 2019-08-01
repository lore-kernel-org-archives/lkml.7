Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F1CC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60C9206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="P5U10DY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbfHAGjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 02:39:52 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40065 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfHAGjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:39:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45zgdK2v0cz9sNf;
        Thu,  1 Aug 2019 16:39:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564641589;
        bh=rOSJAfU1wXnYm8NVYz2R7oA6F020iwGkyVXHzPWR894=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P5U10DY4ohbE1nG9sJTUSrcEnkOrugtJZBB9lGP1PHT7t65lYxqHSMD9v0wVUOza2
         WPRW83apbxcUn23iy1Wr18TN1xngEefkB86fI1oUGDCUc48Rw6e7ejBLT/Ic4KqnaI
         wKVslK8H07HRqPDuVXI6YidlJQiQJFrQ6I3ySo/B12iO5QLYGYK6RXB/SV449GAG+k
         kgX4/9pVe6uy7mYEzbGO2r5lVOmU3DL9yM7yILDUYV3lrlZLM0UryiZHPIUmjT89rJ
         SK3eYN7aNLLcXwuRcQGWpYoSN44paLzDlXrhfGewZTyMrc4MNU/Ptff+7A43KryrYA
         rjvZsWOQeJ/VA==
Date:   Thu, 1 Aug 2019 16:39:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qian Cai <cai@lca.pw>
Subject: Re: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20190801163948.7c869a34@canb.auug.org.au>
In-Reply-To: <1564641003.25219.7.camel@mtkswgap22>
References: <20190731161151.26ef081e@canb.auug.org.au>
        <1564554484.28000.3.camel@mtkswgap22>
        <20190801155130.29a07b1b@canb.auug.org.au>
        <20190801061527.GB11627@dhcp22.suse.cz>
        <1564641003.25219.7.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FmbzQ19EXZAy_89KnZKET1R";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FmbzQ19EXZAy_89KnZKET1R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Miles,

On Thu, 1 Aug 2019 14:30:03 +0800 Miles Chen <miles.chen@mediatek.com> wrot=
e:
>
> It's the first time that I receive a build warning after the patch has
> been merged to -mm tree. The build warning had been fixed by Qian,
> should I send another change for this?

No, that will do.

--=20
Cheers,
Stephen Rothwell

--Sig_/FmbzQ19EXZAy_89KnZKET1R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1CiTQACgkQAVBC80lX
0GzrZAf+PAXK3DBKf3Xwfy9ytM9ikQJhvS5DtkN0xU+R/RS+bZ81t3iyFWHA+iRR
+e+8lM1UHqDydcZJ22f1KkCY2/NxfvlwGfPpuzGSsnRkcJWz6HyrNPJCA30U9sx3
Qx3y8vr+CAlVjLM3BtoGPbqNPqc6hxNAio+Q4/UT5eMDaTmpspgSVIXtRazWE1uu
GWJwwi8nBCQON/RfiWCcbdLOTToeiEw0AC31LqLcLmy9xrSuRZyZaPU+2GbcxL/d
PbEPoEk8JBFvRostEp/DW7jgTrPsWhCz34tTmBkl3vgOeK9soyllqxq2jFWK/rQO
8hQu2ayfIlsE9ANEjVhBpf0nakLbHQ==
=7q1y
-----END PGP SIGNATURE-----

--Sig_/FmbzQ19EXZAy_89KnZKET1R--
