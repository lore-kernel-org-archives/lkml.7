Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD5ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C511D21852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571437502;
	bh=1Bp5QXY3r3Fb+fDqXdQe66OxpU2X041hGzALEvclh84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wmGSRuGIY9MuUDUEE7cA4PesP8zuhrZrOx77NOBvVNDWE1xAG8Z/PQfKxjdCCcZcb
	 vHI8bNsuCq1iMFyrA1nUfe0EfUFrPmRP6NoGz5vinETFOlSkgx+sKgriQpeCBvh/iY
	 bIuIeYxvoFqcQ2rdUN3DGGStdllP75wnyVN/NxNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392314AbfJRWZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:25:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728740AbfJRWEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:04:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD16522467;
        Fri, 18 Oct 2019 22:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436287;
        bh=1Bp5QXY3r3Fb+fDqXdQe66OxpU2X041hGzALEvclh84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MipYs+6vmCA+l06k6iIqkYHE5dTSBbr45LVJHNBPxaNnyaoEKnLdmJ26wMlSYCLEf
         AwqWYWLgoGCYEFad5ZGYuW4Ne8HmEJTU7VJW8/KTjaHhbduMKPso4tClJxVSHetfik
         Tq8DdT6Efp7Lcc1D+8k5+z8psnYxGBQVrcW3shCE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        ak@linux.intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 62/89] x86/cpu: Add Comet Lake to the Intel CPU models header
Date:   Fri, 18 Oct 2019 18:02:57 -0400
Message-Id: <20191018220324.8165-62-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220324.8165-1-sashal@kernel.org>
References: <20191018220324.8165-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit 8d7c6ac3b2371eb1cbc9925a88f4d10efff374de ]

Comet Lake is the new 10th Gen Intel processor. Add two new CPU model
numbers to the Intel family list.

The CPU model numbers are not published in the SDM yet but they come
from an authoritative internal source.

 [ bp: Touch up commit message. ]

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: ak@linux.intel.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1570549810-25049-2-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/intel-family.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 9ae1c0f05fd2d..3525014c71da9 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -76,6 +76,9 @@
 #define INTEL_FAM6_TIGERLAKE_L		0x8C
 #define INTEL_FAM6_TIGERLAKE		0x8D
 
+#define INTEL_FAM6_COMETLAKE		0xA5
+#define INTEL_FAM6_COMETLAKE_L		0xA6
+
 /* "Small Core" Processors (Atom) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
-- 
2.20.1

