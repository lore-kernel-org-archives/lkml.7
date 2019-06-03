Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689B9C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30945261AB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="yE9Sm68d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbfFCNYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:24:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38491 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfFCNYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:24:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DObAI609145
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:24:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DObAI609145
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559568277;
        bh=KvNEdbvzihyyeSAMjn/O1s199qockgQ8cH6pFYpsbu4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=yE9Sm68d0dijsgwy4PS+xGY44/Cdwts3A1UFuFM2iXV3ss96ch9+85bbwldyqwYBF
         3Knr2eeykyzpEUDlaDVJw4Ef0ntix0Z/0lwwIxfkOFBMASERzmCSqscIxWmi5y/Vdg
         NvjMesu9Vdf7A1UAv7nYX5Eqd5PvDUihBmME+xXenBACcqQ1g9Si3La5Kx/2zyh5+D
         qaYR6PZA4uHWR2rbJwqUQc0Wl6J5JYlql+DqmTZLVP5DNxRuWZhh1iiM9gZwj1nvR2
         IiNhdIDK1yptaD0e8qAlG4dSBSTPUrR3+wZo+ocqqrsQ+DUcLSk581XZTx6R0o8sqh
         +fiqhgqyxKy3Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DOadK609142;
        Mon, 3 Jun 2019 06:24:36 -0700
Date:   Mon, 3 Jun 2019 06:24:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Gayatri Kammela <tipbot@zytor.com>
Message-ID: <tip-6e86d3db5f8fb69eea76cc496c3c3da19c855aa9@git.kernel.org>
Cc:     charles.d.prestopine@intel.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, gayatri.kammela@intel.com,
        mingo@kernel.org, tglx@linutronix.de, kan.liang@intel.com,
        hpa@zytor.com, peterz@infradead.org
Reply-To: kan.liang@intel.com, hpa@zytor.com, peterz@infradead.org,
          gayatri.kammela@intel.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, torvalds@linux-foundation.org,
          charles.d.prestopine@intel.com, tglx@linutronix.de
In-Reply-To: <20190511000311.20733-2-gayatri.kammela@intel.com>
References: <20190511000311.20733-2-gayatri.kammela@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel/uncore: Add new IMC PCI IDs for
 KabyLake, AmberLake and WhiskeyLake CPUs
Git-Commit-ID: 6e86d3db5f8fb69eea76cc496c3c3da19c855aa9
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

Commit-ID:  6e86d3db5f8fb69eea76cc496c3c3da19c855aa9
Gitweb:     https://git.kernel.org/tip/6e86d3db5f8fb69eea76cc496c3c3da19c855aa9
Author:     Gayatri Kammela <gayatri.kammela@intel.com>
AuthorDate: Fri, 10 May 2019 17:03:11 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:58:20 +0200

perf/x86/intel/uncore: Add new IMC PCI IDs for KabyLake, AmberLake and WhiskeyLake CPUs

AmberLake and WhiskeyLake have same client uncore events as
KabyLake. Thus add the PCI IDs for AmberLake Y processor lines,
for WhiskeyLake U processor lines and for KabyLake, add H
processor line and workstation.

 Platform		Device ID
 ================================
 AML Y 2 Core		590Ch
 KBL H 4 Core		5910h
 KBL 4 Core WorkStation	5918h
 WHL U 4 Core		3ED0h
 WHL U 4 Core		3E34h
 WHL U 2 Core		3E35h
 AML Y 4 Core		590Dh

Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Charles Prestopine <charles.d.prestopine@intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190511000311.20733-2-gayatri.kammela@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore_snb.c | 43 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index db9eb64ce756..b0ca4f88c6f2 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -20,6 +20,8 @@
 #define PCI_DEVICE_ID_INTEL_KBL_UQ_IMC		0x5914
 #define PCI_DEVICE_ID_INTEL_KBL_SD_IMC		0x590f
 #define PCI_DEVICE_ID_INTEL_KBL_SQ_IMC		0x591f
+#define PCI_DEVICE_ID_INTEL_KBL_HQ_IMC		0x5910
+#define PCI_DEVICE_ID_INTEL_KBL_WQ_IMC		0x5918
 #define PCI_DEVICE_ID_INTEL_CFL_2U_IMC		0x3ecc
 #define PCI_DEVICE_ID_INTEL_CFL_4U_IMC		0x3ed0
 #define PCI_DEVICE_ID_INTEL_CFL_4H_IMC		0x3e10
@@ -34,9 +36,15 @@
 #define PCI_DEVICE_ID_INTEL_CFL_4S_S_IMC	0x3e33
 #define PCI_DEVICE_ID_INTEL_CFL_6S_S_IMC	0x3eca
 #define PCI_DEVICE_ID_INTEL_CFL_8S_S_IMC	0x3e32
+#define PCI_DEVICE_ID_INTEL_AML_YD_IMC		0x590c
+#define PCI_DEVICE_ID_INTEL_AML_YQ_IMC		0x590d
+#define PCI_DEVICE_ID_INTEL_WHL_UQ_IMC		0x3ed0
+#define PCI_DEVICE_ID_INTEL_WHL_4_UQ_IMC	0x3e34
+#define PCI_DEVICE_ID_INTEL_WHL_UD_IMC		0x3e35
 #define PCI_DEVICE_ID_INTEL_ICL_U_IMC		0x8a02
 #define PCI_DEVICE_ID_INTEL_ICL_U2_IMC		0x8a12
 
+
 /* SNB event control */
 #define SNB_UNC_CTL_EV_SEL_MASK			0x000000ff
 #define SNB_UNC_CTL_UMASK_MASK			0x0000ff00
@@ -681,6 +689,14 @@ static const struct pci_device_id skl_uncore_pci_ids[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_SQ_IMC),
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
 	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_HQ_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_WQ_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
 	{ /* IMC */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_2U_IMC),
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
@@ -737,6 +753,26 @@ static const struct pci_device_id skl_uncore_pci_ids[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_8S_S_IMC),
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
 	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_AML_YD_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_AML_YQ_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WHL_UQ_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WHL_4_UQ_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WHL_UD_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
 	{ /* end: all zeroes */ },
 };
 
@@ -807,6 +843,8 @@ static const struct imc_uncore_pci_dev desktop_imc_pci_ids[] = {
 	IMC_DEV(KBL_UQ_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core U Quad Core */
 	IMC_DEV(KBL_SD_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core S Dual Core */
 	IMC_DEV(KBL_SQ_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core S Quad Core */
+	IMC_DEV(KBL_HQ_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core H Quad Core */
+	IMC_DEV(KBL_WQ_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core S 4 cores Work Station */
 	IMC_DEV(CFL_2U_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core U 2 Cores */
 	IMC_DEV(CFL_4U_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core U 4 Cores */
 	IMC_DEV(CFL_4H_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core H 4 Cores */
@@ -821,6 +859,11 @@ static const struct imc_uncore_pci_dev desktop_imc_pci_ids[] = {
 	IMC_DEV(CFL_4S_S_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 4 Cores Server */
 	IMC_DEV(CFL_6S_S_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 6 Cores Server */
 	IMC_DEV(CFL_8S_S_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 8 Cores Server */
+	IMC_DEV(AML_YD_IMC, &skl_uncore_pci_driver),	/* 8th Gen Core Y Mobile Dual Core */
+	IMC_DEV(AML_YQ_IMC, &skl_uncore_pci_driver),	/* 8th Gen Core Y Mobile Quad Core */
+	IMC_DEV(WHL_UQ_IMC, &skl_uncore_pci_driver),	/* 8th Gen Core U Mobile Quad Core */
+	IMC_DEV(WHL_4_UQ_IMC, &skl_uncore_pci_driver),	/* 8th Gen Core U Mobile Quad Core */
+	IMC_DEV(WHL_UD_IMC, &skl_uncore_pci_driver),	/* 8th Gen Core U Mobile Dual Core */
 	IMC_DEV(ICL_U_IMC, &icl_uncore_pci_driver),	/* 10th Gen Core Mobile */
 	IMC_DEV(ICL_U2_IMC, &icl_uncore_pci_driver),	/* 10th Gen Core Mobile */
 	{  /* end marker */ }
