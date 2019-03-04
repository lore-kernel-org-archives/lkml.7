Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2F7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088E820830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uwOVrHH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfCDUDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:03:40 -0500
Received: from ozlabs.org ([203.11.71.1]:37549 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfCDUDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:03:39 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44CrZ10JGYz9s5R;
        Tue,  5 Mar 2019 07:03:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551729817;
        bh=beRsW9C1znwLfteIOI7e51uYwu9VqAP/EqJSM2Ezctc=;
        h=Date:From:To:Cc:Subject:From;
        b=uwOVrHH57fSvopOzuC3hAY8GgAiCYsVc6Tj/1ZV/zCu6xrMr66AYJtreUM6I2L9ES
         +lh6TGLMq8t7O7PCB/mJAW9XGf5DqFjEHp/kWAYlsH2314eNU5LMXzr9i88/3PN622
         +lcA/3+VL/hhRlx9SFwfyNEunT/7ItK/YONDRnPkc1eMT3FSyfdjxsaOScZc0bguHQ
         jFcgTuJkafrSdPQV/Q+JQurs57jySix4O3KgZNbz7Tjr5vRXvn9ddXvK3IDzl8t6Ry
         qgL8j3yTbc3ENxNzf5vrhkAGdoG95K/Wm/AOw7dHoba/BRIXLI7R4YDZsX6+MOHNut
         JXspoRl7l7Oyg==
Date:   Tue, 5 Mar 2019 07:03:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the s390 tree
Message-ID: <20190305070324.294111f6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/PoaZu1Tr0gIvI7lqzBsX.2n"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PoaZu1Tr0gIvI7lqzBsX.2n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  c533b46e5527 ("Revert "s390/cpum_cf: Add kernel message exaplanations"")

is missing a Signed-off-by from its author and committer.

Reverts are commits as well.

--=20
Cheers,
Stephen Rothwell

--Sig_/PoaZu1Tr0gIvI7lqzBsX.2n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx9hIwACgkQAVBC80lX
0Gx3PAgAnU58+GUwHdjyHAUCcA1I/fWSsVv1roKKoYuN8sKcDHG/4dBekE31o7BP
MZeIYaG6T5FMt3miWkdkOv8/gugLt+8Q97tv2dr+oBoAooz/iPZ6jMJEqIYFu6EH
CNY/G60vJ+wkA5MSTO9AFY+19eyr1BhyDKRFiKRptN4OGL/e0L9ucGxEUjGMFBXo
auXV4vW/7AitctlW3hO0aTL7GN9w8uARQr8pLN6BIEBm1UIsE3uiq3GbL7lV5NqD
56iIblzTfWBmpK0vekbiwYOGg8Psg5ayFigHgLa/cGWTtIpEZ+PVhgne6XX5E10R
q9JpDwcBoqrY0Y0Fsa3xOpoY5Tlnkw==
=eFNq
-----END PGP SIGNATURE-----

--Sig_/PoaZu1Tr0gIvI7lqzBsX.2n--
