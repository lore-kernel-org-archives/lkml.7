Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F6DC282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BC82083E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="T3VSD9h4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfDHFxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 01:53:01 -0400
Received: from ozlabs.org ([203.11.71.1]:54989 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfDHFxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 01:53:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44d02L0sKQz9sPP;
        Mon,  8 Apr 2019 15:52:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554702778;
        bh=MwKh65rW0ItgUkrbpXGYIkUYwrSuF+frXc+MMoN2FoY=;
        h=Date:From:To:Cc:Subject:From;
        b=T3VSD9h4fC1yjrazUo2LAXZlYLFGSJL1cnMqElzczqRnkY/oXuZgV9Sq9mGo5ofK7
         Wr/MJ5oWLtHbda7kpRMqdgHzNjNv5RS59RK0P6DTuzgQwQt67L9Z8blqbqdfaQd0u6
         LObmXGNrs25IPrNU2ewYLoFLNZFzzlccpMChKhe1TD0ZIXvkzjsdZoaEqtC8i9hAUJ
         aNkm1R2bPWN/NYgOLzZmipvYkzNMwktBrg9zDYhdcFV5BJ9FI6Znp6If2Kvm3rCqys
         l86+ErCYg3N+VvKVpsth0aooQ7opyeUR+VTmRRRvebbRfAetdtKLXB62/xn5OOyyXB
         Dnab9AkQR1uzg==
Date:   Mon, 8 Apr 2019 15:52:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li RongQing <lirongqing@baidu.com>,
        Liang ZhiCheng <liangzhicheng@baidu.com>
Subject: linux-next: Fixes tag needs some work in the nvdimm-fixes tree
Message-ID: <20190408155257.7b82b64f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Y85CkOK7KtKPvOP1lKX62K9"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Y85CkOK7KtKPvOP1lKX62K9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dan,

In commit

  7c33bd4e3e97 ("libnvdimm/pmem: fix a possible OOB access when read and wr=
ite pmem")

Fixes tag

  Fixes: 98cc093cba1e "(block, THP: make block_device_operations.rw_page su=
pport THP)"

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/Y85CkOK7KtKPvOP1lKX62K9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyq4bkACgkQAVBC80lX
0GyBSQf/XNX2dgkF4NNrElEfq5+hcQh/yHDR1+vpJjQDdlq1/wCT1MoKZJKq2qKd
o7Aj3xFFPf4EPBuyTH3B1NVhewogUGci4vz0dY2pSWyr3HW9bltrGX4iCPClonBC
aXKVPDEr1xHSJjwK5LgTy49o1ndi64N85R5FbPtgr0t+YA+0UOdE2gKR7fWbnDPG
El9RksgAC9lsONjxFMTyTZUyReefjtihqMvQmO4573glEplPxzvnp2n1zu2ccEsW
KCzNBdV+iWrrEmjKKKq5tIR8Le+cuBHLWgIkiWoaQjnX9vk6dAzJ4QGH1nKzJocg
WWF8VqM/KOI1bChl8SxZLyndfDKiQw==
=lHdi
-----END PGP SIGNATURE-----

--Sig_/Y85CkOK7KtKPvOP1lKX62K9--
