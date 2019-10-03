Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97896C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A26E20830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570123139;
	bh=oxUGfmRL9iGpIDJ2pCNJq5o2xCvzlbFrr0Q4xmMQX0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=azyZWVsI9BimRnqTWLBXCIDlB4D8ebCQba8yE5PlY9eUdZJRe6jVrgutLB15rL6p0
	 m1xh40h2NPuQqYPnHJEnBVYwpi5vy10GSoqApPVFNot4xv/WGQP224+s+sMRxbeIuZ
	 Or3eyKPISawDRlEDo6KjfZ7MVVYWPQvz7SyrByDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389866AbfJCQUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389829AbfJCQUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:20:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6D18222BE;
        Thu,  3 Oct 2019 16:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119610;
        bh=oxUGfmRL9iGpIDJ2pCNJq5o2xCvzlbFrr0Q4xmMQX0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p7OHDglXCpFLD6d5zxe7DI4ThnGbMvkZHRvncSeWH7/LP+nymnUTH6+KRsmD8hy7A
         SpTZ5JJksG/a9LJAwdUjK42rYOEfLNb9/ea9fIrSiwviReCb9C0vZNTYpcUTjqAOYt
         OBkxzCNaeAjWvvZBFZbihq7deX4HWiIFSi3RRQ8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 129/211] x86/cpu: Add Tiger Lake to Intel family
Date:   Thu,  3 Oct 2019 17:53:15 +0200
Message-Id: <20191003154516.210922650@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gayatri Kammela <gayatri.kammela@intel.com>

[ Upstream commit 6e1c32c5dbb4b90eea8f964c2869d0bde050dbe0 ]

Add the model numbers/CPUIDs of Tiger Lake mobile and desktop to the
Intel family.

Suggested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190905193020.14707-2-tony.luck@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/intel-family.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index aebedbaf52607..5d0b72f281402 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -58,6 +58,9 @@
 #define INTEL_FAM6_ICELAKE_MOBILE	0x7E
 #define INTEL_FAM6_ICELAKE_NNPI		0x9D
 
+#define INTEL_FAM6_TIGERLAKE_L		0x8C
+#define INTEL_FAM6_TIGERLAKE		0x8D
+
 /* "Small Core" Processors (Atom) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
-- 
2.20.1



