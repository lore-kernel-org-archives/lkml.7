Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F3EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A042720818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SzYLotLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfDJVFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:05:15 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57573 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfDJVFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 17:05:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44fcB06RCgz9s00;
        Thu, 11 Apr 2019 07:05:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554930313;
        bh=g8Lb+eKM97ECpQE92E/vml9/ihlv2HlhayQN2QtI+ok=;
        h=Date:From:To:Cc:Subject:From;
        b=SzYLotLjLDpcWXQisswCdOWhHnt5vfbpiNIwF4bH+qiqFt/ofigNOiyzAYja52k+A
         8pi3xG3fG9DhEkV09naeam0ctu+PsOhOUoHfqr7cQdiOLJrrwRBjJWQtJcY3luya6n
         4iH6i9vCgArWJHwZFEMDXeDlFkMAI+qjos4o0LkUGpv7krLcSJIOsz7jRkAKDJpOmp
         n1ULkCY6RDB3Uu5zgeD3ZwYRU7HDT99kdJ82d89sZjLBBe00pw1XsYiKK+Wb7TZxcQ
         AInqKI8X1K+XQtQigGG9IOGZ260OVZx5i9gKD7erzcBw+IDpK973Z4r+HNDnBx3Dw/
         2LIVsjgsl8KgQ==
Date:   Thu, 11 Apr 2019 07:05:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the orangefs tree
Message-ID: <20190411070511.1188c602@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DBbhbAfzVPos_3Zmo2yIseP"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DBbhbAfzVPos_3Zmo2yIseP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mike,

Commit

  a9781aff5d95 ("orangefs: add orangefs_revalidate_mapping")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/DBbhbAfzVPos_3Zmo2yIseP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyuWocACgkQAVBC80lX
0Gwkhwf+LAQhAL3G0W7pmmmqNR0KISJCfEpDv9nIggiv4dHfaH+LinuXJ2+ZiKjP
Z219MQOFi1rsLLdlR30RgvD5g00HIuJR87wzyigmSW/S2lGrcVNm7q4aLJcN5Zg1
eboD9adKSbcJQCxu7lTtGlik7Tcf9VQCmEXOV5MPVhSXQl7wRu+J/7sHKpZn4/CB
X9/QmqfF7lnoY/bP73ztZsEhN3/cnEXTSGySJ8SvirDXsqZl+PDZ0DuzOq8KTFKt
cPnSeFYF/tLVZ94j69u/PRyo9F2YWlFqvg/djEEO9yv1CDqGkusW0UWqDH1/ocq3
UGo+/e7Abd01TkBH2zcgKEGFTtArwg==
=va5W
-----END PGP SIGNATURE-----

--Sig_/DBbhbAfzVPos_3Zmo2yIseP--
