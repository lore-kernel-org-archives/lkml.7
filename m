Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96C8C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 04:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F10320B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 04:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iG9HHlTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbfFTEeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 00:34:05 -0400
Received: from ozlabs.org ([203.11.71.1]:47193 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfFTEeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 00:34:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Tpqb0g16z9sBp;
        Thu, 20 Jun 2019 14:34:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561005243;
        bh=MJoeeINeVYsq0nk0RHtr1xhM1uVMdezDst5tNv+aqsU=;
        h=Date:From:To:Cc:Subject:From;
        b=iG9HHlTr0tZKw0c8s4iIzrdWdzoVwoOnz1lEWNrXnt6L8ImEH7WIDOiUPImnKd6QG
         0wke/4wvjdf8l52L0ONNmG3m9VwGvd93Jy0Lhh0d2Un9Car2v36blUkoG06w1VcP/s
         gF1jxjDJ2GrwK1gpCUycapoXl/87tNGW+Kxx8EwF38cfklDnRaxuC9oEW8c27fUGgz
         kqKYmR68/qhNK3zoLgwBn07RbqF1nad1vY+fBilCm8meDM+8p3oUtZOq09+2RDmL+b
         rFD0TyKocGUa1ZGdyVAGVNMRDQFgg+YCRi6/F7YrqpxLYdRehf2iv1o8HIOqUOpXg/
         R13bb3UokbomQ==
Date:   Thu, 20 Jun 2019 14:34:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the afs tree
Message-ID: <20190620143402.7ba96661@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hCY_.xSCdugVvuRFE1Zg/.I"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hCY_.xSCdugVvuRFE1Zg/.I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

Commit

  0b8f4f05f41a ("afs: Add some callback tracepoints")

is missing a Signed-off-by from its author and committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/hCY_.xSCdugVvuRFE1Zg/.I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0LDLoACgkQAVBC80lX
0GxlFwf/fo+n8yJ3lXoKtmTSsl3GLy6kkP8aG9DBlaHv+1k0aCSGJdOx7zmQSx7Y
YBecRunUlsQp+v/+dlrQzWq3LiQ8ctY5JVdh+tHnqO4WsJJhW2mktjIdppTSkdw4
vp/W936XnfQ2n3K7a4UATZCzjC723JXyPjAKOr6n2VrSN+jAiy0vhU7CzfSj769r
1MfRUEczau4nh0IAu5zlWlk3n0ChIufRxkq+WkGu+e/ScofOzIKv072CM0P7EZ8+
Vkv4pWQGmGthhV1RV9oU/57ciZAUbOlPl0w0wDf1KP1yzkae4zh1MgKL9gK1WbHt
HTkKimlewEKh+kZZHZTvvJ975OO98g==
=AhwM
-----END PGP SIGNATURE-----

--Sig_/hCY_.xSCdugVvuRFE1Zg/.I--
