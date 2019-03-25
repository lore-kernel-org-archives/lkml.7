Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E07C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F81205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbfCYV7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:59:35 -0400
Received: from muru.com ([72.249.23.125]:42682 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730790AbfCYV73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:59:29 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id DA99881CC;
        Mon, 25 Mar 2019 21:59:41 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 14/14] bus: ti-sysc: Detect DMIC for debugging
Date:   Mon, 25 Mar 2019 14:58:49 -0700
Message-Id: <20190325215849.13182-15-tony@atomide.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325215849.13182-1-tony@atomide.com>
References: <20190325215849.13182-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detect DMIC to see what we have connected if config DEBUG is enabled.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -999,6 +999,7 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 		   0xffff00f0, 0),
 	SYSC_QUIRK("dcan", 0, 0, -1, -1, 0xffffffff, 0xffffffff, 0),
 	SYSC_QUIRK("dcan", 0, 0, -1, -1, 0x00001401, 0xffffffff, 0),
+	SYSC_QUIRK("dmic", 0, 0, 0x10, -1, 0x50010000, 0xffffffff, 0),
 	SYSC_QUIRK("dwc3", 0, 0, 0x10, -1, 0x500a0200, 0xffffffff, 0),
 	SYSC_QUIRK("epwmss", 0, 0, 0x4, -1, 0x47400001, 0xffffffff, 0),
 	SYSC_QUIRK("gpu", 0, 0x1fc00, 0x1fc10, -1, 0, 0, 0),
-- 
2.21.0
