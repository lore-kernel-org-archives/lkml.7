Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBEAC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16AD2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="l4F611aP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfDKG7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:59:03 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60267 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfDKG7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 02:59:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44fsM8068Fz9s3q;
        Thu, 11 Apr 2019 16:58:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554965940;
        bh=N5t2H9Xih9Nc7MP4JXRf63qLEeABxP2jDJ8D6JjE7OA=;
        h=Date:From:To:Cc:Subject:From;
        b=l4F611aPSDqslZplptk3P50Q2kk3XK+hp2g4fBwdF5iFVffR0pmwYT71iB4CHyxu6
         jdrc3FaGBinmkA35iTiCKnfeD5qoSNM1tMtPWezmWy440LnKh98oZkQaCTSuCzAZte
         p1p1IYxJPPqW3zwDNPdrKsrWW4BO7XpT5Oa+HYarFcWK+WWlxzah57bUEa6/TGowQw
         1Exbek5peQeM1DR/qBzOypZM1S+rYekwzDh7S1rg2oh3vkGhfFGKVk0Z3WFN6gRUFZ
         5ZiawCxLLc1hUSOyC8IABj5eHO2tS6oKoGikirAfi9Nj2jPCG0eoUdN0e7BFP1sW+3
         NzBy7UBzqNRqw==
Date:   Thu, 11 Apr 2019 16:58:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>
Subject: linux-next: Fixes tag needs some work in the net tree
Message-ID: <20190411165859.63be9174@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.IH.SVej_fxoiepeJgiNmVp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.IH.SVej_fxoiepeJgiNmVp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  813dbeb656d6 ("vhost: reject zero size iova range")

Fixes tag

  Fixes: 6b1e6cc7 ("vhost: new device IOTLB API")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/.IH.SVej_fxoiepeJgiNmVp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyu5bMACgkQAVBC80lX
0GwtCgf/X6zMJIcm/MjdqicE0RlHVvV5M4u4k1E2k13HBcR7hBAuoAL69xwAxwsH
XMHgqKBqIeeggXgjhMWdy+LhERpTrr9rOqH6IBkrW4reAI9qTtKVWobcsWv0uVrx
6CmlFgzQC5eIRum3i1YAModefcIiST5YW9Le89GsrwSkrZfRnA1a+Of1DkAXBDDf
B5itVeOyick7p/15QJAzD1J6J8UF8btVBUYCwn0q8SjdhFh5GJ/hy/Xj+e1qaTi9
gq+Q9LZUUMR7YIDFfNCo9pgRdrUJzZaWoN+FjhFXkQfo2SqYIFnNaRsrewrPv4IU
X2gMvL47P5W/fFbPEqrotedAaLwh2w==
=L2yi
-----END PGP SIGNATURE-----

--Sig_/.IH.SVej_fxoiepeJgiNmVp--
