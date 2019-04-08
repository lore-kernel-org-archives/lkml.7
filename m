Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F12BC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7D020870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfDHJoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:44:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfDHJoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:44:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C79AE5944C;
        Mon,  8 Apr 2019 09:44:19 +0000 (UTC)
Received: from localhost (ovpn-116-217.ams2.redhat.com [10.36.116.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF1DE1A7E9;
        Mon,  8 Apr 2019 09:44:16 +0000 (UTC)
Date:   Mon, 8 Apr 2019 10:44:16 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC 0/4] vsock/virtio: optimizations to increase the
 throughput
Message-ID: <20190408094416.GQ15001@stefanha-x1.localdomain>
References: <20190404105838.101559-1-sgarzare@redhat.com>
 <a98d194d-e257-41ff-82e7-de2d16d2f4d4@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sBcizk6cgRZY6rnJ"
Content-Disposition: inline
In-Reply-To: <a98d194d-e257-41ff-82e7-de2d16d2f4d4@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 08 Apr 2019 09:44:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sBcizk6cgRZY6rnJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 08, 2019 at 02:43:28PM +0800, Jason Wang wrote:
> Another thing that may help is to implement sendpage(), which will greatly
> improve the performance.

I can't find documentation for ->sendpage().  Is the idea that you get a
struct page for the payload and can do zero-copy tx?  (And can userspace
still write to the page, invalidating checksums in the header?)

Stefan

--sBcizk6cgRZY6rnJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcqxfvAAoJEJykq7OBq3PIpPEIAIPydRh9MmTxWJHiLCIdcVZB
YTFjrwJFHuWU1MSyz9onJyJxcranVbekSDh+RaESeGRrg1xSyNZBqqwNUfzm23XP
jQv1xTzq9qCC6ZB81lHgFclJjT5h1/KFVKzG3Wv2dMffDW+7/Y54wOdvPsYGIQdh
ZaeT3vH1BIoIz9xA7Ajt1H3p4XjqCQyOc8LPXzHi11zpg+UgEV6AIbSNq2hjEOuK
1n4tJ/tRaGVsrhfHcg65GzY3mA/z4X6xfpw+dgZ5ZlWRKqfqNbFr4q8Sxpwla3DF
aGElG+Dsc/4SkbOLzD4WfN+JmM/pvsk1pH6RMb/OHlaD9K6fMDlL9cliH2ovmY8=
=y3qN
-----END PGP SIGNATURE-----

--sBcizk6cgRZY6rnJ--
