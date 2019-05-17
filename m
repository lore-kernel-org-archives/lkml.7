Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D903C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 09:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A6D20879
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 09:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Vau7VG2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfEQJyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 05:54:16 -0400
Received: from ozlabs.org ([203.11.71.1]:44709 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbfEQJyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 05:54:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4553Xh4nDNz9sB3;
        Fri, 17 May 2019 19:54:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558086853;
        bh=73FzsMEDIqD1GOIyHuNtsAPdtGNJiw1agWt6UJFdv3M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vau7VG2eZZGPWWoCE9WwXL3tX7w1vtUVIrx9gHArwILsjjU1hY/xDiLcpKlenWo0Y
         Qgqzcv3pj+/WaO/qSEyPSoFhRku1rEiYMr4PWTDpThqU7bhLke+NcgXmJRlrtDGjiv
         KMZ6kh8kBv1Ml28zy3yP9Z6T81CI/lX5S8NW7Iz7AcAwxpZDEycJ97K+ObW/PpZ8YN
         31daBfrYiTeRa1kBrgVGRg9q09BYvLXKdrKEE9a0K2CX/YJkBvrxyo5+54Sx29PjKz
         K9ZCsAFiYYjpD2ayFJSG/wHiGsgtdBA7oEJimon+H7kJO6KiaCgPqexb0w77L6ZzXY
         CzMAIQj+2qmxA==
Date:   Fri, 17 May 2019 19:53:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     atish.patra@wdc.com, palmer@sifive.com,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for May 17
Message-ID: <20190517195340.269ba527@canb.auug.org.au>
In-Reply-To: <07e1a10a-5348-2d2e-fb6a-c9ef837185fe@virtuozzo.com>
References: <20190517142152.588edb6e@canb.auug.org.au>
        <a119ca58-6771-cc36-fe5a-187ba500010a@virtuozzo.com>
        <07e1a10a-5348-2d2e-fb6a-c9ef837185fe@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/x30sYicc=Trq=q+7RRhjQSu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/x30sYicc=Trq=q+7RRhjQSu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 17 May 2019 12:43:08 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrot=
e:
>
> On 17.05.2019 12:41, Kirill Tkhai wrote:
> > On 17.05.2019 07:21, Stephen Rothwell wrote: =20
> >> Hi all,
> >>
> >> Please do not add any v5.3 material to your linux-next included
> >> trees/branches until after v5.2-rc1 has been released.
> >>
> >> Changes since 20190516:
> >>
> >> The kvm tree gained conflicts against Linus' tree.
> >>
> >> Non-merge commits (relative to Linus' tree): 1023
> >>  1119 files changed, 27058 insertions(+), 7629 deletions(-) =20
> >=20
> > Binary file was added:
> >=20
> > ~/linux-next$ git log --oneline ./modules.builtin.modinfo
> > 4cbb0d07b4d1 RISC-V: Support nr_cpus command line option. =20
>=20
> CC Palmer.

It's been fixed in the risc-v tree since it was included in linux-next
today.

--=20
Cheers,
Stephen Rothwell

--Sig_/x30sYicc=Trq=q+7RRhjQSu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzehKQACgkQAVBC80lX
0Gw1WggAjoBLD0Ea9Npr3UG0H/u07ONi1zuf4U7kYTpaNgETz9eizPAw2P7c8hXb
fp8hLZkJ7169QSei02HiIHL80hwxfsxY8rz9ZRVwGV47oZHhuO+XRwkvFC28S3e7
k7c3RkU/1rKQdEKoY6H1fMS5VF7J2Uls96sddQq5nQAdxs7fr+aBpIEHxapk9qjl
F2Cl8mj5nfDMeeR8iNeapVEQlrUGv2t+zncBrT/WJN0AnubD9ufQO4Eyv21GayWA
9u2urrEWRW5qsRLvMZDEzKLoaGzMCKSZxZibTnVXoo4wWNwTkXLcugq2Ybaam3Fj
zyB5nnPoSOIf5UvgeUBr52v2Pi6Bkw==
=lRvW
-----END PGP SIGNATURE-----

--Sig_/x30sYicc=Trq=q+7RRhjQSu--
