Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF57C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E64214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388170AbfDRGlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:41:32 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.129]:33642 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730682AbfDRGlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:41:31 -0400
Received: from [46.226.53.50] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-c.eu-west-1.aws.symcld.net id 10/16-25548-81C18BC5; Thu, 18 Apr 2019 06:41:28 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleJIrShJLcpLzFFi42I5+OG9rq6EzI4
  Yg++P+CymPnzCZjH/yDlWi6bvq5ktvl3pYLK4vGsOm8XS6xeZLFr3HmF3YPdYM28No8fOWXfZ
  PTat6mTz+LxJLoAlijUzLym/IoE14//9yUwF7VIV0371szQwLhTpYuTiEBJYyyixqnMaaxcjJ
  5BTIfFt/kw2EJtXIF2i/etJJhCbU8BV4tGta1A1LhKfH51gBLHZBEwkNh3ZA2azCKhKvPz2jQ
  XEFhYIlpi7pQ2sXkQgW+LuspPsIMuYBbYwSuzaMBFqgaDEyZlPwBqYBSQkDr54wQyxQE+ie/I
  8sGYJAXuJ6e+vMkPY+hIvv25kgrANJb7PglgmIWAuMfPPHagaa4nrH2axTWAUmoVkxSwkKxYw
  Mq1itEgqykzPKMlNzMzRNTQw0DU0NNI1AtMWeolVusl6qaW65anFJbqGeonlxXrFlbnJOSl6e
  aklmxiBEZNScKJsB+O0FemHGCU5mJREeUtEd8QI8SXlp1RmJBZnxBeV5qQWH2KU4eBQkuA9KA
  2UEyxKTU+tSMvMAcYuTFqCg0dJhHeeFFCat7ggMbc4Mx0idYpRl+PewedzmYVY8vLzUqXEeTe
  DFAmAFGWU5sGNgKWRS4yyUsK8jAwMDEI8BalFuZklqPKvGMU5GJWEeQ+BTOHJzCuB2/QK6Agm
  oCOm6KwGOaIkESEl1cBYM9Pc6/bzB9asBt8/PmAw+N3HKZr9ZMHl3lretUJxOnPC5dPPq3m2K
  p+/oeH526JuWrC3ityUuet3mB6YUTTvq3DW5qaTIsaTPT23n/pmWN83L/33hym54RlR208yxs
  pd2qYxYa7Pf3HPA04STwNkmXSOWJS/Pxhb92rZehmrFxlzVbje3dJVYinOSDTUYi4qTgQAzFh
  2KR4DAAA=
X-Env-Sender: eric.jeong.opensource@diasemi.com
X-Msg-Ref: server-19.tower-302.messagelabs.com!1555569687!6616895!3
X-Originating-IP: [193.240.239.45]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28281 invoked from network); 18 Apr 2019 06:41:28 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (193.240.239.45)
  by server-19.tower-302.messagelabs.com with AES128-SHA256 encrypted SMTP; 18 Apr 2019 06:41:28 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.408.0; Thu, 18 Apr 2019 08:41:26 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22095)      id
 C16FC5F7FE; Thu, 18 Apr 2019 15:41:24 +0900 (KST)
Message-ID: <bbf407bfb94fb10e61a8e6aabbbde62395db3034.1555567784.git.eric.jeong.opensource@diasemi.com>
In-Reply-To: <cover.1555567784.git.eric.jeong.opensource@diasemi.com>
References: <cover.1555567784.git.eric.jeong.opensource@diasemi.com>
From:   Eric Jeong <eric.jeong.opensource@diasemi.com>
Date:   Thu, 18 Apr 2019 15:09:44 +0900
Subject: [PATCH V2 2/3] dt-bindings: regulator: add document bindings for
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
X-KSE-Antivirus-Info: Clean, bases: 18.04.2019 02:42:00
X-EXCLAIMER-MD-CONFIG: 8d172408-bd6a-42b1-8e53-daaedf35a5af
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Add device tree binding information for slg51000 regulator driver.
Example bindings for SLG51000 are added.

Signed-off-by: Eric Jeong <eric.jeong.opensource@diasemi.com>

---
This patch applies against linux-next and next-20190417

v2: No changes.


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
end-of-patch for PATCH V2

