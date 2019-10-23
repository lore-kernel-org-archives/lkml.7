Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D07CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F0B21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571848896;
	bh=qa2RpbyK8WVu7bJzpjKNrc7LpZzN3OwA7S1PzikbESY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=FkUkuGNQB1SNsAcG66MupGnr28Jj3F9dIczLXjdXdJyaZOUpNw/FgS7hil2FrmHvR
	 pATj/5Ag87VLed8vaT2+rUZHeS3nddRWt8CHd5QTk+o45ADw7luzzg1x4dVH34NvIX
	 b6PphwrprSA9veXA7qbFqLpun/VbTofRfhrgJ7Z8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407315AbfJWQlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:41:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58850 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730796AbfJWQlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XuyXAOjEf3zmD1k5zJGGF/5kno23kl46xCMEzjKyWsY=; b=Ci70tSNxskI+I0RopQuPanxE3
        NwmRo0D2GuKM5byCYS9BDF/P8SHgL1RttL9Y8ZQzZD3Pgjcmdsp5z0bA4kEcUr8GIQ3/6CyD/KvEq
        h+bhHLpuIJxU49V2QuHW9+b9NJf8kjSR7wsraXIE226NZziEcupe4q79ntuxE8iMs/GzQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNJhU-0000x9-Is; Wed, 23 Oct 2019 16:41:32 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id CF5E32743021; Wed, 23 Oct 2019 17:41:31 +0100 (BST)
Date:   Wed, 23 Oct 2019 17:41:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: [GIT PULL] regulator fixes for v5.4
Message-ID: <20191023164131.GJ5723@sirena.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EVh9lyqKgK19OcEf"
Content-Disposition: inline
X-Cookie: MMM-MM!!  So THIS is BIO-NEBULATION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVh9lyqKgK19OcEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit c82f27df07573ec7b124efe176d2ac6c038787a5:

  regulator: core: Fix error return for /sys access (2019-09-11 11:17:23 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.4-rc4

for you to fetch changes up to 77fd66c9ff3e992718a79fa6407148935d34b50f:

  regulator: qcom-rpmh: Fix PMIC5 BoB min voltage (2019-10-04 18:44:37 +0100)

----------------------------------------------------------------
regulator: Fixes for v5.4

There are a few core fixes here around error handling and handling if
suspend mode configuration and some driver specific fixes here but the
most important change is the fix to the fixed-regulator DT schema
conversion introduced during the last merge window. That fixes one of
the last two errors preventing successful execution of "make dt_binding_check"
which will be enourmously helpful for DT schema development.

----------------------------------------------------------------
Axel Lin (2):
      regulator: fixed: Prevent NULL pointer dereference when !CONFIG_OF
      regulator: ti-abb: Fix timeout in ti_abb_wait_txdone/ti_abb_clear_all_txdone

Charles Keepax (1):
      regulator: lochnagar: Add on_off_delay for VDDCORE

Kiran Gunda (1):
      regulator: qcom-rpmh: Fix PMIC5 BoB min voltage

Marco Felsch (3):
      regulator: of: fix suspend-min/max-voltage parsing
      regulator: core: make regulator_register() EPROBE_DEFER aware
      regulator: da9062: fix suspend_enable/disable preparation

Philippe Schenker (1):
      dt-bindings: fixed-regulator: fix compatible enum

Yizhuo (1):
      regulator: pfuze100-regulator: Variable "val" in pfuze100_regulator_probe() could be uninitialized

 .../bindings/regulator/fixed-regulator.yaml        |   4 +-
 drivers/regulator/core.c                           |  13 +++
 drivers/regulator/da9062-regulator.c               | 118 ++++++++-------------
 drivers/regulator/fixed.c                          |   5 +-
 drivers/regulator/lochnagar-regulator.c            |   1 +
 drivers/regulator/of_regulator.c                   |  27 +++--
 drivers/regulator/pfuze100-regulator.c             |   8 +-
 drivers/regulator/qcom-rpmh-regulator.c            |   4 +-
 drivers/regulator/ti-abb-regulator.c               |  26 ++---
 9 files changed, 100 insertions(+), 106 deletions(-)

--EVh9lyqKgK19OcEf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2wgrsACgkQJNaLcl1U
h9CBGwgAhfnp6IA3Y6YtOPZ5i8I38NpfXTqmv7twAJskwJh+AJzH3NkDFom87z6s
LUb2TXe+ey7esrVTBr7ZOFq43RtxQPMoeXLvRC/OU8nYNLjpdB6269n5ou6qm2F7
3tJbbq73fYXlnKVRBWo4lu0uNKBVXhoJK64JxW4A6jTUkD3Oo3qfAGY1OgOvtyu3
R9WSQ2B2O4T2xZetZA4dtzgmWd1eP5rc/OIjdtxYXFQtyh+BesbMPgkp1P0drDwU
X5Z/B69xYbJwut/97KCpJvd8nzQhfrxH7BQ6OmLWXNOnkMnW/fVUdwY1mary5Jnv
WauNT4ty7orMLbJm+6ETDR35gdXe1g==
=5tPO
-----END PGP SIGNATURE-----

--EVh9lyqKgK19OcEf--
