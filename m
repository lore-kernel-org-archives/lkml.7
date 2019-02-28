Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26AFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C195D2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MNBEdyw4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732198AbfB1Lxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:53:54 -0500
Received: from m12-11.163.com ([220.181.12.11]:51474 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbfB1Lxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:53:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=bzKFGYKGHUHEhTS9ro
        OtXBF0XfhAMVzbbepapN3M6s4=; b=MNBEdyw4wTf5gPaOZt6ePUBIdfPydrlVUq
        Aaii86lgNH1daiw0XkvPNUT3wDlCPZVAks5/viWawNXGyoQIFcqcHIdFV5fPXeZL
        +lFgOj/s3lPmxPEKVGQ4C7fv/3HGqoEFn5YQbodvLN9xkf/RReUfDwgQc4omTzqm
        qAeOSXWpc=
Received: from localhost.localdomain (unknown [182.139.212.96])
        by smtp7 (Coremail) with SMTP id C8CowADHEG11y3dc3QnWHg--.19928S2;
        Thu, 28 Feb 2019 19:52:22 +0800 (CST)
From:   WangBo <wdjjwb@163.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        paulmck@linux.ibm.com, wang.bo116@zte.com.cn
Subject: [PATCH] include/linux/types.h: use "unsigned int" instead of "unsigned"
Date:   Thu, 28 Feb 2019 19:52:19 +0800
Message-Id: <1551354739-6648-1-git-send-email-wdjjwb@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: C8CowADHEG11y3dc3QnWHg--.19928S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr4xAw4kAw1xKFy8Zr15CFg_yoW3Arg_Aa
        18Ar4xuw4DXFnavFnrKrW5J345ZrWIqFW8WFn3WFnIqrZFyrW5tw48KFyqvrn3ua13Aw43
        XF4DWryI9r109jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8gzVUUUUUU==
X-Originating-IP: [182.139.212.96]
X-CM-SenderInfo: xzgmy4re6rljoofrz/1tbiEBNpGVWBj8mP2wAAs1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "unsigned int" instead of  "unsigned" ,it make code more clear.

Signed-off-by: WangBo <wang.bo116@zte.com.cn>
---
 include/linux/types.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/types.h b/include/linux/types.h
index c2615d6..cc0dbbe 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -155,9 +155,9 @@ typedef u64 dma_addr_t;
 typedef u32 dma_addr_t;
 #endif
 
-typedef unsigned __bitwise gfp_t;
-typedef unsigned __bitwise slab_flags_t;
-typedef unsigned __bitwise fmode_t;
+typedef unsigned int __bitwise gfp_t;
+typedef unsigned int __bitwise slab_flags_t;
+typedef unsigned int __bitwise fmode_t;
 
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
 typedef u64 phys_addr_t;
-- 
2.7.4


