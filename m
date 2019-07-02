Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E4CC06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB1420673
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WMj7A9iQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfGCBRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:17:05 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47337 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfGCBRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:17:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45dd3V6xTLz9s3Z;
        Wed,  3 Jul 2019 07:41:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562103688;
        bh=MorrFaVnjRPpb/j0w/ycYarnWEzNC23UdOM4rLCRAw4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WMj7A9iQnoAZ9HJYlZX8ZoOWX7U2c1Oqr19Jqz0WawEE/jMP+c5PP0lPDhDcazPgR
         8NfPtWJJuPpybsTfuK7I6EsXbN9JwQSH4ah5VfrfYCtbAzhlMmwgFKkwBpzgx/l8/l
         XulffRZCh++zks4Q839C5hpLZ1+e4kPr4FDo8UAbCeNvg7sZRJzcKNet9rku5I7NfI
         B8NLjJd89BoSH28h5G/mie+6wPxEaHW0TiPYF0Y89pQXhrIZ4wTF3/t9n+n0+Bc0UF
         xqh56sll8PunE1f6L988lwDdgrvwlXLT+rjFnGypioHp4DSCs4VcYzTFu7jp6984+b
         s3PHqH3CFklAw==
Date:   Wed, 3 Jul 2019 07:41:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 driver-core tree
Message-ID: <20190703074109.4b2ca5bc@canb.auug.org.au>
In-Reply-To: <20190702130511-mutt-send-email-mst@kernel.org>
References: <20190701190940.7f23ac15@canb.auug.org.au>
        <20190701200418.GA72724@archlinux-epyc>
        <20190702141803.GA13685@ostrya.localdomain>
        <20190702151817.GD3310@8bytes.org>
        <20190702112125-mutt-send-email-mst@kernel.org>
        <20190702155851.GF3310@8bytes.org>
        <20190702130511-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/10I6MeCphAWQjths92+eNZc"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/10I6MeCphAWQjths92+eNZc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 2 Jul 2019 13:05:59 -0400 "Michael S. Tsirkin" <mst@redhat.com> wro=
te:
>
> On Tue, Jul 02, 2019 at 05:58:51PM +0200, Joerg Roedel wrote:
> > On Tue, Jul 02, 2019 at 11:23:34AM -0400, Michael S. Tsirkin wrote: =20
> > > I can drop virtio iommu from my tree. Where's yours? I'd like to take=
 a
> > > last look and send an ack. =20
> >=20
> > It is not in my tree yet, because I was waiting for your ack on the
> > patches wrt. the spec.
> >=20
> > Given that the merge window is pretty close I can't promise to take it
> > into my tree for v5.3 when you ack it, so if it should go upstream this
> > time its better to keep it in your tree.
>=20
> Hmm. But then the merge build fails. I guess I will have to include the
> patch in the pull request then?
>=20

All you (and the driver-core maintainer) need to do is make sure you
tell Linus that the merge requires the fix ... he can then apply it to
the merge commit just as I have.  Linus has asked that maintainers do
not (in general) cross merge to avoid these (semantic) conflicts.
Sometimes, in more complex cases, it may be necessary for maintainers
to share a (non changing) subset of their trees, but this case is
pretty trivial.

--=20
Cheers,
Stephen Rothwell

--Sig_/10I6MeCphAWQjths92+eNZc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0bz3UACgkQAVBC80lX
0GzicQf/dn2NLumpiNgDiKhDjQHDmIflcbEz96E8ZDMp2tfw7qndD4faMaO/28aA
MAp5jUA3oberdrKjDR8PYeNv/x3u0D4zqI/Tgqdof64aeWPeMgdE6T8khMhb4FZI
onEPyVzZpA926K8unDteO7mfFLEqiyVJi7Iw1Wij2zm2NHTIFjMp5HYmyhaSsLxs
/hVEm4zaNcHrw+QdE+Rm9tpT5w0NSKzBP+eXISyRsoqm7JVBVzRixApQa14wfnh4
QknkwsrPSk+Vo4yrFhHciVs4VfweT044j8P5K30CLeNk9SQ8AQOmzcRlZUNw6I/X
PYQLovVVb4jLn0xV4EfIULcT7gvmqg==
=JGpW
-----END PGP SIGNATURE-----

--Sig_/10I6MeCphAWQjths92+eNZc--
