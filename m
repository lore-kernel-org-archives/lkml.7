Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721DFC742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4442421019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562917228;
	bh=JfISlesYnneEbksddxA00wvDcARDgF8mXqRpu3rPcv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L7fG+5YLClWnNZEvgRfGO+Fw6QovVaTL57ZaghS7YkNhuJ7IFg1WnwDNN6zb19lJr
	 BHR/gPGf0PCq2ENSwgXj3uPCcPsEfOMLYG4IcShN9unIk1P39bSTxZDCDdTybkr89i
	 mJMm+yhqJesGL8mzyKnXqeua1amUIXlhDoR0iVlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfGLHk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 03:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfGLHk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 03:40:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8283208E4;
        Fri, 12 Jul 2019 07:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562917225;
        bh=JfISlesYnneEbksddxA00wvDcARDgF8mXqRpu3rPcv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L9Itb9Idc1GIgvxxai9h/D6rck3J4AW5tcvQG2N2ADhoz0hOYehlKeubrYHdZXC8+
         PztL9J3ix1sXAIAINL0mDst0v2/hmOXQauPcxfGBskjbEpSHI8MB3ZD7jzDR6vDAcw
         ONPBxqfxrW0XnuHPZgN57bGP0G+E7OwD+t5pR1hA=
Date:   Fri, 12 Jul 2019 09:40:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] Driver core patches for 5.3-rc1
Message-ID: <20190712074023.GD16253@kroah.com>
References: <20190712073623.GA16253@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <20190712073623.GA16253@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 12, 2019 at 09:36:23AM +0200, Greg KH wrote:
> The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:
> 
>   Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.3-rc1
> 
> for you to fetch changes up to c33d442328f556460b79aba6058adb37bb555389:
> 
>   debugfs: make error message a bit more verbose (2019-07-08 10:44:57 +0200)
> 
> ----------------------------------------------------------------
> Driver Core and debugfs changes for 5.3-rc1
> 
> Here is the "big" driver core and debugfs changes for 5.3-rc1
> 
> It's a lot of different patches, all across the tree due to some api
> changes and lots of debugfs cleanups.  Because of this, there is going
> to be some merge issues with your tree at the moment, I'll follow up
> with the expected resolutions to make it easier for you.
> 
> Other than the debugfs cleanups, in this set of changes we have:
> 	- bus iteration function cleanups (will cause build warnings
> 	  with s390 and coresight drivers in your tree)

And here is the patch that should resolve the coresight build issue.


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="coresight.patch"

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Mon, 1 Jul 2019 11:28:08 -0700
Subject: [PATCH] coresight: Make the coresight_device_fwnode_match declaration's fwnode parameter const

drivers/hwtracing/coresight/coresight.c:1051:11: error: incompatible pointer types passing 'int (struct device *, void *)' to parameter of type 'int (*)(struct device *, const void *)' [-Werror,-Wincompatible-pointer-types]
                                      coresight_device_fwnode_match);
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/device.h:173:17: note: passing argument to parameter 'match' here
                               int (*match)(struct device *dev, const void *data));
                                     ^
1 error generated.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/hwtracing/coresight/coresight-priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 8b07fe55395a..7d401790dd7e 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -202,6 +202,6 @@ static inline void *coresight_get_uci_data(const struct amba_id *id)
 
 void coresight_release_platform_data(struct coresight_platform_data *pdata);
 
-int coresight_device_fwnode_match(struct device *dev, void *fwnode);
+int coresight_device_fwnode_match(struct device *dev, const void *fwnode);
 
 #endif
-- 
2.22.0

-- 
Cheers,
Stephen Rothwell

--IrhDeMKUP4DT/M7F--
