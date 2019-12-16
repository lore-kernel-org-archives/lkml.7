Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD30DC2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94DE20733
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfLPId6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 03:33:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:14638 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfLPId6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 03:33:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 00:33:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,321,1571727600"; 
   d="scan'208";a="217345379"
Received: from rzhang1-mobile.sh.intel.com ([10.239.195.243])
  by orsmga003.jf.intel.com with ESMTP; 16 Dec 2019 00:33:55 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     x86@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, tony.luck@intel.com,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/2] x86/cpu: Add Jasper Lake to Intel family
Date:   Mon, 16 Dec 2019 16:33:44 +0800
Message-Id: <20191216083345.2782-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Japser Lake is an Atom family processor.
It uses Tremont cores and is targeted at mobile platforms.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/include/asm/intel-family.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index c606c0b70738..4981c293f926 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -111,6 +111,7 @@
 
 #define INTEL_FAM6_ATOM_TREMONT_D	0x86 /* Jacobsville */
 #define INTEL_FAM6_ATOM_TREMONT		0x96 /* Elkhart Lake */
+#define INTEL_FAM6_ATOM_TREMONT_L	0x9C /* Jasper Lake */
 
 /* Xeon Phi */
 
-- 
2.17.1

