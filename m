Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83432C31E49
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 03:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55AB42147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 03:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560741081;
	bh=oclaxGHsPXHpPlyCLAX4cyEJYIL9z7zWp6co+UbOkT8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iCLuaUSWgiAOaQCtJtZKxR7w7LmeflHk9fiUyfD0KmMcCa4E9SR/8KWEH+RaMsgaS
	 bweIrJWyLc2LzobwLI+k9hhgCMziio7qnZ2sA/ZT/6EOrKuxRrcbg2nslZys4A5XRX
	 /RhJkWto+YZsGebuTzx+eI2ZMw7+B3+nnkpTHtvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfFQDLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 23:11:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbfFQDLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 23:11:19 -0400
Received: from localhost.localdomain (user-0ccsrjt.cable.mindspring.com [24.206.110.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDD6D2147A;
        Mon, 17 Jun 2019 03:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560741078;
        bh=oclaxGHsPXHpPlyCLAX4cyEJYIL9z7zWp6co+UbOkT8=;
        h=From:To:Cc:Subject:Date:From;
        b=s16WMEiciHYCTT9kivoRCFyGXMt6p82dMWh/HabxbLF9bsRmiPzapTabOVRORI6Xz
         9ITGVR0xcK+nB4rQ8e+2MM67TN9XtV5uhCydL7wq2xRNjOkDjjCuDC1WjRcBDtFLMc
         4KLb8NQwGLxds34ehRZb1bR2qi3by0Tfa9fgcTeI=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Moritz Fischer <mdf@kernel.org>
Cc:     Alan Tull <atull@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Richard Gong <richard.gong@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH] MAINTAINERS: fpga: hand off maintainership to Moritz
Date:   Sun, 16 Jun 2019 22:11:13 -0500
Message-Id: <20190617031113.4506-1-atull@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm moving on to a new position and stepping down as FPGA subsystem
maintainer.  Moritz has graciously agreed to take over the
maintainership.

Signed-off-by: Alan Tull <atull@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 80e2bfa049d7..448730982545 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6266,7 +6266,6 @@ F:	include/linux/ipmi-fru.h
 K:	fmc_d.*register
 
 FPGA MANAGER FRAMEWORK
-M:	Alan Tull <atull@kernel.org>
 M:	Moritz Fischer <mdf@kernel.org>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
-- 
2.21.0

