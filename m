Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B6AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895592070D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbfDBTia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:38:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfDBTia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:38:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 56082F74C0;
        Tue,  2 Apr 2019 19:38:29 +0000 (UTC)
Received: from llong.com (dhcp-17-19.bos.redhat.com [10.18.17.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E92B57D147;
        Tue,  2 Apr 2019 19:38:25 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>
Subject: [PATCH] psi: Clarify the units used in pressure files
Date:   Tue,  2 Apr 2019 15:38:10 -0400
Message-Id: <20190402193810.3450-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 02 Apr 2019 19:38:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The output of the PSI files show a bunch of numbers with no unit.
The psi.txt documentation file also does not indicate what units
are used.  One can only find out by looking at the source code. The
units are percentage for the averages and useconds for the total.
Make the information easier to find by documenting the units in psi.txt.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/accounting/psi.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/accounting/psi.txt b/Documentation/accounting/psi.txt
index b8ca28b60215..7e71c9c1d8e9 100644
--- a/Documentation/accounting/psi.txt
+++ b/Documentation/accounting/psi.txt
@@ -56,12 +56,12 @@ situation from a state where some tasks are stalled but the CPU is
 still doing productive work. As such, time spent in this subset of the
 stall state is tracked separately and exported in the "full" averages.
 
-The ratios are tracked as recent trends over ten, sixty, and three
-hundred second windows, which gives insight into short term events as
-well as medium and long term trends. The total absolute stall time is
-tracked and exported as well, to allow detection of latency spikes
-which wouldn't necessarily make a dent in the time averages, or to
-average trends over custom time frames.
+The ratios (in %) are tracked as recent trends over ten, sixty, and
+three hundred second windows, which gives insight into short term events
+as well as medium and long term trends. The total absolute stall time
+(in us) is tracked and exported as well, to allow detection of latency
+spikes which wouldn't necessarily make a dent in the time averages,
+or to average trends over custom time frames.
 
 Cgroup2 interface
 =================
-- 
2.18.1

