Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9255AC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6A1216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bvRHkMVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfF0CB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 22:01:26 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38229 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbfF0CB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 22:01:26 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Z36C1rD3z9s8m;
        Thu, 27 Jun 2019 12:01:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561600883;
        bh=8ryurff2tG+5lGRaoYwPV0730HEmTm9PC6KTQN4egKE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bvRHkMVDOJt7IlUy+R98UAChbQP2zBjXy+B7cfmyuK6RJe7vbfWna7Yzu8DIeCqYF
         syQkR3oUzB/f9qoqCNmF7J87ooUG6iGMi8NS4FYMjSS7mqUj+h8GdICw8QBCw0InJe
         3+/iRREQkqRRfTdAw3TW0CY4yrDwyKGQnqTqHYe+slUAV+VDD66V1cRsIQgyzqLGWa
         l/DOBPI16AB2FMK6lN72ws+XJw0dfZ8zRuOT0LSXNAHKEs7SlGOtHAmmXxOey2cMAR
         4HPVwiizF+U4FL4v5JezK7sDf5V/8WIMDffN9uQIrff0e2hPCuHTwxMh+yhdwiVeMw
         k6TI5eWHK919A==
Date:   Thu, 27 Jun 2019 12:01:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the pinctrl tree
Message-ID: <20190627120122.29185a42@canb.auug.org.au>
In-Reply-To: <CANMq1KB+wmSU5S=extD_Pe-bG+v0vAdm4NsnMzmkkEcVi+mMjg@mail.gmail.com>
References: <20190626235011.7b449eb0@canb.auug.org.au>
        <CACRpkdaHyb=o=9YzSvKWRbbyPCbsOUxC=zoz+acnTWNvp=vu5w@mail.gmail.com>
        <CANMq1KCUfsKdJD8=DKR7ya-zhV0fgpHBi=PUtD030nFo8k9_ng@mail.gmail.com>
        <20190627114831.5a13dc0c@canb.auug.org.au>
        <CANMq1KB+wmSU5S=extD_Pe-bG+v0vAdm4NsnMzmkkEcVi+mMjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/D_SNT84znQrQ+XJl7101PT6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/D_SNT84znQrQ+XJl7101PT6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On Thu, 27 Jun 2019 09:57:13 +0800 Nicolas Boichat <drinkcat@chromium.org> =
wrote:
>
> I'm not that smart, I count the digits manually ,-( Anyway, TIL `git
> log --pretty=3Dfixes` and I'll use that in the future, thanks. And my
> "auto" setting uses 16 digits, it's ok to use longer ids, right?

Yeah, more is ok (but not too many more :-)).

> BTW Documentation/process/submitting-patches.rst on linux-next/master
> still says to hardcode to 12.

Rats!

--=20
Cheers,
Stephen Rothwell

--Sig_/D_SNT84znQrQ+XJl7101PT6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0UI3IACgkQAVBC80lX
0GyBWQf/aSfSat93NjoEZOWUv5R4308IGEFKGGKvuSCVSl1KFTp7lpH4D8DiY7ZF
0tpHrQsnSN0m475lxj+XzSRewTXMiKEGglbz24y0uK4JYVcCEecpzUBBoxNwcHbS
a3TaYv7xPkJuhwbMfJBWTKSRYUdIHpj0oAvLj98QlUqGzGJxvGCWj+J0o4I0hvKq
84KBQOE+dkGCxYht9Rft9rJzx5ARQG5O+7C/Bg21S43kklJEbnHsFngP/xXcks7d
OhfIwIV7i1E6MZgEVRtluh+Ltwibx3IjmbJ0ZjdxA/jVtUmHvd2hSihYz6IBoLoj
PDXSeVP+cQMG7ze0yunLQSaYvA5MUg==
=TLB2
-----END PGP SIGNATURE-----

--Sig_/D_SNT84znQrQ+XJl7101PT6--
