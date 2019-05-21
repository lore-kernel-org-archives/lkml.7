Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7391AC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539B2217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfEUN2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 09:28:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728415AbfEUN2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:28:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C878D300BEAA;
        Tue, 21 May 2019 13:28:14 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-116-49.ams2.redhat.com [10.36.116.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2ECE6610A1;
        Tue, 21 May 2019 13:28:10 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        KT Liao <kt.liao@emc.com.tw>, Rob Herring <robh+dt@kernel.org>,
        Aaron Ma <aaron.ma@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 10/10] Input: elantech: remove P52 from SMBus blacklist
Date:   Tue, 21 May 2019 15:27:12 +0200
Message-Id: <20190521132712.2818-11-benjamin.tissoires@redhat.com>
In-Reply-To: <20190521132712.2818-1-benjamin.tissoires@redhat.com>
References: <20190521132712.2818-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 21 May 2019 13:28:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The P52 now works correctly over SMBus. Let's use this driver so we can
update all five fingers every 8ms.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

--

new in v2
---
 drivers/input/mouse/elantech.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index ca10fd97d9d5..4a41e5f3074e 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1779,8 +1779,6 @@ static const char * const i2c_blacklist_pnp_ids[] = {
 	 * These are known to not be working properly as bits are missing
 	 * in elan_i2c.
 	 */
-	"LEN2131", /* ThinkPad P52 w/ NFC */
-	"LEN2132", /* ThinkPad P52 */
 	"LEN2133", /* ThinkPad P72 w/ NFC */
 	"LEN2134", /* ThinkPad P72 */
 	NULL
-- 
2.21.0

