Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C75C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3223B206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfLKTM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:12:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:60884 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726312AbfLKTM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:12:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E77CEAC44;
        Wed, 11 Dec 2019 19:12:56 +0000 (UTC)
Message-ID: <caef320ed82f3e28065920d037805f18c29e4156.camel@suse.de>
Subject: Re: [PATCH v2] iommu/dma: Rationalise types for DMA masks
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, hch@lst.de
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        stephan@gerhold.net, natechancellor@gmail.com, arnd@arndb.de
Date:   Wed, 11 Dec 2019 20:12:54 +0100
In-Reply-To: <00d1ddf9439a8c79fb561b0fc740bddf9e6fe6b1.1576089015.git.robin.murphy@arm.com>
References: <00d1ddf9439a8c79fb561b0fc740bddf9e6fe6b1.1576089015.git.robin.murphy@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-XICR1gKRvP0/o9JFpxGW"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XICR1gKRvP0/o9JFpxGW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-12-11 at 18:33 +0000, Robin Murphy wrote:
> Since iommu_dma_alloc_iova() combines incoming masks with the u64 bus
> limit, it makes more sense to pass them around in their native u64
> rather than converting to dma_addr_t early. Do that, and resolve the
> remaining type discrepancy against the domain geometry with a cheeky
> cast to keep things simple.
>=20
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Thanks!

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>


--=-XICR1gKRvP0/o9JFpxGW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3xP7YACgkQlfZmHno8
x/7FiAgAnId4C31mAw6taCSWTYRlI5XzSRM3BWgQ8VW3hnuQJR+8BW9AslfYp1jC
O8Jf22GL7el60MA/jpECLMqmrNryEyysbkQPP+Cxe2ol9bXVCoD2fKnL7kDMwQhi
d5UUU/c7QmHEKucH/BSJpoMrWtz1ljl2dpIh+IFIV0HuCtavfnhqUq1O+whYwiFe
zLow9a+pLjMjKd5y0ZGKFdSiS8ITDk0k1AO1nj2LnUUDEhwu4gv7rZWGrFJP+H4n
vehYQtW88O62CiH3EPBrG4Ge/YxwNhfH+W/q4uxKiQFbBeH9xlvN/AzwnQPYr5/I
2yWOkUHdujJwNhd/h5zdf9gk2Y7vlQ==
=WZQI
-----END PGP SIGNATURE-----

--=-XICR1gKRvP0/o9JFpxGW--

