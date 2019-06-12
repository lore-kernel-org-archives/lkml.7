Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14380C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED7520874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MWV7D1HO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406351AbfFLMeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:34:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35541 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436780AbfFLMeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:34:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5CCXP6x686190
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 12 Jun 2019 05:33:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5CCXP6x686190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560342805;
        bh=heUv8g1Lo0VGhf+7d8xUpZm7lB3UEWy7Zfl4IniEKrw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=MWV7D1HO7jsiq7pfDzrcU6M7ZrADYqcsi+5tsR5RQBjurC3ZSvfv5bsnWeIg/Gyld
         ezCTe41HmNq5iv6X5SOSnJXytlcaoEQFsE0IL83qynFqj0SWN4lMwdBHnnGZ/UyFtE
         ZRAT65D8AW001gogaSfOrdr1XnF3agR/LmaDSlDHV0UV+9zXsSJfVFOKbAvUTDWNAB
         JY6U/AbKTCpebc4pPKC0uvz7dFmrxxEARKunDU0bQbT8mKzwBsd8xW0ocqS19/XoGp
         WR+5WTBRcODmOIdBUVO8z74cJN/wOzS3QvR4L7IDqaN29zFlGl+jgg3TZGg4xKKsm0
         visETQ9zVBPbg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5CCXOJl686187;
        Wed, 12 Jun 2019 05:33:24 -0700
Date:   Wed, 12 Jun 2019 05:33:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Minwoo Im <tipbot@zytor.com>
Message-ID: <tip-0e51833042fccfe882ef3e85a346252550d26c22@git.kernel.org>
Cc:     minwoo.im.dev@gmail.com, ming.lei@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        minwoo.im@samsung.com, hpa@zytor.com
Reply-To: minwoo.im.dev@gmail.com, tglx@linutronix.de, ming.lei@redhat.com,
          minwoo.im@samsung.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20190602112117.31839-1-minwoo.im.dev@gmail.com>
References: <20190602112117.31839-1-minwoo.im.dev@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/affinity: Remove unused argument from
 [__]irq_build_affinity_masks()
Git-Commit-ID: 0e51833042fccfe882ef3e85a346252550d26c22
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

Commit-ID:  0e51833042fccfe882ef3e85a346252550d26c22
Gitweb:     https://git.kernel.org/tip/0e51833042fccfe882ef3e85a346252550d26c22
Author:     Minwoo Im <minwoo.im.dev@gmail.com>
AuthorDate: Sun, 2 Jun 2019 20:21:17 +0900
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 12 Jun 2019 10:52:45 +0200

genirq/affinity: Remove unused argument from [__]irq_build_affinity_masks()

The *affd argument is neither used in irq_build_affinity_masks() nor
__irq_build_affinity_masks(). Remove it.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Cc: Minwoo Im <minwoo.im@samsung.com>
Cc: linux-block@vger.kernel.org
Link: https://lkml.kernel.org/r/20190602112117.31839-1-minwoo.im.dev@gmail.com

---
 kernel/irq/affinity.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index f18cd5aa33e8..4352b08ae48d 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -94,8 +94,7 @@ static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
 	return nodes;
 }
 
-static int __irq_build_affinity_masks(const struct irq_affinity *affd,
-				      unsigned int startvec,
+static int __irq_build_affinity_masks(unsigned int startvec,
 				      unsigned int numvecs,
 				      unsigned int firstvec,
 				      cpumask_var_t *node_to_cpumask,
@@ -171,8 +170,7 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
  *	1) spread present CPU on these vectors
  *	2) spread other possible CPUs on these vectors
  */
-static int irq_build_affinity_masks(const struct irq_affinity *affd,
-				    unsigned int startvec, unsigned int numvecs,
+static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
 				    unsigned int firstvec,
 				    struct irq_affinity_desc *masks)
 {
@@ -197,7 +195,7 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
 	build_node_to_cpumask(node_to_cpumask);
 
 	/* Spread on present CPUs starting from affd->pre_vectors */
-	nr_present = __irq_build_affinity_masks(affd, curvec, numvecs,
+	nr_present = __irq_build_affinity_masks(curvec, numvecs,
 						firstvec, node_to_cpumask,
 						cpu_present_mask, nmsk, masks);
 
@@ -212,7 +210,7 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
 	else
 		curvec = firstvec + nr_present;
 	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
-	nr_others = __irq_build_affinity_masks(affd, curvec, numvecs,
+	nr_others = __irq_build_affinity_masks(curvec, numvecs,
 					       firstvec, node_to_cpumask,
 					       npresmsk, nmsk, masks);
 	put_online_cpus();
@@ -295,7 +293,7 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 		unsigned int this_vecs = affd->set_size[i];
 		int ret;
 
-		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
+		ret = irq_build_affinity_masks(curvec, this_vecs,
 					       curvec, masks);
 		if (ret) {
 			kfree(masks);
