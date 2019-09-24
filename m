Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B27BC432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 06:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA4020673
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 06:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440536AbfIXG23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 02:28:29 -0400
Received: from comms.puri.sm ([159.203.221.185]:38336 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393474AbfIXG22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 02:28:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 8A2F3E0026;
        Mon, 23 Sep 2019 23:28:28 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nPWPNiR57Mq3; Mon, 23 Sep 2019 23:28:27 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     corbet@lwn.net, will@kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH 2/2] CREDITS: update email address for Martin Kepplinger
Date:   Tue, 24 Sep 2019 08:28:03 +0200
Message-Id: <20190924062803.3772-2-martin.kepplinger@puri.sm>
In-Reply-To: <20190924062803.3772-1-martin.kepplinger@puri.sm>
References: <20190924062803.3772-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Employers change - Linux stays. Also, add my (long time valid) GPG key
fingerprint to the contact details.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 CREDITS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 8b67a85844b5..53c556a0c54e 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1871,8 +1871,9 @@ S: The Netherlands
 
 N: Martin Kepplinger
 E: martink@posteo.de
-E: martin.kepplinger@ginzinger.com
+E: martin.kepplinger@puri.sm
 W: http://www.martinkepplinger.com
+P: 4096R/5AB387D3 F208 2B88 0F9E 4239 3468  6E3F 5003 98DF 5AB3 87D3
 D: mma8452 accelerators iio driver
 D: pegasus_notetaker input driver
 D: Kernel fixes and cleanups
-- 
2.20.1

