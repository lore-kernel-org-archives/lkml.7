Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F8BC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98A52089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbfFGPOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:14:38 -0400
Received: from foss.arm.com ([217.140.110.172]:42450 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728486AbfFGPOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:14:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F439367;
        Fri,  7 Jun 2019 08:14:33 -0700 (PDT)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D5323F718;
        Fri,  7 Jun 2019 08:14:32 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-doc@vger.kernel.org, x86@kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Babu Moger <Babu.Moger@amd.com>, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>
Subject: [PATCH 4/4] Documentation: x86: fix some typos
Date:   Fri,  7 Jun 2019 16:14:09 +0100
Message-Id: <20190607151409.15476-5-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607151409.15476-1-james.morse@arm.com>
References: <20190607151409.15476-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are all obvious typos.

Signed-off-by: James Morse <james.morse@arm.com>
---
 Documentation/x86/resctrl_ui.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/x86/resctrl_ui.rst b/Documentation/x86/resctrl_ui.rst
index 866b66aa289b..5368cedfb530 100644
--- a/Documentation/x86/resctrl_ui.rst
+++ b/Documentation/x86/resctrl_ui.rst
@@ -40,7 +40,7 @@ mount options are:
 	Enable the MBA Software Controller(mba_sc) to specify MBA
 	bandwidth in MBps
 
-L2 and L3 CDP are controlled seperately.
+L2 and L3 CDP are controlled separately.
 
 RDT features are orthogonal. A particular system may support only
 monitoring, only control, or both monitoring and control.  Cache
@@ -118,7 +118,7 @@ related to allocation:
 			      Corresponding region is pseudo-locked. No
 			      sharing allowed.
 
-Memory bandwitdh(MB) subdirectory contains the following files
+Memory bandwidth(MB) subdirectory contains the following files
 with respect to allocation:
 
 "min_bandwidth":
@@ -209,7 +209,7 @@ All groups contain the following files:
 	CPUs to/from this group. As with the tasks file a hierarchy is
 	maintained where MON groups may only include CPUs owned by the
 	parent CTRL_MON group.
-	When the resouce group is in pseudo-locked mode this file will
+	When the resource group is in pseudo-locked mode this file will
 	only be readable, reflecting the CPUs associated with the
 	pseudo-locked region.
 
@@ -380,7 +380,7 @@ where L2 external  is 10GBps (hence aggregate L2 external bandwidth is
 240GBps) and L3 external bandwidth is 100GBps. Now a workload with '20
 threads, having 50% bandwidth, each consuming 5GBps' consumes the max L3
 bandwidth of 100GBps although the percentage value specified is only 50%
-<< 100%. Hence increasing the bandwidth percentage will not yeild any
+<< 100%. Hence increasing the bandwidth percentage will not yield any
 more bandwidth. This is because although the L2 external bandwidth still
 has capacity, the L3 external bandwidth is fully used. Also note that
 this would be dependent on number of cores the benchmark is run on.
@@ -398,7 +398,7 @@ In order to mitigate this and make the interface more user friendly,
 resctrl added support for specifying the bandwidth in MBps as well.  The
 kernel underneath would use a software feedback mechanism or a "Software
 Controller(mba_sc)" which reads the actual bandwidth using MBM counters
-and adjust the memowy bandwidth percentages to ensure::
+and adjust the memory bandwidth percentages to ensure::
 
 	"actual bandwidth < user specified bandwidth".
 
-- 
2.20.1

