Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85222C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F9A22506
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257359;
	bh=zx31EvXJSrPvIZNUnpzsdNJ1bY9onSBR7VNrN6mC6WI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FtrAuy0Dt/6zvm3+sqtiWFWIwx4M6cM+uuHCMTM9kELyw7Asp3afdyKOhs7BzIK0m
	 S7ZOfvN3Eb7nlZtZCZZyM+/IeO5T9F/+B78GoU6sLBl6de+DwpPFL7ZDTojXAWyezI
	 xjCJkx+ZWZSKlUA30nUCniazLsnFKcmkxQxCbEtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbfKTNmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:42:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:50442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbfKTNmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:42:36 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF08F22528;
        Wed, 20 Nov 2019 13:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257356;
        bh=zx31EvXJSrPvIZNUnpzsdNJ1bY9onSBR7VNrN6mC6WI=;
        h=From:To:Cc:Subject:Date:From;
        b=TrnrKIHzgXXYdi+5nPmPs/ScaG6071kY6vHoapRWHJenm8mMr6uFZl+WiI/e7M2sf
         oBm5Y+Emp3PCODq4Fe16WC3HXlY2y1b4ixtHQEDAcK0G3hB/t7LFEc5UsFIu+OIW30
         sAV5qaGA6NzMbkpYki2U/fjMkGC2vthPzTMxK8Co=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:42:32 +0800
Message-Id: <20191120134232.15900-1-krzk@kernel.org>
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
 drivers/cpufreq/Kconfig.x86 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index dfa6457deaf6..6eec6ccb14cb 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -9,12 +9,12 @@ config X86_INTEL_PSTATE
        select ACPI_PROCESSOR if ACPI
        select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_MC_PRIO
        help
-          This driver provides a P state for Intel core processors.
+	  This driver provides a P state for Intel core processors.
 	  The driver implements an internal governor and will become
-          the scaling driver and governor for Sandy bridge processors.
+	  the scaling driver and governor for Sandy bridge processors.
 
 	  When this driver is enabled it will become the preferred
-          scaling driver for Sandy bridge processors.
+	  scaling driver for Sandy bridge processors.
 
 	  If in doubt, say N.
 
-- 
2.17.1

