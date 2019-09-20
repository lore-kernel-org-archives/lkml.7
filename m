Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB6FC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BAC2067B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568988237;
	bh=K9lsB5ULphBbXbCVVVum93smBl4jbswhCzaYTFnOYGU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=xpvfsEr3/Zr943OGlmMqoey1U1JjT9w/zoD6hDbvolwabtX3QmuczfV4SUYdSfM3R
	 cG7sB7dCVX3gLsp8IoDOLwilmdfMJMa5x7bCb8d0antBZL5qyEroiSbV53q6S+k9R/
	 WYOAmTriOK0Soc7bFQtoaYS+yGrIcmxiK1XfjT7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfITOD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:03:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727904AbfITOD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:03:57 -0400
Received: from localhost (unknown [171.76.80.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28F9E20644;
        Fri, 20 Sep 2019 14:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568988235;
        bh=K9lsB5ULphBbXbCVVVum93smBl4jbswhCzaYTFnOYGU=;
        h=Date:From:To:Cc:Subject:From;
        b=PRaisUq1LTQ8eqtMtg/A7yQMIoAOCeqiLP4pcXmGM40qAoM6r6sYOHWxi62A7Kkjw
         q3/KYqN5NZ1/rxsYMJwcUJ6hpIXlvTeeZQbKTzImEAxEA7eFwW8M0/fpMJg6qhyndz
         9Vxm+nkSsgrKg3GDgCf4SDjyPJm8UauJuMVCL09A=
Date:   Fri, 20 Sep 2019 19:32:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] soundwire updates for v5.4-rc1
Message-ID: <20190920140247.GX4392@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Normally soundwire updates go thru Greg (char) but this time around I
missed the bus to send him due to some stuff.

So with Greg's blessing here is the pull request for soundwire
subsystem. Please pull to receive these updates.

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

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdhNwHAAoJEHwUBw8lI4NHhMgQALL3Eo4wxtF+CKCnu3zjarBZ
ekJVYsijAz7ZVkbB0UDBYpxfS6Rn2XwqDyIO5KrSlZ+IG3zuKtnHuJ7vW8RtSj/s
TVdovGu8JDYTEtvJisxaHbPfdq7DZ7GP2vWLh1hfN08ucjAsX/tFCX94w0ul9daD
9l77q/9PXdwfuV8btCJrzoOKLdD3HyqVZdQgAmfWHzV35ZF2G8G7y+Np6Tjz/U+Z
OJNxMMoVnG3g6AxGVoNavLUhA7TCRVKfUltXK2drH+Rcww2ouuXAX5dFqUG/UjaP
bcs02p50RRkbzKmFo0zst3a+FprWkrGkELngSXIbQPZE4T91WkBArk7rNzN7mu64
wrOevjEiIdMpNvPTIJO3TBHdYlitvbeW0ukn5YnT18FAPSwE2zwOkxUWBrvIXt8F
R8d1kb9CtoM72KWvH7V/rcEzvNvrcNiy4QiXWK3nK1L86pl9HB1Wz1yuWAI8sX9t
3Ps27RpJskymMy0tkonVCTzBLiMpYgGPndibSTYL1VeuAanAaqV+yT1wVhbiv2e1
BgZtUg6OaDjj8nEHrB1bDlMDId89hdFipknMW8mbrtsnSTC7MA8FMGMJsFBymhzK
8BSsrkBKFzU1OifxSx+zD+kLgguEck2raeNdniRwlwgl1q9JexIunK2IyawMVvCt
GJ6Zzng7Li85e/4OX8fA
=dsLL
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
