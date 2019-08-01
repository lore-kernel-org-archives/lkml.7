Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D05C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76042171F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hOqWAL/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbfHAOZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:25:11 -0400
Received: from ozlabs.org ([203.11.71.1]:49605 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731986AbfHAOZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:25:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45zsyC6ZmKz9s7T;
        Fri,  2 Aug 2019 00:25:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564669508;
        bh=fr2Ht3+8dgEWKOJ2z6MmGWX6pP//2xVJZMrrvySq0qI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hOqWAL/b/zf+bdYXFw3KSz7Y7FEh7YYfpBZ0tp2dpTsp3oE3LYRzak84aNulVucCu
         JcojD9xSrLqiHVB5uhMjvg5ay64cLCMoQvQuONU5vlqgs8y2THB1OkJR2fGzBPM8nS
         TPC/sluYZb6QkucyX39f2VCN/iBsmF38FIvjNLWx8kVOBVSKCCZEqqjzysQOaELcKQ
         JkdJQc2mozNoDcXKXlzVlUxzLCvjWOWD6BYtUdl1DkWm4wKRfUzWp5rHDUYn5uQ0mA
         nvgHAIw34sw3BXBmheEEKUQFxhIqJQkslTgw6y8Q8aAdog4rl190N1B7+B6ITUO/cx
         d5lVhVmQpgufQ==
Date:   Fri, 2 Aug 2019 00:25:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the arm64-fixes
 tree
Message-ID: <20190802002505.6f814277@canb.auug.org.au>
In-Reply-To: <20190801141009.iksa5pc25vxlydak@willie-the-truck>
References: <20190801235614.4318ce1a@canb.auug.org.au>
        <20190801141009.iksa5pc25vxlydak@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xjwJ5G4EUR0rL6BIo3G7JQk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xjwJ5G4EUR0rL6BIo3G7JQk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Thu, 1 Aug 2019 15:10:09 +0100 Will Deacon <will@kernel.org> wrote:
>
> On Thu, Aug 01, 2019 at 11:56:14PM +1000, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Commit
> >=20
> >   23fb9748a46d ("arm64: Lower priority mask for GIC_PRIO_IRQON")
> >=20
> > is missing a Signed-off-by from its committer. =20
>=20
> Urgh, I just can't get this one right, can I? Let's see if I managed it
> this time. Otherwise I'm reverting the thing and we'll just have to live
> with broken priority masking forever!

Looks good - disaster averted :-)
--=20
Cheers,
Stephen Rothwell

--Sig_/xjwJ5G4EUR0rL6BIo3G7JQk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1C9kIACgkQAVBC80lX
0GxH4gf/R5PA/x9bLwm2o8wJcd9rV4BbXyrSOS9CBxiS2pLmYOu28MucXk+a3Vbn
5aLAjSkoqRvJ/qEatj3AEL4tuSU6fJNCxs7lbNLdqDNTGDaWhOfBIcrc4ciHVZCY
o9ydKNmfgqEJr4wVawRoLF82214vP/iJ+nRSB6W0FwTpB1Xy+6ZmzFIZB1cM3nrW
snks6ihcTeSDwtukWj1sADsfDIlxOa0c3BRQKR4qmPP40tXJe5PcOXj5kbO1ttNd
vUuk6QcCj5Xvo+Q8GKkMym9Phn29CUnL0z2HaolSwURoSS+Ci3zGQgVk0P7c29Zl
yxGPS2nXJXHBpFVwtdRFIkIZDwMzCw==
=ewv0
-----END PGP SIGNATURE-----

--Sig_/xjwJ5G4EUR0rL6BIo3G7JQk--
