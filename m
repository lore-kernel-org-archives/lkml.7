Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF97C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D2F233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="do7KSNX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfH2JSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 05:18:12 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33143 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfH2JSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 05:18:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46Jxq31mxpz9s4Y;
        Thu, 29 Aug 2019 19:18:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1567070288;
        bh=KAIwHO1y6ELSe8undG9p709vSkqOpU/LQP6LzzEF5q8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=do7KSNX1yVTsQFfBDzpn6NRtg5jYP10YZ3Jp5lBJqkM8olxDsQsD8sFEZl8ulCpCY
         D3nblWYDGK7cadcYbUzoWIlGPIPP5vDp94jUBxAok27SkbiBu8t8CieNYq/1n/wpf6
         5OmgvsckkCBiJu826GgkKYEj2CUlKrEiC/Rlgf4qQQnowKY8XgeXq7ApWchcEb5bLy
         ndbiw3NMhDFv50BFExEVI2n2jzabvbPeqJx1zgb8iKBUG93/QGjgbANapTqmBASDuR
         eAlgDWmLgMG9rWvXOMHP/Re6I9uxV9eUrgxWvaIcmwJB+dWz9XPetWwDvQ9uQTq0JO
         NaF1eBOfmWBRg==
Date:   Thu, 29 Aug 2019 19:18:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bandan Das <bsd@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the tip tree
Message-ID: <20190829191800.28cd34c2@canb.auug.org.au>
In-Reply-To: <jpgwoewnzra.fsf@linux.bootlegged.copy>
References: <20190829080633.07c7a422@canb.auug.org.au>
        <jpgwoewnzra.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nUfsEhJhRKB3HXl5Y4kgmEs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nUfsEhJhRKB3HXl5Y4kgmEs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bandan,

On Thu, 29 Aug 2019 04:26:33 -0400 Bandan Das <bsd@redhat.com> wrote:
>
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
>=20
> > In commit
> >
> >   bae3a8d3308e ("x86/apic: Do not initialize LDR and DFR for bigsmp")
> >
> > Fixes tag
> >
> >   Fixes: db7b9e9f26b8 ("[PATCH] Clustered APIC setup for >8 CPU systems=
")
> >
> > has these problem(s):
> >
> >   - Target SHA1 does not exist
> > =20
>=20
> I tried to dig this up and I believe that this is from pre-git.
> I went back as far as commit 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
> Author: Linus Torvalds <torvalds@ppc970.osdl.org>
> Date:   Sat Apr 16 15:20:36 2005 -0700
>=20
>     Linux-2.6.12-rc2
>    =20
>     Initial git repository build. I'm not bothering with the full history,
>     even though we have it. We can create a separate "historical" git
>     archive of that later if we want to, and in the meantime it's about
>     3.2GB when imported into git - space that would just make the early
>     git days unnecessarily complicated, when we don't have a lot of good
>     infrastructure for it.
>    =20
>     Let it rip!
>=20
> which adds init_apic_ldr() in include/asm-i386/mach-bigsmp/mach_apic.h wi=
th
> the following:
>=20
> +static inline void init_apic_ldr(void)
> +{
> +       unsigned long val;
> +
> +       apic_write_around(APIC_DFR, APIC_DFR_VALUE);
> +       val =3D apic_read(APIC_LDR) & ~APIC_LDR_MASK;
> +       val =3D calculate_ldr(val);
> +       apic_write_around(APIC_LDR, val);
> +}
> ...
>=20
>=20
> So, the bug seems to be present here as well...

Ah ha!

commit db7b9e9f26b8 ("[PATCH] Clustered APIC setup for >8 CPU systems")
is from Thomas' history git tree ...  I should have read more of the
commit message :-(  Sorry for the noise.

--=20
Cheers,
Stephen Rothwell

--Sig_/nUfsEhJhRKB3HXl5Y4kgmEs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1nmEgACgkQAVBC80lX
0GxxSQf/esmj39P5SVTIqrCg5vFAtZSW+yvsY/+aXlL/KgpjzcYb+QoHdtOpggez
82a6eTmnyc2GbO0qq4YdoHULwQ1enK6W4J2ftEX3k9ougLC5ZbD2y98yFdrzUWQv
OISKd8JWMlMaMKV97GX3NoDl/qm+A3zRxrK2lqy4ptHTGY6DswEa67Q9h9L49h8k
fNoRH0EdAodf0wxFGk5MEkokkqxfItoE+Axp5fMw+QGpfVWPWsiAObP+ENmdD4iy
2Cxq4e9cjlmrStiFiQZEu2pXLBkzz+ln+yl4hDywvHjXaOXv4i9/vfx5kF+/4z3L
eG7rgD9Oa5qdAhOlZ4k8RKHY8Msmew==
=mSCw
-----END PGP SIGNATURE-----

--Sig_/nUfsEhJhRKB3HXl5Y4kgmEs--
