Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A76C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 12:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B0D217AB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 12:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="O2AWhh36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfK2MPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 07:15:40 -0500
Received: from ozlabs.org ([203.11.71.1]:46565 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfK2MPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 07:15:40 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47PYPP2Sdhz9sPj;
        Fri, 29 Nov 2019 23:15:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1575029737;
        bh=39ex8pURGBPP/cI+i8/QOxDKC5Z+vDOw38ntqGTRCiI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O2AWhh36egxFR57pLhYvUBOZ5yWL4+glWq2k2agZPrZyjMXpoRDM0Xh6/r4BpYSpK
         IZxSeIuoo3MxY7f3+WhXpJlEDP0DeLEJnJOJa6yko2wUlAJwRQAs5sM4kJAqP84u/k
         qnSNQaZFEUAJGap25F9IXNTlOJuYb+l15xMl6VbWFQr2htLq/2oI59f3r7GKLCvpF+
         TLDmN/hbCbd4mNzMOlYa+E1RyfYeJ0tzh07/+affo2GRrWG9tQU2q4FCj80H+I+Q6X
         QySn2vHzUkULu7/q0LWxQVVQ8gl794sPOnH8xR0cHX/5Si8Yt/pXD5qK6ofrsS+eAw
         g7lxemDZWhqzQ==
Date:   Fri, 29 Nov 2019 23:15:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the powerpc tree
Message-ID: <20191129231536.1fbd41ba@canb.auug.org.au>
In-Reply-To: <20191129231200.1f5ae2a9@canb.auug.org.au>
References: <20191129231200.1f5ae2a9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/U8m6Gu/o4QploGI=pgWxJU/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/U8m6Gu/o4QploGI=pgWxJU/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

hmm, that subject is completely wrong, sorry.

On Fri, 29 Nov 2019 23:12:00 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Commit
>=20
>   6f090192f822 ("x86/efi: remove unused variables")
>=20
> is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/U8m6Gu/o4QploGI=pgWxJU/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3hC+gACgkQAVBC80lX
0Gyd5Af/bQ9GCeJy6v8qKErFbbWh+CMiHzvI4mTDrpRAYdxxAi2UZIIG8PmaIqCk
/kvxH0DbJ9XSOhQbd2+TioUJVn+jXk0O6sUKQjVgqS1LHENcznL6t+r0f2qUE9D4
UO4bb2A9ZQ/Hu1mDx3kVixFhwQAXNRtnYTiIoUuBZfQyK8v6xrpXc1fN7OqaqNEF
5NGtDxhdtRg1Pc3LuyDgBO7+oo1/1satcBhPSx7fHa5Z5+gMZBrTdk6R8lxKDH9c
+Vq9kWcFMV/sOMGefcfiLy5HDMaSDRC0F7q3eVnUCTRinpj/OlB3FTJcmn2gtwsm
Kt+wM8e24eFEi63gMtqXxgHpCjVg9w==
=vSa4
-----END PGP SIGNATURE-----

--Sig_/U8m6Gu/o4QploGI=pgWxJU/--
