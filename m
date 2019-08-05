Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60D0C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D841214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565015676;
	bh=wGzPCTudUiLOBkA2oPiSV8Ka7bMpn5UGmhHSEmj1PDE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=WBkfxEDayOF964xBbmtlePHkgP/bSKDunLVaijIH28DhOe2a7QwB0tVvWrQLfnD/x
	 r3zAbKTsTk9aGgi5bbskwGTAKdqpgEpGRySZrsGY/e7mndxAUiv2ohH9AV/dyNNUb2
	 53her4FK9q5XKyCDLycOL7lUK+ZKNaU/EEe6KaPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbfHEOef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 10:34:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45762 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbfHEOee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 10:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TH4ezi3C5sqdCLbtzUOjWsIb1FpLjjz2LE22M9NYaUA=; b=M2oV+68mtS7+IfdiyGfyGqyJf
        PRfLxNGfZOWW2RU4VCdz8mgzOKf/e031bsnaZf6pfDFtCzRP/SnJBYWZxuL73OrIrFZpbllIdwLHB
        YD9Ri3qAlbxTxf9/n0r98bNrLk+054+oEzWNllayTWxGt2slHtuIHwqNpdq0Sn3wT59YY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hue4G-0000Ud-OC; Mon, 05 Aug 2019 14:34:32 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D97BC2742D06; Mon,  5 Aug 2019 15:34:31 +0100 (BST)
Date:   Mon, 5 Aug 2019 15:34:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] regulator fixes for v5.3
Message-ID: <20190805143431.GH6432@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2oox5VnwalALFvA7"
Content-Disposition: inline
X-Cookie: Place stamp here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oox5VnwalALFvA7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.3-rc3

for you to fetch changes up to 811ba489fa524ec634933cdf83aaf6c007a4c004:

  regulator: of: Add of_node_put() before return in function (2019-08-01 14:07:46 +0100)

----------------------------------------------------------------
regulator: Fixes for v5.3

A few small driver specific fixes here plus one core fix for a
refcounting problem with DT which will have little practical impact
unless overlays are used.

----------------------------------------------------------------
Axel Lin (1):
      regulator: lp87565: Fix probe failure for "ti,lp87565"

Jernej Skrabec (2):
      regulator: axp20x: fix DCDCA and DCDCD for AXP806
      regulator: axp20x: fix DCDC5 and DCDC6 for AXP803

Mark Brown (1):
      Merge tag 'v5.3-rc1' into regulator-5.3

Nishka Dasgupta (1):
      regulator: of: Add of_node_put() before return in function

 drivers/regulator/axp20x-regulator.c  | 10 +++++-----
 drivers/regulator/lp87565-regulator.c |  8 ++++----
 drivers/regulator/of_regulator.c      |  4 +++-
 3 files changed, 12 insertions(+), 10 deletions(-)

--2oox5VnwalALFvA7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1IPncACgkQJNaLcl1U
h9Civwf+J63Oq3qrB4LPfiXPCZYT8wTRuPoT7kR5sAF3uu0byH6FFAPGHT1JcyF/
VdBpPQio8TWpqQfhnLJ+oZ0Dd0/lLWrpPqx3prPWxrbmVUlQ2mqp8voYUgX4YPBR
GgiSTgUppfwFtHo7SWdl0m75qJDqJp1vQhz3as8MV5uoStpXv2PZD4wlr6fVbJ5p
XE5+Ul2GMkLJXHL8l6uXMZ+uigS2Uh56x4MWZHG0gwrQotrkir3uV0aWoQ+++2NP
LBOZij8vQsT+R8d8ePqVxJmsxdODvf4heb+IeyGPZgLwDCQj1ziU8QwCczmGqh/Q
uFiZhA0EjRWVs+jzbDzk/1Etj5gnxA==
=1s0m
-----END PGP SIGNATURE-----

--2oox5VnwalALFvA7--
