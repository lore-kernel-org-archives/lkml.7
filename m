Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A42C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5CD20693
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfCYGL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:11:59 -0400
Received: from asrmicro.com ([210.13.118.86]:20257 "EHLO spam.asrmicro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729400AbfCYGL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:11:58 -0400
Received: from mail2012.asrmicro.com (mail2012.asrmicro.com [10.1.24.123])
        by spam.asrmicro.com with ESMTP id x2P64omN089656;
        Mon, 25 Mar 2019 14:04:50 +0800 (GMT-8)
        (envelope-from qiaozhou@asrmicro.com)
Received: from localhost (10.1.170.171) by mail2012.asrmicro.com (10.1.24.123)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 25 Mar 2019 14:06:32
 +0800
From:   qiaozhou <qiaozhou@asrmicro.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Qiao Zhou <qiaozhou@asrmicro.com>
Subject: [PATCH] arm64: add support for ASR AquilaC SoC
Date:   Mon, 25 Mar 2019 14:06:31 +0800
Message-ID: <1553493991-9266-1-git-send-email-qiaozhou@asrmicro.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.170.171]
X-ClientProxiedBy: mail2012.asrmicro.com (10.1.24.123) To
 mail2012.asrmicro.com (10.1.24.123)
X-DNSRBL: 
X-MAIL: spam.asrmicro.com x2P64omN089656
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiao Zhou <qiaozhou@asrmicro.com>

Add ARCH_ASR

Signed-off-by: qiaozhou <qiaozhou@asrmicro.com>
---
 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 70498a0..da8d43a 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -278,4 +278,10 @@ config ARCH_ZYNQMP
 	help
 	  This enables support for Xilinx ZynqMP Family
 
+config ARCH_ASR
+	bool "ASR Microelectronics chip Family"
+	select PINCTRL
+	help
+	  This enables support for ASR Microelectronics chip Family, including:
+	  - ASR 8751C SoC
 endmenu
-- 
2.7.4

