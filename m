Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A4BC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D1C22506
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257355;
	bh=4mdIlVqSgF5W1fbW6Lu5ti5hA+egq0Vt8toWgDFv8p8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FZivoSXyiMJZZHp9mf+mlgiS6WZF1avd5mTuhkcQ/Gb+4QUKo7eIBHtdRJiwvuZ39
	 cN7Yt59vvZXsZ5GMRA7U3ISgQMdl7jvF6DlkJnt8G42BA3euk1ahK/Ob/DhbRb/qgu
	 snoLRUJPsZe6pdvoq52FAVD/DW+az1LzJLxLCKjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbfKTNmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:42:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:50320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbfKTNmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:42:32 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7986A22506;
        Wed, 20 Nov 2019 13:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257351;
        bh=4mdIlVqSgF5W1fbW6Lu5ti5hA+egq0Vt8toWgDFv8p8=;
        h=From:To:Cc:Subject:Date:From;
        b=znZIqKyzvoikMA6PHYEFYl0pYg+VwaWWg5d+LhBI8E7xMnffdz6iseITwUDgeQoqG
         yiETnrIC/q+8i7yrmiTwdMeh6fQXJW7rDCwqGolywWYIAzOrYuaiA0v/10hoysB4TA
         mu2h6WRl5nbNLtiONAnLUIN2+BBMhlflS/hkfeV8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH] cpuidle: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:42:28 +0800
Message-Id: <20191120134228.15838-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/cpuidle/Kconfig     |  8 ++++----
 drivers/cpuidle/Kconfig.arm | 16 ++++++++--------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 88727b7c0d59..1b8614d1c696 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -16,7 +16,7 @@ config CPU_IDLE
 if CPU_IDLE
 
 config CPU_IDLE_MULTIPLE_DRIVERS
-        bool
+	bool
 
 config CPU_IDLE_GOV_LADDER
 	bool "Ladder governor (for periodic timer tick)"
@@ -67,9 +67,9 @@ config HALTPOLL_CPUIDLE
        depends on X86 && KVM_GUEST
        default y
        help
-         This option enables halt poll cpuidle driver, which allows to poll
-         before halting in the guest (more efficient than polling in the
-         host via halt_poll_ns for some scenarios).
+	 This option enables halt poll cpuidle driver, which allows to poll
+	 before halting in the guest (more efficient than polling in the
+	 host via halt_poll_ns for some scenarios).
 
 endif
 
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index d8530475493c..e91ab792d14d 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -3,15 +3,15 @@
 # ARM CPU Idle drivers
 #
 config ARM_CPUIDLE
-        bool "Generic ARM/ARM64 CPU idle Driver"
-        select DT_IDLE_STATES
+	bool "Generic ARM/ARM64 CPU idle Driver"
+	select DT_IDLE_STATES
 	select CPU_IDLE_MULTIPLE_DRIVERS
-        help
-          Select this to enable generic cpuidle driver for ARM.
-          It provides a generic idle driver whose idle states are configured
-          at run-time through DT nodes. The CPUidle suspend backend is
-          initialized by calling the CPU operations init idle hook
-          provided by architecture code.
+	help
+	  Select this to enable generic cpuidle driver for ARM.
+	  It provides a generic idle driver whose idle states are configured
+	  at run-time through DT nodes. The CPUidle suspend backend is
+	  initialized by calling the CPU operations init idle hook
+	  provided by architecture code.
 
 config ARM_PSCI_CPUIDLE
 	bool "PSCI CPU idle Driver"
-- 
2.17.1

