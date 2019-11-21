Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593BAC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2579420721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574306365;
	bh=HEUpb8bNwc8SarAfdtsw12BjG6dRX4eNspNtneMvqTQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1ldskSojqoXnnjOQqX1eVSNO431RqhwsFaIGjgj1IJn3eG4pHUbZ8AtEM8Et9LmmY
	 5/YlQwVDph6+BlfpCIXn5fK56kcIKCmjaik9+Uzz/VffTC0BurYX7QNVtlh9BbcfYI
	 2nWsc5Iq1M/RfIBNhgKnBXbtqo0qrdxSGnPGG/o8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfKUDTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:19:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:60890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfKUDTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:19:19 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2DF520721;
        Thu, 21 Nov 2019 03:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306358;
        bh=HEUpb8bNwc8SarAfdtsw12BjG6dRX4eNspNtneMvqTQ=;
        h=From:To:Cc:Subject:Date:From;
        b=UVa/7Q5rZROQia7OQ2qGtMmzIqt/reLDb7O4T6Y9egPwaYhpIYwO3MnREteXgE4ms
         wdeZln250gAydvCr91UpTgl9Cdlcz0lFKU3CGw8IW10rZTCCiZVJ3rOlVY2dAscNy3
         NqGFkDTuEQcaZXM4oyvc3bo67yB42BkFoHkFEiYo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2] cpufreq: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:19:15 +0100
Message-Id: <1574306355-29316-1-git-send-email-krzk@kernel.org>
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
 drivers/cpufreq/Kconfig.powerpc |  8 ++++----
 drivers/cpufreq/Kconfig.x86     | 16 ++++++++--------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.powerpc b/drivers/cpufreq/Kconfig.powerpc
index 35b4f700f054..58151ca56695 100644
--- a/drivers/cpufreq/Kconfig.powerpc
+++ b/drivers/cpufreq/Kconfig.powerpc
@@ -48,9 +48,9 @@ config PPC_PASEMI_CPUFREQ
 	  PWRficient processors.
 
 config POWERNV_CPUFREQ
-       tristate "CPU frequency scaling for IBM POWERNV platform"
-       depends on PPC_POWERNV
-       default y
-       help
+	tristate "CPU frequency scaling for IBM POWERNV platform"
+	depends on PPC_POWERNV
+	default y
+	help
 	 This adds support for CPU frequency switching on IBM POWERNV
 	 platform
diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index dfa6457deaf6..a6528388952e 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -4,17 +4,17 @@
 #
 
 config X86_INTEL_PSTATE
-       bool "Intel P state control"
-       depends on X86
-       select ACPI_PROCESSOR if ACPI
-       select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_MC_PRIO
-       help
-          This driver provides a P state for Intel core processors.
+	bool "Intel P state control"
+	depends on X86
+	select ACPI_PROCESSOR if ACPI
+	select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_MC_PRIO
+	help
+	  This driver provides a P state for Intel core processors.
 	  The driver implements an internal governor and will become
-          the scaling driver and governor for Sandy bridge processors.
+	  the scaling driver and governor for Sandy bridge processors.
 
 	  When this driver is enabled it will become the preferred
-          scaling driver for Sandy bridge processors.
+	  scaling driver for Sandy bridge processors.
 
 	  If in doubt, say N.
 
-- 
2.7.4

