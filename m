Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC6FC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F126521655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UcYZEr/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbfD2Vqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 17:46:36 -0400
Received: from ozlabs.org ([203.11.71.1]:43777 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729341AbfD2Vqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 17:46:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44tJBx5GCWz9sBV;
        Tue, 30 Apr 2019 07:46:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556574393;
        bh=MRhG9A88cMCAptS+YZaKFyl3mBAQ3r7EH3X7rnMFGVk=;
        h=Date:From:To:Cc:Subject:From;
        b=UcYZEr/BNZZxZcI1YnLHnBdeA/oa1tSshFPcPZCl7EKWERfPW6FwKWfeSuWir+cG1
         kRSet7qMw4dx7CFVR24aRmIPqctccu7L8V40GIQBtjuWAcTk9ssmFdfgAPxA/fu3Fv
         mMuhF6F3G8ya7DBfrk0mlKvVUdh8Chgg3NEfVxsyR0rYc6/PmyOOEQ208r7+Q6atJl
         7RQPMMkxkB19fu06/Tdw/4I3RwDTjlq2chWhurNFAmo3r0tk77hvybGgGHq/F7EspT
         2MxIkDU+qcQjyItBrkv917seTIItGif6vOLKH8V0q+Sb9CYbQEoj+7stw2rZqRhCrD
         AW5vk+sWpqWPg==
Date:   Tue, 30 Apr 2019 07:46:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pan Bian <bianpan2016@163.com>
Subject: linux-next: Fixes tag needs some work in the mmc tree
Message-ID: <20190430074632.41770aca@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/GTco9g8Ng=qUi3DFVj=uzvl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GTco9g8Ng=qUi3DFVj=uzvl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

In commit

  98bc384ce704 ("mmc: core: fix possible use after free of host")

Fixes tag

  Fixes: 1ed21719448("mmc: core: fix error path in mmc_host_alloc")

has these problem(s):

  - missing space between the SHA1 and the subject
  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/GTco9g8Ng=qUi3DFVj=uzvl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzHcLgACgkQAVBC80lX
0GylQwf/dKwPkuFztaqgyDI5/T15xB412WcccraMyV39arDYN4cJI9pD0g9VUXwJ
JYfqBF/sjDTMxsmUohwXdsyJm5S1NRSjWaYOvtbhviO804HPHIr9PuqMOmva+0rV
WnqQUdq9RxDIvy27cdmqr0BT5dajpBULY2aYP3kdKhfkAjEC8/azPAtrAO1brMAz
uUnXnmhvH/55nXuLe0np4sbnuZGs9xQsazy4Z8xJC+Rk1zwlsEbmc8+GVbFwq+rI
v4PoX3G4KXnrhvWQQlo3VpM4mm2BmiPaQ0vl2qc+JQSP+FRlHtuzN1VzvLPF3pMM
5+PmkwSRdCCYoawJZnoCvku2doYesA==
=B73O
-----END PGP SIGNATURE-----

--Sig_/GTco9g8Ng=qUi3DFVj=uzvl--
