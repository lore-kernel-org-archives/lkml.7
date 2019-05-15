Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0EDC04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5BC20843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ww/4BnvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfEOAoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 20:44:34 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60295 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfEOAoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 20:44:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 453bRN1qrfz9sB8;
        Wed, 15 May 2019 10:44:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557881072;
        bh=ALoQgvrnB/cJU5NKPqYhvCpW2wWu4vyxyzyUd2h9JJg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ww/4BnvCEJl+7cRw5Kzz5zpYt7BhJFpBO87+3exat+/nEuzqbzah5utQWanRCNv7X
         QUow9naC3wKJhwAxUEoisRZuZbIZMgE1wojPIVrwIe8Vh12gY2NT+1ShDhcgYCl8/A
         psZQulkXBV1zoTa+uerodkHjA6c/m5ldxjvemdf0FCOQavai35TAvATj5pGGCeBEZx
         08AbNHmwa4T7/cbNeMptBgH3k6OMbFKM808q4fCRFR4nLM4ychws/UKy9UDLHl6Itv
         3YxHuRg/DlzY4PpwPmiVGsipBaUpEGrGI61b3NOyqiLWpyWPzR63nWXR7U7dn0Y3uG
         djaoZ29ioXSjw==
Date:   Wed, 15 May 2019 10:44:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Talel Shenhar <talel@amazon.com>
Subject: Re: linux-next: manual merge of the thermal-soc tree with Linus'
 tree
Message-ID: <20190515104431.5e353729@canb.auug.org.au>
In-Reply-To: <20190514141531.GA16968@localhost.localdomain>
References: <20190513104928.0265b40f@canb.auug.org.au>
        <20190514034409.GA5691@localhost.localdomain>
        <20190514144006.60df13bb@canb.auug.org.au>
        <20190514141531.GA16968@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/uTS4l0NsRToI.fEYJBxFZ_1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uTS4l0NsRToI.fEYJBxFZ_1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eduardo,

On Tue, 14 May 2019 07:15:33 -0700 Eduardo Valentin <edubezval@gmail.com> w=
rote:
>
> On Tue, May 14, 2019 at 02:40:06PM +1000, Stephen Rothwell wrote:
> > Hi Eduardo,
> >=20
> > On Mon, 13 May 2019 20:44:11 -0700 Eduardo Valentin <edubezval@gmail.co=
m> wrote: =20
> > >
> > > Thanks for spotting this. I am re-doing the branch based off v5.1-rc7,
> > > where the last conflict went in with my current queue. =20
> >=20
> > Its really not worth the rebase.  Just fix the build problem and send it
> > all to Linus. =20
>=20
> Yeah, I think I was not super clear in my first email. I am about to
> send the content of my branch to Linus.  This specific conflict was
> because a change in MAINTAINERS went in before the change I have in it,
> causing a conflict there. The rebase is simply to make it easier for him
> to pull when I send the git pull.

Linus has repeated told people not to do that.  He wants to see the
conflicts.  You should mention any conflicts you know about in your pull
request - just as a heads up to him.

However, if a conflict is particularly tricky, it may be worth while to
a test merge in another branch and tell him about that other branch in
your pull request.

--=20
Cheers,
Stephen Rothwell

--Sig_/uTS4l0NsRToI.fEYJBxFZ_1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzbYO8ACgkQAVBC80lX
0GxFZggAkigHuDUvAYNu/uw54AEl7CZreJllX9bepthDOydVa+XIVsMgUEMbpcXl
r+CB+XIpZpvW7s5gTH7znt0qSEszkjdOM/+gaOpF0BN37lpx0+nitJaZPk8kUg98
OvpHr0P2S/87M/PUbCXSn43pEZlKIC7q94OB5jFkkBgYWtZ+K99Ux2t2zLYKGD7D
ztdu3yhP4orVqHulmHUca9TcJBQxiVqzGBQtoiUyHpU/A7sXw5POnZQ7Tq2XDLZT
XX6vYJ+msIREeDukfNLejL8O3xhzYZP8jnFgcAC1t2gX9rM+7mDcphiVQVLb0Eee
RqRbAUuKQlM0bN1P2u12nNgF++a8Kg==
=Hyzb
-----END PGP SIGNATURE-----

--Sig_/uTS4l0NsRToI.fEYJBxFZ_1--
