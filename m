Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A944CC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 23:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F9F2072B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 23:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OOmozher"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfKOXcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 18:32:19 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:52363 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbfKOXcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 18:32:19 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47FF4c1p53z9sPF;
        Sat, 16 Nov 2019 10:32:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1573860736;
        bh=eQ5I90vi/r0lH3+Kp3ZPgiAXcKCN9HvIO3uUKvDMdPY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OOmozherXoZ64OXWu8I70kJYMLbMr/J8oOiJHQn8EFEi4M3ui0zXP1IXSH7UZhgwz
         jWws8zFVnD3F8+bCpC06pAA5GZWY0IORdi6ktTzm4MsNol/rGl6Fazc/wZj5ME+CUs
         4wjARPxMZMoC/IFs/5lGrV6RNhDkipNneJdaU8qxMERQeFBhBZhy0GpwvqHc9Yqd6H
         I9aCIrpyZPpbeccUnb904ojZ+stlGWo2oUX6R//eQYZQGunIyRVU2Hq0xMRWCFrb4y
         aT8Dz5ad9VCd87yMUx2y5zgfar9tFyEUd5Wll3Fzsea/knpOU8IBki9rYdnrcBDSCu
         nhObh0DF5H+gg==
Date:   Sat, 16 Nov 2019 10:32:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Alasdair G Kergon <agk@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Thornber <dm-devel@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: linux-next: Tree for Nov 15 (drivers/md/dm-integrity)
Message-ID: <20191116103213.47a1991f@canb.auug.org.au>
In-Reply-To: <20191115231050.GA29649@redhat.com>
References: <20191115190525.77efdf6c@canb.auug.org.au>
        <f368f431-b741-d04f-440b-3d8c3c035537@infradead.org>
        <20191116094620.497663ab@canb.auug.org.au>
        <20191115231050.GA29649@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rpeBUN6Yd2jv+1d_t4lJIva";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rpeBUN6Yd2jv+1d_t4lJIva
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Fri, 15 Nov 2019 18:10:51 -0500 Mike Snitzer <snitzer@redhat.com> wrote:
>
> Yes, I've pushed a fixed commit, please see:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.gi=
t/commit/?h=3Dfor-next&id=3Dd537858ac8aaf4311b51240893add2fc62003b97
>=20

Yeah, sorry for the noise, I should read more ahead in my email before
replying.

--=20
Cheers,
Stephen Rothwell

--Sig_/rpeBUN6Yd2jv+1d_t4lJIva
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3PNX0ACgkQAVBC80lX
0GzR8ggAnIPyKhzm9H/UEtVk/yhaIGtHCjjs3bGYL0WnIFjfa9I3QyTttf+sA2S7
BbQrSZxaAP0M5G3/RLp1ES+xe0Ep8unh8hV7dj47we8J0pAUyd7o92vtnOUjlWiQ
dRAt4rYCmY9meDb+frH1Uzhn2jM3bHtwuWL6X2b6+xF5JQLFx3qi9AnXtgRgpQ0L
/yNiZAEnFSCLyTOMlcbteqHhxVirJ7VTN4Iq0JgEg19vf4UiT8RF78cvjwial1Io
dfK7pCF+yD7IwXzkkCYbVyys5EALWQZS9xLM48QkKCgeigMBjvSt3LUxuaatrqfb
IKWgWFF28iHGlTx1oGWlgySZbuatkA==
=GAOr
-----END PGP SIGNATURE-----

--Sig_/rpeBUN6Yd2jv+1d_t4lJIva--
