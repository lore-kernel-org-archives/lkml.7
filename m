Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B70BC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34C32184E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563899709;
	bh=+qWhcg6cGcPt9JTmOfRR3oQ1lQdVFnaokFDUOzuiZ+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yRWVxMlxMLafeID2EtAz6NPaAVXECZz99yZRjd2LzT866Yqd0khZczaxKLxKBzsxi
	 0VCkG8aX9jex+HfjDXGoGaAsKxEQHgCh2gatENgr/RpX4XiUoeTagDHKXoVXb02/1z
	 Ngt7MNEACC0+F7AZBb6FkM5+hYHnTTtXFZF7gY+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390884AbfGWQfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 12:35:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51694 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbfGWQfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+qWhcg6cGcPt9JTmOfRR3oQ1lQdVFnaokFDUOzuiZ+s=; b=edn2N8z+zEfeWwyh5fLI+ISAA
        LHPR9DSKwGUjE4NhoM2O0ZsKzaEKPCf6PCUuDBOZ/0wdNB29Oyu1X0sdFgZhxgNxKRNNThfXoIiWi
        fgULF+L0BSOZj+DtMW79iDyILWfJTTAgKFR4vbjc2UdrNQlJ6bqZgjlUCBuM69+vaD5iw=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpxkm-0004GG-1q; Tue, 23 Jul 2019 16:35:04 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3949F2742B59; Tue, 23 Jul 2019 17:35:03 +0100 (BST)
Date:   Tue, 23 Jul 2019 17:35:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFT] regulator: lp87565: Fix probe failure for
 "ti,lp87565"
Message-ID: <20190723163503.GL5365@sirena.org.uk>
References: <20190711113517.26077-1-axel.lin@ingics.com>
 <20190723112647.GE5365@sirena.org.uk>
 <CAFRkauDSbmtGRnE0xvKOKxb=SWOA+03i60Wu-9KHYxh1qFuCEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="umrsQkkrw7viUWFs"
Content-Disposition: inline
In-Reply-To: <CAFRkauDSbmtGRnE0xvKOKxb=SWOA+03i60Wu-9KHYxh1qFuCEg@mail.gmail.com>
X-Cookie: Avoid contact with eyes.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--umrsQkkrw7viUWFs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2019 at 08:28:35PM +0800, Axel Lin wrote:
> Mark Brown <broonie@kernel.org> =E6=96=BC 2019=E5=B9=B47=E6=9C=8823=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:26=E5=AF=AB=E9=81=93=EF=BC=9A
> > On Thu, Jul 11, 2019 at 07:35:17PM +0800, Axel Lin wrote:

> > > The "ti,lp87565" compatible string is still in of_lp87565_match_table,
> > > but current code will return -EINVAL because lp87565->dev_type is unk=
nown.
> > > This was working in earlier kernel versions, so fix it.

> > This doesn't seem to apply against current code, please check and
> > resend.

> I re-generate the patch but the new patch is exactly the same as this one.
> It can be applied to both Linus and linux-next trees.
> Did I miss something?

It's a fix so I was trying to apply it on my for-5.3 branch.

--umrsQkkrw7viUWFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl03NzYACgkQJNaLcl1U
h9A6kgf+IJyaBXM/vls0JV29Ss2VbJ5zJhdHdvhCHs/aqqAxRbdWFxIJaTYfPeMa
UB6fmoUdCbu3RILvkYEkp1ld/kkXRu0aZf+MOyVEXvIhWQMMMe/56+a4mJiHyjaW
AaQDYVfaorb+wY0jBumVwU1eZZSKaE2lqdUEYCNFF/2O9nUSEOPlZWGXPSt9JpgO
bmWoURiTp8Ff+Lg9DkUvbnuVr7j5Rvpcl3GgSgpkqnPA2H2gNFo9M1dJTOmI1/5Y
+VsxM9uXpa9jRYB6nZ+5cJKA6fLhcN/UJRDCbSz5+dlV4PXXNxb8JgzMNbljcgoc
LUIbQpe6AmHYfFNxqlytdiLlgcY7LA==
=K5m9
-----END PGP SIGNATURE-----

--umrsQkkrw7viUWFs--
