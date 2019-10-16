Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F12FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4702168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393171AbfJPOun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:50:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28125 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730251AbfJPOum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:50:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A66E89F302;
        Wed, 16 Oct 2019 14:50:42 +0000 (UTC)
Received: from localhost (unknown [10.36.118.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0A5760127;
        Wed, 16 Oct 2019 14:50:39 +0000 (UTC)
Date:   Wed, 16 Oct 2019 15:50:38 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] vsock/virtio: remove unused 'work' field from 'struct
 virtio_vsock_pkt'
Message-ID: <20191016145038.GH5487@stefanha-x1.localdomain>
References: <20191015150051.104631-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EemXnrF2ob+xzFeB"
Content-Disposition: inline
In-Reply-To: <20191015150051.104631-1-sgarzare@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Wed, 16 Oct 2019 14:50:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EemXnrF2ob+xzFeB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2019 at 05:00:51PM +0200, Stefano Garzarella wrote:
> The 'work' field was introduced with commit 06a8fc78367d0
> ("VSOCK: Introduce virtio_vsock_common.ko")
> but it is never used in the code, so we can remove it to save
> memory allocated in the per-packet 'struct virtio_vsock_pkt'
>=20
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  include/linux/virtio_vsock.h | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--EemXnrF2ob+xzFeB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2nLj4ACgkQnKSrs4Gr
c8hxgQf/fJM59TTkQU6f/aLvKMLRivTzsa1Yz/4hy25NeYI++lHojSBwzdtd1BxY
PF945mWrEnCumX+FOqHdpwX6oRU4bnJ0pc3kzHPrxnLYoyHT1NYNPnEHnaZERFfP
7OdE3RMXooLx+JM7MrIn8Fh/ElR2Bi4JhUw+zOUMEO96aY+HIJ7cAPsDG3QTHinj
TL4WUjSRZEqwfZKvJ0TiydqJR/RKjpNEi1bYrTV9TzW84/5AmWternJ3sS76dH3w
2Qb9yLIBpDSbOnohYQQunrl8VuYdeCw2w0NZc9jsbslAgs6yc5EIE/6PoX//fwOn
Tf1ER5hbSetx0Lk+7Jaw3eVDH5r6Uw==
=GpdO
-----END PGP SIGNATURE-----

--EemXnrF2ob+xzFeB--
