Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EFAFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE712168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404828AbfJPLDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:03:53 -0400
Received: from foss.arm.com ([217.140.110.172]:36554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfJPLDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:03:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD4621570;
        Wed, 16 Oct 2019 04:03:51 -0700 (PDT)
Received: from usa.arm.com (unknown [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C89623F6C4;
        Wed, 16 Oct 2019 04:03:50 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] cpufreq: scpi: remove stale/outdated comment about the driver
Date:   Wed, 16 Oct 2019 12:03:42 +0100
Message-Id: <20191016110344.15259-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016110344.15259-1-sudeep.holla@arm.com>
References: <20191016110344.15259-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
removed the arm_big_little dependency from scpi driver and doesn't
provide any ops to arm_big_little cpufreq driver. Lets remove that
stale comment.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/scpi-cpufreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 2b51e0718c9f..20d1f85d5f5a 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -1,8 +1,6 @@
 /*
  * System Control and Power Interface (SCPI) based CPUFreq Interface driver
  *
- * It provides necessary ops to arm_big_little cpufreq driver.
- *
  * Copyright (C) 2015 ARM Ltd.
  * Sudeep Holla <sudeep.holla@arm.com>
  *
-- 
2.17.1

