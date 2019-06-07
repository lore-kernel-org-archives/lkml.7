Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6DAC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851C52089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbfFGPO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:14:26 -0400
Received: from foss.arm.com ([217.140.110.172]:42410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728486AbfFGPO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:14:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E167C367;
        Fri,  7 Jun 2019 08:14:25 -0700 (PDT)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2DB83F718;
        Fri,  7 Jun 2019 08:14:24 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-doc@vger.kernel.org, x86@kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Babu Moger <Babu.Moger@amd.com>, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>
Subject: [PATCH 1/4] Documentation: x86: Contiguous cbm isn't all X86
Date:   Fri,  7 Jun 2019 16:14:06 +0100
Message-Id: <20190607151409.15476-2-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607151409.15476-1-james.morse@arm.com>
References: <20190607151409.15476-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")
resctrl has supported non-contiguous cache bit masks. The interface
for this is currently try-it-and-see.

Update the documentation to say Intel CPUs have this requirement,
instead of X86.

Cc: Babu Moger <Babu.Moger@amd.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 Documentation/x86/resctrl_ui.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/x86/resctrl_ui.rst b/Documentation/x86/resctrl_ui.rst
index 225cfd4daaee..066f94e53418 100644
--- a/Documentation/x86/resctrl_ui.rst
+++ b/Documentation/x86/resctrl_ui.rst
@@ -342,7 +342,7 @@ For cache resources we describe the portion of the cache that is available
 for allocation using a bitmask. The maximum value of the mask is defined
 by each cpu model (and may be different for different cache levels). It
 is found using CPUID, but is also provided in the "info" directory of
-the resctrl file system in "info/{resource}/cbm_mask". X86 hardware
+the resctrl file system in "info/{resource}/cbm_mask". Intel hardware
 requires that these masks have all the '1' bits in a contiguous block. So
 0x3, 0x6 and 0xC are legal 4-bit masks with two bits set, but 0x5, 0x9
 and 0xA are not.  On a system with a 20-bit mask each bit represents 5%
-- 
2.20.1

