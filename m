Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111BAC43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 15:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9686214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 15:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="O3/7BTbB";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="ZsRuzvtw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfLNP2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 10:28:44 -0500
Received: from node.akkea.ca ([192.155.83.177]:55528 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbfLNP2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 10:28:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 162E54E200E;
        Sat, 14 Dec 2019 15:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1576337321; bh=s9cS0kOUcH2uE/d4ffbDRkm1lMRvgvsU6VbvQ8wFuRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=O3/7BTbBGpFJxy94eoDljHn6nK/OBQNdb2oV4uqP7uwqJuuUTYFcVITIRu/JBTwPb
         y8USBYyISoqp1zeYrAqGmsYpnpLpLsILwKcP1g4/64Z7wM8eQxk1EpuVIMSf0hTCPz
         M9M/55MSrGg951UtM7iCK6ZIyI277waib6Yo3o6g=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DAF4LvUi9G-W; Sat, 14 Dec 2019 15:28:40 +0000 (UTC)
Received: from thinkpad-tablet.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 8D4294E2003;
        Sat, 14 Dec 2019 15:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1576337320; bh=s9cS0kOUcH2uE/d4ffbDRkm1lMRvgvsU6VbvQ8wFuRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZsRuzvtw+LCX7rYvFeWI4OqJ9TaFSXrIG+TGs9wKLozFdh+bdOTOTuajepkcFjoTJ
         7h0uczEL7eyjVwlF7f1KE5b0cOuYvtKfyAHdjrbY2rT/qFXpc/a/7yzlx6qsF/Ig2i
         KjfcuQzBJT9v36Jf+2yYzICz2+TisxOznNY6KqhQ=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     krzk@kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm, "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v2 2/2] device-tree: bindings: max17042_battery: add all of the compatible strings
Date:   Sat, 14 Dec 2019 07:27:55 -0800
Message-Id: <20191214152755.25138-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191214152755.25138-1-angus@akkea.ca>
References: <20191214152755.25138-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings are missing documentation for some of the compatible
strings.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
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

