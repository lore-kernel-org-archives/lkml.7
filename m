Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C77C17442
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0782245D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jid4mhlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfKMOaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 09:30:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27172 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727452AbfKMOaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573655420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FFCU4n1YE09Q7aXJHCpWlpOpuKFfBt+IgNUrgcjY6qo=;
        b=Jid4mhlVBkSWPiS9C8OPu6HFQa4/EZW8xhFvFPvAlEPUJwnW2gcF+wYX+sP95WbYNWNVqu
        EZ1hE79skxaUYh/OCivV8oS/pG9XNBnqLrsJAIac5meGdfnSIOr91U3zOVYfktkAmwuMWC
        c4zq12m04Rl7jI/DMuos4OgDfQWJLO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-vnqxZ61pOP-4X93KH2_7Sw-1; Wed, 13 Nov 2019 09:30:17 -0500
X-MC-Unique: vnqxZ61pOP-4X93KH2_7Sw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5415D106B796;
        Wed, 13 Nov 2019 14:30:15 +0000 (UTC)
Received: from localhost (ovpn-117-166.ams2.redhat.com [10.36.117.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D16D918FB9;
        Wed, 13 Nov 2019 14:30:10 +0000 (UTC)
Date:   Wed, 13 Nov 2019 14:30:09 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, virtualization@lists.linux-foundation.org,
        miklos@szeredi.hu, dgilbert@redhat.com
Subject: Re: [PATCH 2/3] virtiofs: Do not send forget request "struct
 list_head" element
Message-ID: <20191113143009.GA554680@stefanha-x1.localdomain>
References: <20191030150719.29048-1-vgoyal@redhat.com>
 <20191030150719.29048-3-vgoyal@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191030150719.29048-3-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2019 at 11:07:18AM -0400, Vivek Goyal wrote:
> We are sending whole of virtio_fs_foreget struct to the other end over

s/foreget/forget/

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3ME3EACgkQnKSrs4Gr
c8hq0Af/Y6T9m3AkYVL7WhS7dEeOaSsP/EYzLga/CaHn7C6d180GQxMyYGpCcf0D
UQwdoH+qnfkDEwUOrF2VkJGMkpHERcoKAJhq9o5sUZgHtLx01mCt4T5nQYbCpbar
DtLxySRfhqeya6Zf2kkRtpz28Th4PHK7k2qT/v3bKxIxM6PiSv3gDO0TFbdRAflr
gRlpFE59+jlOv8zFbGpgVqklwqNEYYG3BO0NM+yYgpsxUXm68rFktSceJTCRLZsQ
RJW6hIqEsBh8o4ewE2WIafyqHNKU1TWJLDlwWQrDmv9+jokNzB1LTKOac1AqlwH6
6+Q7/AHk8zVeY6A6O1ApBtgabXPA6w==
=OR0s
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--

