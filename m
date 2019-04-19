Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A6EC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D986020449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698684;
	bh=Q0yXdmX+CMKEBlh6MXDY+bQpfR5QfU4tzE38/NjmTVU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=hbN+fGHK19mL+2Lkl2dk/DCnXKZ7xiTtuA64tVjDgMVYvlNotB3oBHRrj6UOU/haA
	 QLOJDD+4342RZ1TeQWoDK+0JZiBXeUewNs61cw0gXR43qRZTBksGO/APnGP7q1SALT
	 Y8i9hCyeVRwhVX0JaHGcs6qKoqHwJ5n5xpK07f/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfDSSbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:31:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbfDSS3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40B0621A4C;
        Fri, 19 Apr 2019 12:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555677066;
        bh=Q0yXdmX+CMKEBlh6MXDY+bQpfR5QfU4tzE38/NjmTVU=;
        h=Date:From:To:Cc:Subject:From;
        b=wqApTyhpF2OvwGZ9sci6SrMU77JU4aYtwv4KbKe/HRkWEp/jnrtZ7UWjJt0sBtGuS
         hQvkj1cOIS51U40BOXCb5Mj7c9ILvQdM42qQ/ox1bFgFzTEPaVBDMOKa0+5HFadBjL
         FB1M688zczOyuwTJyV1p1uMfPLVl9F9ulyHUpnck=
Date:   Fri, 19 Apr 2019 14:31:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging driver fixes for 5.1-rc6
Message-ID: <20190419123104.GA4800@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.1-rc6

for you to fetch changes up to af4b54a2e5ba18259ff9aac445bf546dd60d037e:

  staging: comedi: ni_usb6501: Fix possible double-free of ->usb_rx_buf (2019-04-17 11:59:24 +0200)

----------------------------------------------------------------
Staging/IIO fixes for 5.1-rc6

Here is a bunch of IIO driver fixes, and some smaller staging driver
fixes, for 5.1-rc6.  The IIO fixes were delayed due to my vacation, but
all resolve a number of reported issues and have been in linux-next for
a few weeks with no reported issues.

The other staging driver fixes are all tiny, resolving some reported
issues in the comedi and most drivers, as well as some erofs fixes.

All of these patches have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      iio: pms7003: select IIO_TRIGGERED_BUFFER

Christian Gromm (1):
      staging: most: core: use device description as name

Dragos Bogdan (1):
      iio: ad_sigma_delta: select channel when reading register

Fabrice Gasnier (1):
      iio: core: fix a possible circular locking dependency

Gao Xiang (1):
      staging: erofs: fix unexpected out-of-bound data access

Georg Ottinger (1):
      iio: adc: at91: disable adc channel interrupt in timeout case

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-5.1a' of git://git.kernel.org/.../jic23/iio into staging-linus

Gwendal Grignou (1):
      iio: cros_ec: Fix the maths for gyro scale calculation

Ian Abbott (4):
      staging: comedi: vmk80xx: Fix use of uninitialized semaphore
      staging: comedi: vmk80xx: Fix possible double-free of ->usb_rx_buf
      staging: comedi: ni_usb6501: Fix use of uninitialized mutex
      staging: comedi: ni_usb6501: Fix possible double-free of ->usb_rx_buf

Jean-Francois Dagenais (1):
      iio: dac: mcp4725: add missing powerdown bits in store eeprom

Jonathan Cameron (1):
      iio: chemical: fix missing Kconfig block for sgp30

Lars-Peter Clausen (1):
      iio: Fix scan mask selection

Leonard Pollak (1):
      Staging: iio: meter: fixed typo

Mike Looijmans (3):
      iio/gyro/bmg160: Use millidegrees for temperature scale
      iio:chemical:bme680: Fix, report temperature in millidegrees
      iio:chemical:bme680: Fix SPI read interface

Mircea Caprioru (1):
      staging: iio: ad7192: Fix ad7193 channel address

Sergey Larin (1):
      iio: gyro: mpu3050: fix chip ID reading

Sven Van Asbroeck (3):
      iio: adc: xilinx: fix potential use-after-free on remove
      iio: adc: xilinx: fix potential use-after-free on probe
      iio: adc: xilinx: prevent touching unclocked h/w on remove

he, bo (1):
      io: accel: kxcjk1013: restore the range after resume.

 drivers/iio/accel/kxcjk-1013.c                     |   2 +
 drivers/iio/adc/ad_sigma_delta.c                   |   1 +
 drivers/iio/adc/at91_adc.c                         |  28 +++--
 drivers/iio/adc/xilinx-xadc-core.c                 |   3 +-
 drivers/iio/chemical/Kconfig                       |  14 +++
 drivers/iio/chemical/bme680.h                      |   6 +-
 drivers/iio/chemical/bme680_core.c                 |  54 ++++++++--
 drivers/iio/chemical/bme680_i2c.c                  |  21 ----
 drivers/iio/chemical/bme680_spi.c                  | 115 ++++++++++++++-------
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |   7 +-
 drivers/iio/dac/mcp4725.c                          |   1 +
 drivers/iio/gyro/bmg160_core.c                     |   6 +-
 drivers/iio/gyro/mpu3050-core.c                    |   8 +-
 drivers/iio/industrialio-buffer.c                  |   5 +-
 drivers/iio/industrialio-core.c                    |   4 +-
 drivers/staging/comedi/drivers/ni_usb6501.c        |  10 +-
 drivers/staging/comedi/drivers/vmk80xx.c           |   8 +-
 drivers/staging/erofs/data.c                       |   2 +-
 drivers/staging/iio/adc/ad7192.c                   |   8 +-
 drivers/staging/iio/meter/ade7854.c                |   2 +-
 drivers/staging/most/core.c                        |   2 +-
 21 files changed, 192 insertions(+), 115 deletions(-)
