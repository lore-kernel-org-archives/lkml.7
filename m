Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5A5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF06218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="SLdQZ3mH";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="SLdQZ3mH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfCUPlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:41:19 -0400
Received: from node.akkea.ca ([192.155.83.177]:39228 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728420AbfCUPlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:41:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 66EC34E205C;
        Thu, 21 Mar 2019 15:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553182862; bh=4TFo43pNxPR5bE8qq1l7k0ic0qIUblTF7AASecUk58s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SLdQZ3mHo4S8hRTJBvVh/QZEHHiZa3O0FX2aKsI11eki2yvVzY7Y1BnbNca9+VNBN
         HliwiZcRLHlQLxlqpYFln9NmZ9PkHZX+AciXQRo97giJ2xvyIO19EOhcd54UK2aeV9
         Or9srP7OXbI644PdLj+3aRBgpK8vivjiYJmo69EE=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6ZZIeaEe2qqK; Thu, 21 Mar 2019 15:41:02 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 67E5D4E204D;
        Thu, 21 Mar 2019 15:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553182862; bh=4TFo43pNxPR5bE8qq1l7k0ic0qIUblTF7AASecUk58s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SLdQZ3mHo4S8hRTJBvVh/QZEHHiZa3O0FX2aKsI11eki2yvVzY7Y1BnbNca9+VNBN
         HliwiZcRLHlQLxlqpYFln9NmZ9PkHZX+AciXQRo97giJ2xvyIO19EOhcd54UK2aeV9
         Or9srP7OXbI644PdLj+3aRBgpK8vivjiYJmo69EE=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     jic23@kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Tomas Novotny <tomas@novotny.cz>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] dt-bindings: iio: light: add vcnl4000 devicetree bindings
Date:   Thu, 21 Mar 2019 08:40:45 -0700
Message-Id: <20190321154047.23236-4-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190321154047.23236-1-angus@akkea.ca>
References: <20190321154047.23236-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the vishay VCNL4000 devicetree bindings.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 .../bindings/iio/light/vcnl4000.txt           | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4000.txt

diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4000.txt b/Documentation/devicetree/bindings/iio/light/vcnl4000.txt
new file mode 100644
index 000000000000..4a9d558a412a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/vcnl4000.txt
@@ -0,0 +1,22 @@
+VISHAY VCNL4000 -  Ambient Light and proximity sensor
+
+This driver supports the VCNL4000/10/20 and VCNL4200 chips
+
+Required properties:
+
+	-compatible: must be one of :
+        vishay,vcnl4000
+        vishay,vcnl4010
+        vishay,vcnl4020
+        vishay,vcnl4200
+
+	-reg: I2C address of the sensor, should be one from below based on the model:
+        0x13
+        0x51
+
+Example:
+
+light-sensor@51 {
+	compatible = "vishay,vcnl4200";
+	reg = <0x51>;
+};
-- 
2.17.1

