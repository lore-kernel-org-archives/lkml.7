Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67179C28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4D52620C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559267255;
	bh=+OeEewhapcQ/i3CLN4Cm0OE27Ar7683dWewuTciehp0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=d70WVH/ngGvHFh3VOGDr37DDCYT36q7gEhmWB334oU9J99WP/Azd6VwLvnziZDEcS
	 mJ24L9Dfyty2ekLf9ZGdY3HordareV/eFY0yw8/gE3FfM8xOyVc7I8JczhtspTJsXh
	 J4r+h26X3NN6t5ukP3u0UHuAQ21F/qzbFsBdifwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfEaBre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 21:47:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfEaBrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 21:47:33 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B97002572F;
        Fri, 31 May 2019 01:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559267252;
        bh=+OeEewhapcQ/i3CLN4Cm0OE27Ar7683dWewuTciehp0=;
        h=Date:From:To:Cc:Subject:From;
        b=dO3JNUuP0GLdhhptxJJVh/Yf38FXkLmRItkZ2xE0xGm1IF7gwD/GY4mRKG0KFcs4V
         cVOmlafd7ldyJ5RI6DS8AXWIDQchh+gZYW55bGmJ+yy4hHRfnyV0K2rezEhCmTas5O
         A7b0NxI781PVVn8+8tuO3/wRtkl6zd9iIPgS99MI=
Date:   Thu, 30 May 2019 18:47:32 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging/IIO driver fixes for 5.2-rc3
Message-ID: <20190531014732.GA30765@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.2-rc3

for you to fetch changes up to e61ff0fba72d981449c90b5299cebb74534b6f7c:

  staging: kpc2000: Add dependency on MFD_CORE to kconfig symbol 'KPC2000' (2019-05-24 09:41:09 +0200)

----------------------------------------------------------------
Staging/IIO driver fixes for 5.2-rc3

Here are some Staging and IIO driver fixes to resolve some reported
problems for 5.2-rc3.

Nothing major here, just some tiny changes, full details are in the
shortlog.

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Chengguang Xu (1):
      staging: erofs: set sb->s_root to NULL when failing from __getname()

Dan Carpenter (4):
      staging: kpc2000: double unlock in error handling in kpc_dma_transfer()
      Staging: vc04_services: Fix a couple error codes
      staging: vc04_services: prevent integer overflow in create_pagelist()
      staging: wilc1000: Fix some double unlock bugs in wilc_wlan_cleanup()

Geordan Neukum (1):
      staging: kpc2000: Add dependency on MFD_CORE to kconfig symbol 'KPC2000'

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-5.2a' of git://git.kernel.org/.../jic23/iio into staging-linus:

Max Filippov (1):
      staging: kpc2000: fix build error on xtensa

Ruslan Babayev (1):
      iio: dac: ds4422/ds4424 fix chip verification

Sean Nyekjaer (1):
      iio: adc: ti-ads8688: fix timestamp is not updated in buffer

Steve Moskovchenko (1):
      iio: imu: mpu6050: Fix FIFO layout for ICM20602

Tim Collier (1):
      staging: wlan-ng: fix adapter initialization failure

Tomer Maimon (1):
      iio: adc: modify NPCM ADC read reference voltage

Vincent Stehlé (1):
      iio: adc: ads124: avoid buffer overflow

YueHaibing (1):
      staging: kpc2000: Fix build error without CONFIG_UIO

 drivers/iio/adc/npcm_adc.c                         |  2 +-
 drivers/iio/adc/ti-ads124s08.c                     |  2 +-
 drivers/iio/adc/ti-ads8688.c                       |  2 +-
 drivers/iio/dac/ds4424.c                           |  2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 46 ++++++++++++++++++++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          | 20 +++++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |  3 ++
 drivers/staging/erofs/super.c                      |  1 +
 drivers/staging/kpc2000/Kconfig                    |  2 +
 drivers/staging/kpc2000/kpc_dma/fileops.c          |  4 +-
 .../vc04_services/bcm2835-camera/controls.c        |  4 +-
 .../interface/vchiq_arm/vchiq_2835_arm.c           |  9 +++++
 drivers/staging/wilc1000/wilc_wlan.c               |  8 +++-
 drivers/staging/wlan-ng/hfa384x_usb.c              |  3 +-
 14 files changed, 91 insertions(+), 17 deletions(-)
