Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22876C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5C420850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SwmXCG8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfCSOn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:43:27 -0400
Received: from ozlabs.org ([203.11.71.1]:51799 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbfCSOnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:43:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44NwlZ1NPPz9s6w;
        Wed, 20 Mar 2019 01:43:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553006602;
        bh=ZRvqabZ17As/dIMI8GwJJNVsweg7iuM9CsUaBqP8H9k=;
        h=Date:From:To:Cc:Subject:From;
        b=SwmXCG8MPSb219I+9sYpQcAQ1ZNVfTT0K3YFbiXThSNTi1P5Knco4cS6jxV1ImvQM
         0gJW56+CEe0ULxF8fvqE3HxZqxKLTzb1Eo8HjeU5Fbi7OESEBGYpCSxR8N1rNdyUDY
         beRieAHQfCgw5MfntAdKnF248TdnDNtLRYWprTkD6IKkWtHIsVYrSHV5pZA9Itid+j
         XQ8uhP2Oq0ZIFjZ89q1Qqy0KcO6ZHOQY4KEg8ra5cuG4uyvzhfQHBTNI/jCtfSWbb0
         S+ZSlEKMYounqpvUU3XGWPEbQqr5+3nxDnYH0IGxpcLqaGzA35j5FtdsjWb6RMUWQk
         /Tei5ETIbdKWQ==
Date:   Wed, 20 Mar 2019 01:43:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Okamoto, Takayuki" <tokamoto@jp.fujitsu.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: linux-next: Signed-off-by missing for commit in the arm64-fixes
 tree
Message-ID: <20190320014312.562c8f6d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/AmGxuA8/qarnccXK.xvkdbe"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AmGxuA8/qarnccXK.xvkdbe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  a4d17a19c493 ("arm64: apply workaround on A64FX v1r0")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/AmGxuA8/qarnccXK.xvkdbe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyRAAAACgkQAVBC80lX
0Gx41gf/ZfSpi+0jqCI6K3S8+oo8y7PcshpCE3QktwewOpRNfqaA7r3l/+eIRWkm
FJcWoFrBPXSDRPwzd60AGzHVVjSnhL6dD1ZV5+FQmpbMHXq5yqGGXKCMPP+Dq/ps
6w87277OW8AwTsp5I7b+usn+TIuR174zqDCal4DTH3oigszMDMiBNqnSmwYWeeVX
V/lADBPzQgnrUOXRvjq+zBjUFl8sJPohQoDd/QCx8ot3CMtxQM3PvyuQtRQSB3Kv
Fgyk5Ox/hipfOjeZfcEYiTgOeTZM5ZojvWYkz3g6PGTBNI5Bxr0586A2lOGVpAj6
xPffUlh4dhBM/szcxLsts/jeSrERlg==
=6GDH
-----END PGP SIGNATURE-----

--Sig_/AmGxuA8/qarnccXK.xvkdbe--
