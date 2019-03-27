Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73010C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EEE2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="r3eILaMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfC0LcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:32:06 -0400
Received: from ozlabs.org ([203.11.71.1]:45467 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfC0LcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:32:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Tm741Swkz9sP8;
        Wed, 27 Mar 2019 22:31:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553686322;
        bh=IO1KfowyS0+LtyRURqLYVXrlpNyoy+OFe4t2lGoAmnQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r3eILaMndQJoZxUnFT8YWRgDOA8G7XjGyB0VbJYPITz0dar9ep55nRL9rwJZhYZpR
         QSSCUAmpAQPAXRBMXa/GJFV9CTxELdK7nuO7T7fHJNu8lONqxcTuBNwC36LSfn1Uki
         TArVjqzmusFQrwCl+brNyAikUqIIOJoUBcmh8+AmcCjDSTTp0/Cqf2SI+TLSqcJGfd
         vMDir9V/3JxQHI7LVGoO9oG5wB+w1j8NyIulNeRRL9kA3mM1TnDZrDCySBC2HzKuUe
         yNJJnqkdR6qO7zUT9RpZyeVoyzSSC9+uBrkz82tRVfC/dCH2EbV/eUZJux4Nv+TErK
         dHgsHPPwLNXcw==
Date:   Wed, 27 Mar 2019 22:31:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     DRI <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Paulo Zanoni <paulo.r.zanoni@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: linux-next: build failure after merge of the drm-intel tree
Message-ID: <20190327223129.53ce82d6@canb.auug.org.au>
In-Reply-To: <155368485987.8699.12849690159482129286@jlahtine-desk.ger.corp.intel.com>
References: <20190327135904.7830c60c@canb.auug.org.au>
        <155368485987.8699.12849690159482129286@jlahtine-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/HEkKaYgDvwlsgpZofC+D=3+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HEkKaYgDvwlsgpZofC+D=3+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Joonas,

On Wed, 27 Mar 2019 13:07:40 +0200 Joonas Lahtinen <joonas.lahtinen@linux.i=
ntel.com> wrote:
>
> Quoting Stephen Rothwell (2019-03-27 04:59:04)
> >=20
> > After merging the drm-intel tree, today's linux-next build (i386
> > defconfig) failed like this: =20
>=20
> We had a CI reporting mishap, where a failed 32-bit build resulted in
> a misleading success e-mail being sent.

It happens.

> The tree is now fixed and we'll investigate the problem to avoid such
> a false report in the future.

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/HEkKaYgDvwlsgpZofC+D=3+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlybXxEACgkQAVBC80lX
0GzmKQf/Y3drSHltVV8A5o+ooBYdz9JFigcnRBqrrS7FF/CGGOhNAz/oB63jIRdo
c3nodtXz9EBRs0ceY3oGVmswoc+RlTwqn5VfPawDP1wYSL10gaUhvzlNHnKFgNZu
3mCu6hSKYn7l5wmQuBRjWlXJCu1zKy/Jg6DpeYhrl2GwPgCJgbyQUsH4m4vmq7FN
WoTgkoBg6wETaPQrghgTkpo4dAhZ1abkxGa35ePwsM3GIDlh+IHrqVQYh4SHgsCu
C4dixJocZYBrM2h/l3FIV/sQVAXmHvv07QQmZz4yb1MB6T1lBzzgYnn+0Qpc0j3g
jI8lvBLjONBIPLpRmQEdRKjZ1/L9Rg==
=3dkF
-----END PGP SIGNATURE-----

--Sig_/HEkKaYgDvwlsgpZofC+D=3+--
