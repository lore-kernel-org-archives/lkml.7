Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED529C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4E62082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388662AbfIFKp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 06:45:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfIFKpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:45:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9468D878E46;
        Fri,  6 Sep 2019 10:45:55 +0000 (UTC)
Received: from localhost (ovpn-117-208.ams2.redhat.com [10.36.117.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0ACE81000321;
        Fri,  6 Sep 2019 10:45:49 +0000 (UTC)
Date:   Fri, 6 Sep 2019 11:45:49 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 04/18] virtiofs: Check connected state for VQ_REQUEST
 queue as well
Message-ID: <20190906104549.GL5900@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-5-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L/Qt9NZ8t00Dhfad"
Content-Disposition: inline
In-Reply-To: <20190905194859.16219-5-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Fri, 06 Sep 2019 10:45:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L/Qt9NZ8t00Dhfad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:48:45PM -0400, Vivek Goyal wrote:
> Right now we are checking ->connected state only for VQ_HIPRIO. Now we wa=
nt
> to make use of this method for all queues. So check it for VQ_REQUEST as
> well.
>=20
> This will be helpful if device has been removed and virtqueue is gone. In
> that case ->connected will be false and request can't be submitted anymore
> and user space will see error -ENOTCONN.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--L/Qt9NZ8t00Dhfad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1yONwACgkQnKSrs4Gr
c8hiJQf/RcdMwTruxvR/8Bl1CjfN+mUt21UCtv0K/otHklhGEdna7AzGT1QFFBqi
iyQUlYckbqC72mhKLNOWT/I8JJkq3jUS+xUf2i/qzNv/4B3yVfCFazfumOIcb7P+
XriTd61VYMSaPfJRPXLvn+oxLknVB9LohRBQHZc0ljt339uGCt9YBlc38G2/XRud
PT41SRg8rwBjDyfqx3OVTzL7kgxdXaM5ZbUJo24/To3ZQdmzO/QWWDJqUCGi0kCQ
r5x6rkMUjd9gZCIUcgio7ourUi3+gfQA+sIQHU3FUH+UCyL7+nM5XM61n7t80BpH
P8ACIKgUO0IDNTm9uaTHnuUTZAUrrw==
=+Vva
-----END PGP SIGNATURE-----

--L/Qt9NZ8t00Dhfad--
