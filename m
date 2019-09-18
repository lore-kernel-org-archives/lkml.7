Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37651C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F052218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfIRH2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 03:28:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2293 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbfIRH2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 03:28:42 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D4A91B9F413254FC2720;
        Wed, 18 Sep 2019 15:28:40 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 18 Sep 2019
 15:28:35 +0800
Subject: [PATCH] genirq: modify the comment for irq_desc
From:   Yunfeng Ye <yeyunfeng@huawei.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <longman@redhat.com>,
        <dbueso@suse.de>, <julien.thierry.kdev@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <trivial@kernel.org>
References: <f31aba98-5abe-6719-1490-cb249cfe0f08@huawei.com>
Message-ID: <658460cf-493e-8afc-b9fd-364e5f158924@huawei.com>
Date:   Wed, 18 Sep 2019 15:28:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f31aba98-5abe-6719-1490-cb249cfe0f08@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 0c6f8a8b917a ("genirq: Remove compat code") deleted the @status
member of irq_desc, but forgot to update the comment.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 include/linux/irqdesc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index d6e2ab5..8f2820c 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -24,7 +24,7 @@
  * @handle_irq:		highlevel irq-events handler
  * @preflow_handler:	handler called before the flow handler (currently used by sparc)
  * @action:		the irq action chain
- * @status:		status information
+ * @status_use_accessors: status information
  * @core_internal_state__do_not_mess_with_it: core internal status information
  * @depth:		disable-depth, for nested irq_disable() calls
  * @wake_depth:		enable depth, for multiple irq_set_irq_wake() callers
-- 
1.8.3.1


