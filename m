Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81FDC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 02:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D8520815
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 02:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fvk6U1in"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfCBC2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 21:28:07 -0500
Received: from ozlabs.org ([203.11.71.1]:48381 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbfCBC2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 21:28:07 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44B9Dz47qXz9s70;
        Sat,  2 Mar 2019 13:28:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551493684;
        bh=moOPCOx5Ycc+UIxg2ITeUGdRYgmpVjNX8tshmDxFUyc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fvk6U1inlj2RKyvYP+2GRpf/z2X0+VlK7jF8KYzwYhuXUt0q6XjG+pofLMpdYs6kO
         bxrI6qGucwscgAxLQ67wpaca+qm457XJV0dgUrZQyU3O4hYHqqmX+T81cCG02jy/Nc
         9PkqJ67M8XXdlL+uhNYTJtmhGMRTZgixPNw+4zFbHafY0XB0JwQiXfTJmG/v4i8vQI
         J0Rz6FW88kaMMyJUV6v/j/rzJ6FUwfogryJ6cISMO+DX5UFOgSbDZXXGIOgsIdapGf
         dk+IV7AprhF0iVLDF/X76wOw7I0OTC4jx/Q6ySqNs2apNXIit0qr9Np+ii6kiONmlg
         YThHtkKZiR5UQ==
Date:   Sat, 2 Mar 2019 13:27:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     bp@alien8.de, natechancellor@gmail.com, niravd@google.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: clean up headers
Message-ID: <20190302132750.0916adc4@canb.auug.org.au>
In-Reply-To: <20190302000715.130116-1-ndesaulniers@google.com>
References: <20190302000715.130116-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jHWuNsnQ4Jp1Hk.oG.JaExM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jHWuNsnQ4Jp1Hk.oG.JaExM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Nick,

On Fri,  1 Mar 2019 16:07:14 -0800 Nick Desaulniers <ndesaulniers@google.co=
m> wrote:
>
> It turns out that arch/x86/boot/string.c doesn't actually need
> linux/kernel.h, simply linux/limits.h and linux/compiler.h. Include them,
> and sort the headers alphabetically.

One small nit: please do not do the sort in the same commit as the bug
fix.  It just complicates the review and has (a remote) possibility of
adding a new problem.  (Not a big issue here, but in general cleanups
and bug fixes should be separate.)
--=20
Cheers,
Stephen Rothwell

--Sig_/jHWuNsnQ4Jp1Hk.oG.JaExM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx56iYACgkQAVBC80lX
0GzShAf/TSL3x0TMKJNTyBZ5ZodFl1lWtvaZglx/wa+jsa3vLb4BLl2LsBsR623D
IYudqT+SqPHLBrUZA6/tq7NZO2auZBMkdtVXIehOLPAyb8xLEYcIzhbv+cN3h+W1
aBJhqpl2gujG52EXtWDmPBRmsxRaiDh95gJBeVJGXgc4P7Ne6uS0NYOSIh2MCyCz
1uap61tejkkLn67Bipoawc3FxdML8ohD6vZwG2k2oJ/FN6nTiUzShbVU+FY0wGC4
pAm1aWFmnP/i6E4RPjFqLpdbkF0FejMjaB+NOH5Zu/8lSnaftdFpx2Hwb6Ai6Zsq
TK9XmZrjjnLfNT7TkZfpOA6ThvCk7g==
=o20W
-----END PGP SIGNATURE-----

--Sig_/jHWuNsnQ4Jp1Hk.oG.JaExM--
