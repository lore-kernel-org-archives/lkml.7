Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F99CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512442146E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554211946;
	bh=eAsN7JgCEZc/9MEIjeSKZ448OENaVixy3w1KbFJNKv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NiE7ciIL0k20rzXixrZWp3x5GQ30FHSvMPv6fy3HmpdyRfvrF7clHZbUdTayNx5uC
	 3C7Ku4d0F4rJCX9n0LEzDLWw7sProdREdhdBT+HdGVdtBu30TLftE8YD/z51PKnGnT
	 zyqrJfZFJLtgm0nCTDMlTlk+cVN4YSWaiA4HKGM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731389AbfDBNcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:32:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731377AbfDBNcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:32:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B4E220883;
        Tue,  2 Apr 2019 13:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554211942;
        bh=eAsN7JgCEZc/9MEIjeSKZ448OENaVixy3w1KbFJNKv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zuag9nfpO1vm6xLCkpefmMx1/vf1UT/N501OkdBmockwHDR6jOKYPwrrTdIWzgCDS
         6ni7bDowSWD8I97Sj/RWx5n2StsMknwfUPw2UMX6nyjmaWfd1Ook4e8Njitmn24xdX
         /DgC5D8aJqbUX8lcI6yVJQLU6qwVieBo43UPN8j0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 4/4] drivers: base: test: add proper SPDX identifier to Makefile
Date:   Tue,  2 Apr 2019 15:32:03 +0200
Message-Id: <20190402133203.5463-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402133203.5463-1-gregkh@linuxfoundation.org>
References: <20190402133203.5463-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Makefile in the drivers/base/test/ directory did not have a SPDX
identifier on it, so fix that up.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org
---
 drivers/base/test/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
index 90477c5fd9f9..0f1f7277a013 100644
--- a/drivers/base/test/Makefile
+++ b/drivers/base/test/Makefile
@@ -1 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)	+= test_async_driver_probe.o
-- 
2.21.0

