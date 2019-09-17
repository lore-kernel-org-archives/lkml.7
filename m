Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387B9C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 04:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3E6214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 04:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568693578;
	bh=1fvEx3gvkmMEZxE7ds4X+IcRsU5F1NBxSZBQnAPAFr8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=gVSHMYtMP6Z10s+AMbF27lwMXZMzOio6CjA5cIO2vLDMG8iMy9nG8zDkIXldQHmwd
	 bDbmTipxMJKh+P5YbLwF5DepIYS56ftscM41FjiieVGpg36Yj4WhbBwx8fs4dFsrtY
	 blpFsNdjk9zO8xa2V6zEDa+8wbsG3CVkbQPn9eT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfIQEM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 00:12:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfIQEM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 00:12:56 -0400
Received: from localhost (unknown [122.167.81.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2735620880;
        Tue, 17 Sep 2019 04:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568693575;
        bh=1fvEx3gvkmMEZxE7ds4X+IcRsU5F1NBxSZBQnAPAFr8=;
        h=Date:From:To:Cc:Subject:From;
        b=F86SSIsqfd8NZUKXBLp47ZTdhuzsFWxZgjVpwk9OteCZ/VPv22oLz/GrPS4+2b16S
         GVOp78ir5DQO/PlNFcbPtYVfhF/QWS/aSGjsWDPMYT6A0uKuNN0x0yBjYZNIQtN5NV
         qyJPVI87bqLrt2PqzfA9N6kDXzDdkvmuTnc3WLX4=
Date:   Tue, 17 Sep 2019 09:41:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [GIT PULL] soundwire updates for v5.4-rc1
Message-ID: <20190917041147.GK4392@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi greg,

First apologies for sending this very late, I had to go out of town and
didn't have internet access, but I should have done better

Anyhow, here are the changes collected for v5.4-rc1 and as usual they
have been sitting in linux-next.

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-5.4-rc1

for you to fetch changes up to dfcff3f8a5f18a0cfa233522b5647c2e6035fcb5:

  soundwire: stream: make stream name a const pointer (2019-09-04 14:57:28 =
+0530)

----------------------------------------------------------------
soundwire updates for v5.4-rc1

This includes DT support thanks to Srini and more work done by Intel
(Pierre) on improving cadence and intel support.

Details:
 - Add DT bindings and DT support in core
 - Add debugfs support for soundwire properties
 - Improvements on streaming handling to core
 - Improved handling of Cadence module
 - More updates and improvements to Intel driver

----------------------------------------------------------------
Andy Shevchenko (1):
      soundwire: mipi_disco: Switch to use fwnode_property_count_uXX()

Bard Liao (1):
      soundwire: bus: set initial value to port_status

Bard liao (1):
      soundwire: include mod_devicetable.h to avoid compiling warnings

Pierre-Louis Bossart (21):
      soundwire: intel: remove BIOS work-arounds
      soundwire: cadence_master: simplify bus clash interrupt clear
      soundwire: bus: split handling of Device0 events
      soundwire: intel: prevent possible dereference in hw_params
      soundwire: intel: fix channel number reported by hardware
      soundwire: cadence_master: revisit interrupt settings
      soundwire: bus: improve dynamic debug comments for enumeration
      soundwire: export helpers to find row and column values
      soundwire: cadence_master: use firmware defaults for frame shape
      soundwire: stream: fix disable sequence
      soundwire: stream: remove unnecessary variable initializations
      soundwire: add new mclk_freq field for properties
      soundwire: intel: read mclk_freq property from firmware
      soundwire: cadence_master: make use of mclk_freq property
      soundwire: intel_init: add kernel module parameter to filter out links
      soundwire: cadence_master: add kernel parameter to override interrupt=
 mask
      soundwire: intel: move shutdown() callback and don't export symbol
      soundwire: add debugfs support
      soundwire: cadence_master: add debugfs register dump
      soundwire: intel: add debugfs register dump
      soundwire: intel: handle disabled links

Rander Wang (1):
      soundwire: cadence_master: fix divider setting in clock register

Srinivas Kandagatla (3):
      dt-bindings: soundwire: add slave bindings
      soundwire: core: add device tree support for slave devices
      soundwire: stream: make stream name a const pointer

Vinod Koul (2):
      soundwire: intel: remove unused variables
      soundwire: Add compute_params callback

 .../bindings/soundwire/soundwire-controller.yaml   |  82 ++++++++
 drivers/soundwire/Makefile                         |   4 +
 drivers/soundwire/bus.c                            |  20 +-
 drivers/soundwire/bus.h                            |  24 ++-
 drivers/soundwire/bus_type.c                       |   3 +
 drivers/soundwire/cadence_master.c                 | 211 +++++++++++++++++=
----
 drivers/soundwire/cadence_master.h                 |   6 +-
 drivers/soundwire/debugfs.c                        | 151 +++++++++++++++
 drivers/soundwire/intel.c                          | 211 +++++++++++++++++=
++--
 drivers/soundwire/intel_init.c                     |  11 ++
 drivers/soundwire/mipi_disco.c                     |  18 +-
 drivers/soundwire/slave.c                          |  53 ++++++
 drivers/soundwire/stream.c                         | 105 ++++++----
 include/linux/soundwire/sdw.h                      |  20 +-
 include/linux/soundwire/sdw_intel.h                |   1 +
 15 files changed, 819 insertions(+), 101 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soundwire/soundwire-c=
ontroller.yaml
 create mode 100644 drivers/soundwire/debugfs.c

Thanks
--=20
~Vinod

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdgF0DAAoJEHwUBw8lI4NH+F4P/3uOe4d03+vOrlrSL/mKSLzL
jrK/otmrtEeV5mbTGAcu6VXpZ9Rxmau3H8oSoLYlF7pScY02RTO+xr9+7rv3PsVu
hHkmobTaWatb0oGlUGGD3NDAPAFl3ZvUAjsX/bkCewkK3glRWYwV1osbHrVPNSmP
LsSYSJdvOetFTPQmbOaRfPGIaVpZ4WFEpfs2FxC4IW9Wgyp2enJ83I3Op1hoqG22
91JQTwpxewS2V7+G/+B4VM1wIzLNjnpNNKzJ4WZbZndzMOx0bmXzjyPyzNXL0AL2
N2WQ5OWHQUA6oUNJssCxF33CDX6xt7r+hNqE4mHpNEw7EUN+kDLc1mweXZksaFiZ
v5kvpl/0FuMjvW5iF+ew5R6hM3FneRcRH4N/Stwwu1eP+72mlqM45L6aoQBykW3O
+oECo7NUpg/vvmio0yycuSEBnrjzFBYdTFSPz3v8p4EygdnQQddMzbXU613bL6G8
wn482YrIP4gSp5AQouklX400eMRVrs9npq8UNMWGPGe6PRAAF3ciJtBqtaiefOAj
ZDYphrVg6QpBp2fnWsEkz8A5ldJ1O9u5obsNU3lLxGouTL5bxo4ixeQuRQvmYqik
tCoQDoVTBec7xhGbtaMLl+NyzY9cll3t8OwOLNY/2OC8oZRXFBvI7f+4o4c0ZOUc
Zh+OAztC89KvSQbBzFad
=Xwbm
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
