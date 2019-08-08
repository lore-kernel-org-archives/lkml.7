Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333EDC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D91218BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="j52hRIT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731841AbfHHIA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:00:28 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:43718 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfHHIA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:00:27 -0400
Received: from trochilidae.cardiotech.int (unknown [37.17.234.113])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id D03585C0B09;
        Thu,  8 Aug 2019 10:00:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1565251225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=M05gzHKGxby2hM7h2BsIuIBZoqVNih3A9gBg+LSXumQ=;
        b=j52hRIT/sy02HixwzebBmR5sBqtWF8OHjpgWZkS0W0HNECr6IIEgELaMAX8qjHZZuMGrA2
        enVdhcHJaJRnxCquhr1M6NClqMPDcVLqeEQGmWvP7AM/oirXXPQ14lzFeRqgXYhAFUD0L3
        2Iz9HW9//BwNFaiY8WxbjONVa/a3Jtg=
From:   Stefan Agner <stefan@agner.ch>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     olof@lixom.net, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>,
        Stefan Agner <stefan.agner@toradex.com>
Subject: [PATCH] arm64: defconfig: enable deprecated ARMv8 instructions emulation
Date:   Thu,  8 Aug 2019 10:00:04 +0200
Message-Id: <20190808080004.20984-1-stefan@agner.ch>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable deprecated/obsolete ARMv8 instructions emulation. This allows
to run ARMv6 binaries (e.g. Raspberry Pi) on ARMv8 machines.

Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
---
 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0e58ef02880c..fd5af5582dda 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -68,6 +68,10 @@ CONFIG_KEXEC=y
 CONFIG_CRASH_DUMP=y
 CONFIG_XEN=y
 CONFIG_COMPAT=y
+CONFIG_ARMV8_DEPRECATED=y
+CONFIG_SWP_EMULATION=y
+CONFIG_CP15_BARRIER_EMULATION=y
+CONFIG_SETEND_EMULATION=y
 CONFIG_RANDOMIZE_BASE=y
 CONFIG_HIBERNATION=y
 CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
-- 
2.22.0

