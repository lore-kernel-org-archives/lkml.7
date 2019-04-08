Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA99C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E23720833
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554749074;
	bh=OBy9tDdSJkxlr2JmzJK6jnfYwVC6BzXPirDOUycqN5k=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ejg4sORn6nFqwm3Xy5zqPtDZWmBED7qTmQDzirN3OwG8nq23oNXu57FBHRtqXdpnK
	 2dgDoL9hY46hOadS1d15KaiuiRlothgwSrwT5ppZSsfjVPmzi4WhBAnGG8s8kaFIux
	 Me8vcrw8l+4y8o86eufiUgOn8Gfceo9LFRI1rFMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfDHSoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:44:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbfDHSoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:44:32 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8405120833;
        Mon,  8 Apr 2019 18:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554749071;
        bh=OBy9tDdSJkxlr2JmzJK6jnfYwVC6BzXPirDOUycqN5k=;
        h=From:To:Cc:Subject:Date:From;
        b=blOO++oPrypgEBBDCnhLJgJ0QKex+JOV5aP+X81H8nefW8oBm2KxNwnIFbC9MON9B
         MwDxQ5P2geGPOw8q6cctCSd6T3H0EBACqI1XF2ia3Zo0FoOPU1k58YArxThkDR8jTb
         4BKcRdumScYTBVdroQGz3NjLshLB3+KAZqiQlf1Y=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] MAINTAINERS: Add arm64/intel entry for SoCFPGA
Date:   Mon,  8 Apr 2019 13:44:22 -0500
Message-Id: <20190408184422.27545-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add arch/arm64/boot/dts/intel/ under Dinh Nguyen.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf70b548..8c90df31aaf0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2189,6 +2189,7 @@ F:	arch/arm/mach-socfpga/
 F:	arch/arm/boot/dts/socfpga*
 F:	arch/arm/configs/socfpga_defconfig
 F:	arch/arm64/boot/dts/altera/
+F:	arch/arm64/boot/dts/intel/
 W:	http://www.rocketboards.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git
 
-- 
2.20.0

