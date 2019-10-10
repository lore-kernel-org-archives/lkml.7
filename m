Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8D0C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 11:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC1E208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 11:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gArhLL17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732894AbfJJLXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 07:23:38 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56819 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbfJJLXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 07:23:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46ppcL5t44z9sPL;
        Thu, 10 Oct 2019 22:23:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1570706615;
        bh=SKvuq9XCZSxjTmAESVOMU/T/c3K6J/ZB921ZjzgPyK8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gArhLL17y49ll02VycRXfx2H0amayp6lE4CpKDGv/uf94p+05FRR+ILB9oru1h2Ms
         l4o83nNWJQJO81H9oaTIKzA/rXVrlNh8v+pmOn63t/hhqOzuiWNnfApBX2vg6HOB1+
         Nca+/j/U9XmEf/f+e+CGncdo9MbPGVX5IVn37HQywUQaGfosqhJLwHbgq+wO6dd9Ly
         pgqLv/cGngabnX/dCr+iCXEVV50YU+jfLs36QGMhB0l106wCCWYiUW86euMM9ar1Zu
         2eUIRbuFMr/eb80KnXrhZKhk72I59fS8cmHFbLbu3rL859Jdt/Hjf51xt4AqCqfmAC
         G//cs8IN7Ar+g==
Date:   Thu, 10 Oct 2019 22:23:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>, Qian Cai <cai@lca.pw>
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <20191010222210.1365d50b@canb.auug.org.au>
In-Reply-To: <20191010080207.GA22099@gmail.com>
References: <20191010131448.482da2b2@canb.auug.org.au>
        <20191010080207.GA22099@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/R2lbok_WC7n/wPBSA32mK._";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/R2lbok_WC7n/wPBSA32mK._
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ingo,

On Thu, 10 Oct 2019 10:02:07 +0200 Ingo Molnar <mingo@kernel.org> wrote:
>
> I suspect -next will have to carry this semantic merge conflict=20
> resolution until the DRM tree is merged upstream.

Yep, its not a real problem, I get a few like this every cycle.

--=20
Cheers,
Stephen Rothwell

--Sig_/R2lbok_WC7n/wPBSA32mK._
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2fFKkACgkQAVBC80lX
0Gxk2Qf+O7qxMGH0AbcdDkqDOFIScBIa9xy0yrxppIhsVr6Q9Pv9EzY0BsJ4Dabh
diDN+NEj1/JMU22gVBUCHqoPjWcFHPGp83PZX8VEC2Sherq54a3ModGTkx7ydgTa
TV4x3ZJoRNGrjbEqaGwwRav8HrNu4cg3EMi6schpiSfyAX3CgQGD42s/ciOKDSUS
klcFr1/1ct579cXMmQS+CU0OKfGDmYKNSXFHGRe8o1IPXFFAT9HlRl4qp9RIq4PK
A6l3b4nhwoeJlkQq/nnOmmgTsYCCxmMAl6qfLiC3zXd4P7e3dQj/kYs2PMlrO8or
0MfJW72cLArYva06fCV/BrOyWNVIcQ==
=pG6L
-----END PGP SIGNATURE-----

--Sig_/R2lbok_WC7n/wPBSA32mK._--
