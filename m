Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410E4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2875218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bovNm4LX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfCUUKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:10:02 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57504 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfCUUKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:10:01 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2LK9whl115181;
        Thu, 21 Mar 2019 15:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553198998;
        bh=bGm2UFvEMCKtpSVGsH2t6/DZCLjJQ2n4kBrmj3u3r50=;
        h=From:To:CC:Subject:Date;
        b=bovNm4LXMp5tPqMPTEg9sKLhRYxUXwFQsm3F3wYCnNMQEVjJJlw7LM1lQyaegT/7L
         c0VXnqn4jkUdxguMHxymwiJBdjrIhhUaNWA17mPHM3UHmqAHG2rjIO+Sbp1wK2PusY
         dm8Sp/tOAbqXyPYCbMIhJX0oweYm0DIGGQy6j240=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2LK9wO9062010
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Mar 2019 15:09:58 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 21
 Mar 2019 15:09:57 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Thu, 21 Mar 2019 15:09:57 -0500
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2LK9vPB026329;
        Thu, 21 Mar 2019 15:09:57 -0500
Received: from localhost ([10.250.67.168])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x2LK9uU17896;
        Thu, 21 Mar 2019 15:09:57 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 1/2] dma-buf: Remove leftover [un]map_atomic comments
Date:   Thu, 21 Mar 2019 15:09:56 -0500
Message-ID: <20190321200957.16938-1-afd@ti.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The map_atomic/unmap_atomic callbacks have been removed, remove
the related comments.

Fixes: f664a5269542 ("dma-buf: remove kmap_atomic interface")
Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 include/linux/dma-buf.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 58725f890b5b..e4a8dab2bc54 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -39,11 +39,6 @@ struct dma_buf_attachment;
 
 /**
  * struct dma_buf_ops - operations possible on struct dma_buf
- * @map_atomic: [optional] maps a page from the buffer into kernel address
- *		space, users may not block until the subsequent unmap call.
- *		This callback must not sleep.
- * @unmap_atomic: [optional] unmaps a atomically mapped page from the buffer.
- *		  This Callback must not sleep.
  * @map: [optional] maps a page from the buffer into kernel address space.
  * @unmap: [optional] unmaps a page from the buffer.
  * @vmap: [optional] creates a virtual mapping for the buffer into kernel
-- 
2.21.0

