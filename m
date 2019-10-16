Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912AEFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A92621848
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732449AbfJPPJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:09:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:51768 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727045AbfJPPJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:09:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A413B41A;
        Wed, 16 Oct 2019 15:09:32 +0000 (UTC)
Message-ID: <83c223c14c55aff1c8c9b30b0760c7e13c928209.camel@suse.de>
Subject: Re: [PATCH -next v3] arm64: mm: Fix unused variable warning in
 zone_sizes_init
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 16 Oct 2019 17:09:30 +0200
In-Reply-To: <20191016150846.GO49619@arrakis.emea.arm.com>
References: <20191016031107.30045-1-natechancellor@gmail.com>
         <20191016144713.23792-1-natechancellor@gmail.com>
         <20191016150846.GO49619@arrakis.emea.arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-pTKSzfeo3TsXii9om14o"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pTKSzfeo3TsXii9om14o
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-10-16 at 16:08 +0100, Catalin Marinas wrote:
> On Wed, Oct 16, 2019 at 07:47:14AM -0700, Nathan Chancellor wrote:
> > When building arm64 allnoconfig, CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32
> > get disabled so there is a warning about max_dma being unused.
> >=20
> > ../arch/arm64/mm/init.c:215:16: warning: unused variable 'max_dma'
> > [-Wunused-variable]
> >         unsigned long max_dma =3D min;
> >                       ^
> > 1 warning generated.
> >=20
> > Add __maybe_unused to make this clear to the compiler.
> >=20
> > Fixes: 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32")
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>=20
> Thanks. Queued on top of Nicolas' patches for 5.5. I also added Nicolas'
> reviewed-by from v2 as I suspect it still stands.

Yes, thanks!


--=-pTKSzfeo3TsXii9om14o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl2nMqoACgkQlfZmHno8
x/4Qowf+KTCudWRBpmrj4nqdjIh9c68rkqpBSsotdsFpXG/8fgt2MYgIFeKjdnnz
vGK0iAFugF2h6LLKPrx1cUakT9uKC1UeUdyJjGlgfk5dt70XRtsUg8hLQO/tpCCa
Kn9KtfenH9FZ7MgSOFvxVD4HeN5P65zdGGTPi9g0HFSdPdGiUuLBWKhN2p9RhJL9
d+pv7fBHFBWgOZSgeg+P6Kjeb1vlUoiLJXiLcs/5SmOzQTCILFOzGT47KUelDwCi
aE5VOr72KYslTJxxxsVew1ayl1sdlyhDXyryTBgi7rREPiGxGIxDdB/bBmG7L6KR
9++SMdguf4kZZqZ+Zed5EPkBKdai3w==
=oxCW
-----END PGP SIGNATURE-----

--=-pTKSzfeo3TsXii9om14o--

