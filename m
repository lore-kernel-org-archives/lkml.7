Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBD3C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6639A20716
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576586069;
	bh=rL8JfWqXzBOWl3XO68vyPd1QOVL9AsvgUYPDJ39ORnk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=AIvr1hzgS4ZWICJb/mRwf4xS/RPTWAoX9Hz2AvStL5g1n6R/mBKPkoSPKBDHDLltS
	 1sOD7XfY3apBl8MNGbCHa3Olsu5mVd4fK8ads/7WQjD+P9MIjXm4Aae7MVMJax4Wue
	 8Rq0G763afJrLQ0Fc2P9bEszjzqhCQzr6uvEf6Lg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfLQMe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:34:28 -0500
Received: from foss.arm.com ([217.140.110.172]:35402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbfLQMdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:33:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0756D328;
        Tue, 17 Dec 2019 04:33:52 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BE303F718;
        Tue, 17 Dec 2019 04:33:51 -0800 (PST)
Date:   Tue, 17 Dec 2019 12:33:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: [GIT PULL] regulator fixes for v5.5
Message-ID: <20191217123349.GE4755@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
Content-Disposition: inline
X-Cookie: Thufir's a Harkonnen now.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit c15d5a645875bc9b89f68f5d3fb608f691ac78d7:

  regulator: da9062: Return REGULATOR_MODE_INVALID for invalid mode (2019-11-22 19:52:42 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.5-rc2

for you to fetch changes up to 62a1923cc8fe095912e6213ed5de27abbf1de77e:

  regulator: rn5t618: fix module aliases (2019-12-16 11:53:37 +0000)

----------------------------------------------------------------
regulator: Fixes for v5.5

A small set of fixes for mostly minor issues here, the only real code
ones are Wen Yang's fixes for error handling in the core and Christian
Marussi's list_voltage() change which is a fix for disruptively bad
performance for regulators with continuous voltage control (which are
rare).

----------------------------------------------------------------
Andreas Kemnade (1):
      regulator: rn5t618: fix module aliases

Bartosz Golaszewski (1):
      regulator: max77650: add of_match table

Christophe JAILLET (1):
      regulator: s5m8767: Fix a warning message

Cristian Marussi (1):
      regulator: core: avoid unneeded .list_voltage calls

Wen Yang (2):
      regulator: fix use after free issue
      regulator: core: fix regulator_register() error paths to properly release rdev

 drivers/regulator/core.c               | 16 ++++++++++++----
 drivers/regulator/max77650-regulator.c |  7 +++++++
 drivers/regulator/rn5t618-regulator.c  |  1 +
 drivers/regulator/s5m8767.c            |  2 +-
 4 files changed, 21 insertions(+), 5 deletions(-)

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl34yy0ACgkQJNaLcl1U
h9ARAgf+JowpR10+rAafrIw0nGTLnzWltpA2O6BcVDR//4AX6H1DKy4gzxu9VHUQ
0qJ3Vm5uoGg3Od/QhU7lTFo/H5+iO+aMl+xJFdoDlGkHwP0cAmoZk35bEuAu6hJu
biKih5HvRg00QLuAg4SPBgt7+GqbMW1nUraHEBAuzUrzwBLObihQzE2+EwOv1tQU
EwKDNsOO94bstv8bjbyNSTmCHUO4Mxwf9p+339REc/04Lj4Wg7fQ73NEtk4Tl/T9
umOHOMqBttU1UhAhNFQLCiPruJr/s8XlAX00LDnvTs0b6TID8kvLy09u5lb4lP+D
3uiCEZO5wFIpnV1CHYDKrzmEdnSegg==
=LBpn
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--
