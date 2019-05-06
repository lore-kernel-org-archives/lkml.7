Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9045FC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 20:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE7B2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 20:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mY2Uh06A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfEFU6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 16:58:16 -0400
Received: from ozlabs.org ([203.11.71.1]:33651 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbfEFU6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 16:58:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44yZnt0pW8z9s6w;
        Tue,  7 May 2019 06:58:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557176290;
        bh=rp6uXvZ1QO/O4YYacxR96AjQ7HnXUFdddfUoH4MZ31w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mY2Uh06AeFzrVpaSgm7+yoVw0gnQduihMjdw5O7D4eS0VfWO/WJMmKh6yOI0cShY+
         LjyGaChP08jO6khGisyQ7n4n0yi9cf+bvigKC/nIVx/a3hQVyCsHU0kTtrgepbAOT2
         KjEwJtNfhBHsD/61R5qCUaJR0xVrCzLv9IGxAX77F4ABnnTed6fnWQvP/OYARlbLtg
         6jnYwuU6TmLBT9sm0YK4gEpCOb0cgdvinFb8jcRuNzTH7nW6pyYCrv4ZKFJBb/uOgE
         bTwiIFoqOyRj2EgKLOebQ4T2FTlLoLyqmmUYx+DotpH/F6IlmHfZqoIh3u75G9oz7Z
         QPYN5iyhGxE3Q==
Date:   Tue, 7 May 2019 06:58:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Richard Weinberger <richard@nod.at>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: linux-next: Fixes tags need some work in the mtd tree
Message-ID: <20190507065808.342affcb@canb.auug.org.au>
In-Reply-To: <1062675236.47533.1557175510785.JavaMail.zimbra@nod.at>
References: <20190507064008.1ecba58b@canb.auug.org.au>
        <1062675236.47533.1557175510785.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jaCURDb/sWOipUNbN1OZiTN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jaCURDb/sWOipUNbN1OZiTN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Mon, 6 May 2019 22:45:10 +0200 (CEST) Richard Weinberger <richard@nod.at=
> wrote:
>
> What is the suggest approach to fix that?
> Rebase and force-push?

It's probably not worth it, just remember for next time.

--=20
Cheers,
Stephen Rothwell

--Sig_/jaCURDb/sWOipUNbN1OZiTN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzQn+AACgkQAVBC80lX
0GzfjQf+M56nIpDb2DBOcK0+IcPxEjAE1mn5E0BJroWWrN7TtSog0BbCGXgVWFNg
WFpAtfBCbmE+sHreBZbPKNkt3HKQ9qVvm0iknJb1TCWVb68mhph/Xc2opvlvT29F
2JCklHwKs8Q7QDZo1y825d9Se1q7ZrevmLUGy4hf2FasLhF4y5FHt8RSzm7QBBll
dNAZyD1tnJBkvvCAcAowi0PTzbO6leogzDQ1nv1ss4xGnHpitpoeQC02fMm7jjma
YY4b9EHw2QaqumlRgnsUd4mi2QjLMmLISCYjg3Z68s6SxMt9OFpRJg443bm3tJV6
RSZxW9KKT6Q2r0oayc06ypzM44q3UA==
=agRq
-----END PGP SIGNATURE-----

--Sig_/jaCURDb/sWOipUNbN1OZiTN--
