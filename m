Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D4EC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323B626ABD
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfEaOdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 10:33:43 -0400
Received: from foss.arm.com ([217.140.101.70]:52452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbfEaOdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 10:33:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61CED165C;
        Fri, 31 May 2019 07:33:40 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8AFE53F5AF;
        Fri, 31 May 2019 07:33:38 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH 2/6] mailbox: arm_mhu: reorder header inclusion and drop unneeded ones
Date:   Fri, 31 May 2019 15:33:16 +0100
Message-Id: <20190531143320.8895-3-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531143320.8895-1-sudeep.holla@arm.com>
References: <20190531143320.8895-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch just re-orders some of the headers includes and also drop
the ones that are unnecessary.

Cc: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/arm_mhu.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mailbox/arm_mhu.c b/drivers/mailbox/arm_mhu.c
index 64d85c6a2bdf..747cab1090ff 100644
--- a/drivers/mailbox/arm_mhu.c
+++ b/drivers/mailbox/arm_mhu.c
@@ -13,16 +13,13 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/interrupt.h>
-#include <linux/spinlock.h>
-#include <linux/mutex.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
+#include <linux/amba/bus.h>
+#include <linux/device.h>
 #include <linux/err.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/module.h>
-#include <linux/amba/bus.h>
 #include <linux/mailbox_controller.h>
+#include <linux/module.h>
 
 #define INTR_STAT_OFS	0x0
 #define INTR_SET_OFS	0x8
-- 
2.17.1

