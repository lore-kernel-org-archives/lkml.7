Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EE8C606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F892166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Tl5JdZFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfGIAMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 20:12:51 -0400
Received: from ozlabs.org ([203.11.71.1]:36599 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfGIAMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 20:12:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jN7M0SmXz9sMr;
        Tue,  9 Jul 2019 10:12:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562631167;
        bh=ZZTfzyE+cPSzGQoUXg5UJzRqYPFv9U0TKErOUGeuwR4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tl5JdZFHIssf7gy7XtbC3OQR3jYjORX/KmKkpXxjxt/nuJflDHy35m6d1wVbSvjEO
         XTsVAOIK5TSJjuibOF9g/iyK69hwEZUeKn+W03VkWnzjrXYml06MzQ+hYagvkeQbi4
         cYULcs3kBvgBlmAYWTlOQ1sxRZj9bqX050e5eh4DvMsqb5LRAB+RqQ3baijdUl7uAb
         xj2UXGOwhWpGn9QvjvvXHlx+PzFHxuW2kCuMmV6NqNykGulnODp/IlV3ttjBVio/x4
         nTrWJ8cPXwnmdZQq08+VhXgmcg6LvwsN96PpzDIM3aX9zft1owPCbC1443UOpap/7i
         4WbjTR6V0BcAA==
Date:   Tue, 9 Jul 2019 10:12:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Russell King <rmk@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: linux-next: manual merge of the samsung-krzk tree with the arm
 tree
Message-ID: <20190709101246.58e21f1b@canb.auug.org.au>
In-Reply-To: <20190628091634.12fdc79c@canb.auug.org.au>
References: <20190621093347.36987c97@canb.auug.org.au>
        <20190628091634.12fdc79c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/PtdDwAOn==6Zouw31bhux/y"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PtdDwAOn==6Zouw31bhux/y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 28 Jun 2019 09:16:34 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> On Fri, 21 Jun 2019 09:33:47 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >=20
> > Today's linux-next merge of the samsung-krzk tree got a conflict in:
> >=20
> >   arch/arm/configs/exynos_defconfig
> >=20
> > between commit:
> >=20
> >   5f41f9198f29 ("ARM: 8864/1: Add workaround for I-Cache line size mism=
atch between CPU cores")
> >=20
> > from the arm tree and commit:
> >=20
> >   9f532d26c75c ("ARM: exynos_defconfig: Trim and reorganize with savede=
fconfig")
> >=20
> > from the samsung-krzk tree.
> >=20
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> >=20
> > diff --cc arch/arm/configs/exynos_defconfig
> > index 9b959afaaa12,f140532ddca7..000000000000
> > --- a/arch/arm/configs/exynos_defconfig
> > +++ b/arch/arm/configs/exynos_defconfig
> > @@@ -4,12 -5,7 +5,8 @@@ CONFIG_PREEMPT=3D
> >   CONFIG_CGROUPS=3Dy
> >   CONFIG_BLK_DEV_INITRD=3Dy
> >   CONFIG_PERF_EVENTS=3Dy
> > - CONFIG_MODULES=3Dy
> > - CONFIG_MODULE_UNLOAD=3Dy
> > - CONFIG_PARTITION_ADVANCED=3Dy
> >   CONFIG_ARCH_EXYNOS=3Dy
> > - CONFIG_ARCH_EXYNOS3=3Dy
> >  +CONFIG_CPU_ICACHE_MISMATCH_WORKAROUND=3Dy
> >   CONFIG_SMP=3Dy
> >   CONFIG_BIG_LITTLE=3Dy
> >   CONFIG_NR_CPUS=3D8 =20
>=20
> This is now a conflict between the arm-soc tree and the arm tree.

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/PtdDwAOn==6Zouw31bhux/y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0j2/4ACgkQAVBC80lX
0Gxq2Af+NocXoSKFdoIZF8ymYFO5+3MxUg8UPU5uW6n2MYaU0roKS1N6qvR8y8Vq
rKEQOt8KM25xJ6oV4mBFEh9pBqflepsh+Ps6yZFFYsEcofkD7yey2oGBSaJ77pJ/
aT/3JTHoDA16s9TTRzFkdvm13T43rOhpvAyAABv2fG7Qg8lRp/a8BjL41Qs1KUmM
BeT+DfjcxGDMctuYYS+wZupifjv09/klGKKNC6yBcXAb1RLsjhFEdCDl35Wk4+8B
VJFwSQMw8syqwM3mdxivq+EzgQVaTZS04NQuHLgmdTluhNqGB50JABUi7TsE4io7
RnILUrTrX4HtXSY+5BLIAicPg2Zs+Q==
=TaxR
-----END PGP SIGNATURE-----

--Sig_/PtdDwAOn==6Zouw31bhux/y--
