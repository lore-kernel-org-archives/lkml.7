Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25544C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58B72070B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="chgPYFLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfC1BXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 21:23:04 -0400
Received: from ozlabs.org ([203.11.71.1]:33243 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbfC1BXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 21:23:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44V6Yx1Yqbz9sP1;
        Thu, 28 Mar 2019 12:23:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553736181;
        bh=X9nQdAIJPZlx203HnUcjmQRYLuFPd9uUqKZbyT9WgFw=;
        h=Date:From:To:Cc:Subject:From;
        b=chgPYFLhFAk+Vo60rIPNlFULv5NrNIwBXsX9DZ8s7tId/OgBaWEfmyu2mQ7cHmw/i
         DhyxFXIlFueDrA3ka8YYZxEvhg6pO9xJVJX8z5aaaHrp/Cj4cZNG3gOVzx2g3Xaphr
         caAJT0PF9B10Uy7vMJRFesFxYhXnOb1iD+zyCZAUywvbQwsZeCNwkn2eeWcehCeVDL
         /HSASMQkB+4QWxz7MsfXpV1xDvT1BZK5TAZbs+iNwYVFgYxEqWDbpcly8xvvfRvLbV
         YuU6F3gRTqSFtYXwzZtmE1HHAUTACmicTwo34J38vvrXxrMPNCskkKbOAGygG2v5Ln
         N68Qinf+fGdlA==
Date:   Thu, 28 Mar 2019 12:23:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Subject: linux-next: build warning after merge of the rtc tree
Message-ID: <20190328122300.02fc46c4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Mv6dydBiL6ncGbiEWL_5PUN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Mv6dydBiL6ncGbiEWL_5PUN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rtc tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

drivers/rtc/rtc-aspeed.c: In function 'aspeed_rtc_read_time':
drivers/rtc/rtc-aspeed.c:26:16: warning: unused variable 'flags' [-Wunused-=
variable]
  unsigned long flags;
                ^~~~~
drivers/rtc/rtc-aspeed.c: In function 'aspeed_rtc_set_time':
drivers/rtc/rtc-aspeed.c:57:16: warning: unused variable 'flags' [-Wunused-=
variable]
  unsigned long flags;
                ^~~~~

Introduced by commit

  7f4d485413fb ("rtc: Add ASPEED RTC driver")

--=20
Cheers,
Stephen Rothwell

--Sig_/Mv6dydBiL6ncGbiEWL_5PUN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlycIfQACgkQAVBC80lX
0Gzfigf+Ltz7iVBBQvWiWlOBKad6xVJ1NjAihM2+LdUvD8BBKpwhkHvGBzgdJ19t
p4XIJCW3XDtdAuAl0p4sadElC4dzdb2xe2XIzp12pvPu2H6qIWyXSTOKKllx8Ryh
nLakrlR02ixvC093Erxq6zD/FECMvOKYupsP3b6WY1wz6Ic9uY6DkKBWTR75jvTb
GvBJCQVB0D+WVQ/62zhTQ8r7r8gPwtVD+DtOCe4m1jvFXflWCYGqJQNL93yQJrjt
FBrwue/IcWopTw3DHVKrWvIzqZCN9DS0HcVSmCUYA/6fWdcLsd4HWIhzv8lVjWyh
rToG/emnGANouv967y99ZYTWf2AElQ==
=sp2f
-----END PGP SIGNATURE-----

--Sig_/Mv6dydBiL6ncGbiEWL_5PUN--
