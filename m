Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B506C48BDB
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 21:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F61320673
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 21:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QYMey3OB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfGGV3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 17:29:08 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41481 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbfGGV3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 17:29:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45hhXw3RLQz9s3Z;
        Mon,  8 Jul 2019 07:29:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562534945;
        bh=NALcSf4JxZPqMxNvupzy2z8xGoJsECRpYxfpF9O/qdk=;
        h=Date:From:To:Cc:Subject:From;
        b=QYMey3OBF+AYU5US/yoY0hFvYWrl6UFNCTZ1xkwRqd19cYcaHG4970hR875rpcfJ+
         tpyDY7OOt79uqTISdjhrO62fQxi8eLeszaMCcRk/fXV+rr7VsDGA5G1c0Sm7izh9Gx
         fXs04L2xIyEYVRwQxSsNZM/700PXVUoY0jcmNCGPPP2nYmqzk4lJhr4MXOD6Y7+/ku
         A6f5uqspbUYj7d2oTXmPub4di0jtol4UxR17f86uqqVLNEpVS+hmIvplRyIQdWEjCG
         BjKQFFYJhD+K0NmrZo6pYQvEnX2WA5Z/jBX18XiEWZNCsJu12WI1Q/dK6mXGIEXd4w
         BjSodw+J+PrzA==
Date:   Mon, 8 Jul 2019 07:28:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: linux-next: Signed-off-by missing for commits in the nfs tree
Message-ID: <20190708072858.566aa564@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/SQV5lqOq5h55WP=SGQwO2zZ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SQV5lqOq5h55WP=SGQwO2zZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  fe9ad197bd8a ("xprtrdma: Remove the RPCRDMA_REQ_F_PENDING flag")
  08d720bcd822 ("xprtrdma: Fix occasional transport deadlock")
  beb843739ea0 ("xprtrdma: Replace use of xdr_stream_pos in rpcrdma_marshal=
_req")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/SQV5lqOq5h55WP=SGQwO2zZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0iZBoACgkQAVBC80lX
0Gw4yQf+Oa9dWIJx7AWeZD3x6VGMo0fw//DkdOWNuKzGuyWzZuyYyiNkJZayBDCq
WRsipYgaCwenH+djQZDMGnyCcYSmTEIdIxWV7OabFfPnYWPtnmDIwXirHUxZJCjz
weHP9RhVUkeNxjuqtNs9kgpDnaJBb5Wlhh+cKfSs4XgUJdnnb5kbW7X2rzTKJYlq
wDFIxxIDWiBwx01EZqvuucUcu0kMgwDqEQ8Ka0lqJAf8l9HLDjJvzLtoKvmp/wt/
E/3Cd7Huwo+KY4Jn7Je30twpWAKCRCZFXfQXYwTDHenrO8ER/1ojVXbCwk9oMuW7
dyi3czWZWJl47sVqj3gYRGcGpieJxQ==
=lW+S
-----END PGP SIGNATURE-----

--Sig_/SQV5lqOq5h55WP=SGQwO2zZ--
