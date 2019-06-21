Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D348C48BE1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 03:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E0420675
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 03:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AAwQsW5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfFUD4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 23:56:21 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33271 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfFUD4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 23:56:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45VPxZ0GD0z9s4V;
        Fri, 21 Jun 2019 13:56:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561089378;
        bh=T49oJThNAqg4VC+1Nc2pJIUqqDnxAZAKozmYg6nR75c=;
        h=Date:From:To:Cc:Subject:From;
        b=AAwQsW5DdEAAOtKp0Wah9pnHy27ZH0W7uNkAhS+1p6uRNLztFkDXnLWwmpqyeePjO
         Vju0+acdkhUEaxqV9difvs2Po7OG53M4wwajFOPJOnHYrBxL3OCzGWr3rjuLr0mq0i
         ZdS8/+UBfvWJOqqpy0BN1Hww9x18gZLTJeuo46XZXP1FSjHDstE32U8bJGtnueI7r5
         QddxubpR17sxnH1EbzwNRJyPR6jz4ZDT6suU66hO4XEEh1AJ/Lwn4h3xZj0sd7Su4X
         l95v0ewR6OsgfgoopYoxQYED9aHYwxAtqpstuHIcNOMo9YxlfDx88mOcxy9ujdG7gx
         ABWsucvChshWw==
Date:   Fri, 21 Jun 2019 13:56:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: build failure after merge of the block tree
Message-ID: <20190621135616.20299058@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//CvIe62J8Or=KdtE5_1Awk0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//CvIe62J8Or=KdtE5_1Awk0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jens,

After merging the block tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: "css_next_descendant_pre" [block/bfq.ko] undefined!

Probably caused by commit

  8060c47ba853 ("block: rename CONFIG_DEBUG_BLK_CGROUP to CONFIG_BFQ_CGROUP=
_DEBUG")

I have used the block tree from next-20190620 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_//CvIe62J8Or=KdtE5_1Awk0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0MVWAACgkQAVBC80lX
0GxALAf/ekDm3cV+cRRAqR1ZSokpv8VXJKHzRkqYQ/SFIOCxYWW8euN54tUZZ9VT
xZo0JDvvqL/j5mxGQFzKkBTP8ycnayqzLn9+qeiXbiTHYrJLuv/N9TNhwh+SWEYD
JjLhxbGRKBCPVpwVjBjNUaUhe/Rn0fOybCh3Z0zGKB0rarTMjzWrDDZGk+rUyhp1
eVzqLIs8k4VnzO6nzoPz5N9eB2ynSQGcNZAyApc5u1W2vxArRI+IMgKFWBSmz2Jm
E9RHVMGQuXddMqI9hBwdrWnN+bwhVUFVgyCauhYtFvB8NjZzVe3aAaCOudcWSPG8
ULINEliaRHgaD/E6xXGyUVn7bdu9lg==
=X4Hh
-----END PGP SIGNATURE-----

--Sig_//CvIe62J8Or=KdtE5_1Awk0--
