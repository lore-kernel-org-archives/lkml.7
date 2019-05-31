Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01374C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8F52631B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nD2RRtbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfEaDlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 23:41:06 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58851 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbfEaDlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 23:41:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45FVbh0m5Lz9sCJ;
        Fri, 31 May 2019 13:41:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559274064;
        bh=Li5NgN1yN1nuxa8i00z7M6+W88hUmcjN6gD/ILdsFGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nD2RRtbw9nLOc/TqN30IfhMa9CPiwiorHrWO8g1jBPQ9pDe87jfOeawcJ2+i704xN
         cvQDLurrQmHZybTB9KHdewIkSxDDSBMDgEASB3y4aX7HKbVlqmzJSwplhkChSU0+rf
         4eZJI5HLfWh1R8JNDa7Z7uRGk+JhNrx3ZwpK1bFejcHJAvMU4JOFPGQdfi5EkkqS7n
         oZJCQ8XoOr/uPcfPJ7poP5meFprBE9pboom+HDtEs1zX6TLOKsFMxhGgsirbDcVr19
         djgCmSb3WHMVpu1oGP4Sa+FDtVE0LM1zkrMJ5kNSD+p+po+IfOjTlrm3Twx1mwv3uU
         4EsxKya+zcwgQ==
Date:   Fri, 31 May 2019 13:41:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: linux-next: boot failure after merge of the akpm tree
Message-ID: <20190531134103.6fc980d9@canb.auug.org.au>
In-Reply-To: <1559269507.z7w3zfjexi.astroid@bobo.none>
References: <20190530161741.0b4c3e92@canb.auug.org.au>
        <1559269507.z7w3zfjexi.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/PlQLemxBvR/fwW+Gj/sMO9m"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PlQLemxBvR/fwW+Gj/sMO9m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 31 May 2019 12:27:58 +1000 Nicholas Piggin <npiggin@gmail.com> wrot=
e:
>
> > I have reverted
> >=20
> >   c353e2997976 ("mm/vmalloc: hugepage vmalloc mappings")
> >   a826492f28d9 ("mm: move ioremap page table mapping function to mm/")
> >=20
> > (and my fix up) for today and things seem to work (if only because the
> > BUG() has been removed :-)). =20
>=20
> Good to know, maybe I didn't test powerpc without later enabling=20
> patches...
>=20
> The series also has a compile bug on ARM I have to work out, so
> yeah drop those for now, I'll post a v2. The large system map patches
> that I posted in that series can stay I think.

OK, I have removed them from the akpm-current tree today.

--=20
Cheers,
Stephen Rothwell

--Sig_/PlQLemxBvR/fwW+Gj/sMO9m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzwok8ACgkQAVBC80lX
0Gw9yggAiBpwmM3Sfbs6LzWUB+rlFP9IQi6z8R9JbCdzAp2Fs/6WVlKtdSR5WJil
gNl55rQxGvsq0qnKRplDswk7AFFS2ruqlfJ6ZPYMnTrgy6KwFq9M+spGeQJcuPqd
lxGNxp/k/K+6KNi2Z9gJiXYQj0zvqib4VTSFtUozLXUrfRzvTOaqVcbfY7Qb8PtR
gKjeQxHxV6blptZJhkixqxjQdhKiv0WQxwXN9Z6K0GHml/8amyAJHCUdj2d1LakJ
IF9jGQviN6jyDOQoPHGDjqs9nPaqca3nglfdZdIw8Ssllfp4/qJsD/JJiJHk2CRg
JE4FUi/cuUfaRE2fjUhWKGx4aQ2xRQ==
=+FzF
-----END PGP SIGNATURE-----

--Sig_/PlQLemxBvR/fwW+Gj/sMO9m--
