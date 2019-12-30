Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE78C2D0DA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 08:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A8D208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 08:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577694236;
	bh=bxf8EZJDD9igkh37WLh+g0Si6gef3N0HX1lUMypoJt8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=KiBnkZqjqY/zAgBGyn91g/+NUXVTvQqAc3yXshUNdR2a83aED8KSyF/W/3tupcZ+5
	 1Q/Lig8jCCxNgx13Vtw5zO/EuTlMPzJWeHaeVsbSiwsmFt30wCwzUDu7LNB0fqxpb4
	 XduSP2XhAmwWRYDBhFXnqWpozAkcZ+ioCXmlIpv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfL3IXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 03:23:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:47566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbfL3IXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 03:23:54 -0500
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C939220748;
        Mon, 30 Dec 2019 08:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577694234;
        bh=bxf8EZJDD9igkh37WLh+g0Si6gef3N0HX1lUMypoJt8=;
        h=From:To:Cc:Subject:Date:From;
        b=W+8GXso80Dwc/3pFcCMN0HfMHf1aM3LMavYJbUL8UziJS+fG0RxQevVHV9AG5kza1
         wB3ArfXjh2mYXmaM+swivMWpI4CEpXYJfOVmhAIxRBM0ijXq3h/I7fe66vSvAaHiD1
         AG17nFdPOMT3TsRjvVHzY2M38nTRhB5Nt3ooty+g=
From:   guoren@kernel.org
To:     linux-csky@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 1/5] MAINTAINERS: csky: Add mailing list for csky
Date:   Mon, 30 Dec 2019 16:23:27 +0800
Message-Id: <20191230082331.30976-1-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Add mailing list and it's convenient for maintain C-SKY
subsystem.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e4f170d8bc29..1b0e8dcefb94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3553,6 +3553,7 @@ F:	sound/pci/oxygen/
 
 C-SKY ARCHITECTURE
 M:	Guo Ren <guoren@kernel.org>
+L:	linux-csky@vger.kernel.org
 T:	git https://github.com/c-sky/csky-linux.git
 S:	Supported
 F:	arch/csky/
-- 
2.17.0

