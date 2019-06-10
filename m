Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA87DC43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78487214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hhF+aS0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390228AbfFJWeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 18:34:20 -0400
Received: from ozlabs.org ([203.11.71.1]:47421 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388328AbfFJWeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 18:34:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45N7Gd4kDHz9sBp;
        Tue, 11 Jun 2019 08:34:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560206057;
        bh=IQNa7rqN29D5MWb/x0sJpMuRtcYtKItCDHtISQvB3ek=;
        h=Date:From:To:Cc:Subject:From;
        b=hhF+aS0nC2Sqg5U48AMyw1TSAy+Qut0mvdDdl3AYE/nTX1Xs+F2rbIR5PPu9Moid2
         iBCWYAxCg0qwm4f6k9UCt4bjA4bWxhIbJU3KxL7/im8ILlHHRgAmFTakvXxl+P4fzD
         WnzVVklbX0oWRf72xzQQqg6k81G20bzqPBevK/LKiE2t/jXRxO4p+ZfTpnysOXlkD3
         zFzqKaTDZsb1zVIFIxxia1Tg4ucclSjEycpRcGGDhRskXaVdfJH0wPg3xYWu4u21yt
         uDVkXzsDGLpVsvmWx3e3vipiQPzOppkhfvZ/XSHLm4FonyjlgMo4Mbd2EXCT7fXXH9
         xjCUb4gceFDNw==
Date:   Tue, 11 Jun 2019 08:34:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the devicetree tree
Message-ID: <20190611083415.6d18997e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1dOKuDaYW44I/WCpGDOcdSu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1dOKuDaYW44I/WCpGDOcdSu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

Commit

  4713b5d95035 ("dt-bindings: vendor: Add a bunch of vendors")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/1dOKuDaYW44I/WCpGDOcdSu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz+2ucACgkQAVBC80lX
0GxNAAgAh4F0MyaJXL1sWbCoflviEnifQ1oMgqHCVK6g4D8PeWmRymqii5WGFh3f
MQcknPUpCqSfNXgEPlJwurab2V/8gg5JNRoOeptuAQvAQWlvb7Jkwp2XpLhvCfj1
4qCczDnoEOLzWVB6yUvsV8MR4xcE2wx3tkAdqDtOERSHKYpT7UD1zyc7s4slJg2H
TaZxO4lPhC7YjZlv9AlvKiMKxYkTYn3Umng/SZ11zsT5zh0efIzwNL5wd/uu5hOe
4XS0WwnJItBouzfcQRP6iXVx0x6kt0WlwOt8Q4ZdkNvZx2ifHFdBndCyatDJJRLP
ZT5wLfVU56B/mJ+R49Fw9VCksZSYeQ==
=NSBi
-----END PGP SIGNATURE-----

--Sig_/1dOKuDaYW44I/WCpGDOcdSu--
