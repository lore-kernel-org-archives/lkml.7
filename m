Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E0CC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 03:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F882080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 03:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MGO4bi4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbfD3Dsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 23:48:35 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60191 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730095AbfD3Dsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 23:48:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44tSDZ6zdkz9s9T;
        Tue, 30 Apr 2019 13:48:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556596111;
        bh=TlLXOzvzzWmnPRhinkP88A7XOHvI8RucBtZix5fefjs=;
        h=Date:From:To:Cc:Subject:From;
        b=MGO4bi4v6EhMJYazTwNQ1FCq26Z9lWhZ1zYUv2bpsZZYOJaXSSeXhJGP52kGr8YqL
         bJDYy6pNxnYV53i1DKeY6JPTq+FOcLjf7A/icUNV9R7tIo/7Zq6HumUynuw0wIkcxC
         OQpgquRCYBlgfJabUvKEKFuyZJEM6OvrqG4Noin+XvVzqAImWf6cTxvjFzPjFYWyO5
         5pC0P1CMY2VFIbluoBMfgXDWESwPNvIkT6ZSQF+HcXqM602BpSz9SFBwbnFVzRhIfK
         ujUz8u6cWp/uqYpL5NZQBD5n55o25Mcz8hF+w5ltWRmzew0Pv+kfYGvBCTBvdPdUtJ
         BRr2PtqvfM+pQ==
Date:   Tue, 30 Apr 2019 13:48:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: linux-next: build warning after merge of the thermal tree
Message-ID: <20190430134823.73bdc4f4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/NhN5W6ljlI1QGFo90A49E2T"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NhN5W6ljlI1QGFo90A49E2T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Zhang,

After merging the thermal tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

boolean symbol THERMAL tested for 'm'? test forced to 'n'

Introduced by commit

  be33e4fbbea5 ("thermal/drivers/core: Remove the module Kconfig's option")

There is a test for =3Dm in drivers/net/ethernet/mellanox/mlxsw/Kconfig.

--=20
Cheers,
Stephen Rothwell

--Sig_/NhN5W6ljlI1QGFo90A49E2T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzHxYcACgkQAVBC80lX
0GwqVQf+Nu5eg45oBphFCXGaZZP5XcNk7vZpnRvH7Y6JvEdRvP2c74VA+swwC0Tq
xDOiC+UYQw/JxrTkSvdsEi76BE9skB2y1AGHD2rdKpSBsPPF9hSGrwwUmFqCC6Tv
ncPG5oJM9vSu5xJhCtdG3Fnd2flobPWOt8OYzF7UmWOI/St4kVipWV4RnbYSvGdQ
9Q/ChBbg/BIR94TYpwC3p1NqwSL9MlP21cc1dX3eUZuKiIoHPXMQMcnwi3FeyEzS
yUSVxzO44I0Ivu8jfaU6q+5wMicLkOxr95p7kuw/YhAsfgKazZm0EGcwcf4QJku/
J3WlHz/IPjYv5S8y6INbvc8wef4Q7A==
=DfbY
-----END PGP SIGNATURE-----

--Sig_/NhN5W6ljlI1QGFo90A49E2T--
