Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9CAC31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5852183F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560892098;
	bh=xntHe4RWyoCFyTJYvldfqXVJY2+xzaowu4my2cfwFuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XcfeAhiNuoTfeGNPWXy6h0rauH9KQtEgFIJUzbIUfo6YKSw9XivY7vkqdPEaL224v
	 hBiuJVaO9lC0Qk3BlpQFU+GpGVGhpwFfx1z31Fca4H+W56yoocXIA3sR3yG6rEbrh6
	 oHtD5oFGLXFAlB9TYEJvs3X65eFOqe+NzM2Q8+0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731194AbfFRVIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 17:08:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34442 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730761AbfFRVFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 17:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=329rCUqApFVAbejJdpmkt0hVW4Z1MhYzPyBEH8+Oq+Y=; b=jyS71AnECKgcKcqbtejAWBnjjl
        ogMpoVlL+mFgLnnYQ95dIoI7qjZqMhsJlVPsvRNOvz69NobDMCOGkIMeRESckl0J1sF6wZNTTsyQ8
        /R2+w9/t35j2yyEyZLGLlvGSgUtb0z8HWMgF5LBj1gkLdHasz3HpsnlnvfSU5OL/Cs9hjnJFnXo6U
        eci2YZKJ+7/4aleE8789m5YJe4X9e2oYCPLVkZFM0gioa2TgjKrCYex+SjihEift1Y0YcuoWw6VmW
        U8mhT1eRNRssPfBJcWhGuhLJgnD0BAxDcCimg7BD6J/cg26d3Khg+LJu10ydBOXyjEreQ8Got2LNz
        AeEsLGbg==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdLIc-0006yj-4C; Tue, 18 Jun 2019 21:05:50 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hdLIa-0002Cs-2h; Tue, 18 Jun 2019 18:05:48 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 16/22] docs: driver-api: add xilinx driver API documentation
Date:   Tue, 18 Jun 2019 18:05:40 -0300
Message-Id: <df317331caeb27702ad501bad2d5f46eee7f177e.1560891322.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560891322.git.mchehab+samsung@kernel.org>
References: <cover.1560891322.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current file there (emmi) provides a description of
the driver uAPI and kAPI.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/driver-api/index.rst              | 1 +
 Documentation/{ => driver-api}/xilinx/eemi.rst  | 0
 Documentation/{ => driver-api}/xilinx/index.rst | 1 -
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/{ => driver-api}/xilinx/eemi.rst (100%)
 rename Documentation/{ => driver-api}/xilinx/index.rst (94%)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 492b96003af2..6935d973ff5b 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -124,6 +124,7 @@ available subsections can be seen below.
    unaligned-memory-access
    vfio
    vfio-mediated-device
+   xilinx/index
    xillybus
    xz
    zorro
diff --git a/Documentation/xilinx/eemi.rst b/Documentation/driver-api/xilinx/eemi.rst
similarity index 100%
rename from Documentation/xilinx/eemi.rst
rename to Documentation/driver-api/xilinx/eemi.rst
diff --git a/Documentation/xilinx/index.rst b/Documentation/driver-api/xilinx/index.rst
similarity index 94%
rename from Documentation/xilinx/index.rst
rename to Documentation/driver-api/xilinx/index.rst
index 01cc1a0714df..13f7589ed442 100644
--- a/Documentation/xilinx/index.rst
+++ b/Documentation/driver-api/xilinx/index.rst
@@ -1,4 +1,3 @@
-:orphan:
 
 ===========
 Xilinx FPGA
-- 
2.21.0

