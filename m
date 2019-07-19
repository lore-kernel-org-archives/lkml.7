Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC479C76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4C42173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nGMv6pXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfGSAkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 20:40:42 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35307 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfGSAkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:40:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45qXGt728nz9s00;
        Fri, 19 Jul 2019 10:40:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563496839;
        bh=vWIpdAMZ+vT46Akc4v9NZRJYvyZiozmtJ4+w96anCLY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nGMv6pXAW7TJF2qcbITorX4qbqUA3xOaSbqxDkbX3NwHSKz63W9s8s12/tzLqBJjd
         Au9HjPjusyb5DNMkmvajn1p7G7C+Wy/+vIdsVyChvneLmrxkJfJs9rgNUmTG8QMZ2V
         TyODt7ACzQnDFxx3XKzhgXw87sbI1mbkark4o4CRky0L9xSBPkl3D5G26o6ahzFifa
         CwhdQ6oXc/YdM5hx/cJgGY5s9R022geenaX9VZ0FVCOHbt5V+4vk/XwT41r/kPAeh4
         9+Ygnu1a0N2uTxrrO+KtmjdqmUCv9TQ56r0H3jM4+YJ8cWiubaLQ5PVofJww97slSY
         Br0/LJ9Fpv1EQ==
Date:   Fri, 19 Jul 2019 10:40:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: linux-next: Tree for Jul 18 (header build error)
Message-ID: <20190719104038.1d1f9a15@canb.auug.org.au>
In-Reply-To: <20190719003045.GF692234@magnolia>
References: <20190718133751.3cf036be@canb.auug.org.au>
        <127d228c-322d-6349-382b-d304974df148@infradead.org>
        <20190719100557.3ead3285@canb.auug.org.au>
        <20190719003045.GF692234@magnolia>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nX4Jeu6sxuCZYl9N82CPIAF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nX4Jeu6sxuCZYl9N82CPIAF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Darrick,

On Thu, 18 Jul 2019 17:30:45 -0700 "Darrick J. Wong" <darrick.wong@oracle.c=
om> wrote:
>
> ... oh, this is some weird "mash all the kernel headers together and see
> if they compile" thing, isn't it?  Um, yes, iomap.h should only be
> tested if CONFIG_IOMAP=3Dy (which in turn requires CONFIG_BLOCK=3Dy)

Actually it tries to build each header file on its own to see if it
include all its dependencies.

--=20
Cheers,
Stephen Rothwell

--Sig_/nX4Jeu6sxuCZYl9N82CPIAF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0xEYYACgkQAVBC80lX
0Gwjnwf/cpxl9GjFax+XTHpFksObgF3XDfOvv7FrK++PfETXXai/cL9CmG4r0KSY
m/s7MXlV83ONX4PmSB3LdMjMcPjYZFtuv5ZQ5LsAyupecwuJNDH7MEfH6F5pmx05
h4DEWwQTSauxRA9GXqUGApYNrzbXcauaUMy1kWyKO95owuNdQWFS5mGq0n3jL2dN
ClrPQuZZwPjvBRfrlJfJVe4/P8YluO5xJSGDCcFGmjiMc/zB71DoOHjWpP4ttS9J
/9J7EiaibV7dKQz6fl0uF5HnAyi2i0aD3/HCx4drT+kbMUWiohHlmxXJLyr5BW7j
tQAdbePufT0htEO3/XVLcm3+3PDyLg==
=GzlS
-----END PGP SIGNATURE-----

--Sig_/nX4Jeu6sxuCZYl9N82CPIAF--
