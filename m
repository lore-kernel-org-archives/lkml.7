Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC30C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2651C2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfDPGUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:20:11 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.3]:46072 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726905AbfDPGUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:20:11 -0400
Received: from [85.158.142.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-central-1.aws.symcld.net id ED/88-19557-71475BC5; Tue, 16 Apr 2019 06:20:07 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileJIrShJLcpLzFFi42I5+OG9rq54ydY
  Yg5Yl0hZTHz5hs5h/5ByrRdP31cwW3650MFlc3jWHzWLp9YtMFq17j7A7sHusmbeG0WPnrLvs
  HptWdbJ5fN4kF8ASxZqZl5RfkcCa8XdJE2tBi1RF25fzjA2Mi0S6GLk4hATWMko09nawdDFyA
  jkVEtvezmLvYuTg4BVIl1jZLAkS5hRwlbh8rIkJosRF4sb5a2A2m4CJxKYjexhBbBYBVYnew1
  0sIK3CAuES/5amgoRFBLIl7i47yQ6yillgC6PErg0T2UASvAKCEidnPgFbyywgIXHwxQtmiPl
  6Et2T57GC2BIC9hLT319lhrD1JV5+3cgEYRtKfJ/1jQXCNpf49/4XI4RtLXH9wyy2CYxCs5Cs
  mIVkxQJGplWMlklFmekZJbmJmTm6hgYGuoaGxroGukYmJnqJVbqJeqmlusmpeSVFiUBZvcTyY
  r3iytzknBS9vNSSTYzAeEkpZPiyg3HN8vRDjJIcTEqivHmhW2OE+JLyUyozEosz4otKc1KLDz
  HKcHAoSfAaFALlBItS01Mr0jJzgJELk5bg4FES4f1bBJTmLS5IzC3OTIdInWLU5bh38PlcZiG
  WvPy8VClx3ikgRQIgRRmleXAjYEnkEqOslDAvIwMDgxBPQWpRbmYJqvwrRnEORiVh3maQKTyZ
  eSVwm14BHcEEdMQUndUgR5QkIqSkGhhtnnzM+Twj1+D1bzs1zSPW3P5siX3ZE+T1fvZdnsGyt
  HdNeDafTp5gxifmksMN+1bOe+V1wbtFadPmb3Ec0y1bf9Xtq9ixbneq0qH7Mid/7/j0rHEti6
  CVwBzzrg3veg0e9m9rWX+x6bL3+7z7vRVW88xq7fzmiF96XBJsH+kSE858ttW66ZgSS3FGoqE
  Wc1FxIgBTrvccHQMAAA==
X-Env-Sender: eric.jeong.opensource@diasemi.com
X-Msg-Ref: server-18.tower-229.messagelabs.com!1555395606!4413668!1
X-Originating-IP: [193.240.239.45]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20475 invoked from network); 16 Apr 2019 06:20:07 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (193.240.239.45)
  by server-18.tower-229.messagelabs.com with AES128-SHA256 encrypted SMTP; 16 Apr 2019 06:20:07 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.408.0; Tue, 16 Apr 2019 08:20:06 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22095)      id
 213055F7FF; Tue, 16 Apr 2019 15:20:05 +0900 (KST)
Message-ID: <969035f30e614fd68288a0e21b729ae53ef3fca0.1555389447.git.eric.jeong.opensource@diasemi.com>
In-Reply-To: <cover.1555389447.git.eric.jeong.opensource@diasemi.com>
References: <cover.1555389447.git.eric.jeong.opensource@diasemi.com>
From:   Eric Jeong <eric.jeong.opensource@diasemi.com>
Date:   Tue, 16 Apr 2019 13:37:26 +0900
Subject: [PATCH V1 2/3] Documentation: devicetree: regulator: add binding for
 slg51000
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: NB-EX-CASHUB01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 16.04.2019 01:43:00
X-EXCLAIMER-MD-CONFIG: 8d172408-bd6a-42b1-8e53-daaedf35a5af
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Eric Jeong <eric.jeong.opensource@diasemi.com>

Add device tree binding information for slg51000 regulator driver.


Signed-off-by: Eric Jeong <eric.jeong.opensource@diasemi.com>

---
This patch applies against linux-next and next-20190415


 .../devicetree/bindings/regulator/slg51000.txt     |   88 ++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/slg51000.txt

diff --git a/Documentation/devicetree/bindings/regulator/slg51000.txt b/Documentation/devicetree/bindings/regulator/slg51000.txt
new file mode 100644
index 0000000..aa0733e
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/slg51000.txt
@@ -0,0 +1,88 @@
+* Dialog Semiconductor SLG51000 Voltage Regulator
+
+Required properties:
+- compatible : Should be "dlg,slg51000" for SLG51000
+- reg : Specifies the I2C slave address.
+- xxx-supply: Input voltage supply regulator for ldo3 to ldo7.
+  These entries are required if regulators are enabled for a device.
+  An absence of these properties can cause the regulator registration to fail.
+  If some of input supply is powered through battery or always-on supply then
+  also it is required to have these parameters with proper node handle of always
+  on power supply.
+    vin3-supply: Input supply for ldo3
+    vin4-supply: Input supply for ldo4
+    vin5-supply: Input supply for ldo5
+    vin6-supply: Input supply for ldo6
+    vin7-supply: Input supply for ldo7
+
+Optional properties:
+- interrupt-parent : Specifies the reference to the interrupt controller.
+- interrupts : IRQ line information.
+- dlg,cs-gpios : Specify a valid GPIO for chip select
+
+Sub-nodes:
+- regulators : This node defines the settings for the regulators.
+  The content of the sub-node is defined by the standard binding
+  for regulators; see regulator.txt.
+
+  The SLG51000 regulators are bound using their names listed below:
+    ldo1
+    ldo2
+    ldo3
+    ldo4
+    ldo5
+    ldo6
+    ldo7
+
+Optional properties for regulators:
+- enable-gpios : Specify a valid GPIO for platform control of the regulator.
+
+Example:
+	pmic: slg51000@75 {
+		compatible = "dlg,slg51000";
+		reg = <0x75>;
+
+		regulators {
+			ldo1 {
+			        regulator-name = "ldo1";
+			        regulator-min-microvolt = <2400000>;
+			        regulator-max-microvolt = <3300000>;
+			};
+
+			ldo2 {
+			        regulator-name = "ldo2";
+			        regulator-min-microvolt = <2400000>;
+			        regulator-max-microvolt = <3300000>;
+			};
+
+			ldo3 {
+			        regulator-name = "ldo3";
+			        regulator-min-microvolt = <1200000>;
+			        regulator-max-microvolt = <3750000>;
+			};
+
+			ldo4 {
+			        regulator-name = "ldo4";
+			        regulator-min-microvolt = <1200000>;
+			        regulator-max-microvolt = <3750000>;
+			};
+
+			ldo5 {
+			        regulator-name = "ldo5";
+			        regulator-min-microvolt = <500000>;
+			        regulator-max-microvolt = <1200000>;
+			};
+
+			ldo6 {
+			        regulator-name = "ldo6";
+			        regulator-min-microvolt = <500000>;
+			        regulator-max-microvolt = <1200000>;
+			};
+
+			ldo7 {
+			        regulator-name = "ldo7";
+			        regulator-min-microvolt = <1200000>;
+			        regulator-max-microvolt = <3750000>;
+			};
+		};
+	};
-- 
end-of-patch for PATCH V1

