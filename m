Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A56C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 03:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCC92166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 03:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dzycMjTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfGIDL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 23:11:29 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34459 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfGIDL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 23:11:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jS5V2FSmz9sML;
        Tue,  9 Jul 2019 13:11:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562641886;
        bh=VBoxWR+50ZGyksTH5yBOU1Om+w5nu2WIrA1jcIXIrU4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dzycMjTrO/QsKznZiOrSCEQ0tAhD36Nq5btf0wc7JAwt6Vn64HwHwPz6i49LarzKF
         acef3sSC4xTfwn3roOk6G1lTvldDceQQ4N0kwbcVQjNX7/JB+bVWUkv8eQHy18mLsy
         5AObkUZeV5u4y7LIGN4xzehK1Ow1ha2bdR94obeoQm1fH+lkvWZ0/qjX5iWSY912Sf
         mUlqh/KJ3rzWf1CUtHkSELbmz9H5JH0u3Q3yePVtzg1pOR4OAsleydF84LEnLlalCL
         evSV4OWkMrAYrLBQdzEsJPtmoUFMhK9kaMFwKPggT2lH4D4+8XmTeChyfDUDIYxzvU
         uaNrR41q6pCSw==
Date:   Tue, 9 Jul 2019 13:11:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kamenee Arumugam <kamenee.arumugam@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: linux-next: build failure after merge of the rdma tree
Message-ID: <20190709131125.6f418604@canb.auug.org.au>
In-Reply-To: <20190708160823.GH23966@mellanox.com>
References: <20190708125725.25c38fa7@canb.auug.org.au>
        <20190708160823.GH23966@mellanox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xpRz/sKV_eSTYFZMnZeN56N"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xpRz/sKV_eSTYFZMnZeN56N
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Mon, 8 Jul 2019 16:08:27 +0000 Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> From f10ff380fd7dfba4a36d40f8dd00fe17da8a1a10 Mon Sep 17 00:00:00 2001
> From: Jason Gunthorpe <jgg@mellanox.com>
> Date: Mon, 8 Jul 2019 12:17:48 -0300
> Subject: [PATCH] RDMA/rvt: Do not use a kernel header in the ABI
>=20
> rvt was using ib_sge as part of it's ABI, which is not allowed. Introduce
> a new struct with the same layout and use it instead.
>=20
> Fixes: dabac6e460ce ("IB/hfi1: Move receive work queue struct into uapi d=
irectory")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

I applied that to linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/xpRz/sKV_eSTYFZMnZeN56N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0kBd0ACgkQAVBC80lX
0Gw93wf/SQWCdSWkpPFGR32ZzI8fL6eoL9YxZn04jTHTC86aqB1JspaIfU9xigm1
y0sSlxesiknfHp7oIK8NWdLAYxYis5yHr5yYq9b1VdM0JvIsWYzR5j2wtXReFxlC
tGWHTdsr8Vsb2RzroMnC8j3DEhvqgGS8DKzVQbuBTcriQVEg4pOzSbyFl5KtgbB2
gjWyN67CPPs6gRPPYLtXaxiUkqk9cl4eTYYwwIZq5CUXKSdubbH36zZTwSiFdkYi
F3iZ8RzryCbt2YccPpYEtOKACt9HSS7sc/yriAaQaiPzN3EoNH73ssdGI2UJZST4
Uu7toaOvC5uz4AdSqUGhH2TbRaBoRg==
=FhlC
-----END PGP SIGNATURE-----

--Sig_/xpRz/sKV_eSTYFZMnZeN56N--
