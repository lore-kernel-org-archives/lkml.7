Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CC4C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6510B217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BM/uExDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfF0Bsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 21:48:35 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44573 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbfF0Bsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 21:48:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Z2qN1gymz9s8m;
        Thu, 27 Jun 2019 11:48:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561600112;
        bh=nrNGhtMBTI3QrHkPUsVro/17jM5J9mt4TL5ByIs8mBQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BM/uExDZz0w0Ey0xtkCg+GIPFMzLeYuBmwANJdEF3FH2Jy3hTr33VoYMl3FKfTObL
         zJWNUcTV6nFGBebV+oUoZCWeWFg87TXoK/HvajMNBj//k2KKcYZ+g9Mz5Y6FYxud9m
         z+6Dokx5nFIzDqbvSo6zH7fKCU+evixMzaqvx2sxiqCXbB/PmCVbhr6tp3s4AP1fsj
         2b33gItM2ce9Li96TDKWOqJBeEYta+O0G1hazc7I2U1mBIkdgSJtmJ+4N0JNlGvBHJ
         +0zcgnp+2EQ4wG4g0Dt2+OtWM8dcYTctZ49bJItoltmBsstkGoRBVxevhG4+WogcAV
         sHc/K29KoaPzQ==
Date:   Thu, 27 Jun 2019 11:48:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the pinctrl tree
Message-ID: <20190627114831.5a13dc0c@canb.auug.org.au>
In-Reply-To: <CANMq1KCUfsKdJD8=DKR7ya-zhV0fgpHBi=PUtD030nFo8k9_ng@mail.gmail.com>
References: <20190626235011.7b449eb0@canb.auug.org.au>
        <CACRpkdaHyb=o=9YzSvKWRbbyPCbsOUxC=zoz+acnTWNvp=vu5w@mail.gmail.com>
        <CANMq1KCUfsKdJD8=DKR7ya-zhV0fgpHBi=PUtD030nFo8k9_ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3dwd/mVe8ynlYMOSM14lbGD"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3dwd/mVe8ynlYMOSM14lbGD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On Thu, 27 Jun 2019 08:32:34 +0800 Nicolas Boichat <drinkcat@chromium.org> =
wrote:
>
> Ouch, sorry, for some reasons I thought it was 10, not 12...

It used to be 10, but will slowly grow over time.  That's why setting
core.abbrev to "auto" is best (or leaving it unset).

--=20
Cheers,
Stephen Rothwell

--Sig_/3dwd/mVe8ynlYMOSM14lbGD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0UIG8ACgkQAVBC80lX
0GzObQf5Adf6xqgI70td5WRzqCmRyvIdd+Bsj6mhn60GOY301LMIRsTo24YO4QsZ
hUgz1yLtvX76p0b09AFePePpP9yDlM5B9paOirhM3/XMYwVBbo5G2Btcsvah3gGK
fPjFB57bohqU0cTrZupS16KLo62/PVXZbO6Gjv9Bh2/MHGGU1M4kNNQ7i/uCZqgo
6gX3VQgmf8hueCHbqRP/sl3ADV4hXisuZv6DjtbW9rpML0ta3uKMPFmQLA9Ksxlw
1VLzQiwQkSdG9Pz1taMtL4LsgyjV7k69oUulxL+hK1mGSc0y4so1aYITBi5KRATL
NiEcZOVnriLwKjmY7/ic70PCQtk8rg==
=fVsj
-----END PGP SIGNATURE-----

--Sig_/3dwd/mVe8ynlYMOSM14lbGD--
