Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDECAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD1E20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="OQX5iBoD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbfDDVWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:22:12 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:44530 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfDDVWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 17:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dB5vjofHjOHiNF+THKpAlY5dGiqfzvlvS8mkCmefwjQ=; b=OQX5iBoDbCsxuDdxNfswcno3c
        QJxY4JFyDpO7A9+MYR28N8MHhchr/Siny5xHvX/054+V2JGWAQB+tunhm/DetYqvZGOUs/74deIrP
        JjxfX1CzKHI3WIZWKLfoOdFvTA0fM0Pz8sxNCSryEITNA9DFVw+REhtwGZsmjZDqFS4zw=;
Received: from p200300ccfbcdbf007ee9d3fffe1fa246.dip0.t-ipconnect.de ([2003:cc:fbcd:bf00:7ee9:d3ff:fe1f:a246] helo=eeepc)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1hC9oF-00010D-U3; Thu, 04 Apr 2019 23:22:08 +0200
Received: from [::1] (helo=localhost)
        by eeepc with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1hC9oF-00056C-1m; Thu, 04 Apr 2019 23:22:07 +0200
Date:   Thu, 4 Apr 2019 23:21:51 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the mfd-fixes tree
Message-ID: <20190404232151.46cb903c@kemnade.info>
In-Reply-To: <20190405074843.7f0013db@canb.auug.org.au>
References: <20190405074843.7f0013db@canb.auug.org.au>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vHMLlvOAa3d=0GF1FpV27k7"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vHMLlvOAa3d=0GF1FpV27k7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Fri, 5 Apr 2019 07:48:43 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Lee,
>=20
> In commit
>=20
>   20bb907f7dc8 ("mfd: twl-core: Disable IRQ while suspended")
>=20
> Fixes tag
>=20
>   Fixes: 6e2bd956936 ("i2c: omap: Use noirq system sleep pm ops to idle d=
evice for suspend")
>=20
> has these problem(s):
>=20
>   - Target SHA1 does not exist
>=20
> Did you mean
>=20
> Fixes: c6e2bd956936 ("i2c: omap: Use noirq system sleep pm ops to idle de=
vice for suspend")
>
I meant that patch. Copy and paste error on my side.
Sorry for the confusion.

Regards,
Andreas

--Sig_/vHMLlvOAa3d=0GF1FpV27k7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAlymdW8ACgkQl4jFM1s/
ye+bKhAAslPcXLN4x1kHuBmSdfvRZskFZ0SIXExTXZy4wkibiGH7hBtyk+rXWaCh
5KnYz8ZSQJCp9/ZNltw64xW96gH1V9mQcBkSfqN5lo6fO7tviZ3u3u55H0+YvoNc
QCJTKJ3yA5IudkMAYEsw29ywW+ZnBd28UGXg85o0YMwBxNZ0i420s1IRLWlAKAO0
SrSXByKsOl3bb3WYtmMefae6NC4knWTHG9ssdnvQhnATawaoDwcw74vD0bx/1GD5
QsHSrVMo9TUnUHCuhqVJy/RJdN6q5ct7RSH+sn+3mF8HxfiwYsPsznKrAM1wwNI1
+xJuWqRiPjQ2jb2aLuPXHkImQdW8pMPjKx27jXEmrzXR/wqxmM1LxK/EEeSx3N9C
v1T6mXzWj/owv6Y8g+TNw4AcErfOXr6emzfOtkqpEsfXf1If0Yd4e+ZtnOAozm8I
SVRO2ptZLVvO45euOse223VO6pQO8pFedRuQWWEphFJvYjsWsk/PfUzDUVL/j1Dr
1EQb5+/jYX3YIN7pEdF9g58N112f78cUuUjZ0kdaMuCnIj8pnv1k3aWKj+fwMhSc
0S73nsP2btVEAtCRmXfHw78/d79kQ2DeeASeCRAAOqDAl3rfDHh53tu4DEFzHnDl
00ikxRMBUg2qQPX4TOaeMFFP28OyRJ50x5cgBjkKuEm+dWn8fNE=
=zvj5
-----END PGP SIGNATURE-----

--Sig_/vHMLlvOAa3d=0GF1FpV27k7--
