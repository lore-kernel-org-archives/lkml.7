Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7FEC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9276B20870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MQcMA9gv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbfCaW7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 18:59:37 -0400
Received: from ozlabs.org ([203.11.71.1]:34037 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731347AbfCaW7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 18:59:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44XWBV1GYkz9sSK;
        Mon,  1 Apr 2019 09:59:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554073172;
        bh=rJc2UWgFrmi987vzf+BxRr6mbPa5b/ruGPnRYFQhzog=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MQcMA9gvp2k76p9ZZf5KtOo/lE6kJV9Uu3Frol99/k2VQdHrX8/X6hiHt/bpzYpjb
         s/UA+Na+2hsY/+n15sK/l4wbB8d+9SNQpVuqHb1UBWRUXN46Ae+c/gxk1wXvJX74Do
         ApHwWgDeZsMJV4QaGZanYMQf+dbJNOdG/pewyHowOKEQW5iwCsXKqrlZzqfkYbRkK6
         nS/51ACpz6NsPdUtJpe0uyRx2HOGC+RO2F6O/9ldzc8T1LqTHCW16VU0PJNBIAtD4r
         z1eUqFQNPKmv7t0ae2jYwubuv45w5A6ON0bmR1CuNYn7kbsCl3mE2IQOxaYaAUj+fX
         Iea1vMdzXWdgA==
Date:   Mon, 1 Apr 2019 09:59:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     DRI <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin Xu <colin.xu@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: linux-next: manual merge of the drm-intel tree with the
 drm-intel-fixes tree
Message-ID: <20190401095929.4be4e6a7@canb.auug.org.au>
In-Reply-To: <20190322105728.28622f5d@canb.auug.org.au>
References: <20190322105728.28622f5d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/..F.gZRT39f26oBmSCHPBJe"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/..F.gZRT39f26oBmSCHPBJe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

This is now a conflict between the drm tree and Linus' tree.

On Fri, 22 Mar 2019 10:57:28 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the drm-intel tree got a conflict in:
>=20
>   drivers/gpu/drm/i915/gvt/mmio_context.c
>=20
> between commit:
>=20
>   1e8b15a1988e ("drm/i915/gvt: Add in context mmio 0x20D8 to gen9 mmio li=
st")
>=20
> from the drm-intel-fixes tree and commit:
>=20
>   8a68d464366e ("drm/i915: Store the BIT(engine->id) as the engine's mask=
")
>=20
> from the drm-intel tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc drivers/gpu/drm/i915/gvt/mmio_context.c
> index 7902fb162d09,a00a807a1d55..000000000000
> --- a/drivers/gpu/drm/i915/gvt/mmio_context.c
> +++ b/drivers/gpu/drm/i915/gvt/mmio_context.c
> @@@ -73,71 -73,70 +73,71 @@@ static struct engine_mmio gen8_engine_m
>   };
>  =20
>   static struct engine_mmio gen9_engine_mmio_list[] __cacheline_aligned =
=3D {
> - 	{RCS, GFX_MODE_GEN7, 0xffff, false}, /* 0x229c */
> - 	{RCS, GEN9_CTX_PREEMPT_REG, 0x0, false}, /* 0x2248 */
> - 	{RCS, HWSTAM, 0x0, false}, /* 0x2098 */
> - 	{RCS, INSTPM, 0xffff, true}, /* 0x20c0 */
> - 	{RCS, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 0), 0, false}, /* 0x24d0=
 */
> - 	{RCS, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 1), 0, false}, /* 0x24d4=
 */
> - 	{RCS, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 2), 0, false}, /* 0x24d8=
 */
> - 	{RCS, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 3), 0, false}, /* 0x24dc=
 */
> - 	{RCS, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 4), 0, false}, /* 0x24e0=
 */
> - 	{RCS, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 5), 0, false}, /* 0x24e4=
 */
> - 	{RCS, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 6), 0, false}, /* 0x24e8=
 */
> - 	{RCS, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 7), 0, false}, /* 0x24ec=
 */
> - 	{RCS, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 8), 0, false}, /* 0x24f0=
 */
> - 	{RCS, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 9), 0, false}, /* 0x24f4=
 */
> - 	{RCS, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 10), 0, false}, /* 0x24f=
8 */
> - 	{RCS, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 11), 0, false}, /* 0x24f=
c */
> - 	{RCS, CACHE_MODE_1, 0xffff, true}, /* 0x7004 */
> - 	{RCS, GEN7_GT_MODE, 0xffff, true}, /* 0x7008 */
> - 	{RCS, CACHE_MODE_0_GEN7, 0xffff, true}, /* 0x7000 */
> - 	{RCS, GEN7_COMMON_SLICE_CHICKEN1, 0xffff, true}, /* 0x7010 */
> - 	{RCS, HDC_CHICKEN0, 0xffff, true}, /* 0x7300 */
> - 	{RCS, VF_GUARDBAND, 0xffff, true}, /* 0x83a4 */
> -=20
> - 	{RCS, GEN8_PRIVATE_PAT_LO, 0, false}, /* 0x40e0 */
> - 	{RCS, GEN8_PRIVATE_PAT_HI, 0, false}, /* 0x40e4 */
> - 	{RCS, GEN8_CS_CHICKEN1, 0xffff, true}, /* 0x2580 */
> - 	{RCS, COMMON_SLICE_CHICKEN2, 0xffff, true}, /* 0x7014 */
> - 	{RCS, GEN9_CS_DEBUG_MODE1, 0xffff, false}, /* 0x20ec */
> - 	{RCS, GEN8_L3SQCREG4, 0, false}, /* 0xb118 */
> - 	{RCS, GEN7_HALF_SLICE_CHICKEN1, 0xffff, true}, /* 0xe100 */
> - 	{RCS, HALF_SLICE_CHICKEN2, 0xffff, true}, /* 0xe180 */
> - 	{RCS, HALF_SLICE_CHICKEN3, 0xffff, true}, /* 0xe184 */
> - 	{RCS, GEN9_HALF_SLICE_CHICKEN5, 0xffff, true}, /* 0xe188 */
> - 	{RCS, GEN9_HALF_SLICE_CHICKEN7, 0xffff, true}, /* 0xe194 */
> - 	{RCS, GEN8_ROW_CHICKEN, 0xffff, true}, /* 0xe4f0 */
> - 	{RCS, TRVATTL3PTRDW(0), 0, false}, /* 0x4de0 */
> - 	{RCS, TRVATTL3PTRDW(1), 0, false}, /* 0x4de4 */
> - 	{RCS, TRNULLDETCT, 0, false}, /* 0x4de8 */
> - 	{RCS, TRINVTILEDETCT, 0, false}, /* 0x4dec */
> - 	{RCS, TRVADR, 0, false}, /* 0x4df0 */
> - 	{RCS, TRTTE, 0, false}, /* 0x4df4 */
> -=20
> - 	{BCS, RING_GFX_MODE(BLT_RING_BASE), 0xffff, false}, /* 0x2229c */
> - 	{BCS, RING_MI_MODE(BLT_RING_BASE), 0xffff, false}, /* 0x2209c */
> - 	{BCS, RING_INSTPM(BLT_RING_BASE), 0xffff, false}, /* 0x220c0 */
> - 	{BCS, RING_HWSTAM(BLT_RING_BASE), 0x0, false}, /* 0x22098 */
> - 	{BCS, RING_EXCC(BLT_RING_BASE), 0x0, false}, /* 0x22028 */
> -=20
> - 	{VCS2, RING_EXCC(GEN8_BSD2_RING_BASE), 0xffff, false}, /* 0x1c028 */
> -=20
> - 	{VECS, RING_EXCC(VEBOX_RING_BASE), 0xffff, false}, /* 0x1a028 */
> -=20
> - 	{RCS, GEN8_HDC_CHICKEN1, 0xffff, true}, /* 0x7304 */
> - 	{RCS, GEN9_CTX_PREEMPT_REG, 0x0, false}, /* 0x2248 */
> - 	{RCS, GEN7_UCGCTL4, 0x0, false}, /* 0x940c */
> - 	{RCS, GAMT_CHKN_BIT_REG, 0x0, false}, /* 0x4ab8 */
> -=20
> - 	{RCS, GEN9_GAMT_ECO_REG_RW_IA, 0x0, false}, /* 0x4ab0 */
> - 	{RCS, GEN9_CSFE_CHICKEN1_RCS, 0xffff, false}, /* 0x20d4 */
> - 	{RCS, _MMIO(0x20D8), 0xffff, true}, /* 0x20d8 */
> -=20
> - 	{RCS, GEN8_GARBCNTL, 0x0, false}, /* 0xb004 */
> - 	{RCS, GEN7_FF_THREAD_MODE, 0x0, false}, /* 0x20a0 */
> - 	{RCS, FF_SLICE_CS_CHICKEN2, 0xffff, false}, /* 0x20e4 */
> - 	{RCS, INVALID_MMIO_REG, 0, false } /* Terminated */
> + 	{RCS0, GFX_MODE_GEN7, 0xffff, false}, /* 0x229c */
> + 	{RCS0, GEN9_CTX_PREEMPT_REG, 0x0, false}, /* 0x2248 */
> + 	{RCS0, HWSTAM, 0x0, false}, /* 0x2098 */
> + 	{RCS0, INSTPM, 0xffff, true}, /* 0x20c0 */
> + 	{RCS0, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 0), 0, false}, /* 0x24d=
0 */
> + 	{RCS0, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 1), 0, false}, /* 0x24d=
4 */
> + 	{RCS0, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 2), 0, false}, /* 0x24d=
8 */
> + 	{RCS0, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 3), 0, false}, /* 0x24d=
c */
> + 	{RCS0, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 4), 0, false}, /* 0x24e=
0 */
> + 	{RCS0, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 5), 0, false}, /* 0x24e=
4 */
> + 	{RCS0, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 6), 0, false}, /* 0x24e=
8 */
> + 	{RCS0, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 7), 0, false}, /* 0x24e=
c */
> + 	{RCS0, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 8), 0, false}, /* 0x24f=
0 */
> + 	{RCS0, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 9), 0, false}, /* 0x24f=
4 */
> + 	{RCS0, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 10), 0, false}, /* 0x24=
f8 */
> + 	{RCS0, RING_FORCE_TO_NONPRIV(RENDER_RING_BASE, 11), 0, false}, /* 0x24=
fc */
> + 	{RCS0, CACHE_MODE_1, 0xffff, true}, /* 0x7004 */
> + 	{RCS0, GEN7_GT_MODE, 0xffff, true}, /* 0x7008 */
> + 	{RCS0, CACHE_MODE_0_GEN7, 0xffff, true}, /* 0x7000 */
> + 	{RCS0, GEN7_COMMON_SLICE_CHICKEN1, 0xffff, true}, /* 0x7010 */
> + 	{RCS0, HDC_CHICKEN0, 0xffff, true}, /* 0x7300 */
> + 	{RCS0, VF_GUARDBAND, 0xffff, true}, /* 0x83a4 */
> +=20
> + 	{RCS0, GEN8_PRIVATE_PAT_LO, 0, false}, /* 0x40e0 */
> + 	{RCS0, GEN8_PRIVATE_PAT_HI, 0, false}, /* 0x40e4 */
> + 	{RCS0, GEN8_CS_CHICKEN1, 0xffff, true}, /* 0x2580 */
> + 	{RCS0, COMMON_SLICE_CHICKEN2, 0xffff, true}, /* 0x7014 */
> + 	{RCS0, GEN9_CS_DEBUG_MODE1, 0xffff, false}, /* 0x20ec */
> + 	{RCS0, GEN8_L3SQCREG4, 0, false}, /* 0xb118 */
> + 	{RCS0, GEN7_HALF_SLICE_CHICKEN1, 0xffff, true}, /* 0xe100 */
> + 	{RCS0, HALF_SLICE_CHICKEN2, 0xffff, true}, /* 0xe180 */
> + 	{RCS0, HALF_SLICE_CHICKEN3, 0xffff, true}, /* 0xe184 */
> + 	{RCS0, GEN9_HALF_SLICE_CHICKEN5, 0xffff, true}, /* 0xe188 */
> + 	{RCS0, GEN9_HALF_SLICE_CHICKEN7, 0xffff, true}, /* 0xe194 */
> + 	{RCS0, GEN8_ROW_CHICKEN, 0xffff, true}, /* 0xe4f0 */
> + 	{RCS0, TRVATTL3PTRDW(0), 0, false}, /* 0x4de0 */
> + 	{RCS0, TRVATTL3PTRDW(1), 0, false}, /* 0x4de4 */
> + 	{RCS0, TRNULLDETCT, 0, false}, /* 0x4de8 */
> + 	{RCS0, TRINVTILEDETCT, 0, false}, /* 0x4dec */
> + 	{RCS0, TRVADR, 0, false}, /* 0x4df0 */
> + 	{RCS0, TRTTE, 0, false}, /* 0x4df4 */
> +=20
> + 	{BCS0, RING_GFX_MODE(BLT_RING_BASE), 0xffff, false}, /* 0x2229c */
> + 	{BCS0, RING_MI_MODE(BLT_RING_BASE), 0xffff, false}, /* 0x2209c */
> + 	{BCS0, RING_INSTPM(BLT_RING_BASE), 0xffff, false}, /* 0x220c0 */
> + 	{BCS0, RING_HWSTAM(BLT_RING_BASE), 0x0, false}, /* 0x22098 */
> + 	{BCS0, RING_EXCC(BLT_RING_BASE), 0x0, false}, /* 0x22028 */
> +=20
> + 	{VCS1, RING_EXCC(GEN8_BSD2_RING_BASE), 0xffff, false}, /* 0x1c028 */
> +=20
> + 	{VECS0, RING_EXCC(VEBOX_RING_BASE), 0xffff, false}, /* 0x1a028 */
> +=20
> + 	{RCS0, GEN8_HDC_CHICKEN1, 0xffff, true}, /* 0x7304 */
> + 	{RCS0, GEN9_CTX_PREEMPT_REG, 0x0, false}, /* 0x2248 */
> + 	{RCS0, GEN7_UCGCTL4, 0x0, false}, /* 0x940c */
> + 	{RCS0, GAMT_CHKN_BIT_REG, 0x0, false}, /* 0x4ab8 */
> +=20
> + 	{RCS0, GEN9_GAMT_ECO_REG_RW_IA, 0x0, false}, /* 0x4ab0 */
> + 	{RCS0, GEN9_CSFE_CHICKEN1_RCS, 0xffff, false}, /* 0x20d4 */
> ++	{RCS0, _MMIO(0x20D8), 0xffff, true}, /* 0x20d8 */
> +=20
> + 	{RCS0, GEN8_GARBCNTL, 0x0, false}, /* 0xb004 */
> + 	{RCS0, GEN7_FF_THREAD_MODE, 0x0, false}, /* 0x20a0 */
> + 	{RCS0, FF_SLICE_CS_CHICKEN2, 0xffff, false}, /* 0x20e4 */
> + 	{RCS0, INVALID_MMIO_REG, 0, false } /* Terminated */
>   };
>  =20
>   static struct {

--=20
Cheers,
Stephen Rothwell

--Sig_/..F.gZRT39f26oBmSCHPBJe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyhRlEACgkQAVBC80lX
0Gyawgf/aadU27qURAG8ViBBE7oekBsmcIBVVHrCxtPb/JfGto0NaCg0NkgVxZ4V
R0m5GkS2OWkoLHQgkWtofNbZkWCECvMilOPMU9BGvNzFH53gDCbRNbsx4ZxTKiM9
JJfgOQnSMV11WVVOAz9TrFkwo6T6DtvIOoDOFpPnwcfnvdz6A1sM7iJ/RPJQ2ZCE
sVw7b+0npfw/+cNaVLdwwTewtwjdSxMr1PW49NvR1EZNL5n/rOHTcDHrZQ5IbIT4
MiHNGwxU9QmZJynVTvofdo8YDnn1cBM0ld4RkK+u9fB3Z99I3hMW3DhBYU3peJnm
0JUPFuSTPO5fQUfTpsSyAf4jx+OALA==
=/U5+
-----END PGP SIGNATURE-----

--Sig_/..F.gZRT39f26oBmSCHPBJe--
