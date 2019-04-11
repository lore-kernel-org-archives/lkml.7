Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F061C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCB82133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Rr0akxD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfDKKZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:25:32 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:35858 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKKZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1554978330; x=1586514330;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=ewHfeHaZGCcbtoMonZP3Mqcm8V5hUOP6oD7ibYxYroA=;
  b=Rr0akxD4UUAkqlE3p/T3rLar8fpbC2UGeo+ES2OPrrcGJQIZSSr5RGTn
   XPwROryxnDWu/VrlL/YNi/olk7Do8L95zld6oeG03njZZ0enBzJTTaYqp
   kPihzVegZgOrPGrCQ5g/89eX8EuM2ZOoieyRMLMPRqdGPVE91Kw3Jn3f+
   Q=;
X-IronPort-AV: E=Sophos;i="5.60,337,1549929600"; 
   d="scan'208";a="793572855"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Apr 2019 10:23:31 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x3BAN9PI109976
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 11 Apr 2019 10:23:12 GMT
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Apr 2019 10:23:11 +0000
Received: from udc4a3e82dbc15a031435.hfa14.amazon.com (10.43.160.69) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Apr 2019 10:23:04 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <talel@amazon.com>, <robh@kernel.org>, <edubezval@gmail.com>,
        <dwmw@amazon.co.uk>, <jonnyc@amazon.com>, <rui.zhang@intel.com>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <hanochu@amazon.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: thermal: al-thermal: Add binding documentation
Date:   Thu, 11 Apr 2019 13:22:47 +0300
Message-ID: <1554978168-17369-2-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554978168-17369-1-git-send-email-talel@amazon.com>
References: <1554978168-17369-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.69]
X-ClientProxiedBy: EX13D15UWB001.ant.amazon.com (10.43.161.254) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add thermal binding documentation for Amazon's Annapurna Labs Thermal
Sensor.

Signed-off-by: Talel Shenhar <talel@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/thermal/amazon,al-thermal.txt         | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt b/Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
new file mode 100644
index 0000000..703979d
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
+		thermal-z0 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&thermal 0>;
+			trips {
+				critical {
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

