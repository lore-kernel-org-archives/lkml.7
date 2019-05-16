Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64E6C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E10205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfEPPcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 11:32:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfEPPcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:32:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BAD9B3082131;
        Thu, 16 May 2019 15:32:23 +0000 (UTC)
Received: from localhost (ovpn-117-183.ams2.redhat.com [10.36.117.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFB8A5D72E;
        Thu, 16 May 2019 15:32:19 +0000 (UTC)
Date:   Thu, 16 May 2019 16:32:18 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 2/8] vsock/virtio: free packets during the socket
 release
Message-ID: <20190516153218.GC29808@stefanha-x1.localdomain>
References: <20190510125843.95587-1-sgarzare@redhat.com>
 <20190510125843.95587-3-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Content-Disposition: inline
In-Reply-To: <20190510125843.95587-3-sgarzare@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 16 May 2019 15:32:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2019 at 02:58:37PM +0200, Stefano Garzarella wrote:
> When the socket is released, we should free all packets
> queued in the per-socket list in order to avoid a memory
> leak.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Ouch, this would be nice as a separate patch that can be merged right
away (with s/virtio_vsock_buf/virtio_vsock_pkt/).

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzdgoIACgkQnKSrs4Gr
c8inUgf/ZWWrRlkmdo0umzZLZb20m5kj29mccKVqTXumpuuP4uj0fUgYDiHaO2Nw
RzI9h1D2ZxH0eu8lymsu9LScLZ+x/WoZh36H7BDqAJCqvo3/t3mKQVRj8h+x2Pqg
nhlAE54DTQLjeNBahCiZSNHDx2znDN7XQhTGD4LlEJr4Fo5wxNkflX2aPUtwjH2P
dQFDh2kXCqneuo2QQ/GPpYAufMXA4+n2YNsLKPqV3XtJP26a14tbdhbqaGOnOV4q
J9tOGaC8xukkX331J0Pqo0lPRLwqgeJEYTbjsjfUHcw8OP9Fcsy+/tDZMALSTc1P
4gMCqmXG6V/yfH6zkt7xipW8qhpmsQ==
=htot
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--
