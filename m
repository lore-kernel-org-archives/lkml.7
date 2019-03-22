Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACD3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2B821904
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="Zb6Hg81B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfCVFSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 01:18:49 -0400
Received: from tomli.me ([153.92.126.73]:58774 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727719AbfCVFSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 01:18:46 -0400
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 43220baa;
        Fri, 22 Mar 2019 05:18:44 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:dddb:8cda)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Fri, 22 Mar 2019 05:18:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=MLJ+eN9q2Vru6tsjA4mvWrQPNlupWr+eL239fVtxbxY=; b=Zb6Hg81BEV3jRcHwyOkfaho23AHpl6F3xc9IG572YbQFDumpslFrnjA0R2qtmgJktkwluLUcVYIoAfsxSviSskHh7Lw0FNikgEsUNHijoZKlTxAnU2eNYwci42oBTtRZSCXx/TytyPcwM+34w6RbR7SuaVyfygxfxsX8kcvHxXXyo+1B9LNXBY4jOttApWALfPx1/f9XKrUBGImOppDSdQNrzOXpbMIA2FuWDc7kprfHWxIU9WhDD6kEch3bA/vFvh9uH4ifPe5la2bLEDtUXPXwPdl5xtYqQxNefXkdW8BMTLGh37DsrydV1+54YFq10TA14hh3vVJgljvEnz89Mg==
From:   Yifeng Li <tomli@tomli.me>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Yifeng Li <tomli@tomli.me>
Subject: [PATCH v2 7/7] MAINTAINERS: sm712fb: list myself as one maintainer.
Date:   Fri, 22 Mar 2019 13:17:59 +0800
Message-Id: <20190322051759.15007-8-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322051759.15007-1-tomli@tomli.me>
References: <20190322051759.15007-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have working on the sm712fb driver for a while and have some familiarity
with this hardware, I'll be helping working on and testing problems of this
driver, so add myself to the MAINTAINERS file.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dce5c099f43c..3f6686f0f020 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13871,6 +13871,7 @@ F:	drivers/input/touchscreen/silead.c
 F:	drivers/platform/x86/touchscreen_dmi.c
 
 SILICON MOTION SM712 FRAME BUFFER DRIVER
+M:	Tom Li <tomli@tomli.me>
 M:	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
 M:	Teddy Wang <teddy.wang@siliconmotion.com>
 M:	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
-- 
2.20.1

