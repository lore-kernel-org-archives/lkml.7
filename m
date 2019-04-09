Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE3AC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871A620833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SCHnd5dB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfDIVQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:16:06 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42195 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbfDIVQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:16:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44f0Sy1RPSz9sTL;
        Wed, 10 Apr 2019 07:16:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554844562;
        bh=CY7vp+AOdaEGbXRn0Jb4+9n9d17lWmVWbiC3unm7Z3I=;
        h=Date:From:To:Cc:Subject:From;
        b=SCHnd5dBbc0IGTylTQkZXh/s+esQd6DvQILhORg7fWWGfaYOrIyaeph8IE8RIcMXZ
         18VraCzsUbKw44/WMzZcT7sEhizlVkwAO0IdTM3h/ksoqSJluNq2aITgk0JZmkDx6E
         5yFDOg0o8Wg3GVlmT5Eso2iNDFNQ34xCwC4UeVLeS1PHXESkZz5KaFJb80LPYmTz85
         XbbDhoFIV9qKdeSPyvXVHeM2o4OU1mYeOM7ArFeY9sVLS0oRZl15txMmwT5Mcim+Iy
         ToXJprhy8ooqaOUanyGtDsjagAbZmo3gL3LJiidptLYGH9NC2T2SKC46IJDhj+RHB7
         u3247RHySMwqg==
Date:   Wed, 10 Apr 2019 07:15:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Subject: linux-next: Fixes tag needs some work in the nvdimm-fixes tree
Message-ID: <20190410071555.6a283e81@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Lh_f5ZKb7voCN2YyW9N7roG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Lh_f5ZKb7voCN2YyW9N7roG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dan,

In commit

  631804370762 ("tools/testing/nvdimm: Retain security state after overwrit=
e")

Fixes tag

  Fixes: 926f74802cb ("tools/testing/nvdimm: Add overwrite support for nfit=
_test")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/Lh_f5ZKb7voCN2YyW9N7roG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlytC4sACgkQAVBC80lX
0GwrPQf/cxotoDN5+QHPjWSNJ1vkJYZRiAmUIAa0RMJMbJhdRCpUtjZDCAKuu/EB
aRrnCIO6eftLIR6my8lrzpDeqxHT0omHY9AWJI791mcvjIqcqmVF0mskGd6DJpGy
VxvleYMuWo1ReJM84bplc2vu25JrgT2AGl9svOVE5fPXCEOHk7gGog8Jzov8uQfu
Os6SaVf2Xjvyr9M9umf8Q9apzvmoSsN0Ebxr3zNfO8seYaZgEJ64mQQ+tuXdTW2k
IgkAuu9OS47L/XGYaLJucHhylQ9ZpD+syiglw0V6cLyblYTEIFqvG6lGX+2iBmle
PGz9mOfLt5+truOrhqxlA6NwcMOS4w==
=PjQh
-----END PGP SIGNATURE-----

--Sig_/Lh_f5ZKb7voCN2YyW9N7roG--
