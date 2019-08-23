Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B4CC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A77E20673
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZFCDdjGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390034AbfHWJyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 05:54:01 -0400
Received: from ozlabs.org ([203.11.71.1]:50241 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389719AbfHWJyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:54:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46FGv96Y9Yz9sBp;
        Fri, 23 Aug 2019 19:53:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1566554039;
        bh=BfJ4KeMa9ynIbqcUGKqsYvI1yTpHP9RlmVesWrmaLB8=;
        h=Date:From:To:Cc:Subject:From;
        b=ZFCDdjGA496Rzj1MHYXPmcTMB6hcvg5d8lrz2VziNJbr8DRl+Ro8CRNxpVTQkwGMB
         uSZ2prc9OXYh/uJhq+IqqaCmVGrsiuVR4HuFjoussNnUogzadE1+l2r2YSCTMPBxLf
         tKR7aYsRgflcfQNG5/lEKjpvtCatYFk+1nNTEgZ6u+6nQQPZZHH3K2zCpfNJCJT/kL
         p+Y0SXlFAvUTg9JdGK9sNrbM4vItvOttSSg58Cpy0XR0NTbZwiriZUSdmZ0uQiGUZt
         xeWN/7ck+5me7+/LBtTjroAPsEFcSKxwOM1f0o1FsNr6tm4y5w4CqpJF7RBAAXIUlq
         GOi8hK4x3ySxQ==
Date:   Fri, 23 Aug 2019 19:53:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: linux-next: Signed-off-by missing for commit in the kvm-ppc tree
Message-ID: <20190823195356.3d6f4ebe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BXiLglyjSYLp9Wz80AFIQk8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BXiLglyjSYLp9Wz80AFIQk8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  ff7240ccf0cd ("KVM: PPC: Book3S: Mark expected switch fall-through")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/BXiLglyjSYLp9Wz80AFIQk8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1ft7QACgkQAVBC80lX
0Gx1sggAoLNRPbANjKnnzXcuhwMDpEbvfsCI0STGPK0klb9YmUi+pTxFKH3/Gxil
XpUrK3eAIB8o4ACRuWKxsQDmfoO7ubo5zxlINBD+Ddd0GmdKOB2GOLhU7CY/bPAy
BoN5ik0yflfjsKXhlKShzUZcDfiDOSvApf+k7cPL3XMDJQlkDSN1GUiIpzwGp570
nSHlgzQQCmBJQwcFjHyF+2axuCqvRAkq6GxICIP5XL8jnwJgzjpSchHTivC7tNbl
q/BXNkujELLzm4xJbt5M2TeeYJXHdNlfKF9zaXHUD/Ptwg5EvPSMZHht4MCDuxPj
gUpq1DeQYmhv8QBwKYG3uN9Thi6Ihw==
=culJ
-----END PGP SIGNATURE-----

--Sig_/BXiLglyjSYLp9Wz80AFIQk8--
