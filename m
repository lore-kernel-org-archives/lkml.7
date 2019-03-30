Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E294AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 05:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7759218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 05:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aYeXZbyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfC3FTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 01:19:48 -0400
Received: from ozlabs.org ([203.11.71.1]:41833 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfC3FTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 01:19:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44WRk93GCkz9sRJ;
        Sat, 30 Mar 2019 16:19:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553923185;
        bh=Yjd1lCwG0pHGRBRp/6OpJn4jRmj1fU28uUG7M0TKF/o=;
        h=Date:From:To:Cc:Subject:From;
        b=aYeXZbyxHHy0typhEkLxfS5JcafuX6auGYXhFB6cKpjYxI0VBDa+apYw8D/fZJrP2
         HF8lObr0pMwfzcrukqTyARCkTOckzJhgndfPkToEDSuSBqgHpoSXpUXn5Qg3wSbuh5
         dfcM+5fJQJy56WTn2IlWQjr2QYIQ3g6B5I2ZcAsDfqKW2/CaSvuQdGkn6jLxL+PZ9E
         c29a2K3GY1lcSm+vvEj5DzSCqL+Ip5NRWgwY4QDQBFW81evqoONRMgCNT/z8FWz0Sb
         ZCswxUovpCjG6JW1hJpbjKx4TgzUAWsUyw+h4efR2O0weap1++/2r67Nu1d+PrRkEy
         QyCztlkPFeo6Q==
Date:   Sat, 30 Mar 2019 16:19:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jan Kara <jack@suse.cz>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yangerkun <yangerkun@huawei.com>
Subject: linux-next: Fixes tag needs some work in the ext3 tree
Message-ID: <20190330161939.231c39cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ZvcIm2HgQnLvSurBMojGEfZ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZvcIm2HgQnLvSurBMojGEfZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jan,

In commit

  47d92aa5d33a ("quota: fix a problem about transfer quota")

Fixes tag

  Fixes: 7b9ca4c61("quota: Reduce contention on dq_data_lock")

has these problem(s):

  - missing space between the SHA1 and the subject
  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/ZvcIm2HgQnLvSurBMojGEfZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlye/GsACgkQAVBC80lX
0GwccQf9Ee6TWHw3Vr8SYL5S20PDLodzRs1sNKFZdmrln+7D0MDzCzdhhodjD3O+
uquOYZNrredVd9DfPNJJ4UmcwB7t1Nsu0JJWxgpVnUs23uuy+7Wrt1Im38RfEmPX
ZLPb+h6sKH3jKtppJCasURVwOuIxg+8msZuvE7A6ZODC3DIduSPLXgUkWexEV/MA
Co0QnYpVF8IOSn5GGeVKCxKHncjpwU7mym6yqQOnORVXIJceLnKQg81tpdVdyTzE
ww+/1IQ2SFFqUeweXp+OAVK3mLY5Qf0KG78BKMXvhcEeYrHph6WLbfUuEtFmSbA4
sOw6mUdtjkyCCcsh577N7lmodjPS0A==
=nAzx
-----END PGP SIGNATURE-----

--Sig_/ZvcIm2HgQnLvSurBMojGEfZ--
