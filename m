Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149C7CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 11:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E0B20B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 11:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OrYxeeP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387884AbfJVLSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 07:18:38 -0400
Received: from ozlabs.org ([203.11.71.1]:38529 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730515AbfJVLSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 07:18:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46y9x73VPSz9sPh;
        Tue, 22 Oct 2019 22:18:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1571743116;
        bh=obHRO/VzwarZaX01qTrD12x+hd87XUXFgpKqb0arRQs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OrYxeeP9OlTPtaF2Feq4rPnfvAr0PAwUB6ZMggAv0YfYNOCANMiL7ZCoTBXjRzOWe
         tRJadFGuKSybus08MmaVmzQTm3Y90zmk7C9dNbH9xpfdyo/hPTe2enYc54EfKcwFsj
         rPI811KX3m0ZJvkIpvWFNUJSkLA8/x+ZG5eBeRMxyUh1AUT5X5ds44HLxbmahGx3T2
         YMuCt2pgE/o7o7n7rFftrG781rjuW4HKFXrKOysw5afm9F2UBVnR8QqGfoOMjnXPbm
         JQDIGC/8Fc4IH3tSoVJLhOZ68O1FjWEvvxZwJbCJIc5flV3XFmHIxoH4EOikAeQXCv
         RqTghabFUy6+A==
Date:   Tue, 22 Oct 2019 22:18:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the thermal tree
Message-ID: <20191022221406.298ccd6a@canb.auug.org.au>
In-Reply-To: <CAP245DXChLoSUkj49FrYq4HVkcP2pS8=qamWDDUNOg7aygDwpA@mail.gmail.com>
References: <20191022102334.67e5d3d1@canb.auug.org.au>
        <CAP245DXChLoSUkj49FrYq4HVkcP2pS8=qamWDDUNOg7aygDwpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ditOg80WTfshu/cH67DoS_+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ditOg80WTfshu/cH67DoS_+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Amit,

On Tue, 22 Oct 2019 15:20:00 +0530 Amit Kucheria <amit.kucheria@linaro.org>=
 wrote:
>=20
> What compiler version do you use? Any additional flags to make? I'm
> not seeing this, even with W=3D1.

$ x86_64-linux-gnu-gcc --version
x86_64-linux-gnu-gcc (Debian 9.2.1-8) 9.2.1 20190909

No special flags to make.
--=20
Cheers,
Stephen Rothwell

--Sig_/ditOg80WTfshu/cH67DoS_+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2u5YIACgkQAVBC80lX
0GyvBQf7BLJpVTtVfLB81RiiBipeN3635ygkWaxZETWL8ULKYo2yqKXAv5qlQ3h8
L4jhve0dIyVUZtnmCDiT2us15a01EkGK/KtMjLUR6p7ujY3H0fSf/5poSwcsKbnL
yNgnP9ORyCahN5tY516deNXW95x81qXf37MyE34R/mBcTj6xR3qkMIb3uBFaPHTe
N76zMIEdkLsWgHxYa8cx1Re8pJkCnMS2UQ7Rs7WCwtwc/NgUEsmd+XVLe+jN19UK
aTC064E2cDZdF3RANzH1LY6iqXejeWKvKKXYa6MdM3tfLuSt4SjGH2TuPnxeAYnt
UHal5a5yeUJ8skhatfSxl5Qt27E3Gg==
=nOFJ
-----END PGP SIGNATURE-----

--Sig_/ditOg80WTfshu/cH67DoS_+--
