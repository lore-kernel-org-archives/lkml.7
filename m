Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA98AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627672190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfCVWYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:24:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34247 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfCVWYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:24:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMO8gV751071
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:24:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMO7xf751064;
        Fri, 22 Mar 2019 15:24:07 -0700
Date:   Fri, 22 Mar 2019 15:24:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mamatha Inamdar <tipbot@zytor.com>
Message-ID: <tip-c3b4d5c4afb0856e62a60db04c71205712b0d24f@git.kernel.org>
Cc:     mpe@ellerman.id.au, mingo@kernel.org, ravi.bangoria@linux.ibm.com,
        hpa@zytor.com, acme@redhat.com, maddy@linux.vnet.ibm.com,
        sukadev@linux.vnet.ibm.com, mamatha4@linux.vnet.ibm.com,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        peterz@infradead.org, jolsa@redhat.com
Reply-To: mingo@kernel.org, ravi.bangoria@linux.ibm.com,
          mpe@ellerman.id.au, maddy@linux.vnet.ibm.com,
          sukadev@linux.vnet.ibm.com, hpa@zytor.com, acme@redhat.com,
          alexander.shishkin@linux.intel.com, namhyung@kernel.org,
          mamatha4@linux.vnet.ibm.com, jolsa@redhat.com,
          peterz@infradead.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <154953186583.11022.14819560028300370163.stgit@localhost.localdomain>
References: <154953186583.11022.14819560028300370163.stgit@localhost.localdomain>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf vendor events: Remove P8 HW events which are
 not supported
Git-Commit-ID: c3b4d5c4afb0856e62a60db04c71205712b0d24f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c3b4d5c4afb0856e62a60db04c71205712b0d24f
Gitweb:     https://git.kernel.org/tip/c3b4d5c4afb0856e62a60db04c71205712b0d24f
Author:     Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
AuthorDate: Thu, 7 Feb 2019 15:09:28 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:52:03 -0300

perf vendor events: Remove P8 HW events which are not supported

This patch is to remove following hardware events from JSON file which
are not supported on POWER8.

  pm_co_disp_fail
  pm_co_tm_sc_footprint
  pm_iside_disp
  pm_iside_disp_fail
  pm_iside_disp_fail_other
  pm_iside_mru_touch
  pm_l2_castout_mod
  pm_l2_castout_shr
  pm_l2_dc_inv
  pm_l2_disp_all_l2miss
  pm_l2_grp_guess_correct
  pm_l2_grp_guess_wrong
  pm_l2_ic_inv
  pm_l2_inst
  pm_l2_inst_miss
  pm_l2_ld
  pm_l2_ld_disp
  pm_l2_ld_hit
  pm_l2_ld_miss
  pm_l2_loc_guess_correct
  pm_l2_loc_guess_wrong
  pm_l2_rcld_disp
  pm_l2_rcld_disp_fail_addr
  pm_l2_rcld_disp_fail_other
  pm_l2_rcst_disp
  pm_l2_rcst_disp_fail_addr
  pm_l2_rcst_disp_fail_other
  pm_l2_rc_st_done
  pm_l2_rty_ld
  pm_l2_sn_m_rd_done
  pm_l2_sn_m_wr_done
  pm_l2_sn_sx_i_done
  pm_l2_st_disp
  pm_l2_st_hit
  pm_l2_sys_guess_correct
  pm_l2_sys_guess_wrong
  pm_l2_sys_pump
  pm_l3_ci_hit
  pm_l3_ci_miss
  pm_l3_cinj
  pm_l3_co
  pm_l3_co_lco
  pm_l3_grp_guess_correct
  pm_l3_grp_guess_wrong_high
  pm_l3_grp_guess_wrong_low
  pm_l3_hit
  pm_l3_l2_co_hit
  pm_l3_l2_co_miss
  pm_l3_lat_ci_hit
  pm_l3_lat_ci_miss
  pm_l3_ld_hit
  pm_l3_ld_miss
  pm_l3_loc_guess_correct
  pm_l3_loc_guess_wrong
  pm_l3_miss
  pm_l3_p0_co_l31
  pm_l3_p0_co_mem
  pm_l3_p0_co_rty
  pm_l3_p0_grp_pump
  pm_l3_p0_lco_data
  pm_l3_p0_lco_no_data
  pm_l3_p0_lco_rty
  pm_l3_p0_node_pump
  pm_l3_p0_pf_rty
  pm_l3_p0_sn_hit
  pm_l3_p0_sn_inv
  pm_l3_p0_sn_miss
  pm_l3_p0_sys_pump
  pm_l3_p1_co_l31
  pm_l3_p1_co_mem
  pm_l3_p1_co_rty
  pm_l3_p1_grp_pump
  pm_l3_p1_lco_data
  pm_l3_p1_lco_no_data
  pm_l3_p1_lco_rty
  pm_l3_p1_node_pump
  pm_l3_p1_pf_rty
  pm_l3_p1_sn_hit
  pm_l3_p1_sn_inv
  pm_l3_p1_sn_miss
  pm_l3_p1_sys_pump
  pm_l3_pf_hit_l3
  pm_l3_sys_guess_correct
  pm_l3_sys_guess_wrong
  pm_l3_trans_pf
  pm_l3_wi0_busy
  pm_l3_wi_usage
  pm_non_tm_rst_sc
  pm_rd_clearing_sc
  pm_rd_forming_sc
  pm_rd_hit_pf
  pm_snp_tm_hit_m
  pm_snp_tm_hit_t
  pm_st_caused_fail
  pm_tm_cam_overflow
  pm_tm_cap_overflow
  pm_tm_fav_caused_fail
  pm_tm_ld_caused_fail
  pm_tm_ld_conf
  pm_tm_rst_sc
  pm_tm_sc_co
  pm_tm_st_caused_fail
  pm_tm_st_conf

Signed-off-by: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Fixes: 2a81fa3bb5ed ("perf vendor events: Add power8 PMU events")
Link: http://lkml.kernel.org/r/154953186583.11022.14819560028300370163.stgit@localhost.localdomain
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/pmu-events/arch/powerpc/power8/other.json | 594 ---------------------
 1 file changed, 594 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power8/other.json b/tools/perf/pmu-events/arch/powerpc/power8/other.json
index 704302c3e67d..9dc2f6b70354 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/other.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/other.json
@@ -347,18 +347,6 @@
     "BriefDescription": "CO mach 0 Busy. Used by PMU to sample ave RC livetime(mach0 used as sample point)",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x517082",
-    "EventName": "PM_CO_DISP_FAIL",
-    "BriefDescription": "CO dispatch failed due to all CO machines being busy",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x527084",
-    "EventName": "PM_CO_TM_SC_FOOTPRINT",
-    "BriefDescription": "L2 did a cleanifdirty CO to the L3 (ie created an SC line in the L3)",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x3608a",
     "EventName": "PM_CO_USAGE",
@@ -1577,36 +1565,12 @@
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another core's L3 on the same chip due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x617082",
-    "EventName": "PM_ISIDE_DISP",
-    "BriefDescription": "All i-side dispatch attempts",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x627084",
-    "EventName": "PM_ISIDE_DISP_FAIL",
-    "BriefDescription": "All i-side dispatch attempts that failed due to a addr collision with another machine",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x627086",
-    "EventName": "PM_ISIDE_DISP_FAIL_OTHER",
-    "BriefDescription": "All i-side dispatch attempts that failed due to a reason other than addrs collision",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x4608e",
     "EventName": "PM_ISIDE_L2MEMACC",
     "BriefDescription": "valid when first beat of data comes in for an i-side fetch where data came from mem(or L4)",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x44608e",
-    "EventName": "PM_ISIDE_MRU_TOUCH",
-    "BriefDescription": "Iside L2 MRU touch",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x30ac",
     "EventName": "PM_ISU_REF_FX0",
@@ -1733,222 +1697,36 @@
     "BriefDescription": "Instruction Demand sectors wriittent into IL1",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x417080",
-    "EventName": "PM_L2_CASTOUT_MOD",
-    "BriefDescription": "L2 Castouts - Modified (M, Mu, Me)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x417082",
-    "EventName": "PM_L2_CASTOUT_SHR",
-    "BriefDescription": "L2 Castouts - Shared (T, Te, Si, S)",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x27084",
     "EventName": "PM_L2_CHIP_PUMP",
     "BriefDescription": "RC requests that were local on chip pump attempts",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x427086",
-    "EventName": "PM_L2_DC_INV",
-    "BriefDescription": "Dcache invalidates from L2",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x44608c",
-    "EventName": "PM_L2_DISP_ALL_L2MISS",
-    "BriefDescription": "All successful Ld/St dispatches for this thread that were an L2miss",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x27086",
     "EventName": "PM_L2_GROUP_PUMP",
     "BriefDescription": "RC requests that were on Node Pump attempts",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x626084",
-    "EventName": "PM_L2_GRP_GUESS_CORRECT",
-    "BriefDescription": "L2 guess grp and guess was correct (data intra-6chip AND ^on-chip)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x626086",
-    "EventName": "PM_L2_GRP_GUESS_WRONG",
-    "BriefDescription": "L2 guess grp and guess was not correct (ie data on-chip OR beyond-6chip)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x427084",
-    "EventName": "PM_L2_IC_INV",
-    "BriefDescription": "Icache Invalidates from L2",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x436088",
-    "EventName": "PM_L2_INST",
-    "BriefDescription": "All successful I-side dispatches for this thread (excludes i_l2mru_tch reqs)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x43608a",
-    "EventName": "PM_L2_INST_MISS",
-    "BriefDescription": "All successful i-side dispatches that were an L2miss for this thread (excludes i_l2mru_tch reqs)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x416080",
-    "EventName": "PM_L2_LD",
-    "BriefDescription": "All successful D-side Load dispatches for this thread",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x437088",
-    "EventName": "PM_L2_LD_DISP",
-    "BriefDescription": "All successful load dispatches",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x43708a",
-    "EventName": "PM_L2_LD_HIT",
-    "BriefDescription": "All successful load dispatches that were L2 hits",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x426084",
-    "EventName": "PM_L2_LD_MISS",
-    "BriefDescription": "All successful D-Side Load dispatches that were an L2miss for this thread",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x616080",
-    "EventName": "PM_L2_LOC_GUESS_CORRECT",
-    "BriefDescription": "L2 guess loc and guess was correct (ie data local)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x616082",
-    "EventName": "PM_L2_LOC_GUESS_WRONG",
-    "BriefDescription": "L2 guess loc and guess was not correct (ie data not on chip)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x516080",
-    "EventName": "PM_L2_RCLD_DISP",
-    "BriefDescription": "L2 RC load dispatch attempt",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x516082",
-    "EventName": "PM_L2_RCLD_DISP_FAIL_ADDR",
-    "BriefDescription": "L2 RC load dispatch attempt failed due to address collision with RC/CO/SN/SQ",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x526084",
-    "EventName": "PM_L2_RCLD_DISP_FAIL_OTHER",
-    "BriefDescription": "L2 RC load dispatch attempt failed due to other reasons",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x536088",
-    "EventName": "PM_L2_RCST_DISP",
-    "BriefDescription": "L2 RC store dispatch attempt",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x53608a",
-    "EventName": "PM_L2_RCST_DISP_FAIL_ADDR",
-    "BriefDescription": "L2 RC store dispatch attempt failed due to address collision with RC/CO/SN/SQ",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x54608c",
-    "EventName": "PM_L2_RCST_DISP_FAIL_OTHER",
-    "BriefDescription": "L2 RC store dispatch attempt failed due to other reasons",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x537088",
-    "EventName": "PM_L2_RC_ST_DONE",
-    "BriefDescription": "RC did st to line that was Tx or Sx",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x63708a",
-    "EventName": "PM_L2_RTY_LD",
-    "BriefDescription": "RC retries on PB for any load from core",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x3708a",
     "EventName": "PM_L2_RTY_ST",
     "BriefDescription": "RC retries on PB for any store from core",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x54708c",
-    "EventName": "PM_L2_SN_M_RD_DONE",
-    "BriefDescription": "SNP dispatched for a read and was M",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x54708e",
-    "EventName": "PM_L2_SN_M_WR_DONE",
-    "BriefDescription": "SNP dispatched for a write and was M",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x53708a",
-    "EventName": "PM_L2_SN_SX_I_DONE",
-    "BriefDescription": "SNP dispatched and went from Sx or Tx to Ix",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x17080",
     "EventName": "PM_L2_ST",
     "BriefDescription": "All successful D-side store dispatches for this thread",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x44708c",
-    "EventName": "PM_L2_ST_DISP",
-    "BriefDescription": "All successful store dispatches",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x44708e",
-    "EventName": "PM_L2_ST_HIT",
-    "BriefDescription": "All successful store dispatches that were L2Hits",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x17082",
     "EventName": "PM_L2_ST_MISS",
     "BriefDescription": "All successful D-side store dispatches for this thread that were L2 Miss",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x636088",
-    "EventName": "PM_L2_SYS_GUESS_CORRECT",
-    "BriefDescription": "L2 guess sys and guess was correct (ie data beyond-6chip)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x63608a",
-    "EventName": "PM_L2_SYS_GUESS_WRONG",
-    "BriefDescription": "L2 guess sys and guess was not correct (ie data ^beyond-6chip)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x617080",
-    "EventName": "PM_L2_SYS_PUMP",
-    "BriefDescription": "RC requests that were system pump attempts",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x1e05e",
     "EventName": "PM_L2_TM_REQ_ABORT",
@@ -1961,36 +1739,12 @@
     "BriefDescription": "TM marked store abort",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x23808a",
-    "EventName": "PM_L3_CINJ",
-    "BriefDescription": "l3 ci of cache inject",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x128084",
-    "EventName": "PM_L3_CI_HIT",
-    "BriefDescription": "L3 Castins Hit (total count",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x128086",
-    "EventName": "PM_L3_CI_MISS",
-    "BriefDescription": "L3 castins miss (total count",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x819082",
     "EventName": "PM_L3_CI_USAGE",
     "BriefDescription": "rotating sample of 16 CI or CO actives",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x438088",
-    "EventName": "PM_L3_CO",
-    "BriefDescription": "l3 castout occurring ( does not include casthrough or log writes (cinj/dmaw)",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x83908b",
     "EventName": "PM_L3_CO0_ALLOC",
@@ -2009,120 +1763,18 @@
     "BriefDescription": "L3 CO to L3.1 OR of port 0 and 1 ( lossy)",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x238088",
-    "EventName": "PM_L3_CO_LCO",
-    "BriefDescription": "Total L3 castouts occurred on LCO",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x28084",
     "EventName": "PM_L3_CO_MEM",
     "BriefDescription": "L3 CO to memory OR of port 0 and 1 ( lossy)",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0xb19082",
-    "EventName": "PM_L3_GRP_GUESS_CORRECT",
-    "BriefDescription": "Initial scope=group and data from same group (near) (pred successful)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xb3908a",
-    "EventName": "PM_L3_GRP_GUESS_WRONG_HIGH",
-    "BriefDescription": "Initial scope=group but data from local node. Predition too high",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xb39088",
-    "EventName": "PM_L3_GRP_GUESS_WRONG_LOW",
-    "BriefDescription": "Initial scope=group but data from outside group (far or rem). Prediction too Low",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x218080",
-    "EventName": "PM_L3_HIT",
-    "BriefDescription": "L3 Hits",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x138088",
-    "EventName": "PM_L3_L2_CO_HIT",
-    "BriefDescription": "L2 castout hits",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x13808a",
-    "EventName": "PM_L3_L2_CO_MISS",
-    "BriefDescription": "L2 castout miss",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x14808c",
-    "EventName": "PM_L3_LAT_CI_HIT",
-    "BriefDescription": "L3 Lateral Castins Hit",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x14808e",
-    "EventName": "PM_L3_LAT_CI_MISS",
-    "BriefDescription": "L3 Lateral Castins Miss",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x228084",
-    "EventName": "PM_L3_LD_HIT",
-    "BriefDescription": "L3 demand LD Hits",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x228086",
-    "EventName": "PM_L3_LD_MISS",
-    "BriefDescription": "L3 demand LD Miss",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x1e052",
     "EventName": "PM_L3_LD_PREF",
     "BriefDescription": "L3 Load Prefetches",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0xb19080",
-    "EventName": "PM_L3_LOC_GUESS_CORRECT",
-    "BriefDescription": "initial scope=node/chip and data from local node (local) (pred successful)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xb29086",
-    "EventName": "PM_L3_LOC_GUESS_WRONG",
-    "BriefDescription": "Initial scope=node but data from out side local node (near or far or rem). Prediction too Low",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x218082",
-    "EventName": "PM_L3_MISS",
-    "BriefDescription": "L3 Misses",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x54808c",
-    "EventName": "PM_L3_P0_CO_L31",
-    "BriefDescription": "l3 CO to L3.1 (lco) port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x538088",
-    "EventName": "PM_L3_P0_CO_MEM",
-    "BriefDescription": "l3 CO to memory port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x929084",
-    "EventName": "PM_L3_P0_CO_RTY",
-    "BriefDescription": "L3 CO received retry port 0",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0xa29084",
     "EventName": "PM_L3_P0_GRP_PUMP",
@@ -2147,120 +1799,6 @@
     "BriefDescription": "L3 LCO received retry port 0",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0xa19080",
-    "EventName": "PM_L3_P0_NODE_PUMP",
-    "BriefDescription": "L3 pf sent with nodal scope port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x919080",
-    "EventName": "PM_L3_P0_PF_RTY",
-    "BriefDescription": "L3 PF received retry port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x939088",
-    "EventName": "PM_L3_P0_SN_HIT",
-    "BriefDescription": "L3 snoop hit port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x118080",
-    "EventName": "PM_L3_P0_SN_INV",
-    "BriefDescription": "Port0 snooper detects someone doing a store to a line thats Sx",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x94908c",
-    "EventName": "PM_L3_P0_SN_MISS",
-    "BriefDescription": "L3 snoop miss port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xa39088",
-    "EventName": "PM_L3_P0_SYS_PUMP",
-    "BriefDescription": "L3 pf sent with sys scope port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x54808e",
-    "EventName": "PM_L3_P1_CO_L31",
-    "BriefDescription": "l3 CO to L3.1 (lco) port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x53808a",
-    "EventName": "PM_L3_P1_CO_MEM",
-    "BriefDescription": "l3 CO to memory port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x929086",
-    "EventName": "PM_L3_P1_CO_RTY",
-    "BriefDescription": "L3 CO received retry port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xa29086",
-    "EventName": "PM_L3_P1_GRP_PUMP",
-    "BriefDescription": "L3 pf sent with grp scope port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x528086",
-    "EventName": "PM_L3_P1_LCO_DATA",
-    "BriefDescription": "lco sent with data port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x518082",
-    "EventName": "PM_L3_P1_LCO_NO_DATA",
-    "BriefDescription": "dataless l3 lco sent port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xa4908e",
-    "EventName": "PM_L3_P1_LCO_RTY",
-    "BriefDescription": "L3 LCO received retry port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xa19082",
-    "EventName": "PM_L3_P1_NODE_PUMP",
-    "BriefDescription": "L3 pf sent with nodal scope port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x919082",
-    "EventName": "PM_L3_P1_PF_RTY",
-    "BriefDescription": "L3 PF received retry port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x93908a",
-    "EventName": "PM_L3_P1_SN_HIT",
-    "BriefDescription": "L3 snoop hit port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x118082",
-    "EventName": "PM_L3_P1_SN_INV",
-    "BriefDescription": "Port1 snooper detects someone doing a store to a line thats Sx",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x94908e",
-    "EventName": "PM_L3_P1_SN_MISS",
-    "BriefDescription": "L3 snoop miss port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xa3908a",
-    "EventName": "PM_L3_P1_SYS_PUMP",
-    "BriefDescription": "L3 pf sent with sys scope port 1",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x84908d",
     "EventName": "PM_L3_PF0_ALLOC",
@@ -2273,12 +1811,6 @@
     "BriefDescription": "lifetime, sample of PF machine 0 valid",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x428084",
-    "EventName": "PM_L3_PF_HIT_L3",
-    "BriefDescription": "l3 pf hit in l3",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x18080",
     "EventName": "PM_L3_PF_MISS_L3",
@@ -2369,42 +1901,12 @@
     "BriefDescription": "Data stream touchto L3",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0xb29084",
-    "EventName": "PM_L3_SYS_GUESS_CORRECT",
-    "BriefDescription": "Initial scope=system and data from outside group (far or rem)(pred successful)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xb4908c",
-    "EventName": "PM_L3_SYS_GUESS_WRONG",
-    "BriefDescription": "Initial scope=system but data from local or near. Predction too high",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x24808e",
-    "EventName": "PM_L3_TRANS_PF",
-    "BriefDescription": "L3 Transient prefetch",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x18081",
     "EventName": "PM_L3_WI0_ALLOC",
     "BriefDescription": "lifetime, sample of Write Inject machine 0 valid",
     "PublicDescription": "0.0"
   },
-  {,
-    "EventCode": "0x418080",
-    "EventName": "PM_L3_WI0_BUSY",
-    "BriefDescription": "lifetime, sample of Write Inject machine 0 valid",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x418082",
-    "EventName": "PM_L3_WI_USAGE",
-    "BriefDescription": "rotating sample of 8 WI actives",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0xc080",
     "EventName": "PM_LD_REF_L1_LSU0",
@@ -3311,12 +2813,6 @@
     "BriefDescription": "Dispatch time non favored tbegin",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x328084",
-    "EventName": "PM_NON_TM_RST_SC",
-    "BriefDescription": "non tm snp rst tm sc",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x2001a",
     "EventName": "PM_NTCG_ALL_FIN",
@@ -3419,24 +2915,6 @@
     "BriefDescription": "Continuous 16 cycle(2to1) window where this signals rotates thru sampling each L2 RC machine busy. PMU uses this wave to then do 16 cyc count to sample total number of machs running",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x34808e",
-    "EventName": "PM_RD_CLEARING_SC",
-    "BriefDescription": "rd clearing sc",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x34808c",
-    "EventName": "PM_RD_FORMING_SC",
-    "BriefDescription": "rd forming sc",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x428086",
-    "EventName": "PM_RD_HIT_PF",
-    "BriefDescription": "rd machine hit l3 pf machine",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x20004",
     "EventName": "PM_REAL_SRQ_FULL",
@@ -3503,18 +2981,6 @@
     "BriefDescription": "TLBIE snoop",
     "PublicDescription": "TLBIE snoopSnoop TLBIE"
   },
-  {,
-    "EventCode": "0x338088",
-    "EventName": "PM_SNP_TM_HIT_M",
-    "BriefDescription": "snp tm st hit m mu",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x33808a",
-    "EventName": "PM_SNP_TM_HIT_T",
-    "BriefDescription": "snp tm_st_hit t tn te",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x4608c",
     "EventName": "PM_SN_USAGE",
@@ -3533,12 +2999,6 @@
     "BriefDescription": "STCX executed reported at sent to nest",
     "PublicDescription": "STCX executed reported at sent to nest42"
   },
-  {,
-    "EventCode": "0x717080",
-    "EventName": "PM_ST_CAUSED_FAIL",
-    "BriefDescription": "Non TM St caused any thread to fail",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x3090",
     "EventName": "PM_SWAP_CANCEL",
@@ -3623,18 +3083,6 @@
     "BriefDescription": "Tm any tbegin",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x318082",
-    "EventName": "PM_TM_CAM_OVERFLOW",
-    "BriefDescription": "l3 tm cam overflow during L2 co of SC",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x74708c",
-    "EventName": "PM_TM_CAP_OVERFLOW",
-    "BriefDescription": "TM Footprint Capactiy Overflow",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x20ba",
     "EventName": "PM_TM_END_ALL",
@@ -3689,48 +3137,6 @@
     "BriefDescription": "Transactional conflict from LSU, whatever gets reported to texas",
     "PublicDescription": "Transactional conflict from LSU, whatever gets reported to texas 42"
   },
-  {,
-    "EventCode": "0x727086",
-    "EventName": "PM_TM_FAV_CAUSED_FAIL",
-    "BriefDescription": "TM Load (fav) caused another thread to fail",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x717082",
-    "EventName": "PM_TM_LD_CAUSED_FAIL",
-    "BriefDescription": "Non TM Ld caused any thread to fail",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x727084",
-    "EventName": "PM_TM_LD_CONF",
-    "BriefDescription": "TM Load (fav or non-fav) ran into conflict (failed)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x328086",
-    "EventName": "PM_TM_RST_SC",
-    "BriefDescription": "tm snp rst tm sc",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x318080",
-    "EventName": "PM_TM_SC_CO",
-    "BriefDescription": "l3 castout tm Sc line",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x73708a",
-    "EventName": "PM_TM_ST_CAUSED_FAIL",
-    "BriefDescription": "TM Store (fav or non-fav) caused another thread to fail",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x737088",
-    "EventName": "PM_TM_ST_CONF",
-    "BriefDescription": "TM Store (fav or non-fav) ran into conflict (failed)",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x20bc",
     "EventName": "PM_TM_TBEGIN",
