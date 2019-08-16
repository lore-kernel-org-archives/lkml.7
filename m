Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EE4C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 09:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB9921655
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 09:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565949504;
	bh=/WSy9j2iYT01Rxs8gxmHUnYV6ztO0QAJLRoEe22qF1I=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ZTRtrJ3ev5B4lIdmD6gPCJP6qu18x+rC/Hy49NZ9E2DpXPk/o0J+njsOp/Gpym11Q
	 Kd+tB8wWyyg0iI09nBhrvaP9S3WUGaCaXwfroRiT0jCLPPYxFBLPQqE03PenMAC9Kj
	 06yP5sarHwmmfx/n+WZ1WM5ctZaJFFN0wgeHx1KA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfHPJ6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 05:58:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:32968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbfHPJ6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 05:58:22 -0400
Received: from localhost (unknown [117.99.90.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73DF12133F;
        Fri, 16 Aug 2019 09:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565949501;
        bh=/WSy9j2iYT01Rxs8gxmHUnYV6ztO0QAJLRoEe22qF1I=;
        h=Date:From:To:Cc:Subject:From;
        b=U1i6AXWwH+cLHbsqKrjdQTNc55sAomcu9Idiy99msv3yQQyvkVonLOj38vMG3yhpu
         DRkPMibTminSVYQ80+Fr9hVeb4KszDs/1srD1eF1YW3ZRF24qzK0m84c9il1/TK7UA
         DdhXtzgcjvuPrsIEKfjBE5D8UkWOXEP49xz9c4zo=
Date:   Fri, 16 Aug 2019 15:27:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] soundwire fixes for v5.4-rc5
Message-ID: <20190816095709.GC12733@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

We have couple of fixes queued up, please pull. Some more are in review,
will send them later.
These fixes are in linux-next as well.

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-5.3-rc5

for you to fetch changes up to 8676b3ca4673517650fd509d7fa586aff87b3c28:

  soundwire: fix regmap dependencies and align with other serial links (201=
9-08-09 10:20:40 +0530)

----------------------------------------------------------------
soundwire fixes for v5.3-rc5

Pierre sent fixes which are queued now for v5.3-rc5 are:
 - regmap dependecy
 - cadence register definitions

----------------------------------------------------------------
Pierre-Louis Bossart (3):
      soundwire: cadence_master: fix register definition for SLAVE_STATE
      soundwire: cadence_master: fix definitions for INTSTAT0/1
      soundwire: fix regmap dependencies and align with other serial links

 drivers/base/regmap/Kconfig        | 2 +-
 drivers/soundwire/Kconfig          | 7 +------
 drivers/soundwire/Makefile         | 2 +-
 drivers/soundwire/cadence_master.c | 8 ++++----
 4 files changed, 7 insertions(+), 12 deletions(-)

Thanks
--=20
~Vinod

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdVn31AAoJEHwUBw8lI4NHbucQAM+0LcMCYEANet0ypYgl51j2
k8EUiwGmk+QFnyOuBmjQy57Q6SxLLBRDx5+rbXUro9AuZaWae+sobMeK/OYw++3c
PMs7s4X5bU3I9qibnv6yco4G3jh7LOraFKXbWPTL/LuJcnThTo6ml9pt1Od7dccY
FzcE0bZ/AJgN37+Oa/Wsb85gvX5Cdg5lKRqcVhFQZX3I/hvqN4Cs7dRa8UsO2xON
ZtpOdKHCchR1URSzVqWhpGIxgU1L8eBLlh0BKFeoSrVBv5Gb8XcJmCa5ypM6nZpQ
Ra3Rdv5PXJ3clrj93C2+3pwY17wISjQKjcWeo/esCmxm+Psq3sRo61hO8PFkuGm6
xNHC2djcYPyMlmPwQp75Xfr2SOAWr1Ca9W4jk2V4A3hxQ/cpocYFy9BGs9O4wzGV
kaJFeS9mBQxgMYEqinu2KeS2Ek313Q2Y8c89m924FBzCSpIlUehZImgACukMigI/
TYnk0lpMk3InbS3uHJOKQQRpMclgbhFg4x3HzFmaeYKKZGlraNUWiXYf7+ZNbBTR
o2Cqqe3CwYRsZW5EUlazQW8ZTctoGCnu26noLLKkhOecmSWNW8f3HS4/koGWTQPf
KemgIL7ZpIDOzQ5DhmcOJmCkIS8IPw8S2S7SsV1VWl4Ns2wqLv/pVOOizHaR0OLu
mJOnsFTTkm54zmzvcmAp
=JH/o
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--
