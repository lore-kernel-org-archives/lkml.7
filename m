Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFDEC31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6502084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfFQOCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:02:24 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:51638 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfFQOCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:02:24 -0400
Received: from ramsan ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id Rq2P2000C3XaVaC01q2PNo; Mon, 17 Jun 2019 16:02:23 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcsDH-0002Ap-7r; Mon, 17 Jun 2019 16:02:23 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcsDH-0000EV-6R; Mon, 17 Jun 2019 16:02:23 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] usb: isp1362: Spelling s/eclusive/exclusive/
Date:   Mon, 17 Jun 2019 16:02:22 +0200
Message-Id: <20190617140222.845-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/usb/host/isp1362.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/isp1362.h b/drivers/usb/host/isp1362.h
index 650240846ee22350..4c49688a069d1d5d 100644
--- a/drivers/usb/host/isp1362.h
+++ b/drivers/usb/host/isp1362.h
@@ -11,7 +11,7 @@
 
 #define USE_32BIT		0
 
-/* These options are mutually eclusive */
+/* These options are mutually exclusive */
 #define USE_PLATFORM_DELAY	0
 #define USE_NDELAY		0
 
-- 
2.17.1

