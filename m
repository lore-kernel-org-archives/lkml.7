Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0FAC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D842464B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbfLLOU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:20:29 -0500
Received: from mx2.freebsd.org ([96.47.72.81]:40148 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729695AbfLLOU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:20:28 -0500
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Dec 2019 09:20:27 EST
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 7C8036BDEE;
        Thu, 12 Dec 2019 14:14:29 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: from freefall.freebsd.org (freefall.freebsd.org [96.47.72.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "freefall.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 47YbQY21H5z3CbD;
        Thu, 12 Dec 2019 14:14:29 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: by freefall.freebsd.org (Postfix, from userid 1079)
        id 24842F04E; Thu, 12 Dec 2019 14:14:29 +0000 (UTC)
From:   Ed Maste <emaste@freefall.freebsd.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ed Maste <emaste@freebsd.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH] perf vendor events s390: Fix commas so PMU event files are valid JSON
Date:   Thu, 12 Dec 2019 14:14:22 +0000
Message-Id: <20191212141422.72187-1-emaste@freefall.freebsd.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed Maste <emaste@freebsd.org>

No functional change.

Akin to da3ef7f6 for power9, remove extra commas in the s390 JSON files
so that the files can be parsed and validated by other utilities.

Signed-off-by: Ed Maste <emaste@freebsd.org>
---
 tools/perf/pmu-events/arch/s390/cf_z10/basic.json      | 2 +-
 tools/perf/pmu-events/arch/s390/cf_z10/crypto.json     | 2 +-
 tools/perf/pmu-events/arch/s390/cf_z10/extended.json   | 2 +-
 tools/perf/pmu-events/arch/s390/cf_z13/basic.json      | 2 +-
 tools/perf/pmu-events/arch/s390/cf_z13/crypto.json     | 2 +-
 tools/perf/pmu-events/arch/s390/cf_z13/extended.json   | 2 +-
 tools/perf/pmu-events/arch/s390/cf_z14/basic.json      | 2 +-
 tools/perf/pmu-events/arch/s390/cf_z14/crypto.json     | 2 +-
 tools/perf/pmu-events/arch/s390/cf_z14/extended.json   | 2 +-
 tools/perf/pmu-events/arch/s390/cf_z15/basic.json      | 2 +-
 tools/perf/pmu-events/arch/s390/cf_z15/crypto.json     | 2 +-
 tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json    | 2 +-
 tools/perf/pmu-events/arch/s390/cf_z15/extended.json   | 2 +-
 tools/perf/pmu-events/arch/s390/cf_z196/basic.json     | 2 +-
 tools/perf/pmu-events/arch/s390/cf_z196/crypto.json    | 2 +-
 tools/perf/pmu-events/arch/s390/cf_z196/extended.json  | 2 +-
 tools/perf/pmu-events/arch/s390/cf_zec12/basic.json    | 2 +-
 tools/perf/pmu-events/arch/s390/cf_zec12/crypto.json   | 2 +-
 tools/perf/pmu-events/arch/s390/cf_zec12/extended.json | 2 +-
 19 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z10/basic.json b/tools/perf/pmu-events/arch/s390/cf_z10/basic.json
index 2dd8dafff2ef..783de7f1aeaa 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z10/basic.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z10/basic.json
@@ -82,5 +82,5 @@
 		"EventName": "PROBLEM_STATE_L1D_PENALTY_CYCLES",
 		"BriefDescription": "Problem-State L1D Penalty Cycles",
 		"PublicDescription": "Problem-State Level-1 D-Cache Penalty Cycle Count"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z10/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z10/crypto.json
index db286f19e7b6..3f28007d3892 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z10/crypto.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z10/crypto.json
@@ -110,5 +110,5 @@
 		"EventName": "AES_BLOCKED_CYCLES",
 		"BriefDescription": "AES Blocked Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the AES functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z10/extended.json b/tools/perf/pmu-events/arch/s390/cf_z10/extended.json
index b6b7f29ca831..86bd8ba9391d 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z10/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z10/extended.json
@@ -124,5 +124,5 @@
 		"EventName": "L2C_STORES_SENT",
 		"BriefDescription": "L2C Stores Sent",
 		"PublicDescription": "Incremented by one for every store sent to Level-2 (L1.5) cache"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/basic.json b/tools/perf/pmu-events/arch/s390/cf_z13/basic.json
index 2dd8dafff2ef..783de7f1aeaa 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z13/basic.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z13/basic.json
@@ -82,5 +82,5 @@
 		"EventName": "PROBLEM_STATE_L1D_PENALTY_CYCLES",
 		"BriefDescription": "Problem-State L1D Penalty Cycles",
 		"PublicDescription": "Problem-State Level-1 D-Cache Penalty Cycle Count"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z13/crypto.json
index db286f19e7b6..3f28007d3892 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z13/crypto.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z13/crypto.json
@@ -110,5 +110,5 @@
 		"EventName": "AES_BLOCKED_CYCLES",
 		"BriefDescription": "AES Blocked Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the AES functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/extended.json b/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
index 436ce33f1182..62e6bdf750dd 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
@@ -390,5 +390,5 @@
 		"EventName": "MT_DIAG_CYCLES_TWO_THR_ACTIVE",
 		"BriefDescription": "Cycle count with two threads active",
 		"PublicDescription": "Cycle count with two threads active"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/basic.json b/tools/perf/pmu-events/arch/s390/cf_z14/basic.json
index 17fb5241928b..fc762e9f1d6e 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z14/basic.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/basic.json
@@ -54,5 +54,5 @@
 		"EventName": "PROBLEM_STATE_INSTRUCTIONS",
 		"BriefDescription": "Problem-State Instructions",
 		"PublicDescription": "Problem-State Instruction Count"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z14/crypto.json
index db286f19e7b6..3f28007d3892 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z14/crypto.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/crypto.json
@@ -110,5 +110,5 @@
 		"EventName": "AES_BLOCKED_CYCLES",
 		"BriefDescription": "AES Blocked Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the AES functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/extended.json b/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
index 68618152ea2c..e6478dff0af7 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
@@ -369,5 +369,5 @@
 		"EventName": "MT_DIAG_CYCLES_TWO_THR_ACTIVE",
 		"BriefDescription": "Cycle count with two threads active",
 		"PublicDescription": "Cycle count with two threads active"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/basic.json b/tools/perf/pmu-events/arch/s390/cf_z15/basic.json
index 17fb5241928b..fc762e9f1d6e 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z15/basic.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z15/basic.json
@@ -54,5 +54,5 @@
 		"EventName": "PROBLEM_STATE_INSTRUCTIONS",
 		"BriefDescription": "Problem-State Instructions",
 		"PublicDescription": "Problem-State Instruction Count"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z15/crypto.json
index db286f19e7b6..3f28007d3892 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z15/crypto.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z15/crypto.json
@@ -110,5 +110,5 @@
 		"EventName": "AES_BLOCKED_CYCLES",
 		"BriefDescription": "AES Blocked Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the AES functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json b/tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json
index 5e36bc2468d0..0b88daf840c5 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json
@@ -26,5 +26,5 @@
 		"EventName": "ECC_BLOCKED_CYCLES_COUNT",
 		"BriefDescription": "ECC Blocked Cycles Count",
 		"PublicDescription": "Long ECC blocked cycles count"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/extended.json b/tools/perf/pmu-events/arch/s390/cf_z15/extended.json
index 89e070727e1b..4942b20a1ea1 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z15/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z15/extended.json
@@ -369,5 +369,5 @@
 		"EventName": "MT_DIAG_CYCLES_TWO_THR_ACTIVE",
 		"BriefDescription": "Cycle count with two threads active",
 		"PublicDescription": "Cycle count with two threads active"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z196/basic.json b/tools/perf/pmu-events/arch/s390/cf_z196/basic.json
index 2dd8dafff2ef..783de7f1aeaa 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z196/basic.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z196/basic.json
@@ -82,5 +82,5 @@
 		"EventName": "PROBLEM_STATE_L1D_PENALTY_CYCLES",
 		"BriefDescription": "Problem-State L1D Penalty Cycles",
 		"PublicDescription": "Problem-State Level-1 D-Cache Penalty Cycle Count"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z196/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z196/crypto.json
index db286f19e7b6..3f28007d3892 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z196/crypto.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z196/crypto.json
@@ -110,5 +110,5 @@
 		"EventName": "AES_BLOCKED_CYCLES",
 		"BriefDescription": "AES Blocked Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the AES functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z196/extended.json b/tools/perf/pmu-events/arch/s390/cf_z196/extended.json
index b7b42a870bb0..86b29fd181cf 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z196/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z196/extended.json
@@ -166,5 +166,5 @@
 		"EventName": "L1I_OFFCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Chip L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_zec12/basic.json b/tools/perf/pmu-events/arch/s390/cf_zec12/basic.json
index 2dd8dafff2ef..783de7f1aeaa 100644
--- a/tools/perf/pmu-events/arch/s390/cf_zec12/basic.json
+++ b/tools/perf/pmu-events/arch/s390/cf_zec12/basic.json
@@ -82,5 +82,5 @@
 		"EventName": "PROBLEM_STATE_L1D_PENALTY_CYCLES",
 		"BriefDescription": "Problem-State L1D Penalty Cycles",
 		"PublicDescription": "Problem-State Level-1 D-Cache Penalty Cycle Count"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_zec12/crypto.json b/tools/perf/pmu-events/arch/s390/cf_zec12/crypto.json
index db286f19e7b6..3f28007d3892 100644
--- a/tools/perf/pmu-events/arch/s390/cf_zec12/crypto.json
+++ b/tools/perf/pmu-events/arch/s390/cf_zec12/crypto.json
@@ -110,5 +110,5 @@
 		"EventName": "AES_BLOCKED_CYCLES",
 		"BriefDescription": "AES Blocked Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the AES functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_zec12/extended.json b/tools/perf/pmu-events/arch/s390/cf_zec12/extended.json
index 162251037219..f40cbed89418 100644
--- a/tools/perf/pmu-events/arch/s390/cf_zec12/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_zec12/extended.json
@@ -243,5 +243,5 @@
 		"EventName": "TX_C_TABORT_SPECIAL",
 		"BriefDescription": "Aborted transactions in constrained TX mode using special completion logic",
 		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is using special logic to allow the transaction to complete"
-	},
+	}
 ]
-- 
2.24.0

