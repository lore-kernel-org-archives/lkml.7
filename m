Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37078C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0776220844
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QJrs+8g7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfHSLBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:01:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40981 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfHSLBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:01:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7JB15KT4107102
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 19 Aug 2019 04:01:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7JB15KT4107102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1566212465;
        bh=9Ebv9eTrhDD+BlNsrkHBKIOZy6lsF2i1J2fZnUWvzF0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=QJrs+8g7KBHGFerOQNMeMBKup78jEHykrh4j1z0+6xBo6KbjQk2B6IoY4reXdnjke
         LkL0Q69ms/veDvri09QQp/vABQrrIV2BD8S1Fa8bniSCT6p9JF02c7QNaXt3gMkoBk
         S7kRp3YaiDEYqEcXJtMSYAEFmniO6Q30WfJhH3U/4gNF6KZ9z3UZhOGBB9znoz1vXe
         FvDA06tiAvfDnYRkrw5cdZd3llDtln3AuzQ4BrFdjivCiFWf48n6s3eQ/RBkQ7/ZSf
         TQvdfcY8jwK0UDni642Z4whvZZ6Cvnz07GMqJR84k5k0Y2azPVCLKiwtkGiV42SsBs
         ReXJtR2Uj5sCg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7JB14tU4107099;
        Mon, 19 Aug 2019 04:01:04 -0700
Date:   Mon, 19 Aug 2019 04:01:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Miles Chen <tipbot@zytor.com>
Message-ID: <tip-ee050dc83bc326ad5ef8ee93bca344819371e7a5@git.kernel.org>
Cc:     mingo@kernel.org, miles.chen@mediatek.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: tglx@linutronix.de, miles.chen@mediatek.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20190815113246.18478-1-miles.chen@mediatek.com>
References: <20190815113246.18478-1-miles.chen@mediatek.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] lib/stackdepot: Fix outdated comments
Git-Commit-ID: ee050dc83bc326ad5ef8ee93bca344819371e7a5
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

Commit-ID:  ee050dc83bc326ad5ef8ee93bca344819371e7a5
Gitweb:     https://git.kernel.org/tip/ee050dc83bc326ad5ef8ee93bca344819371e7a5
Author:     Miles Chen <miles.chen@mediatek.com>
AuthorDate: Thu, 15 Aug 2019 19:32:46 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 19 Aug 2019 12:57:28 +0200

lib/stackdepot: Fix outdated comments

Replace "depot_save_stack" with "stack_depot_save" in code comments because
depot_save_stack() was replaced in commit c0cfc337264c ("lib/stackdepot:
Provide functions which operate on plain storage arrays") and removed in
commit 56d8f079c51a ("lib/stackdepot: Remove obsolete functions")

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190815113246.18478-1-miles.chen@mediatek.com

---
 lib/stackdepot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 66cab785bea0..ed717dd08ff3 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -87,7 +87,7 @@ static bool init_stack_slab(void **prealloc)
 		stack_slabs[depot_index + 1] = *prealloc;
 		/*
 		 * This smp_store_release pairs with smp_load_acquire() from
-		 * |next_slab_inited| above and in depot_save_stack().
+		 * |next_slab_inited| above and in stack_depot_save().
 		 */
 		smp_store_release(&next_slab_inited, 1);
 	}
@@ -114,7 +114,7 @@ static struct stack_record *depot_alloc_stack(unsigned long *entries, int size,
 		depot_offset = 0;
 		/*
 		 * smp_store_release() here pairs with smp_load_acquire() from
-		 * |next_slab_inited| in depot_save_stack() and
+		 * |next_slab_inited| in stack_depot_save() and
 		 * init_stack_slab().
 		 */
 		if (depot_index + 1 < STACK_ALLOC_MAX_SLABS)
