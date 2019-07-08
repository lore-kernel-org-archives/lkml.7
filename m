Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E2AC606A7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 10:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C14920656
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 10:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562582231;
	bh=yPThQeFL/BhZ8+aoC7iBG0STcDJCCdd/GunD5L0du0Q=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=p+LTup0sBUurPDExrK0/tTllJ7dkJsMJw5kdKD3E+I7mURgy4aB0uHq0fwvoThcLI
	 Sv3to5osUjlhPssXWnZiLvQdUdk6azdubBB9+Xi591PutwVsyeEUyP56Vkw/Wsrx89
	 gl+QceP2GnYKc0hQmCS/HjWOyZG30FKcXpdXyRAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfGHKhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 06:37:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53502 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfGHKhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 06:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T91IgG+rHZNc0YB1ANzKPE0tZSQBRCXLcDSK9NZh7+k=; b=RIXKBBPou5htvmoG3XlZxb6a2
        rEGkWuVCnCaSdxl5ztreMDUc4SIHfeRDMeiB0huUyOmip6ver5eZzY8I5dk7xVbXeW1XV1ywoG0tg
        F0jgW6QQ9s4MijFnxH0iFuG+qpBpLy5UsgeQDkBvgX9gZ2bqtI3I7puoQERiJpkWbnVdw=;
Received: from [217.140.106.54] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hkR19-0003DI-W4; Mon, 08 Jul 2019 10:37:08 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 92916D02D15; Mon,  8 Jul 2019 11:37:07 +0100 (BST)
Date:   Mon, 8 Jul 2019 11:37:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] regmap updates for v5.3
Message-ID: <20190708103707.GB8576@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
X-Cookie: optimist, n:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6fbc7275c7a9ba97877050335f290341a1fd8dbf:

  Linux 5.2-rc7 (2019-06-30 11:25:36 +0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git regmap-v5.3

for you to fetch changes up to aaccf3863ce22108ae1d3bac82604eec9d8ae44c:

  Merge branch 'regmap-5.3' into regmap-next (2019-07-04 17:33:59 +0100)

----------------------------------------------------------------
regmap: Updates for v5.3

This is a relatively busy release for regmap, though not busy in the
grand scheme of things, with the addition of support for I3C from Vitor
Soares and a few small fixes and cleanups.

----------------------------------------------------------------
Andy Shevchenko (1):
      regmap: lzo: Switch to bitmap_zalloc()

Daniel Baluta (1):
      regmap: debugfs: Fix memory leak in regmap_debugfs_init

Mark Brown (2):
      Merge branch 'regmap-5.2' into regmap-linus
      Merge branch 'regmap-5.3' into regmap-next

Srinivas Kandagatla (1):
      regmap: fix bulk writes on paged registers

Vitor Soares (1):
      regmap: add i3c bus support

YueHaibing (1):
      regmap: select CONFIG_REGMAP while REGMAP_SCCB is set

 drivers/base/regmap/Kconfig          |  6 +++-
 drivers/base/regmap/Makefile         |  1 +
 drivers/base/regmap/regcache-lzo.c   |  8 ++---
 drivers/base/regmap/regmap-debugfs.c |  2 ++
 drivers/base/regmap/regmap-i3c.c     | 60 ++++++++++++++++++++++++++++++++++++
 drivers/base/regmap/regmap.c         |  2 ++
 include/linux/regmap.h               | 20 ++++++++++++
 7 files changed, 93 insertions(+), 6 deletions(-)
 create mode 100644 drivers/base/regmap/regmap-i3c.c

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0jHNIACgkQJNaLcl1U
h9Bu1wf/eHD4yjePQu6Z/kPD2C6Fxm1/wRVuXC6/1DM1YPqCXWdL8s3VM3U4Rsim
5BHF0SyQveKMaKm40BfhkcqUXD4BG7MmStroE9BEVmwC9VsUEkZNXvkgNkmbco9W
eqFhpgITA9PKw+TF7cdJz/Y4SSVPWFgLPohb+hxfOzCg3QYKMosh5sIZiYh5mubF
RTzWZOGL9Wkq21GP+Jckcur5uyc6sSJk16Ex0lr8tWJu3fiWxzRH+0XOjO7hIIAI
NYQtL23V+FWJiaU3OqXBQQ/yK2MOByML1v1qiacA2EV+7EWoOzhv64J1V5S216JL
+/L/Ql6++ort1wsz2ZEeJmpTRF70Ow==
=TWM6
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
