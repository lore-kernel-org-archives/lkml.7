Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3501C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBBF204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VUxfHXDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfFFWBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 18:01:23 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46887 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfFFWBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 18:01:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45KfkS0hbkz9s00;
        Fri,  7 Jun 2019 08:01:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559858480;
        bh=nRYnLt1pP0T6LPIL1a/hHDJC3kNRn4Tgk5aqtjLRJYw=;
        h=Date:From:To:Cc:Subject:From;
        b=VUxfHXDaMcUXUlbUb8ChZrHRfN9LepGudS6K8NsBWOAS+pagHBLcjziBbPo2AAHIr
         4Iskz0qamvYxt+C9rtohiihx6OLTyWNnJHUXN/yHmjwNERFxR1KyEwLOL0boJ95EIN
         zbEkt3NNgnQh0x5YzMyBJBuqDR8OmKhj+fOc6as8QnMeZEbsNk3NCckXA4tw+bseLW
         lj2VGp/0XcIseHr1wZo5ncQu1xQQFNKKzPzCxN+6MbcaiiL4GVPFIj0IzkEOI/qPfw
         l2C3mrNlwQ+2trFpgEmHkoFSkKO918nBN+blJPmuLCOAjIL4kRxJeDNkDQEqLAYrh5
         Spt3GQNoVz/nw==
Date:   Fri, 7 Jun 2019 08:01:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: linux-next: Fixes tag needs some work in the sound-asoc-fixes tree
Message-ID: <20190607080115.15a14726@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/90WHSYWzN0mFhY3z42dsM8D"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/90WHSYWzN0mFhY3z42dsM8D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  1f5253b08e06 ("ASoC: SOF: Intel: hda: use the defined ppcap functions")

Fixes tag

  Fixes: 8a300c8fb17 ("ASoC: SOF: Intel: Add HDA controller for Intel DSP")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/90WHSYWzN0mFhY3z42dsM8D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz5jSsACgkQAVBC80lX
0GxccAgAnxNwSxEsPS7kcP0hkUA4FyQ0jgEJiYZTjv/Cw5mguVtBFbBWFYqvnzro
unC4PR+6rYZNsYqqGURfrgBA1B16fxKRaOs0XxUIIChe2k+wCGOM8V+OViZWHUIN
2QGJ1Ok4+ZOc0S8YMwHazkQu3JLjYTUczV+BN8j5CaKBzIX1rEDZQI6x0Vawg2wk
4K0ymXnnHiL9Ay3NRTrK599fULyS0VlXMLhzCtwMSTuKWLcprvZZxTKiuo/xLudE
4xaT0vGl/qfqhDfCYjwshG+ajHqwsBW+uNxpzBsmWDKdbqwO0FAFV7LcNshxdJ5e
YQW9EH/4Ur60k6Ro/4/YmumubVV7fA==
=knvX
-----END PGP SIGNATURE-----

--Sig_/90WHSYWzN0mFhY3z42dsM8D--
