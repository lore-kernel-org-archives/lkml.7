Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD24BC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C095F206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="udM+LvDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbfDYVFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:05:16 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40887 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727232AbfDYVFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:05:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44qqT611Gwz9s4V;
        Fri, 26 Apr 2019 07:05:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556226314;
        bh=oZPUeXO/SaC3myJYwDXRRYoPQNdpM7RHxI/5lu+P6yU=;
        h=Date:From:To:Cc:Subject:From;
        b=udM+LvDOIxkuzzgXtMnkqTZ1daJcUmlHQBwgGjI2QFrs23udO6iv0nlLqYhwbdZdO
         Lxf09xPN19xKSnqT+VlBSI80eBM5/+38/KBTuKERwRDEeVpKh/KcQUa3HIxmqr4eg+
         KQlSszWJ8G/ZUfNzYtIkluLDMxlsdLZa4CTWtE8U1sMdHf+Z/GGL+6ljvQTCbuI47J
         X5zxHY0+cH+hq4UUp6ToXFnZA0ueL1WXnruLQxTEo70zy8/NWL+GL7CPyvt/GfffuG
         X2A3wH9dXRKl20Z7xHjWufz6cO6C91GjSAzRJlS5D+Fdt3Qm8I7x5wC8IWcxb8y84X
         e8Bz+49os1ULw==
Date:   Fri, 26 Apr 2019 07:05:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the ext4 tree
Message-ID: <20190426070513.775fa11f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fOmKO0v29pS1zs434CNnQ7P"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fOmKO0v29pS1zs434CNnQ7P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  8851f707186e ("unicode: update unicode database unicode version 12.1.0")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/fOmKO0v29pS1zs434CNnQ7P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzCIQkACgkQAVBC80lX
0GzHYQf9FMZZVsY2iGEX4Vq5NYKVqM4lErp6GT8bAxdqTKk42mSLs0CiwODTHE3H
zgWKHQEa6w9ZnQ5O9RnO5vmXwuqiXMOTcEo5HBs51apVCnJ/sX/IWmmmMy5sHM3Q
XEbnPOJairbhgSMKrjwrdFUuQ18o/R+qj6OyBl3eBQpuQkj90r+/tj+bEc+TCFjd
7XUIUGVA03wlWHvlup8aXWjf6SaxEcNYLjnQs7tfJjJ4r3kH7x3L+J4QieI3XtFQ
oMxZ2yl/W5HsEHfuKAc43/LvPxQ/g9ziylR0nQOZ/DdN4He4h/aUIIx/NVYf5aOn
gZ/ZZa1xZEbH/TF43L1leN9eAGwCeA==
=Ks+T
-----END PGP SIGNATURE-----

--Sig_/fOmKO0v29pS1zs434CNnQ7P--
