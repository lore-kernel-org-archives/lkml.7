Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA9BC43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 15:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CB624656
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 15:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576337272;
	bh=y5MB+qGzyOrtC6JL8tH+Wpn8yVc6/kX3dLZJJyDxdpw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=aVWW/zmYTr1dlpUgZ5ghp39z0HIXgMXOpluBBL2EW2+P+6acRT6vVBRM75j2Z9Y3h
	 lodypsMCjCUXmDRwtXGfJ/Pfuhi2UJpC60GaQcVjhIbLMzoDZHOFDAT9xmr83bmGPR
	 jHRNJJ+oJENgMmg9fUY14kum5uQ9CWfOHZ/vcpX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLNP1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 10:27:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:34674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbfLNP1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 10:27:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C46A0214AF;
        Sat, 14 Dec 2019 15:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576337270;
        bh=y5MB+qGzyOrtC6JL8tH+Wpn8yVc6/kX3dLZJJyDxdpw=;
        h=Date:From:To:Cc:Subject:From;
        b=fQiKq8UrUnBNe6Z/JOM1RMEwBTqYjZk7kW50vjUEIzTixoXf5ElhkVagExLphJkK+
         vPpkLacrwqltEO9cOIo5v4FbtCjwVLEKC4cW7SGTc4wU/5n4LhzrSq9R7lYV3B8eG8
         CDWECd6DZJl+qHV/K1Gs32R21Y3WRb25pfUGlE0g=
Date:   Sat, 14 Dec 2019 16:27:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging / IIO driver fixes for 5.5-rc2
Message-ID: <20191214152748.GA3460096@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.5-rc2

for you to fetch changes up to 4bcd9eae731083bb724faf68cce6021213308333:

  fbtft: Fix the initialization from property algorithm (2019-12-10 15:55:55 +0100)

----------------------------------------------------------------
Staging/IIO fixes for 5.5-rc2

Here are a number of small staging and IIO driver fixes for reported
issues for 5.5-rc2

Nothing major, a bunch of tiny IIO driver issues resolved, and some
staging driver fixes for things that people ran into with 5.5-rc1.  Full
details are in the shortlog.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andrea Merello (1):
      iio: ad7949: fix channels mixups

Andrea Righi (1):
      staging: exfat: properly support discard in clr_alloc_bitmap()

Andy Shevchenko (1):
      fbtft: Fix the initialization from property algorithm

Beniamin Bia (1):
      iio: adc: ad7606: fix reading unnecessary data from device

Brendan Higgins (1):
      staging: exfat: fix multiple definition error of `rename_file'

Chris Lesiak (1):
      iio: humidity: hdc100x: fix IIO_HUMIDITYRELATIVE channel reporting

Chuhong Yuan (1):
      iio: adc: max1027: fix not unregistered iio trigger

Colin Ian King (1):
      iio: temperature: ltc2983: fix u32 read into a unsigned long long

Dan Carpenter (1):
      iio: adc: intel_mrfld_adc: Allocating too much data in probe()

Geert Uytterhoeven (1):
      iio: adc: max9611: Fix too short conversion time delay

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-5.5a' of git://git.kernel.org/.../jic23/iio into staging-linus

Guenter Roeck (1):
      staging/octeon: Mark Ethernet driver as BROKEN

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_mpu6050: fix temperature reporting using bad unit

Johan Hovold (5):
      staging: gigaset: fix general protection fault on probe
      staging: gigaset: fix illegal free on probe errors
      staging: gigaset: add endpoint-type sanity check
      staging: rtl8188eu: fix interface sanity check
      staging: rtl8712: fix interface sanity check

Kay Friedrich (1):
      staging/wlan-ng: add CRC32 dependency in Kconfig

Linus Walleij (1):
      staging: fbtft: Do not hardcode SPI CS polarity inversion

Lorenzo Bianconi (3):
      iio: imu: st_lsm6dsx: fix decimation factor estimation
      iio: imu: st_lsm6dsx: track hw FIFO buffering with fifo_mask
      iio: imu: st_lsm6dsx: do not power-off accel if events are enabled

Marcelo Diop-Gonzalez (1):
      staging: vchiq: call unregister_chrdev_region() when driver registration fails

Marcelo Schmitt (2):
      dt-bindings: iio: adc: ad7292: Update SPDX identifier
      dt-bindings: iio: adc: ad7292: fix constraint over channel quantity

Mircea Caprioru (1):
      iio: adc: ad7124: Enable internal reference

YueHaibing (2):
      iio: st_accel: Fix unused variable warning
      staging: hp100: Fix build error without ETHERNET

 .../devicetree/bindings/iio/adc/adi,ad7292.yaml    |  5 ++-
 drivers/iio/accel/st_accel_core.c                  |  8 +++-
 drivers/iio/adc/ad7124.c                           |  7 ++-
 drivers/iio/adc/ad7606.c                           |  2 +-
 drivers/iio/adc/ad7949.c                           | 22 +++++++---
 drivers/iio/adc/intel_mrfld_adc.c                  |  2 +-
 drivers/iio/adc/max1027.c                          |  8 +++-
 drivers/iio/adc/max9611.c                          | 16 ++++---
 drivers/iio/humidity/hdc100x.c                     |  2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 23 +++++-----
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          | 16 +++++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |  6 +--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     | 50 ++++++++++++++--------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       | 34 ++++++++++++---
 drivers/iio/temperature/ltc2983.c                  |  6 ++-
 drivers/staging/exfat/exfat.h                      |  4 +-
 drivers/staging/exfat/exfat_core.c                 | 10 +++--
 drivers/staging/exfat/exfat_super.c                |  4 +-
 drivers/staging/fbtft/fb_uc1611.c                  | 12 ++++--
 drivers/staging/fbtft/fb_watterott.c               | 13 ++++--
 drivers/staging/fbtft/fbtft-core.c                 |  6 +--
 drivers/staging/hp/Kconfig                         |  1 +
 drivers/staging/isdn/gigaset/usb-gigaset.c         | 23 +++++++---
 drivers/staging/octeon/Kconfig                     |  1 +
 drivers/staging/rtl8188eu/os_dep/usb_intf.c        |  2 +-
 drivers/staging/rtl8712/usb_intf.c                 |  2 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |  2 +-
 drivers/staging/wlan-ng/Kconfig                    |  1 +
 28 files changed, 198 insertions(+), 90 deletions(-)
