Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64864C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 00:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5022080C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 00:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YjzdNqoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbfHBAUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 20:20:31 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58317 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbfHBAUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 20:20:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4607960P1Sz9sBF;
        Fri,  2 Aug 2019 10:20:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564705226;
        bh=+ve0AekgqeeerfEkv1cIPb21hnwgyPwKRGIXqIAzqJk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YjzdNqoPwyZUWcWwEkhgLFWielvXQDNt1oh/h/3f7OZHuhkvwAEnmS0NsS2aSWgx2
         B2V300+TDrUdlC7OpBnVfPKCtyHspBYyVrIkzS2oKTUABP3kFuebLKXOxoWobTLpWa
         uyp1LPoZKiFNdZfqftKot8ImxnEgY49kSfG4gIejZSVnSdHNAJI+OD6KU5ayeGi4SZ
         ZQ5fjPNon1XBDUGhd/xAMdshCfRYN1u0zLF00rzcq6t+AaRto8nMHC3HX3UxSm3XyC
         svZz2CrudgIRmQGzt7iCXoPxqo4vqvQbB04QRPB8Hx8WS8TAJMoIzMr45mqliclP3J
         U7WmrRBAl+DRQ==
Date:   Fri, 2 Aug 2019 10:20:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Patrick Steuer <steuer@linux.ibm.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: linux-next: Tree for Jul 31 - s390 crypto build breakage
Message-ID: <20190802102019.6a789c51@canb.auug.org.au>
In-Reply-To: <CAKv+Gu_1HP2NapMk5O_-XpJdga5zyFJDkVudTRT6CWm+tqPndA@mail.gmail.com>
References: <20190731163915.3fdfcb14@canb.auug.org.au>
        <20190731085819.GA3488@osiris>
        <20190731110816.GA20753@gondor.apana.org.au>
        <20190731111520.GC3488@osiris>
        <20190731113216.GA21068@gondor.apana.org.au>
        <20190731114453.GD3488@osiris>
        <20190801122849.GB4163@osiris>
        <CAKv+Gu_1HP2NapMk5O_-XpJdga5zyFJDkVudTRT6CWm+tqPndA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wVw44K.uM21QiDqGKSG=HiW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wVw44K.uM21QiDqGKSG=HiW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

On Thu, 1 Aug 2019 20:28:56 +0300 Ard Biesheuvel <ard.biesheuvel@linaro.org=
> wrote:
>
> On Thu, 1 Aug 2019 at 15:28, Heiko Carstens <heiko.carstens@de.ibm.com> w=
rote:
> >
> > On Wed, Jul 31, 2019 at 01:44:54PM +0200, Heiko Carstens wrote: =20
> > > On Wed, Jul 31, 2019 at 09:32:16PM +1000, Herbert Xu wrote: =20
> > > > On Wed, Jul 31, 2019 at 01:15:20PM +0200, Heiko Carstens wrote: =20
> > > > >
> > > > > However that doesn't fix the simd.h header file breakage with the
> > > > > second patch :) =20
> > > >
> > > > That fix should be there now too. =20
> > >
> > > Yes, works now. Thank you! =20
> >
> > Still not... with linux-next as of today I get this (s390 defconfig):
> >
> > ERROR: "crypto_aegis128_decrypt_chunk_simd" [crypto/aegis128.ko] undefi=
ned!
> > ERROR: "crypto_aegis128_update_simd" [crypto/aegis128.ko] undefined!
> > ERROR: "crypto_aegis128_encrypt_chunk_simd" [crypto/aegis128.ko] undefi=
ned!
> > scripts/Makefile.modpost:105: recipe for target 'modules-modpost' failed
> > =20
>=20
> Hello Heiko,
>=20
> Apologies for the breakage. The first two fixes addressed obvious
> shortcomings in my code, but with this issue, I'm a bit puzzled tbh.
> The calls to these missing functions should be optimized away, since
> have_simd never gets assigned if CONFIG_CRYPTO_AEGIS128_SIMD is not
> defined, but for some reason, this isn't working. Which version of GCC
> are you using?
>=20
> Also, could you please try whether the patch below fixes the problem? Tha=
nks
>=20
> https://lore.kernel.org/linux-crypto/20190729074434.21064-1-ard.biesheuve=
l@linaro.org/

It might be time to revert all this series and try again.  The
implementation seems to have not been well thought through from a kernel
building point of view.  For a start the two commits

  7cdc0ddbf74a ("crypto: aegis128 - add support for SIMD acceleration")
  ecc8bc81f2fb ("crypto: aegis128 - provide a SIMD implementation based on =
NEON intrinsics")

seem to be in the wrong order (function used in the first before being
defined in the second).  There are a series of declarations of external
functions in crypto/aegis128-core.c that should be in a header file.
And there was the assumption that asm/simd.h was available everywhere.

Also crypto_aegis128_decrypt_chunk_simd() is referenced in a structure
initialisation (unprotected by any CONFIG_ variable - and so will be
referenced even if it does not exist).  The compiler will have a hard
time knowing that "have_simd" is effectively a constant zero (and
crypto_simd_usable() is not constant).
--=20
Cheers,
Stephen Rothwell

--Sig_/wVw44K.uM21QiDqGKSG=HiW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1DgcMACgkQAVBC80lX
0Gwx/Af/cVufoIrfiSSSl7Y9kjmf50nbufyfwr0bVq1E4/cox6s3YYwm5YjksyAv
0Va0rY0BckXUkkFT6wi27uqVnX61synIjcUUDB4Gossa1LtK3+BlBqyWc2i8KYWk
f04gN4Q8Y+CriSJPMkuXXy6mi0fp/kdxbfiJe4kag2Hs+5XCpVnDt3vwk4CP3Eci
iasyqK5spS0ZcUBr8T6KmtiW8QmkO7wtdNnJOjeCFcioNihAu+KAK6yhaKtjAsIW
/9uU761Bvzow2XqRp8uf71FXfWbiMKcJzJ+/ln5te2AS+4PFhU5vZtYeIYEZUN0w
tuGhZn+FzLeLjMP1ZoPUVFCy4b0qFw==
=WIXM
-----END PGP SIGNATURE-----

--Sig_/wVw44K.uM21QiDqGKSG=HiW--
