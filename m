Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E19C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D613A20881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="OfaJYQTl";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="OfaJYQTl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfLBPel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 10:34:41 -0500
Received: from node.akkea.ca ([192.155.83.177]:57856 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727445AbfLBPel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 10:34:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id A4CEB4E201D;
        Mon,  2 Dec 2019 15:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1575300330; bh=iHgUsViNgJaJu51knhIGUnBoTr/el9Xe/qUZYMfe4Kw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OfaJYQTlZ+DVHsr6F2rntHFbnPkuUhcEIY4rZlHbBKirHYBTXK0byFY8PIjxEu0/X
         E/YbbAzQa2L1ixW0NBsn/5JGdYx+OX3XQ5lIi3ROpXKw+4FeJsp9Kl795g/1R+r0ij
         GSm9EOBPSRkbMzrwkTwEmsCNgeN5+euUNlPjlINU=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XEeBMcwq-AS1; Mon,  2 Dec 2019 15:25:30 +0000 (UTC)
Received: from thinkpad-tablet.cg.shawcable.net (S0106905851b613e9.cg.shawcable.net [70.77.244.40])
        by node.akkea.ca (Postfix) with ESMTPSA id C05364E2003;
        Mon,  2 Dec 2019 15:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1575300330; bh=iHgUsViNgJaJu51knhIGUnBoTr/el9Xe/qUZYMfe4Kw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OfaJYQTlZ+DVHsr6F2rntHFbnPkuUhcEIY4rZlHbBKirHYBTXK0byFY8PIjxEu0/X
         E/YbbAzQa2L1ixW0NBsn/5JGdYx+OX3XQ5lIi3ROpXKw+4FeJsp9Kl795g/1R+r0ij
         GSm9EOBPSRkbMzrwkTwEmsCNgeN5+euUNlPjlINU=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm, "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH 2/2] dts: bindings: max17042_battery: add all of the compatible strings
Date:   Mon,  2 Dec 2019 08:25:20 -0700
Message-Id: <20191202152520.27558-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202152520.27558-1-angus@akkea.ca>
References: <20191202152520.27558-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings are missing documentation for some of the compatible
strings.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 .../devicetree/bindings/power/supply/max17042_battery.txt   | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/max17042_battery.txt b/Documentation/devicetree/bindings/power/supply/max17042_battery.txt
index 3f3894aaeebc..f34c5daae9af 100644
--- a/Documentation/devicetree/bindings/power/supply/max17042_battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/max17042_battery.txt
@@ -2,7 +2,11 @@ max17042_battery
 ~~~~~~~~~~~~~~~~
 
 Required properties :
- - compatible : "maxim,max17042"
+ - compatible : one of the following
+ * "maxim,max17042"
+ * "maxim,max17047"
+ * "maxim,max17050"
+ * "maxim,max17055"
 
 Optional properties :
  - maxim,rsns-microohm : Resistance of rsns resistor in micro Ohms
-- 
2.17.1

