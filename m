Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBC9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C893D20830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbfCZKcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:32:09 -0400
Received: from [217.140.106.54] ([217.140.106.54]:44725 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726111AbfCZKcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:32:09 -0400
Received: from e110455-lin.cambridge.arm.com (e110455-lin.cambridge.arm.com [10.2.131.87])
        by cam-smtp0.cambridge.arm.com (8.13.8/8.13.8) with ESMTP id x2QAW3pf025748;
        Tue, 26 Mar 2019 10:32:03 GMT
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     "James (Qian) Wang" <james.qian.wang@arm.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        Joe Perches <joe@perches.com>, Daniel Vetter <daniel@ffwll.ch>,
        DRI-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH] MAINTAINERS: Fix pattern for Documentation path for Arm Mali Komeda
Date:   Tue, 26 Mar 2019 10:32:03 +0000
Message-Id: <20190326103203.8891-1-Liviu.Dudau@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325233040.30983-1-joe@perches.com>
References: <20190325233040.30983-1-joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Device Tree bindings documentation file is in a simplified path
that doesn't match the MAINTAINERS entry.

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf70b5480..9fa4686212bdd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1167,7 +1167,7 @@ S:	Supported
 T:	git git://linux-arm.org/linux-ld.git for-upstream/mali-dp
 F:	drivers/gpu/drm/arm/display/include/
 F:	drivers/gpu/drm/arm/display/komeda/
-F:	Documentation/devicetree/bindings/display/arm/arm,komeda.txt
+F:	Documentation/devicetree/bindings/display/arm,komeda.txt
 F:	Documentation/gpu/komeda-kms.rst
 
 ARM MALI-DP DRM DRIVER
-- 
2.21.0

