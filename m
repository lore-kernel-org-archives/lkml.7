Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E8DC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED40208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391752AbfIFMHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:07:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51928 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387557AbfIFMHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:07:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5CE86300BCE9;
        Fri,  6 Sep 2019 12:07:04 +0000 (UTC)
Received: from localhost (ovpn-117-208.ams2.redhat.com [10.36.117.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04D145D9CA;
        Fri,  6 Sep 2019 12:06:58 +0000 (UTC)
Date:   Fri, 6 Sep 2019 13:06:57 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 18/18] virtiofs: Remove TODO item from
 virtio_fs_free_devs()
Message-ID: <20190906120657.GZ5900@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-19-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H7BIH7T1fRJ3RGOi"
Content-Disposition: inline
In-Reply-To: <20190905194859.16219-19-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 06 Sep 2019 12:07:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H7BIH7T1fRJ3RGOi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:48:59PM -0400, Vivek Goyal wrote:
> virtio_fs_free_devs() is now called from ->kill_sb(). By this time
> all device queues have been quiesced. I am assuming that while
> ->kill_sb() is in progress, another mount instance will wait for
> it to finish (sb->s_umount mutex provides mutual exclusion).
>=20
> W.r.t ->remove path, we should be fine as we are not touching vdev
> or virtqueues. And we have reference on virtio_fs object, so we know
> rest of the data structures are valid.
>=20
> So I can't see the need of any additional locking yet.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--H7BIH7T1fRJ3RGOi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1yS+EACgkQnKSrs4Gr
c8hs9gf+K5gZQL97pXObXjA7p0E5N+4Mu7Z87yZAklDhpHu9q0fe3y4R1Mgfbav4
2LIQdjT1jkJl0MxWr5p90E65k9EIXHqDWalOtCobxdFYDbw9IOKOtm6cbp6qbQQX
iURNmLJIf7q4+rIu5ekeRtb8/DmshZJ1zWdbYvegrvMcaRIP+PT2NcBiccFSKX24
yZ0VlxNOfXZIvXSirKuKn29sKtaLlqbmwtsLGIctcryosKZAS6TP7SJ0iUIh1q83
v3jAjTJE+YIybDSFbuFE0bkKHNm2zKrZLKoUL+tI4GC6l0FoE1zk5yJPU+qNKTr+
nx5oaJ/l0rx/cb7cpVXU9vB5xXNlSA==
=mSQ0
-----END PGP SIGNATURE-----

--H7BIH7T1fRJ3RGOi--
