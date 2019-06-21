Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13064C48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57DC208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BrskgRFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfFUIgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 04:36:49 -0400
Received: from ozlabs.org ([203.11.71.1]:47631 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfFUIgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 04:36:49 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45VX994m0Fz9s3l;
        Fri, 21 Jun 2019 18:36:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561106206;
        bh=ZlhWhI4DfW1N6bmx8poJ/T6Z6DiwcVEOB8XO8Mu/ruo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BrskgRFT8quZnsC5nJzlwIRCiJ7WDzODd0kKqWUZDdgWqWS5HAmI5gcPuULc3PlbR
         vOFP7y6Th620AGQqR1ncPLvexiGHurH8UTejZ8DMNGjfZHa/mG5qUV8urDAhiGDngl
         GhWCMTAnM0MAR0EaZA/QcT7n5dX9JaSldqsos8gLvvrU4HWEwdHvTYwI3fimEIBiFO
         uOXtkxJhxL6yJH8+Tc/MeGpeet4q8L91FK0/mdHb/jueFCWsl0ETGkCYN08UzmhkVz
         7p9i/v6ktRGtei4FbNwDNcm/2v3EEdQisOdzWNmidFTAAPiyL90HaUNM+LQFs/CxPW
         81foCDv2byyrw==
Date:   Fri, 21 Jun 2019 18:36:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the block tree
Message-ID: <20190621183643.0e9f3fbd@canb.auug.org.au>
In-Reply-To: <20190621081836.GB17718@lst.de>
References: <20190621135616.20299058@canb.auug.org.au>
        <20190621081836.GB17718@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/t_mFD+sROxCPJ=pV27kzbzz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/t_mFD+sROxCPJ=pV27kzbzz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Fri, 21 Jun 2019 10:18:36 +0200 Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jun 21, 2019 at 01:56:16PM +1000, Stephen Rothwell wrote:
> > Hi Jens,
> >=20
> > After merging the block tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >=20
> > ERROR: "css_next_descendant_pre" [block/bfq.ko] undefined! =20
>=20
> I think the culprit is "bfq-iosched: move bfq_stat_recursive_sum into the=
 only
> caller" as that starts using css_next_descendant_pre in bfq.
>=20
> I'll send a patch to export it.

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/t_mFD+sROxCPJ=pV27kzbzz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0MlxsACgkQAVBC80lX
0GwWswf/eJZbR3bc56RwbI8GYx87fxwAg6ggyAQMAG2Lazt5yD9bsMT4HVwwpArK
US93+lcBfQfN/5BDEyegFyDc/F0uMBRAeGBWWSzjENesUIMZ4D22wMBMZj/LzQJm
H1jBBVxt+OISoVp8pQJFNPoGW1aZYwpQ4tderJOJ8Tq+dnKaeJYQMoJTnTjlnhpR
GlX5zLyJq7RuQf4LhcX8t5xSsMLgqTt5q6nJz7OMKTcjidYLPmBqPHTHh2M8K01g
5cMC6k3eySpISYC0/LK7Pi+XRkEM3GyVWF0VE+HnwPYPsffm6MyDJ7JgVfk8zVMe
Zy1nSiLrq0jhSvNCtbnDBnph+fS+fA==
=gusO
-----END PGP SIGNATURE-----

--Sig_/t_mFD+sROxCPJ=pV27kzbzz--
