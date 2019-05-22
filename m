Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CC2C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD805217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="k5sXZjUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfEVIFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 04:05:30 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51849 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfEVIF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 04:05:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4584tv296Vz9s6w;
        Wed, 22 May 2019 18:05:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558512327;
        bh=5k9DDli4sG5wljC2UtgesCL45vdVEt97tqs5ZqtEYUE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k5sXZjUp3WUaxnzzELFNlHAJfR4ozkKFnmSjKQYbsdel3a6an4u41EQv0oNmWrdIO
         FTeNhjLhBCdN5I5CGx3SORI4LO+SJ+8RaWfBC90rCQxar+qZCOf2Nd8ink2kmfHQUX
         FIspdqkMWBC1JaORz9xFpr3NnYhpZEffWkFVjPe5gJo4sWbs9XRO1ZuZyHbQXSQVz9
         r0BSlGDvKMlwbvsaOizrY6IrTvT7QssniGuiY4sl6im6Mo8PSdO8ZxkFQHTCWpUqw7
         BkoTp7cFDbGvwr4QCNW/7ro3nlnHX6b6GnEtWTYSDenDpeR/BaqxTUefcrLjQ2EdVi
         Itijl2OrZvh1Q==
Date:   Wed, 22 May 2019 18:05:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <christian@brauner.io>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: linux-next: manual merge of the pidfd tree with Linus' tree
Message-ID: <20190522180524.4e751614@canb.auug.org.au>
In-Reply-To: <CEB120FD-547A-4D92-92AE-43E6AF8E767B@brauner.io>
References: <20190522110115.7350be3e@canb.auug.org.au>
        <20190522055235.GC13702@kroah.com>
        <20190522174725.6bfd51bd@canb.auug.org.au>
        <CEB120FD-547A-4D92-92AE-43E6AF8E767B@brauner.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/dMu_ynlLlbctLrd4FLVcZ.g"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dMu_ynlLlbctLrd4FLVcZ.g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Wed, 22 May 2019 09:55:00 +0200 Christian Brauner <christian@brauner.io>=
 wrote:
>
> On May 22, 2019 9:48:33 AM GMT+02:00, Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
> >Hi Greg,
> >
> >On Wed, 22 May 2019 07:52:35 +0200 Greg Kroah-Hartman
> ><gregkh@linuxfoundation.org> wrote: =20
> >>
> >> Sorry, you are going to get a number of these types of minor =20
> >conflicts =20
> >> now.  That's the problem of touching thousands of files :( =20
> >
> >Yeah, I expected that one I saw the commits.  At least is is just after
> >-rc1, hopefully most maintainers will start their -next branches after
> >today :-) =20
>=20
> I can just rebase if that helps you out.

No need, those conflicts are now in my "git rerere" cache, so I
hopefully won;t have ot worry about them again.

--=20
Cheers,
Stephen Rothwell

--Sig_/dMu_ynlLlbctLrd4FLVcZ.g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzlAsQACgkQAVBC80lX
0GwKKAf/Vdk1+Zg9m6WG2lmqpxpqn+xy/BChQkXfXN5ruj7oAAtTHoGzrIAQQFPz
hLDIFxyEjZ+VIloEKY7TH4MYSvvRX3kO7I+TyWJsEtNMB1yH+Ko6DYIdnHXk1o1I
seWD+lypo2SUcYPbQuP770f3lKQeFrTtRjtTRoQL/iLDrriJTLn4jQAYOBhlVX6J
zppqWx0MU1f9JaFlYeoa9xSrNtsaq/rlf3p4le3mH0kjfsIG6HF1Wk3/+SKyOabP
VpIi25Vyd1kAbrVn2wa/Uaez0yxFbPoHbuQYz4AgMCQ/AGNNaBzPvZKEa46O4Vl9
hyVSHBP5nzzGBlis1XSbJgXRYQf4IA==
=S8wa
-----END PGP SIGNATURE-----

--Sig_/dMu_ynlLlbctLrd4FLVcZ.g--
