Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDD6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A942147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WJGzChcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfDDKRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:17:55 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:52463 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbfDDKRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1554373074; x=1585909074;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=5DxTW9PtZZ3mSeHNjENoa9rON7DMLH0EzOwcicSWPsU=;
  b=WJGzChcYqUK/PcrSetPNOracMf1OLHFQH3+f1F9MuCcWZA/4eq9hbvDN
   mRY3B7hkJD0cFy4aZUsq9wE6P7nSy5xD4ZbSL9yvtAKxj1bzZvzN8aGGn
   arbBOfzw1y7D4mafKTeWxPWbNmBLybrZx7bSuQdht/YJqKhVqk0t0KBUw
   8=;
X-IronPort-AV: E=Sophos;i="5.60,308,1549929600"; 
   d="scan'208";a="797408673"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Apr 2019 10:17:24 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x34AHICx010298
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 4 Apr 2019 10:17:21 GMT
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 4 Apr 2019 10:17:20 +0000
Received: from udc4a3e82dbc15a031435.hfa14.amazon.com (10.43.160.69) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 4 Apr 2019 10:17:14 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <talel@amazon.com>, <robh@kernel.org>, <edubezval@gmail.com>,
        <dwmw@amazon.co.uk>, <jonnyc@amazon.com>, <rui.zhang@intel.com>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <hanochu@amazon.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: thermal: al-thermal: Add binding documentation
Date:   Thu, 4 Apr 2019 13:16:55 +0300
Message-ID: <1554373016-1442-2-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554373016-1442-1-git-send-email-talel@amazon.com>
References: <1554373016-1442-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.69]
X-ClientProxiedBy: EX13D25UWC003.ant.amazon.com (10.43.162.129) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add thermal binding documentation for Amazon's Annapurna Labs Thermal
Sensor.

Signed-off-by: Talel Shenhar <talel@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
 .../bindings/thermal/amazon,al-thermal.txt         | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt b/Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
new file mode 100644
index 0000000..af8cf18
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
@@ -0,0 +1,33 @@
+Amazon's Annapurna Labs Thermal Sensor
+
+Simple thermal device that allows temperature reading by a single MMIO
+transaction.
+
+Required properties:
+- compatible: "amazon,al-thermal".
+- reg: The physical base address and length of the sensor's registers.
+- #thermal-sensor-cells: Must be 1. See ./thermal.txt for a description.
+
+Example:
+	thermal: thermal {
+		compatible = "amazon,al-thermal";
+		reg = <0x0 0x05002860 0x0 0x1>;
+		#thermal-sensor-cells = <0x1>;
+	};
+
+	thermal-zones {
+		thermal_z0 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&thermal 0>;
+			trips {
+				thermalz0_crit {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+		};
+	};
+
-- 
2.7.4

