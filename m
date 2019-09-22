Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38847C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 16:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A50A206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 16:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569168130;
	bh=9wsAAbEAVofJ6yJd8qo5jL+AB/s4bUWzZ6+YiC2pUjg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=bIU/ZxSHDVZ/nKI1Qv/tdA5MwtmKRqbe5rh5tD0bNigKoc4ekunkMWAAoMcuwn7Xm
	 2y7SV0CITnVDV4KacHGz1JDxND/8ynV0lzF+ODdR1OOjTnZsQJRisz+py9gZb9u8Ai
	 EA+Y6uuZ+/YrAu+g32h7ciJn/M2dfaejqNsU7gJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387580AbfIVQCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 12:02:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387558AbfIVQCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 12:02:08 -0400
Received: from earth.universe (dyndsl-037-138-173-172.ewe-ip-backbone.de [37.138.173.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12291206C2;
        Sun, 22 Sep 2019 16:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569168128;
        bh=9wsAAbEAVofJ6yJd8qo5jL+AB/s4bUWzZ6+YiC2pUjg=;
        h=Date:From:To:Cc:Subject:From;
        b=KqqN3E+dbw8R2uPMMIQNBFCHLOJo8OFyH83hxYCxH6zg8G77RfWcXnuHGjtk7cJ9a
         JPYFzE44OwC+Zs1wPylQtZuCEiFzjQke6/3dcYANTaHdjR/QlgWLS7TtTGf7A8uqmb
         2/DhmLShYWPaORv/d9mhkwSEZv/X3iEVS5UalcH0=
Received: by earth.universe (Postfix, from userid 1000)
        id 142113C0CA1; Sun, 22 Sep 2019 18:02:06 +0200 (CEST)
Date:   Sun, 22 Sep 2019 18:02:06 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] hsi changes for hsi-5.4
Message-ID: <20190922160206.qqsrupqvtly4akhn@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iuhiomdhesaqvih4"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iuhiomdhesaqvih4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-5.4

for you to fetch changes up to c1030cd456198a2c58f718c3c4b215698d635553:

  HSI: Remove dev_err() usage after platform_get_irq() (2019-07-30 22:40:03 +0200)

----------------------------------------------------------------
HSI changes for the 5.4 series

* misc. cleanups

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      HSI: ssi_protocol: Mark expected switch fall-throughs

Stephen Boyd (1):
      HSI: Remove dev_err() usage after platform_get_irq()

 drivers/hsi/clients/ssi_protocol.c      | 7 ++++---
 drivers/hsi/controllers/omap_ssi_core.c | 4 +---
 drivers/hsi/controllers/omap_ssi_port.c | 4 +---
 3 files changed, 6 insertions(+), 9 deletions(-)

--iuhiomdhesaqvih4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2HmvoACgkQ2O7X88g7
+prddQ//alQY6J3SV7+7UX3bv3LmHi+yGh/7S33XHK+4hhyLvCfcn6gqZU8wH0At
NuFipy9PS2gLX23q0Ir4J5Fojsjh2AGaxxIBuzLwuS+Ly7ic8LQ9kNBgs3uMFm5H
Ka0CJpur4funO82ILRBlryNqhrj3hGMt09H8y7nuJz55U5g/Fm1oQE8g6o4/h/SI
ssf9wBSDZG4jYlz5UiyQtLBteRogZsp0D1FR0u1nTyuAH30Yutd0jzOa5NvWGR7D
ZJwkKcYXd2fbHbp8u5rZdVOf0LK7TP0aWkrEIng7lB/u8oO5iWBL2aBv2fRU9mSh
wooIV3M4pZk1LirVLpEGXIGqXstqmzBjwUVFeeFk9twCcqVv+DuZqwwD6FBgLwcD
b1FFl/hXnY0voR4WQWgYhlF565navLkKiWakHUTDCVIm1PNXf2ba0fCZgAb1S4dC
tEDEWrCy5kGX659d1tMj+TxRPyRhbuseyNC524yeYO1Bf/OBcGByTZvBpD3YboLI
St5BS5fSUY9ggyvZa+NbQR/+ZIgOMX/ZNmXbigR8Mnv+9EleuI7OoVMos7DhxNBq
WhES1E+kW35yADX2hn8VLx51vgUFIXEYbn/+EcAIWbOnFmX7YWwAaZS2Xu4b6MX7
arTwXbhKEm85xkzisVShAjTX1eRorXHv0Xr/a/UCcyJr6iptgvQ=
=/Vul
-----END PGP SIGNATURE-----

--iuhiomdhesaqvih4--
