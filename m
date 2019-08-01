Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0DEC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43633214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ozHjXT8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfHAN4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 09:56:32 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47231 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727537AbfHAN4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:56:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45zsK836Xcz9sBF;
        Thu,  1 Aug 2019 23:56:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564667788;
        bh=6BCeGoebN3+ezTGb7aIVfsOPQ9n+oSPb6Db6MJyQ4qw=;
        h=Date:From:To:Cc:Subject:From;
        b=ozHjXT8Kgzoeq4aI4u5LbR74trLcqtlTSDqr4vT1pOH//t7P9FopJhEvt3BI8Jy3/
         AC+iTVi+jQQAiU7ZVYHDm7KNIwg36Cn3PKPhxWZIiWVMof3GCOLIQg6mr45e/9a0JY
         RShkj9WAbcScShaZpDEj5B8lIKGhFp04UOb1u2dH+XAFb1fM9nprlvtzcs6y+R6R4I
         ISqi7emNXSUasn/Pz76nkU9zvFwGMHUV471PMBYL3maA5SRfXRGR8qvnZqfncFmYGP
         Jg4cPaZ70gPnyWQ7FxcRYGQkmoX+u9MwO6faMej1AOKd3Y0vK6ouWL1DbEoln7vwLW
         7TNniCrP3Wljg==
Date:   Thu, 1 Aug 2019 23:56:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the arm64-fixes
 tree
Message-ID: <20190801235614.4318ce1a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+om.97=OhQigt5oudaBcNS/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+om.97=OhQigt5oudaBcNS/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  23fb9748a46d ("arm64: Lower priority mask for GIC_PRIO_IRQON")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/+om.97=OhQigt5oudaBcNS/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1C734ACgkQAVBC80lX
0Gy42Af/YjJM8O1ZqD9gyCeD5EColFnWbMN6DDMLBwE6xWKoUl1CkNaqi042tjGD
jcv3r+60zzGGBbkbFr2NLB772rKsCmwuzTSEM7bd/dt4ehrhnbh6eHXthf66A7y2
VyatHBEQE1V2g1rlrYJY/aS7aR9UaZc8CRR2qv1BGNZs9QP234f5iDc7yVOGvFqz
cUoRuMyMwGqYUypW5PFbxBZ6Ydf49ikjgwi22dDQ0EyQId68W6tOFdvppY9kober
xPKEnxwevPs1V7yNrvTz/I42zwpXW3YXQo/Tq8W+EYNRb0daVfo6s28eg1YOoH1m
RZ3lYpf9Jd1eq8q2wSFisKqsQSA0ig==
=sAhC
-----END PGP SIGNATURE-----

--Sig_/+om.97=OhQigt5oudaBcNS/--
