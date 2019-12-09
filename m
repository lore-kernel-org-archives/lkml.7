Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A18C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38094207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfLIJjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:39:24 -0500
Received: from foss.arm.com ([217.140.110.172]:53430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727578AbfLIJjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:39:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5B00328;
        Mon,  9 Dec 2019 01:39:21 -0800 (PST)
Received: from e123648.NAT.warszawa.vectranet.pl (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D0E143F6CF;
        Mon,  9 Dec 2019 01:39:19 -0800 (PST)
From:   lukasz.luba@arm.com
To:     linux-kernel@vger.kernel.org, krzk@kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, Dietmar.Eggemann@arm.com,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH] MAINTAINERS: update my email address
Date:   Mon,  9 Dec 2019 09:39:07 +0000
Message-Id: <20191209093907.6646-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukasz Luba <lukasz.luba@arm.com>

Update my email address to @arm.com in MAINTAINERS and map it correctly
in .mailmap file.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
Hi Krzysztof,

Could you pick it up, please?
It is based on tag v5.5-rc1.

Regards,
Lukasz

 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index c24773db04a7..6adff2db7076 100644
--- a/.mailmap
+++ b/.mailmap
@@ -152,6 +152,7 @@ Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@web.de>
 Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@ascom.ch>
 Li Yang <leoyang.li@nxp.com> <leo@zh-kernel.org>
 Li Yang <leoyang.li@nxp.com> <leoli@freescale.com>
+Lukasz Luba <lukasz.luba@arm.com> <l.luba@partner.samsung.com>
 Maciej W. Rozycki <macro@mips.com> <macro@imgtec.com>
 Marc Zyngier <maz@kernel.org> <marc.zyngier@arm.com>
 Marcin Nowakowski <marcin.nowakowski@mips.com> <marcin.nowakowski@imgtec.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index bd5847e802de..e3626bacea40 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4999,7 +4999,7 @@ F:	include/linux/dma-mapping.h
 F:	include/linux/dma-noncoherent.h
 
 DMC FREQUENCY DRIVER FOR SAMSUNG EXYNOS5422
-M:	Lukasz Luba <l.luba@partner.samsung.com>
+M:	Lukasz Luba <lukasz.luba@arm.com>
 L:	linux-pm@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
-- 
2.17.1

