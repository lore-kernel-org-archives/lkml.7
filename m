Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AE8CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701A2214E0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905213;
	bh=1Bp5QXY3r3Fb+fDqXdQe66OxpU2X041hGzALEvclh84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LVcxHbG2zqUkUDsV1/iOun/rpYJKUdVQtzuXt7NY2aDT+w8vO4xFKj5WUJ9W/zEGZ
	 ZQM99v/ntkniodURtn8KrsRrxI2QlLOtIunUX1xmDSR7AcIj0vh2ahOwmd2ZAkD7K8
	 PqNIBQVwdE3pNnoYucLr9KfoSynxND9aOFpozY3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390002AbfKDWGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:06:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:38674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389044AbfKDWGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:06:41 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7339320650;
        Mon,  4 Nov 2019 22:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572905201;
        bh=1Bp5QXY3r3Fb+fDqXdQe66OxpU2X041hGzALEvclh84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jQnDWIH9el/BCYI26n6kSF6uFoDQv+4Pv3D3JDu3oDOaF/nwPhoiKI2Npr+DesqB2
         dgxORVEWfERbmkxu4wv6MdyKY8Tl0DNEKoMlBb6VCY8yB8xweCZkp+PuhSIiAWm0xi
         mwHibZluB19wsTnTQOWas4tI5zHrLM1BLF2N+4aw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        ak@linux.intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 064/163] x86/cpu: Add Comet Lake to the Intel CPU models header
Date:   Mon,  4 Nov 2019 22:44:14 +0100
Message-Id: <20191104212144.657911293@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212140.046021995@linuxfoundation.org>
References: <20191104212140.046021995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



