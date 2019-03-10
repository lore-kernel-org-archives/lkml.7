Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FFCC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12EC620657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfCJQYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 12:24:45 -0400
Received: from shell.v3.sk ([90.176.6.54]:45089 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfCJQYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 12:24:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 87506102CB9;
        Sun, 10 Mar 2019 17:24:40 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id kT1mOd_heSw3; Sun, 10 Mar 2019 17:24:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id BD62B102CB2;
        Sun, 10 Mar 2019 17:24:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8qaIYXl4m-H0; Sun, 10 Mar 2019 17:24:28 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 64088102CA4;
        Sun, 10 Mar 2019 17:24:28 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Darren Hart <dvhart@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 01/10] dt-bindings: olpc_battery: Add XO-1.5 battery
Date:   Sun, 10 Mar 2019 17:24:10 +0100
Message-Id: <20190310162419.11861-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190310162419.11861-1-lkundrak@v3.sk>
References: <20190310162419.11861-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XO-1 and XO-1.5 batteries apparently differ in an ability to report
ambient temperature.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

---
Changes since v1:
- Collected Reviewed-by and Acked-by tags

 Documentation/devicetree/bindings/power/supply/olpc_battery.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/olpc_battery.=
txt b/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
index c8901b3992d9..8d87d6b35a98 100644
--- a/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
@@ -2,4 +2,4 @@ OLPC battery
 ~~~~~~~~~~~~
=20
 Required properties:
-  - compatible : "olpc,xo1-battery"
+  - compatible : "olpc,xo1-battery" or "olpc,xo1.5-battery"
--=20
2.20.1

