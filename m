Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18148C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23D0208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561104668;
	bh=+jBq7H953ib5nQuYrIc7CFnlGp5JodSLhuZNmZmVCaw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ps7EdNclC4W8aaD0cU9uBnIiSfYroKmWBKvczZXznJ3AXrDlkBBjnyRQJVhynkT3/
	 s5wj6TGf8oBr545tyF3rR88Ok/04RapE/Ok1IZHNVe/S3DrRWRdmfiJPhsPF1YJGZ2
	 5gmZDuaolSLkpn7sRWQZkpr8U5YzT/UM3Pm1OfrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfFUILG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 04:11:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfFUILG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 04:11:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5439208C3;
        Fri, 21 Jun 2019 08:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561104665;
        bh=+jBq7H953ib5nQuYrIc7CFnlGp5JodSLhuZNmZmVCaw=;
        h=Date:From:To:Cc:Subject:From;
        b=cXMBn6Z6qxBu8wz9H9EdczUJ5W5WOhC9mKUTsnSfuLaKySCs6e6yfPoru6t2FhW9e
         zNZdadMcZsjURCy4eP37QpJLAz2cBYzCSRlJEZQYOC1hT7sWnOvNRiHFDPrNPWijLU
         I4UTL7ZJELU5LGVS/crGzls5qP6cTsel9/uZKoPc=
Date:   Fri, 21 Jun 2019 10:11:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging/IIO driver fixes for 5.2-rc6
Message-ID: <20190621081102.GA28012@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

  Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.2-rc6

for you to fetch changes up to 9b9410766f5422d1e736783dc0c3a053eefedac4:

  Merge branch 'erofs_fix' into staging-linus (2019-06-17 22:59:28 +0200)

----------------------------------------------------------------
Staging/IIO/Counter fixes for 5.2-rc6

Here are some small driver bugfixes for some staging/iio/counter
drivers.

Staging and IIO have been lumped together for a while, as those
subsystems cross the areas a log, and counter is used by IIO, so that's
why they are all in one pull request here.

These are small fixes for reported issues in some iio drivers, the erofs
filesystem, and a build issue for counter code.

All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Crt Mori (1):
      iio: temperature: mlx90632 Relax the compatibility check

Fabio Estevam (1):
      staging: iio: adt7316: Fix build errors when GPIOLIB is not set

Gao Xiang (1):
      staging: erofs: add requirements field in superblock

Greg Kroah-Hartman (2):
      Merge tag 'iio-fixes-for-5.2b' of git://git.kernel.org/.../jic23/iio into staging-linus
      Merge branch 'erofs_fix' into staging-linus

Lorenzo Bianconi (1):
      iio: imu: st_lsm6dsx: fix PM support for st_lsm6dsx i2c controller

Melissa Wen (1):
      staging:iio:ad7150: fix threshold mode config bit

Patrick Havelange (1):
      counter/ftm-quaddec: Add missing dependencies in Kconfig

 drivers/counter/Kconfig                      |  1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 25 +++++++++++++++++--------
 drivers/iio/temperature/mlx90632.c           |  9 +++++++--
 drivers/staging/erofs/erofs_fs.h             | 13 ++++++++++---
 drivers/staging/erofs/internal.h             |  2 ++
 drivers/staging/erofs/super.c                | 19 +++++++++++++++++++
 drivers/staging/iio/addac/adt7316.c          |  3 ++-
 drivers/staging/iio/cdc/ad7150.c             | 19 +++++++++++--------
 9 files changed, 71 insertions(+), 22 deletions(-)
