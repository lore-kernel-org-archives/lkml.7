Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3315C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 11:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E4320880
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 11:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565437975;
	bh=ELQN+mT/SvWtPwffTxC5jZQThBIxCndcXEesU6BJNso=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=TrVP5Rf522GTPmXmUgiB+oTv/szv0Pqjnr8GizMhWurcrsd8FnT+AEx66IuwxWwax
	 PNDjhew3rFShlF9e8r/F2xa0BVSW4PynY9M0KVt8bLe+0xaFDerKka1Rs05fDY0ovg
	 i02WymakdpgZmWkqXx4gHD4qu+nhrShNrXGpRR54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfHJLw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 07:52:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbfHJLwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 07:52:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E001220880;
        Sat, 10 Aug 2019 11:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565437944;
        bh=ELQN+mT/SvWtPwffTxC5jZQThBIxCndcXEesU6BJNso=;
        h=Date:From:To:Cc:Subject:From;
        b=SQUhg8N8q5shtxRmfHTPB9NcQxRKGo3G3Cbl9wZIWcYgegpCnI5yU9joQeg6bPABo
         7E7Ab4uws1YUAprDEZyT1Y9rKj07aOVLpnfXS6rNzb2felOvfN8TLcRcaDbr7iXM6v
         VfFsEc5C7+Yzrfjl0szdh1g3gWG/24YntsprHpyg=
Date:   Sat, 10 Aug 2019 13:52:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging/IIO driver fixes for 5.3-rc4
Message-ID: <20190810115222.GA5874@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.3-rc4

for you to fetch changes up to 09f6109ff4f8003af3370dfee0f73fcf6d20087a:

  Merge tag 'iio-fixes-for-5.3a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2019-07-28 11:07:26 +0200)

----------------------------------------------------------------
Staging / IIO driver fixes for 5.3-rc4

Here are some small staging and IIO driver fixes for 5.3-rc4.

Nothing major, just resolutions for a number of small reported issues,
full details in the shortlog.

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Adham Abozaeid (1):
      staging: wilc1000: flush the workqueue before deinit the host

Arnd Bergmann (1):
      iio: adc: gyroadc: fix uninitialized return code

Christophe JAILLET (1):
      staging: unisys: visornic: Update the description of 'poll_for_irq()'

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-5.3a' of git://git.kernel.org/.../jic23/iio into staging-linus

Gwendal Grignou (1):
      iio: cros_ec_accel_legacy: Fix incorrect channel setting

Ivan Bornyakov (1):
      staging: gasket: apex: fix copy-paste typo

Jan Sebastian Götte (1):
      Staging: fbtft: Fix GPIO handling

Jean-Baptiste Maneyrol (1):
      iio: imu: mpu6050: add missing available scan masks

Joe Perches (1):
      iio: adc: max9611: Fix misuse of GENMASK macro

Maarten ter Huurne (1):
      IIO: Ingenic JZ47xx: Set clock divider on probe

Mauro Carvalho Chehab (1):
      docs: generic-counter.rst: fix broken references for ABI file

Phil Reid (2):
      Staging: fbtft: Fix probing of gpio descriptor
      Staging: fbtft: Fix reset assertion when using gpio descriptor

Tetsuo Handa (1):
      staging: android: ion: Bail out upon SIGKILL when allocating memory.

 Documentation/driver-api/generic-counter.rst      |  4 +-
 drivers/iio/accel/cros_ec_accel_legacy.c          |  1 -
 drivers/iio/adc/ingenic-adc.c                     | 54 +++++++++++++++++++++++
 drivers/iio/adc/max9611.c                         |  2 +-
 drivers/iio/adc/rcar-gyroadc.c                    |  4 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c        | 43 ++++++++++++++++++
 drivers/staging/android/ion/ion_page_pool.c       |  3 ++
 drivers/staging/fbtft/fb_bd663474.c               |  2 +-
 drivers/staging/fbtft/fb_ili9163.c                |  2 +-
 drivers/staging/fbtft/fb_ili9325.c                |  2 +-
 drivers/staging/fbtft/fb_s6d1121.c                |  2 +-
 drivers/staging/fbtft/fb_ssd1289.c                |  2 +-
 drivers/staging/fbtft/fb_ssd1331.c                |  4 +-
 drivers/staging/fbtft/fb_upd161704.c              |  2 +-
 drivers/staging/fbtft/fbtft-bus.c                 |  2 +-
 drivers/staging/fbtft/fbtft-core.c                | 47 +++++++++-----------
 drivers/staging/gasket/apex_driver.c              |  2 +-
 drivers/staging/unisys/visornic/visornic_main.c   |  3 +-
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c |  1 +
 19 files changed, 140 insertions(+), 42 deletions(-)
