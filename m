Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF95C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B8A214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="OT0OSOhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfCLJQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:16:10 -0400
Received: from forward101o.mail.yandex.net ([37.140.190.181]:60703 "EHLO
        forward101o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726597AbfCLJQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:16:09 -0400
Received: from mxback4j.mail.yandex.net (mxback4j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10d])
        by forward101o.mail.yandex.net (Yandex) with ESMTP id EE0AF3C01B81;
        Tue, 12 Mar 2019 12:16:04 +0300 (MSK)
Received: from smtp1j.mail.yandex.net (smtp1j.mail.yandex.net [2a02:6b8:0:801::ab])
        by mxback4j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 2UVJOtG89k-G4gCnnQC;
        Tue, 12 Mar 2019 12:16:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1552382164;
        bh=ya+hjTTpaU5sZx1o2lpk6Fl32GWJrnkjDTIHBZ4pNpQ=;
        h=In-Reply-To:Subject:To:From:Message-Id:Cc:References:Date;
        b=OT0OSOhYq6ARD9sqnF1T2KyQbYPPlW2HWsZzS1IkVVp0KIajCm+jlPpMEqE2S8ynA
         tXhUn+c+MFhitt8t9cCPn3NqEsVHMA1hf1iy/KzbnfevG/bMtyq7pKtdLvnaI+ORKn
         TScB48p6YHI5w5uhZroQkYu286WdRK5xL/C4AI5g=
Authentication-Results: mxback4j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id HHvVQer8fs-G0dKOB0B;
        Tue, 12 Mar 2019 12:16:03 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     paul.burton@mips.com, keguang.zhang@gmail.com,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 4/4] MIPS: Loongson32: dts: add ls1b & ls1c
Date:   Tue, 12 Mar 2019 17:15:20 +0800
Message-Id: <20190312091520.8863-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312091520.8863-1-jiaxun.yang@flygoat.com>
References: <20190312091520.8863-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree skeleton for ls1b and ls1c

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/boot/dts/loongson/Makefile  |   6 ++
 arch/mips/boot/dts/loongson/ls1b.dts  |  21 +++++
 arch/mips/boot/dts/loongson/ls1c.dts  |  25 ++++++
 arch/mips/boot/dts/loongson/ls1x.dtsi | 117 ++++++++++++++++++++++++++
 4 files changed, 169 insertions(+)
 create mode 100644 arch/mips/boot/dts/loongson/Makefile
 create mode 100644 arch/mips/boot/dts/loongson/ls1b.dts
 create mode 100644 arch/mips/boot/dts/loongson/ls1c.dts
 create mode 100644 arch/mips/boot/dts/loongson/ls1x.dtsi

diff --git a/arch/mips/boot/dts/loongson/Makefile b/arch/mips/boot/dts/loongson/Makefile
new file mode 100644
index 000000000000..447801568f33
--- /dev/null
+++ b/arch/mips/boot/dts/loongson/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_LOONGSON1_LS1B)	+= ls1b.dtb
+
+dtb-$(CONFIG_LOONGSON1_LS1B)	+= ls1c.dtb
+
+obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/loongson/ls1b.dts b/arch/mips/boot/dts/loongson/ls1b.dts
new file mode 100644
index 000000000000..6d40dc502acf
--- /dev/null
+++ b/arch/mips/boot/dts/loongson/ls1b.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+/dts-v1/;
+#include <ls1x.dtsi>
+
+/ {
+	model = "Loongson LS1B";
+	compatible = "loongson,ls1b";
+
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
\ No newline at end of file
diff --git a/arch/mips/boot/dts/loongson/ls1c.dts b/arch/mips/boot/dts/loongson/ls1c.dts
new file mode 100644
index 000000000000..778d205a586e
--- /dev/null
+++ b/arch/mips/boot/dts/loongson/ls1c.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+/dts-v1/;
+#include <ls1x.dtsi>
+
+/ {
+	model = "Loongson LS1C300A";
+	compatible = "loongson,ls1c300a";
+
+};
+
+&platintc4 {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
\ No newline at end of file
diff --git a/arch/mips/boot/dts/loongson/ls1x.dtsi b/arch/mips/boot/dts/loongson/ls1x.dtsi
new file mode 100644
index 000000000000..f808e4328fd8
--- /dev/null
+++ b/arch/mips/boot/dts/loongson/ls1x.dtsi
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+/dts-v1/;
+#include <dt-bindings/interrupt-controller/irq.h>
+
+
+/ {
+    #address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			reg = <0>;
+		};
+	};
+
+	cpu_intc: interrupt-controller {
+		#address-cells = <0>;
+		compatible = "mti,cpu-interrupt-controller";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		compatible = "simple-bus";
+		ranges;
+
+
+		platintc0: interrupt-controller@1fd01040 {
+			compatible = "loongson,ls1x-intc";
+			reg = <0x1fd01040 0x18>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <2>;
+		};
+
+		platintc1: interrupt-controller@1fd01058 {
+			compatible = "loongson,ls1x-intc";
+			reg = <0x1fd01058 0x18>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <3>;
+		};
+
+		platintc2: interrupt-controller@1fd01070 {
+			compatible = "loongson,ls1x-intc";
+			reg = <0x1fd01070 0x18>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <4>;
+		};
+
+		platintc3: interrupt-controller@1fd01088 {
+			compatible = "loongson,ls1x-intc";
+			reg = <0x1fd01088 0x18>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <5>;
+		};
+
+		platintc4: interrupt-controller@1fd010a0 {
+			compatible = "loongson,ls1x-intc";
+			reg = <0x1fd010a0 0x18>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <6>;
+
+	    status = "disabled";
+		};
+
+		ehci0: usb@1fe20000 {
+			compatible = "generic-ehci";
+			reg = <0x1fe20000 0x100>;
+			interrupt-parent = <&platintc1>;
+			interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+
+	    status = "disabled";
+			};
+
+		ohci0: usb@1fe28000 {
+			compatible = "generic-ohci";
+			reg = <0x1fe28000 0x100>;
+			interrupt-parent = <&platintc1>;
+			interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+
+	    status = "disabled";
+			};
+
+	};
+};
+\ 文件尾没有换行符
-- 
2.20.1

