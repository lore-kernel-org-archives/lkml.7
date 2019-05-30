Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B89BC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 22:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6282F26255
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 22:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XabQyxjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfE3WCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 18:02:17 -0400
Received: from ozlabs.org ([203.11.71.1]:47639 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfE3WCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 18:02:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45FM4l06hHz9s3l;
        Fri, 31 May 2019 08:02:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559253735;
        bh=kJLoTCjBs/nwP+hdiL4Z0EGzrpWOykBaAOwDzaoToEs=;
        h=Date:From:To:Cc:Subject:From;
        b=XabQyxjyYhU4FPhHRp526ehMPht8l4ZwJGXrsUAGlvjAp+KmYHLvQEG9+iuMYhkas
         3lpd2flEOLEW6A5i4E3JLAn7fTi1GKzTS6crd6vv0QKZg5P1vEl7dRcRvZ/w0npjOj
         2T31FS2Q2y/v6Lg5rNuphnJpyCtwk0WhQLBnMcQOQLDE72aERL0oyWBvM/JitwEqbw
         vRaEfLV3OqTdYhFD5VhAZCRleQFLfuH8yIa+dU7eUQlRDh3uqUqZhOSIu/lC7m9R39
         C0B3wtIMVXES6e8hQQqk4I006wdktiasUkUPGN5ozsI8cvvy2KX77/DSVbtsJMCK5H
         zqm9tFWAS8KWQ==
Date:   Fri, 31 May 2019 08:02:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: linux-next: Fixes tag needs some work in the sound-asoc tree
Message-ID: <20190531080212.234f5149@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xwFiduZFtHNxIq6+IWrFOX8"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xwFiduZFtHNxIq6+IWrFOX8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  970c43d17835 ("ASoC: SOF: Intel: hda: use the defined ppcap functions")

Fixes tag

  Fixes: 8a300c8fb17 ("ASoC: SOF: Intel: Add HDA controller for Intel DSP")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/xwFiduZFtHNxIq6+IWrFOX8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzwUuQACgkQAVBC80lX
0GzVRwgAmyt/mf9wP3UCFmKzhD6E1U3i67ofU3ZBR/QMjdZhjrbwy7cA5uaiSIjZ
u4eQj0C0uzwYfHk7wBhksk4u1Z5Lr4Gvg9lWxd1Q7KR4GUJd5aQoZEeID9lLQ6vI
Xv20PUr7KhpiCfT5oWfdxx/zQfGUPBcXjJv93ZCq/UifX3TNuK0ALXcT9HwsXr1N
bRYz85g03PTDtT9hfUQXzQW6To8lZavwvhO3lLPlcYkVereeVEYz40VU6ojlV7zo
Mp6zs6p/EmTWtNQv0mspARQwY6Td0ehZgam1lxJOOhM4YAqqb25vb3ovcI/deK2O
fiQKx9Y+snzykRoGCUAzvzxVkfMhFw==
=hKvK
-----END PGP SIGNATURE-----

--Sig_/xwFiduZFtHNxIq6+IWrFOX8--
