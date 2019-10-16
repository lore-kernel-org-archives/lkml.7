Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0272FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD39820854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404815AbfJPLDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:03:51 -0400
Received: from foss.arm.com ([217.140.110.172]:36546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfJPLDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:03:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8818428;
        Wed, 16 Oct 2019 04:03:50 -0700 (PDT)
Received: from usa.arm.com (unknown [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 97F8C3F6C4;
        Wed, 16 Oct 2019 04:03:49 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] cpufreq: merge arm_big_little and vexpress-spc
Date:   Wed, 16 Oct 2019 12:03:41 +0100
Message-Id: <20191016110344.15259-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since vexpress-spc is the sole user of arm_big_little cpufreq driver,
there's no point in keeping it separate anymore. I wanted to post these
patches for ages but kept postponing for no reason.

Regards,
Sudeep

Sudeep Holla (3):
  cpufreq: scpi: remove stale/outdated comment about the driver
  cpufreq: merge arm_big_little and vexpress-spc
  cpufreq: simplify and remove lots of debug messages

 MAINTAINERS                            |   5 +-
 drivers/cpufreq/Kconfig.arm            |  12 +-
 drivers/cpufreq/Makefile               |   2 -
 drivers/cpufreq/arm_big_little.c       | 658 -------------------------
 drivers/cpufreq/arm_big_little.h       |  43 --
 drivers/cpufreq/scpi-cpufreq.c         |   2 -
 drivers/cpufreq/vexpress-spc-cpufreq.c | 559 ++++++++++++++++++++-
 7 files changed, 539 insertions(+), 742 deletions(-)
 delete mode 100644 drivers/cpufreq/arm_big_little.c
 delete mode 100644 drivers/cpufreq/arm_big_little.h

--
2.17.1

