Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FDDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 04:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3372085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 04:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Pg9BcaqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfCREvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 00:51:02 -0400
Received: from ozlabs.org ([203.11.71.1]:58689 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbfCREvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 00:51:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44N3fW6TD3z9s6w;
        Mon, 18 Mar 2019 15:50:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1552884659;
        bh=HMaEeXt6R91BQc/uH1IeJSnxdOTiUIETz5gnZa75vF8=;
        h=Date:From:To:Cc:Subject:From;
        b=Pg9BcaqO2LTQIEoDiBu8NaKuEi2n2MzC3B/XG5NjeCdCbQ/pSZ8JxS+UIBCNR+I1+
         pEKtOn1OE39YYG0kJZT7wRIX/29pVm0xXIOomFXKYOTcbUXsUBcmRnsR6kodSP7LJe
         L4V4IuvARddXxdXHSRLyT6fUV3p+o7pJEJik4t1qbBvBWQUDtmWABDg7FwKuO39sCc
         j9wQlpFn9pI4XVQ0cbLZXupgnT2j20bqYRL1J9nzbNb4L4X+lFxUI4uneNqFuk6u21
         H71UZZ0jDzs+8vLH1H1WwzGg8DuazIKKoAQC+N4MWgXyvel1WIO0zQBxOJK+hPm/8k
         jMT/FEwPfzELQ==
Date:   Mon, 18 Mar 2019 15:50:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the net tree
Message-ID: <20190318155058.38a63575@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cUbdlbebHn2wFaQf1jn4NG9"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cUbdlbebHn2wFaQf1jn4NG9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  65e9a6d25deb ("networking: fix snmp_counter.rst Doc. Warnings")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/cUbdlbebHn2wFaQf1jn4NG9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyPI7IACgkQAVBC80lX
0Gzm+Af9HkfV1wqx5lspWtWmiOsMMrhEzNv+n5yX8GPI/vVagJGqF86VT+XnPhEo
JkwvLpVBx5WJse+hdECl3hR2hjoElLzH1f9Q4j5gFSPc0YqRDOiRXWzyXczirjRC
aU2p34Es4ogwteoPsaQu/vkayPhxQxQdXAEvn+A6+YflVd9kcOe7M+uO+DtZ44Xq
4Z6EZ1C6xoHkb8CjXWNSgXGkOaNeZG9HxR3CUfqXzCnPDFVOA6PJ22UdRGJKMJCG
I0/UVXJuR2ilNItileFNcR9t3J+wOAr704tlNynckRhq9rGuHARm24hXESxLeVuo
2gn53SK0FRhpFi/pXYrNIjI50NlLFA==
=EicI
-----END PGP SIGNATURE-----

--Sig_/cUbdlbebHn2wFaQf1jn4NG9--
