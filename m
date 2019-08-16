Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2549C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0097206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfHPIYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 04:24:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:54028 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbfHPIYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 04:24:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 01:19:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; 
   d="scan'208";a="182118822"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga006.jf.intel.com with ESMTP; 16 Aug 2019 01:19:17 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        tony.luck@intel.com, x86@kernel.org
Cc:     andriy.shevchenko@intel.com, alan@linux.intel.com,
        ricardo.neri-calderon@linux.intel.com, rafael.j.wysocki@intel.com,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v2 2/3] x86/cpu: Add new Intel Atom CPU model name
Date:   Fri, 16 Aug 2019 16:18:58 +0800
Message-Id: <83345984845d24b6ce97a32bef21cd0bbdffc86d.1565940653.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1565940653.git.rahul.tanwar@linux.intel.com>
References: <cover.1565940653.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1565940653.git.rahul.tanwar@linux.intel.com>
References: <cover.1565940653.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new variant of Intel Atom Airmont CPU model.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 arch/x86/include/asm/intel-family.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 0278aa66ef62..cbbb8250370f 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -73,6 +73,7 @@
 
 #define INTEL_FAM6_ATOM_AIRMONT		0x4C /* Cherry Trail, Braswell */
 #define INTEL_FAM6_ATOM_AIRMONT_MID	0x5A /* Moorefield */
+#define INTEL_FAM6_ATOM_AIRMONT_NP	0x75 /* Lightning Mountain */
 
 #define INTEL_FAM6_ATOM_GOLDMONT	0x5C /* Apollo Lake */
 #define INTEL_FAM6_ATOM_GOLDMONT_X	0x5F /* Denverton */
-- 
2.11.0

