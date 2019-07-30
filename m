Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA22C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F283020578
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455756;
	bh=PSjU/J96qYUTgZJWl8A6gS6FjJ45nEybaQnrKlCX67c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=peF/8FxKE/eOttVo7umx6tm9KBEcwVbUfGhWfadw9l2Yr+DaesvyDMm/RjwF/0aj/
	 /irU2Dl4t+42ltjBl1PRQzEXkOD73o2dOw4NQmg1XzzqUv/TJgYEKvRBaI93CCsE24
	 fRlBBWoHa5vbMA8xkiCc0HbWms7+tKIbmaM4Qltg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbfG3DCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:02:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732810AbfG3DC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:02:28 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D12D0216C8;
        Tue, 30 Jul 2019 03:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455747;
        bh=PSjU/J96qYUTgZJWl8A6gS6FjJ45nEybaQnrKlCX67c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rmdn8grVj1phifwIbh16XgDIzUW3+r80oAhC4eT8EKQOjIOkzi7bveZkBLINxL7oA
         cE1HBygCe2kJjp2azFWkYXid9BwFEPMDKhvr+q2wHixPqItpX6F+n6yxh6sElweC93
         I2N3OdvpPMQHB1B10GSpUecX6qsSAk1hzqzUw47Q=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Michael Petlan <mpetlan@redhat.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Carl Love <cel@us.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Paul Clarke <pc@us.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        linuxppc-dev@ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 107/107] perf vendor events power9: Added missing event descriptions
Date:   Mon, 29 Jul 2019 23:56:10 -0300
Message-Id: <20190730025610.22603-108-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Petlan <mpetlan@redhat.com>

Documentation source:

https://wiki.raptorcs.com/w/images/6/6b/POWER9_PMU_UG_v12_28NOV2018_pub.pdf

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Carl Love <cel@us.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Paul Clarke <pc@us.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
LPU-Reference: 20190719100837.7503-1-mpetlan@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/powerpc/power9/memory.json | 2 +-
 tools/perf/pmu-events/arch/powerpc/power9/other.json  | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/memory.json b/tools/perf/pmu-events/arch/powerpc/power9/memory.json
index 2e2ebc700c74..c3bb283e37e9 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/memory.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/memory.json
@@ -52,7 +52,7 @@
   {,
     "EventCode": "0x4D02C",
     "EventName": "PM_PMC1_REWIND",
-    "BriefDescription": ""
+    "BriefDescription": "PMC1 rewind event"
   },
   {,
     "EventCode": "0x15158",
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/other.json b/tools/perf/pmu-events/arch/powerpc/power9/other.json
index 48cf4f920b3f..62b864269623 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/other.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/other.json
@@ -237,7 +237,7 @@
   {,
     "EventCode": "0xD0B0",
     "EventName": "PM_HWSYNC",
-    "BriefDescription": ""
+    "BriefDescription": "A hwsync instruction was decoded and transferred"
   },
   {,
     "EventCode": "0x168B0",
@@ -1232,7 +1232,7 @@
   {,
     "EventCode": "0xD8AC",
     "EventName": "PM_LWSYNC",
-    "BriefDescription": ""
+    "BriefDescription": "An lwsync instruction was decoded and transferred"
   },
   {,
     "EventCode": "0x2094",
@@ -1747,7 +1747,7 @@
   {,
     "EventCode": "0xD8B0",
     "EventName": "PM_PTESYNC",
-    "BriefDescription": ""
+    "BriefDescription": "A ptesync instruction was counted when the instruction is decoded and transmitted"
   },
   {,
     "EventCode": "0x26086",
@@ -2107,7 +2107,7 @@
   {,
     "EventCode": "0xF080",
     "EventName": "PM_LSU_STCX_FAIL",
-    "BriefDescription": ""
+    "BriefDescription": "The LSU detects the condition that a stcx instruction failed. No requirement to wait for a response from the nest"
   },
   {,
     "EventCode": "0x30038",
-- 
2.21.0

