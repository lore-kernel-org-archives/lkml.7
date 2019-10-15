Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D72ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F88920873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfJOIF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:05:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:59616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728350AbfJOIFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:05:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BB241B562;
        Tue, 15 Oct 2019 08:05:53 +0000 (UTC)
Message-ID: <453a9a954f4967a68a7023c8c79a39fdcb69254a.camel@suse.de>
Subject: Re: [PATCH] sh: use dma_to_phys() instead of dev->dma_pfn_offset
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Date:   Tue, 15 Oct 2019 10:05:52 +0200
In-Reply-To: <20191015074354.GB3464@infradead.org>
References: <20191011165129.29655-1-nsaenzjulienne@suse.de>
         <20191015074354.GB3464@infradead.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-LqhdFNFQbXFXXko83wzg"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LqhdFNFQbXFXXko83wzg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-15 at 00:43 -0700, Christoph Hellwig wrote:
> On Fri, Oct 11, 2019 at 06:51:29PM +0200, Nicolas Saenz Julienne wrote:
> > It's more explicit and lets dma-direct handle the specifics of how to
> > translate addresses.
> >=20
> > On top of that get rid of warnings as, since the introduction of commit
> > 6fa1d28e38c ("sh: use generic dma_noncoherent_ops"), it's impossible fo=
r
> > the dev to be NULL.
>=20
> This looks ok, but the real answer is to switch sh to the generic
> dma remapping code.  I've been trying to get this included for about
> a year now, but never managed to get a reply from the sh maintainers.

I see, well I guess this one will get ignored too :)

> Here is the last one:
>=20
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/sh-dma-re=
map

I'd be happy with your series too.

In case you're wondering why I want this: I'm interested in supporting mult=
iple
dma-ranges in DT. So I was looking at the amount of work needed to centrali=
ze
usage of dev->dma_pfn_offset. This one patch seemed trivial enough to send
right away.

Regards,
Nicolas


--=-LqhdFNFQbXFXXko83wzg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl2lfeAACgkQlfZmHno8
x/7FnQf/fWogNvidITqlQcsKCGc7oeRASPSjW/lRMdE4n3pH/nBJe8zF9LqxNsZj
n0yCrXQfiJt9fVzHMLjWmi7vrC8/e7MQ94nqYnK9R1E9KPKnkriRFU0ux2ahlU8l
xXHa0Q0momOpZimYl5rR0rYVVi1nrhkRl8TUJn2WAAfO2X+z9r1O2LwWTAVmR6yL
wIG81FoN1wXzZShor97MX7RAivRQ5HwediXU6o1GOjsqRPl8K8YvCFDuTnXH6iGZ
7TvnaGzKy0flfbvihDOCUNCLYTIy01aq/lqxBDl0/O9yOuRwNjfD8GekckaOx3p6
GJk1+BKLk3RydGJXLzJn37JhXq2eqg==
=h442
-----END PGP SIGNATURE-----

--=-LqhdFNFQbXFXXko83wzg--

