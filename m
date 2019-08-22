Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369D3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036A821848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lIdu/jnN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbfHVGE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 02:04:29 -0400
Received: from ozlabs.org ([203.11.71.1]:50041 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729877AbfHVGE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 02:04:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46DYrn6bGXz9s00;
        Thu, 22 Aug 2019 16:04:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1566453866;
        bh=xevryb0cBS6pgjNUrk9qQ6SxfzSEULSEp7tmyIAV1Nk=;
        h=Date:From:To:Cc:Subject:From;
        b=lIdu/jnNaBstIKXsKrO1J3nV950nSe4AX4K/VkKCwX+/5dta+zMgTTS0Tb7d6QGn3
         FMU2MYIeCubdCrlAwL6lkjxcVyA+sICf3D1Ga7ZFzmUiae6+TZoYoMPNTSfNqQeZyQ
         4IOW2SbtWU6AR4ya5WQPrXRrZSLDNznmcpGjdYuwtw6FqqNsN6qMDVqwxviixzynB1
         DPiQ9SLXtXKWgbKuPI1+nhKSUVvUXhgwjBEDZw1yPPpzFN6ThCqGAKA9tSBHZRq5u2
         P0QDu2dHJDpE3ZrS0KMIE7UIRCUPscQFMMP5IgxdpGHQtC5ogi8W3Hb6DbDSh20b1g
         uaskd+kUnKp7Q==
Date:   Thu, 22 Aug 2019 16:04:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: linux-next: build warning after merge of the soundwire tree
Message-ID: <20190822160425.6998054e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lUk2R4Zs4qhBXgIcDPq6IY/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lUk2R4Zs4qhBXgIcDPq6IY/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the soundwire tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/soundwire/intel.c: In function 'sdw_master_read_intel_prop':
drivers/soundwire/intel.c:829:12: warning: unused variable 'i' [-Wunused-va=
riable]
  int nval, i;
            ^
drivers/soundwire/intel.c:829:6: warning: unused variable 'nval' [-Wunused-=
variable]
  int nval, i;
      ^~~~

Introduced by commit

  085f4ace103d ("soundwire: intel: read mclk_freq property from firmware")

--=20
Cheers,
Stephen Rothwell

--Sig_/lUk2R4Zs4qhBXgIcDPq6IY/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1eMGkACgkQAVBC80lX
0Gx3KwgAkJqquDMzglB6Dm9inBqPQS2vzaw61LIsSQcIaedIkzbkB1CAfm0jpjir
bjllO+UnDdCjVUYnI+tG7C4a9p+0EkK4+zfYbsUbq+nUW16/mN0UGRVJnnfItQuJ
FsbduDbdSEgGdLn/8Y6zrcA3uuMVvMv6o4iGoG71bLNKeoNwoh0A/CS8uOmAQryD
kigGlJkGx6VuARwpn4QoHS+I1Ip9UquFBeEjGFhRVlXq0ZUaZBpHkn/Pn8hudNjZ
mHv3nFD6u5SioTlaMPIxzZCtbDBPoH/BMZMKgxzsYVEz3m40FWaAfXIv5x8heHJF
yi3bJEP+ccOFJzU1DegR6zh3CDIlKg==
=8TyC
-----END PGP SIGNATURE-----

--Sig_/lUk2R4Zs4qhBXgIcDPq6IY/--
