Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F258CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 05:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99632166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 05:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Bm83GnaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408444AbfJXFfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 01:35:23 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51803 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404022AbfJXFfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 01:35:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46zGD871RQz9sPL;
        Thu, 24 Oct 2019 16:35:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1571895321;
        bh=+XW0WbvkHDCjGqc+rwLOj4r6xESyf5Ddvi1gE6TTqcQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bm83GnaIY9Uf0Y3zs9IxA7xL483ZJZM2pqH1JSiKgu4Ivz3FT2wTvkLwWKgJWCkmQ
         FzdOo1fB5dNuou+yqeCbMn/2l8gnUVQD74azr4Pd0pstLCwTbtZMpj6LydC0AJyeMp
         x0uXcTswuuogubht9qfbx0xRFa58CTFcFsyeohA6zy5DJkHoxrUAfACsTpWEtHHxcc
         jst1T70qwxUpPkvOuka5MAQGGX8OKol16+SnMb0oogQAFcaqJU3cWZXBKsvb9c97e9
         FOYhEAArS0ob6lWBteZlEF+GRG7PfUytisC1G5pDDhWZuPTouE+jx7Yr2El/TlMIYA
         P0TSSIXZeLGbg==
Date:   Thu, 24 Oct 2019 16:35:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Valdis =?UTF-8?B?S2zEk3RuaWVrcw==?=" <valdis.kletnieks@vt.edu>
Cc:     Mark Salyzyn <salyzyn@android.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next - sparse warnings after prefered/preferred patch.
Message-ID: <20191024163404.46045abb@canb.auug.org.au>
In-Reply-To: <822877.1571890784@turing-police>
References: <822877.1571890784@turing-police>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uiDp8dD83pH_Sh0akJ=XC=S";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uiDp8dD83pH_Sh0akJ=XC=S
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Valdis,

On Thu, 24 Oct 2019 00:19:44 -0400 "Valdis Kl=C4=93tnieks" <valdis.kletniek=
s@vt.edu> wrote:
>
> Building with C=3D1 W=3D1.  After this commit:
>=20
> commit 79f0cf35dccb1df27436c11b1a928b7a46152211
> Author: Mark Salyzyn <salyzyn@android.com>
> Date:   Wed Oct 23 11:25:16 2019 +1100
>=20
>     treewide: cleanup: replace prefered with preferred
>=20
> sparse throws messages on every single .c that includes sysctl.h:

This patch has been removed for today's linux-next after other reports
or errors.

--=20
Cheers,
Stephen Rothwell

--Sig_/uiDp8dD83pH_Sh0akJ=XC=S
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2xOBMACgkQAVBC80lX
0Gy3eAf/fW1MkxoN6EwsDFPhJanN1mCf7w0vMCuRqHxfRjra3Adhd0kNIirkV3IX
5Kly6cEXhRiDF1w2RcnaH1+5GN4yNHUhEbdASHozt8w9DoGbcRoVhHC36nZjJhdB
Oj8uPeozgSTNpttzgEbkp+266fOu9DIk+sFbAb+ugjKoJJjguSkcxY46jnH6vMro
TSXattBm7cBX6u1WZSB4vXgdXI1XG0OR5KU3efjFCK+KNLCil8tiOoSmP0Ms1xp9
t+0+gBKrphh7JejyWF0DcyNfk63fIG4biU4moHKWyRMQsyTtWOFG+MYsDy+Ksq4H
1Pa074cCAsgHI2bNmero3e6lV8dgqw==
=9IEz
-----END PGP SIGNATURE-----

--Sig_/uiDp8dD83pH_Sh0akJ=XC=S--
