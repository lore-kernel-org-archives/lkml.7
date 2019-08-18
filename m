Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80415C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 08:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D9F2183E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 08:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566118637;
	bh=ZV/DUtof7HJNFG9uunWbxc0XTtWOTUrKrzBU1NZiZzg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=TErj8MTCJtz8G3Sok01DQPSQGQ2kEGgjO7BJp1j5/Z0AwzGyc4PwmC0Xl5Uv89rio
	 jMYVRI2zquXltgsjrhKYi5k93rUttVOL1LQK3KGuFt9FKSfZZNb2W6yxe+cyhzXozv
	 JW7wEG6/E0RbuuogKLQ7Fz02M4PkoT2zoT7pdIgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfHRI5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 04:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfHRI5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 04:57:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 685952086C;
        Sun, 18 Aug 2019 08:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566118634;
        bh=ZV/DUtof7HJNFG9uunWbxc0XTtWOTUrKrzBU1NZiZzg=;
        h=Date:From:To:Cc:Subject:From;
        b=lMjrzCVYjl64VFd71cC+RT7QQ38qVz3nKbfD4WNiaStDzS4pcLtdhcPxeSkxK+6K4
         sWMXlGFFXtgRj+Z1O26LZ95RKq0W1DGie+JQ2In8NWcVK6c5LhkADQKWwD2Yb4kcP0
         aN19NaVE0JzwBqZV6D+pE1rq7w4f+z65TAF1yKwg=
Date:   Sun, 18 Aug 2019 10:57:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging/IIO driver fixes for 5.3-rc5
Message-ID: <20190818085712.GA28706@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d45331b00ddb179e291766617259261c112db872:

  Linux 5.3-rc4 (2019-08-11 13:26:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.3-rc5

for you to fetch changes up to 48b30e10bfc20ec6195642cc09ea6f08a8015df7:

  Merge tag 'iio-fixes-for-5.3b' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2019-08-12 22:47:59 +0200)

----------------------------------------------------------------
Staging/IIO fixes for 5.3-rc5

Here are 4 small staging and iio driver fixes for 5.3-rc5

Two are for the dt3000 comedi driver for some reported problems found in
that codebase, and two are some small iio fixes.

All of these have been in linux-next this week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-5.3b' of git://git.kernel.org/.../jic23/iio into staging-linus

Ian Abbott (2):
      staging: comedi: dt3000: Fix signed integer overflow 'divider * base'
      staging: comedi: dt3000: Fix rounding up of timer divisor

Jacopo Mondi (1):
      iio: adc: max9611: Fix temperature reading in probe

Nuno Sá (1):
      iio: frequency: adf4371: Fix output frequency setting

 drivers/iio/adc/max9611.c               | 2 +-
 drivers/iio/frequency/adf4371.c         | 8 ++++----
 drivers/staging/comedi/drivers/dt3000.c | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)
