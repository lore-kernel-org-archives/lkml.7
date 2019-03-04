Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D80DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E7820823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551716342;
	bh=ga2dz3nIpLjy7D5jmSqN8PjH0ZT+h+qcF6JL0FnpqPI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=xYQkw+6f9D3scb3TGPcwHNaR8cHN3TxtHya4MUjEtsXpcSuVEB4i/0btfx7Go7L5I
	 VAw8wIwC9zhS1MS85kBeeqGO28PgmthU+VtDfLG/VVwvOQvD+L3Zf9BXZQFHzrsGzy
	 G5WCr0sQYOzO8j5adMx0Sr9MTArPjivr4tKqIK8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfCDQTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 11:19:00 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48522 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfCDQS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 11:18:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VN9wRbdwNR9KAwVDQVuS30FGOyUupoqXgA7e1zbuvlw=; b=hsciqyJThJHm1n+4Liur3WSWZ
        XDSxXSeB4LGSjCeklLYYoQPcixOTeuuZj/AcqE3pbRBTn/1AW2wn8dZj6WBXUlZqeds4YJk19/JrE
        gT9PskECI9ex4Rd9Lu2Ibfs/bGXG+F1wNAUfdyqVKLzWVwWWZmBzHwY5g7FzXyxzK5++M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h0qIr-00034I-D6; Mon, 04 Mar 2019 16:18:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0767B1128814; Mon,  4 Mar 2019 16:18:56 +0000 (GMT)
Date:   Mon, 4 Mar 2019 16:18:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] regmap updates for v5.1
Message-ID: <20190304161855.GA8877@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
X-Cookie: Do, or do not
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit f17b5f06cb92ef2250513a1e154c47b78df07d40:

  Linux 5.0-rc4 (2019-01-27 15:18:05 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.1

for you to fetch changes up to 66fb181d6f824f7695417e8c19560c5b57dc8c2d:

  Merge remote-tracking branch 'regmap/topic/irq' into regmap-next (2019-01-29 17:17:03 +0000)

----------------------------------------------------------------
regmap: Changes for v5.1

There's only two changes here, one fix for conflicting attributes on the
rbtree node structure and the implementation of main status register
support in the interrupt code which supports chips that have a register
to cut down on the number of per-interrupt status registers that need to
be checked when handling interrupts.

----------------------------------------------------------------
Mark Brown (2):
      Merge branch 'regmap-5.1' into regmap-next
      Merge remote-tracking branch 'regmap/topic/irq' into regmap-next

Mathieu Malaterre (1):
      regmap: Remove attribute packed from struct 'regcache_rbtree_node'

Matti Vaittinen (1):
      regmap: regmap-irq: Add main status register support

 drivers/base/regmap/regcache-rbtree.c |  2 +-
 drivers/base/regmap/regmap-irq.c      | 99 +++++++++++++++++++++++++++++++++--
 include/linux/regmap.h                | 31 +++++++++++
 3 files changed, 127 insertions(+), 5 deletions(-)

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx9T+8ACgkQJNaLcl1U
h9Bp9Qf9Hl35Xvzk14n7+eQ3i4Tn1A05l6jfI4lUncVOlXJoNQE9g0RJcFsXLWym
7+a5//l3ooDuLpuibXMM3OkcY9VfXhj5Nsq56vWLmFmxkCgxUlXDGIN+Vs7gqR2+
kWRAdB9Frl0M4Hu4Q8EwZ/XU/GygQ/sGPqO3hZE5JSG6QG4qpNw44V7kJRHS74yt
WuvIClS829nJFOd/sywubDgM2+t/WuWqyEpzUozti/55ZFNSR2+llSFeaJ2vMBKB
3/H8inEXA6dLQIHnXwhBa8P65ZZbnpUcQFxTJ7NzrfUMpFaIV6lrqPIHIIfcSuTz
Pfw1AYwkzCtfZJ0PnDTbD3msDidp6w==
=jYf2
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
