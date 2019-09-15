Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041C5C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 22:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A6B2077C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 22:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568587397;
	bh=MdqFAOE+2DNDHQAGOVBoHXXuw9d5idZl6zrdrTci9c0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=rkVxkkGtLtOI5JRvLgLdSCK/yMJvWqOVFzOrDKBxOAvNf7Y1OiBaUeVvk5jeBiOEv
	 Fg2Qh7GGa/F6jxVPwTs7EQCqcVuDOmQ1XyAG/xpgL4WTweM0sZj3uDzGRtMPQvbdHs
	 wZYt8sU2GbPlcVWQE0Qrrr8sejTCXGP9iM635JI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfIOWnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 18:43:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38454 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfIOWnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 18:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UNDR/lp43Ps83XKO2JRrLH9gra/v02hb+QFq/weqnwE=; b=XtKHZtKimxONShXSzdd7hknM1
        lmsPvPTEo5nG7UluuZuyD7WyC9j51j87m0JJwI+7SxilwBUwE5qgXL8/7dTPWfuCJmaXX0zX9nX/t
        J9UbsuvWEOtPUljdvS5BcKevByIihAPXY6O27KhqhEgrHYNgqV53zAYF7+0wS374nvAcE=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i9dEg-0001XJ-V2; Sun, 15 Sep 2019 22:43:15 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 22D8B27415FF; Sun, 15 Sep 2019 23:43:14 +0100 (BST)
Date:   Sun, 15 Sep 2019 23:43:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] regmap updates for v5.4
Message-ID: <20190915224314.GM4352@sirena.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YIwHDYD8sUXtBKvt"
Content-Disposition: inline
X-Cookie: Man and wife make one fool.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YIwHDYD8sUXtBKvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit d45331b00ddb179e291766617259261c112db872:

  Linux 5.3-rc4 (2019-08-11 13:26:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.4

for you to fetch changes up to 1bd4584626a9715634d2cb91ae2ed0364c070b01:

  Merge branch 'regmap-5.4' into regmap-next (2019-08-12 14:10:42 +0100)

----------------------------------------------------------------
regmap: Updates for v5.4

Only two changes for this release, one fix for error handling with
runtime PM and a change from Greg removing error handling from debugfs
API calls now that they implement user visible error reporting.

----------------------------------------------------------------
Charles Keepax (1):
      regmap-irq: Correct error paths in regmap_irq_thread for pm_runtime

Greg Kroah-Hartman (1):
      regmap: no need to check return value of debugfs_create functions

Mark Brown (2):
      Merge branch 'regmap-5.3' into regmap-linus
      Merge branch 'regmap-5.4' into regmap-next

 drivers/base/regmap/regmap-debugfs.c | 12 ------------
 drivers/base/regmap/regmap-irq.c     |  7 +------
 2 files changed, 1 insertion(+), 18 deletions(-)

--YIwHDYD8sUXtBKvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1+voEACgkQJNaLcl1U
h9CZowf/V1cODLNnfpMeIz9wNLWrdM9fVqqPg7L838rJpeHzjoE85htJ9+xOTxby
bEMAfzmi1gzAmkBqr+6/odb5CwTBkHEISk1N0aFrBBXNlL8gi6vo6i541Oe8ueTv
qxHWhQ06Lc4MI4YpbCJbOIA9Xg5iBL/eJYLoW89SbnJ3uNXqh+M9e8o78omSYY2G
YioPtJ9rMJa4EhM6mUJL8i60/b7u6l46/Mw7ateHcye+7JjITjYRYCTQMSJ9NRfQ
u5niCsjCTMldUNeQ0IT6KMNQHgdTsMVC+mktbIZi21NzKj2HPwwTGqIMSFhdTeej
KIc9PivlKAqcylgTm52gBjwB1wZKJQ==
=PUyi
-----END PGP SIGNATURE-----

--YIwHDYD8sUXtBKvt--
