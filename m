Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F511C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86E620898
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574306358;
	bh=5CuMeteoMTQfuON89jjX7S9uHe2uK9dnR5V5Sn9kLeA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=YauMCqbqK27LCY4u2v/Tne4EbFS+TU3oKf7YgFeWfwCRY01MQmqE3CIW5P9gXbtpG
	 eFqK9Wn3QlFa6+0FoyHyvB7FYvm/cK2JcSbnpT2jQ2giUzOo61UZR5qGf8aV9dA/h5
	 5uYiNLgTNF8JSuVYa/srVzdDacvoUvv1mDIlh6Fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKUDTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:19:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:60816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfKUDTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:19:15 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 296F22089D;
        Thu, 21 Nov 2019 03:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306355;
        bh=5CuMeteoMTQfuON89jjX7S9uHe2uK9dnR5V5Sn9kLeA=;
        h=From:To:Cc:Subject:Date:From;
        b=Y60ApEHOfo0BCRaWUCXTxlQ6aFMjv4aMNbUHN5R0Hd95JndyxB2ntvJtLJxCEDS+S
         Ep4WASmKQgVGAVyQAdZbFS6YeaHMu5/u2GaXtuM3xIzXnX5jfRsLxP2oJ0hUhTFq7M
         I+D7FK6BRGwW42WS0n2E7FGWY5Rtczwqr6BDIm1c=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2] cpuidle: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:19:12 +0100
Message-Id: <1574306352-29264-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 drivers/cpuidle/Kconfig     | 16 ++++++++--------
 drivers/cpuidle/Kconfig.arm | 16 ++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 88727b7c0d59..c0aeedd66f02 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -16,7 +16,7 @@ config CPU_IDLE
 if CPU_IDLE
 
 config CPU_IDLE_MULTIPLE_DRIVERS
-        bool
+	bool
 
 config CPU_IDLE_GOV_LADDER
 	bool "Ladder governor (for periodic timer tick)"
@@ -63,13 +63,13 @@ source "drivers/cpuidle/Kconfig.powerpc"
 endmenu
 
 config HALTPOLL_CPUIDLE
-       tristate "Halt poll cpuidle driver"
-       depends on X86 && KVM_GUEST
-       default y
-       help
-         This option enables halt poll cpuidle driver, which allows to poll
-         before halting in the guest (more efficient than polling in the
-         host via halt_poll_ns for some scenarios).
+	tristate "Halt poll cpuidle driver"
+	depends on X86 && KVM_GUEST
+	default y
+	help
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
2.7.4

