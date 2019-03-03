Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B20C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFED2070B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="Hhf5h7D1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfCCQzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 11:55:47 -0500
Received: from tomli.me ([153.92.126.73]:42626 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfCCQzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 11:55:47 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 8d4c55df;
        Sun, 3 Mar 2019 16:55:44 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:3d30:3659)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sun, 03 Mar 2019 16:55:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding; s=1490979754; bh=j2aS/gpg/PjviS0avQsDBOalno7p16vI2oEd/UZfID0=; b=Hhf5h7D1fO4HQukLKscMX6kjhgD0oNo9m6Q7HBSIfJdz9Pj//c7CHIB7M6qNd18oMz7okwY7S6oQwyKlejD5V+lBQn6pdpKSKMVE2VO6BZBGK0Nb6pEiGjBYQhARYLqHNLNmbcLalL/BVy6bTDXtQO7t0S1uW6sdZ4erE+Qo+DUeaIq7ykIJTsZ4DeiA7/zV6SMllLLBmxuXuTWHlViMNRqPSw1Dn0asZoG1noTUtmOtg+eY/CySq11oRYgmwx2rzot43yzscl74d1ddQNy2dni3KPX1sUgvURkN9hnMs1yCd4I93SuiNObgcc1QN+j6VLUCuSub6rwAZUotfp5DyQ==
From:   Yifeng Li <tomli@tomli.me>
To:     Jiri Kosina <trivial@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org
Cc:     Yifeng Li <tomli@tomli.me>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel@vger.kernel.org
Subject: [RESEND][PATCH 0/2] staging: sm750fb: trivial style fixes.
Date:   Mon,  4 Mar 2019 00:55:30 +0800
Message-Id: <20190303165532.23727-1-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

From January to February, there have been two trivial sm750fb patches
submitted to linux-fbdev, one by me, one by Jin Chen, but both without
any response. Further, it seems both maintainers, Sudip Mukherjee and
Teddy Wang, are currently unavailable, getting an "Ack-by" would be
unfeasible.

Since they're extremely trivial. Hereby, I picked them up, reworded
commit message, and now resubmit them as trivial patches, and send them
to trivial@kernel.org. I hope it could be directly applied by either a
fbdev, a staging maintainer or by Jiri Kosina.

Thanks for your time!

Yifeng Li (2):
  staging: sm750fb: trivial comment indention fix.
  staging: sm750fb: trivial Camel Case removal for setDisplayControl().

 drivers/staging/sm750fb/ddk750_display.c |  6 ++---
 drivers/staging/sm750fb/sm750_accel.c    | 32 ++++++++++++------------
 2 files changed, 19 insertions(+), 19 deletions(-)

-- 
2.20.1

