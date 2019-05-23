Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260F8C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 22:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25C420879
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 22:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gVRWsJWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388523AbfEWWd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 18:33:28 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51085 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387621AbfEWWd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 18:33:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45945w370pz9sBr;
        Fri, 24 May 2019 08:33:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558650804;
        bh=QWurjPbadvLi/z4O5dSr2aM3lqa3PhG88Zxdi9mp4fU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gVRWsJWIDPYNKirFujwrxZ7RMk66i1doKjzuAFeU/6iDA7LjggRGlzRrF7b+OQzY1
         KZU85tETll4C0hRASyIIKno490dRU0V7OH2CwfdMrvm/uil2kP+mVD+7yTTic3vzCv
         B6vuVXuAJWCLF8qbyxGia/g1mYq8smC9DxF5apV9rMa0uMK98xlQrqcMM6In9SndEA
         LJedpbKXumBdnR6CF6IiEGddJ0Py3HG0FZAEiQnEVrebdj/VPIivd6QLIcXuoQ91Ot
         RiCOG/BwTDgH7ihkaPjKO0LoI6n824F++hfGdmC2WgJhADWfOJbdWvCoyjKm3YcoY6
         0WFp4JIirWHzg==
Date:   Fri, 24 May 2019 08:33:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the block tree
Message-ID: <20190524083321.7ada6382@canb.auug.org.au>
In-Reply-To: <20190523215206.GA15192@localhost.localdomain>
References: <20190524074500.1fde68d6@canb.auug.org.au>
        <20190523215206.GA15192@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bH4wz8EXsUVjijbXawieSEI"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bH4wz8EXsUVjijbXawieSEI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Keith,

On Thu, 23 May 2019 15:52:07 -0600 Keith Busch <kbusch@kernel.org> wrote:
>
> On Fri, May 24, 2019 at 07:45:00AM +1000, Stephen Rothwell wrote:
> > Commits
> >=20
> >   5fb4aac756ac ("nvme: release namespace SRCU protection before perform=
ing controller ioctls")
> >   90ec611adcf2 ("nvme: merge nvme_ns_ioctl into nvme_ioctl")
> >   3f98bcc58cd5 ("nvme: remove the ifdef around nvme_nvm_ioctl")
> >   100c815cbd56 ("nvme: fix srcu locking on error return in nvme_get_ns_=
from_disk")
> >=20
> > are missing a Signed-off-by from their committer. =20
>=20
> Oops, I'd only added my Reviewed-by. Do I need to update the commit
> messages and resend, or is this just putting me on notice for next time?

That depends on Jens ...

--=20
Cheers,
Stephen Rothwell

--Sig_/bH4wz8EXsUVjijbXawieSEI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlznH7EACgkQAVBC80lX
0GzBnQf/dI0C/I6VfskUrct9z8/c/UiS7V4TOegHThOyh+n+WRFgZH/Pm7mezScA
uwqHlNd9CI9qIoQatQHg93I6tjtcB/hYSMDQEqTEvaBz39NqFZJuJWY4z+9Uk4YR
4QJRKSi99ABMrc4RtNQUFrk8fBW49M/uBpZ2McY0TheR4m/6Lom90a7WQyCyeqbz
w3CTOAP3UAd/KkMgEHYGKH1GI4XmdB15fstbGtd1XCTw0VjTWOu8r7d5IWYrSJWQ
Pkh8t1q2osTZFbe3Yti9iobdsbcF2oXt+EqyrZEGxaqMBbcw5uglQuS0t8gPhkAh
ls19SIdwHf4skdZraAqcipgaFH+K2A==
=D15q
-----END PGP SIGNATURE-----

--Sig_/bH4wz8EXsUVjijbXawieSEI--
