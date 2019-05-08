Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBE2C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA7820675
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="tx4r86vC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfEHLkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:40:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53541 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbfEHLkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:40:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x48Be6Y4986798
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 8 May 2019 04:40:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x48Be6Y4986798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1557315607;
        bh=6VBugT9NH7tbm1198ezLA0I9G0gUOewrFYBF11b/gLU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=tx4r86vC0qWrBTXzN9waynQ8R907qOqXAKXsdC40zw/YNxYdEnsZVRrM75bUZHsby
         /FyDIkL5WfEwL0qMdvjNDhvuMsTbAFpQX5TeFDg/rkpTGdUggLuiS3qVNT8oo75qIP
         SYeQef5I+g/piugkchi2dq7sYyMlz4ZZbe2ctEYrG9l6IwvNaDaKoF5XsQ2CG9Y3Eo
         a4PhdUGrAQnqp9rv01ql/DKZROmHATfrxT3pOo+epvqCWCZFg0l5X+zWdYzOHEzioO
         UMy03GIULGuKBEu7OKDGxOb22fp1uI+T4snUR3RdRvl93hZZQNL3VrXkFf8qc7S0qd
         FAtwqQtch2ndQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x48Be5sf986795;
        Wed, 8 May 2019 04:40:05 -0700
Date:   Wed, 8 May 2019 04:40:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Wang Hai <tipbot@zytor.com>
Message-ID: <tip-4abf1ee16e25ba97bc9e04ddc64e0cd2a1bc41a8@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        hpa@zytor.com, mingo@kernel.org, wanghai26@huawei.com,
        peterz@infradead.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, peterz@infradead.org, wanghai26@huawei.com,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20190508020418.19568-1-wanghai26@huawei.com>
References: <20190508020418.19568-1-wanghai26@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/amd/iommu: Make the
 'amd_iommu_attr_groups' symbol static
Git-Commit-ID: 4abf1ee16e25ba97bc9e04ddc64e0cd2a1bc41a8
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

Commit-ID:  4abf1ee16e25ba97bc9e04ddc64e0cd2a1bc41a8
Gitweb:     https://git.kernel.org/tip/4abf1ee16e25ba97bc9e04ddc64e0cd2a1bc41a8
Author:     Wang Hai <wanghai26@huawei.com>
AuthorDate: Wed, 8 May 2019 10:04:18 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 8 May 2019 13:35:32 +0200

perf/x86/amd/iommu: Make the 'amd_iommu_attr_groups' symbol static

Fixes the following sparse warning:

  arch/x86/events/amd/iommu.c:396:30: warning:
   symbol 'amd_iommu_attr_groups' was not declared. Should it be static?

Signed-off-by: Wang Hai <wanghai26@huawei.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: acme@kernel.org
Cc: alexander.shishkin@linux.intel.com
Cc: bp@alien8.de
Cc: jolsa@redhat.com
Cc: namhyung@kernel.org
Fixes: 51686546304f (x86/events/amd/iommu: Fix sysfs perf attribute groups)
Link: http://lkml.kernel.org/r/20190508020418.19568-1-wanghai26@huawei.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 7635c23f7d82..58a6993d7eb3 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -393,7 +393,7 @@ static __init int _init_events_attrs(void)
 	return 0;
 }
 
-const struct attribute_group *amd_iommu_attr_groups[] = {
+static const struct attribute_group *amd_iommu_attr_groups[] = {
 	&amd_iommu_format_group,
 	&amd_iommu_cpumask_group,
 	&amd_iommu_events_group,
