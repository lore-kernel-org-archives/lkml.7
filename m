Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA88C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 18:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE722158A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 18:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="I3jX63QU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfK2SGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 13:06:32 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22574 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727004AbfK2SG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 13:06:26 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xATI08mp024288;
        Fri, 29 Nov 2019 19:06:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=dAq7R3H7IKdrtGpxINjpm51TQLi/qDTgGLAWiKNgOtg=;
 b=I3jX63QURBQNXTQCzaTMFLxGbe0DLV8yFgvhdy4EsEYg7AdJvd5tx9zVS+Paw1xrs3bs
 dfm+xn0sCbZ2iMNORvJWCmrTu+hr33fQvlDDKm6WO9KrQO6i0V07+1mq9YWkuwMugZUd
 NyTtqBfAVW724CVUTCFxsKmMzFz/jVrWTxWCmZnVrJKaRD/fPPZJ/VlO47iFkVOyvpG3
 oZHWmEwju0fsP048pkxVZxHXDKirN3KrZgfBHb9U8uXC3Q9ITP4kjNZ6Xv4EDvNw6zek
 soXNzoeJeszfMeI8xxM0LybJ8iB+EpKIE5hZ/nLu4L+2B5dXF6+kvRvD1T7+BGLgF1al Tg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2whcxss0n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Nov 2019 19:06:06 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0915E100038;
        Fri, 29 Nov 2019 19:06:06 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EA6A1222D1F;
        Fri, 29 Nov 2019 19:06:05 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 29 Nov 2019 19:06:05
 +0100
From:   Alexandre Torgue <alexandre.torgue@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>, <arnd@arndb.de>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/6] ARM: dts: stm32: Update stm32mp157 pinctrl files
Date:   Fri, 29 Nov 2019 19:05:58 +0100
Message-ID: <20191129180602.28470-3-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191129180602.28470-1-alexandre.torgue@st.com>
References: <20191129180602.28470-1-alexandre.torgue@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_06:2019-11-29,2019-11-29 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to cover the STM32MP15 SOCs family this commit updates pinctrl
file names (group definition and packages files).
This family includes: STM32MP151, STM32MP153 and STM32MP157.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
rename to arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
diff --git a/arch/arm/boot/dts/stm32mp157a-avenger96.dts b/arch/arm/boot/dts/stm32mp157a-avenger96.dts
index 628c74a45a25..2f6dd51e8506 100644
--- a/arch/arm/boot/dts/stm32mp157a-avenger96.dts
+++ b/arch/arm/boot/dts/stm32mp157a-avenger96.dts
@@ -7,7 +7,8 @@
 /dts-v1/;
 
 #include "stm32mp157c.dtsi"
-#include "stm32mp157xac-pinctrl.dtsi"
+#include "stm32mp15-pinctrl.dtsi"
+#include "stm32mp15xxac-pinctrl.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/mfd/st,stpmic1.h>
 
diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/stm32mp157a-dk1.dts
index 2f9f8cf94b02..7ee7b4d13d39 100644
--- a/arch/arm/boot/dts/stm32mp157a-dk1.dts
+++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
@@ -7,7 +7,8 @@
 /dts-v1/;
 
 #include "stm32mp157c.dtsi"
-#include "stm32mp157xac-pinctrl.dtsi"
+#include "stm32mp15-pinctrl.dtsi"
+#include "stm32mp15xxac-pinctrl.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/mfd/st,stpmic1.h>
 
diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index 341fb6064447..e5d8da01aaef 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -6,7 +6,8 @@
 /dts-v1/;
 
 #include "stm32mp157c.dtsi"
-#include "stm32mp157xaa-pinctrl.dtsi"
+#include "stm32mp15-pinctrl.dtsi"
+#include "stm32mp15xxaa-pinctrl.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/mfd/st,stpmic1.h>
 
diff --git a/arch/arm/boot/dts/stm32mp157xaa-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157xaa-pinctrl.dtsi
deleted file mode 100644
index 875adf5e1e30..000000000000
--- a/arch/arm/boot/dts/stm32mp157xaa-pinctrl.dtsi
+++ /dev/null
@@ -1,90 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/*
- * Copyright (C) STMicroelectronics 2019 - All Rights Reserved
- * Author: Alexandre Torgue <alexandre.torgue@st.com>
- */
-
-#include "stm32mp157-pinctrl.dtsi"
-/ {
-	soc {
-		pinctrl: pin-controller@50002000 {
-			st,package = <STM32MP_PKG_AA>;
-
-			gpioa: gpio@50002000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 0 16>;
-			};
-
-			gpiob: gpio@50003000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 16 16>;
-			};
-
-			gpioc: gpio@50004000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 32 16>;
-			};
-
-			gpiod: gpio@50005000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 48 16>;
-			};
-
-			gpioe: gpio@50006000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 64 16>;
-			};
-
-			gpiof: gpio@50007000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 80 16>;
-			};
-
-			gpiog: gpio@50008000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 96 16>;
-			};
-
-			gpioh: gpio@50009000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 112 16>;
-			};
-
-			gpioi: gpio@5000a000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 128 16>;
-			};
-
-			gpioj: gpio@5000b000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 144 16>;
-			};
-
-			gpiok: gpio@5000c000 {
-				status = "okay";
-				ngpios = <8>;
-				gpio-ranges = <&pinctrl 0 160 8>;
-			};
-		};
-
-		pinctrl_z: pin-controller-z@54004000 {
-			st,package = <STM32MP_PKG_AA>;
-
-			gpioz: gpio@54004000 {
-				status = "okay";
-				ngpios = <8>;
-				gpio-ranges = <&pinctrl_z 0 400 8>;
-			};
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/stm32mp157xab-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157xab-pinctrl.dtsi
deleted file mode 100644
index 961fa12a59c3..000000000000
--- a/arch/arm/boot/dts/stm32mp157xab-pinctrl.dtsi
+++ /dev/null
@@ -1,62 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/*
- * Copyright (C) STMicroelectronics 2019 - All Rights Reserved
- * Author: Alexandre Torgue <alexandre.torgue@st.com>
- */
-
-#include "stm32mp157-pinctrl.dtsi"
-/ {
-	soc {
-		pinctrl: pin-controller@50002000 {
-			st,package = <STM32MP_PKG_AB>;
-
-			gpioa: gpio@50002000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 0 16>;
-			};
-
-			gpiob: gpio@50003000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 16 16>;
-			};
-
-			gpioc: gpio@50004000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 32 16>;
-			};
-
-			gpiod: gpio@50005000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 48 16>;
-			};
-
-			gpioe: gpio@50006000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 64 16>;
-			};
-
-			gpiof: gpio@50007000 {
-				status = "okay";
-				ngpios = <6>;
-				gpio-ranges = <&pinctrl 6 86 6>;
-			};
-
-			gpiog: gpio@50008000 {
-				status = "okay";
-				ngpios = <10>;
-				gpio-ranges = <&pinctrl 6 102 10>;
-			};
-
-			gpioh: gpio@50009000 {
-				status = "okay";
-				ngpios = <2>;
-				gpio-ranges = <&pinctrl 0 112 2>;
-			};
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/stm32mp157xac-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157xac-pinctrl.dtsi
deleted file mode 100644
index 26600f188d25..000000000000
--- a/arch/arm/boot/dts/stm32mp157xac-pinctrl.dtsi
+++ /dev/null
@@ -1,78 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/*
- * Copyright (C) STMicroelectronics 2019 - All Rights Reserved
- * Author: Alexandre Torgue <alexandre.torgue@st.com>
- */
-
-#include "stm32mp157-pinctrl.dtsi"
-/ {
-	soc {
-		pinctrl: pin-controller@50002000 {
-			st,package = <STM32MP_PKG_AC>;
-
-			gpioa: gpio@50002000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 0 16>;
-			};
-
-			gpiob: gpio@50003000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 16 16>;
-			};
-
-			gpioc: gpio@50004000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 32 16>;
-			};
-
-			gpiod: gpio@50005000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 48 16>;
-			};
-
-			gpioe: gpio@50006000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 64 16>;
-			};
-
-			gpiof: gpio@50007000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 80 16>;
-			};
-
-			gpiog: gpio@50008000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 96 16>;
-			};
-
-			gpioh: gpio@50009000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 112 16>;
-			};
-
-			gpioi: gpio@5000a000 {
-				status = "okay";
-				ngpios = <12>;
-				gpio-ranges = <&pinctrl 0 128 12>;
-			};
-		};
-
-		pinctrl_z: pin-controller-z@54004000 {
-			st,package = <STM32MP_PKG_AC>;
-
-			gpioz: gpio@54004000 {
-				status = "okay";
-				ngpios = <8>;
-				gpio-ranges = <&pinctrl_z 0 400 8>;
-			};
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/stm32mp157xad-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157xad-pinctrl.dtsi
deleted file mode 100644
index 910113f3e69a..000000000000
--- a/arch/arm/boot/dts/stm32mp157xad-pinctrl.dtsi
+++ /dev/null
@@ -1,62 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/*
- * Copyright (C) STMicroelectronics 2019 - All Rights Reserved
- * Author: Alexandre Torgue <alexandre.torgue@st.com>
- */
-
-#include "stm32mp157-pinctrl.dtsi"
-/ {
-	soc {
-		pinctrl: pin-controller@50002000 {
-			st,package = <STM32MP_PKG_AD>;
-
-			gpioa: gpio@50002000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 0 16>;
-			};
-
-			gpiob: gpio@50003000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 16 16>;
-			};
-
-			gpioc: gpio@50004000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 32 16>;
-			};
-
-			gpiod: gpio@50005000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 48 16>;
-			};
-
-			gpioe: gpio@50006000 {
-				status = "okay";
-				ngpios = <16>;
-				gpio-ranges = <&pinctrl 0 64 16>;
-			};
-
-			gpiof: gpio@50007000 {
-				status = "okay";
-				ngpios = <6>;
-				gpio-ranges = <&pinctrl 6 86 6>;
-			};
-
-			gpiog: gpio@50008000 {
-				status = "okay";
-				ngpios = <10>;
-				gpio-ranges = <&pinctrl 6 102 10>;
-			};
-
-			gpioh: gpio@50009000 {
-				status = "okay";
-				ngpios = <2>;
-				gpio-ranges = <&pinctrl 0 112 2>;
-			};
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/stm32mp15xxaa-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15xxaa-pinctrl.dtsi
new file mode 100644
index 000000000000..04f7a43ad66f
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp15xxaa-pinctrl.dtsi
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) STMicroelectronics 2019 - All Rights Reserved
+ * Author: Alexandre Torgue <alexandre.torgue@st.com> for STMicroelectronics.
+ */
+
+&pinctrl {
+	st,package = <STM32MP_PKG_AA>;
+
+	gpioa: gpio@50002000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 0 16>;
+	};
+
+	gpiob: gpio@50003000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 16 16>;
+	};
+
+	gpioc: gpio@50004000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 32 16>;
+	};
+
+	gpiod: gpio@50005000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 48 16>;
+	};
+
+	gpioe: gpio@50006000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 64 16>;
+	};
+
+	gpiof: gpio@50007000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 80 16>;
+	};
+
+	gpiog: gpio@50008000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 96 16>;
+	};
+
+	gpioh: gpio@50009000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 112 16>;
+	};
+
+	gpioi: gpio@5000a000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 128 16>;
+	};
+
+	gpioj: gpio@5000b000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 144 16>;
+	};
+
+	gpiok: gpio@5000c000 {
+		status = "okay";
+		ngpios = <8>;
+		gpio-ranges = <&pinctrl 0 160 8>;
+	};
+};
+
+&pinctrl_z {
+	st,package = <STM32MP_PKG_AA>;
+
+	gpioz: gpio@54004000 {
+		status = "okay";
+		ngpios = <8>;
+		gpio-ranges = <&pinctrl_z 0 400 8>;
+	};
+};
diff --git a/arch/arm/boot/dts/stm32mp15xxab-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15xxab-pinctrl.dtsi
new file mode 100644
index 000000000000..328dad140e9b
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp15xxab-pinctrl.dtsi
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) STMicroelectronics 2019 - All Rights Reserved
+ * Author: Alexandre Torgue <alexandre.torgue@st.com> for STMicroelectronics.
+ */
+
+&pinctrl {
+	st,package = <STM32MP_PKG_AB>;
+
+	gpioa: gpio@50002000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 0 16>;
+	};
+
+	gpiob: gpio@50003000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 16 16>;
+	};
+
+	gpioc: gpio@50004000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 32 16>;
+	};
+
+	gpiod: gpio@50005000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 48 16>;
+	};
+
+	gpioe: gpio@50006000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 64 16>;
+	};
+
+	gpiof: gpio@50007000 {
+		status = "okay";
+		ngpios = <6>;
+		gpio-ranges = <&pinctrl 6 86 6>;
+	};
+
+	gpiog: gpio@50008000 {
+		status = "okay";
+		ngpios = <10>;
+		gpio-ranges = <&pinctrl 6 102 10>;
+	};
+
+	gpioh: gpio@50009000 {
+		status = "okay";
+		ngpios = <2>;
+		gpio-ranges = <&pinctrl 0 112 2>;
+	};
+};
diff --git a/arch/arm/boot/dts/stm32mp15xxac-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15xxac-pinctrl.dtsi
new file mode 100644
index 000000000000..7eaa245f44db
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp15xxac-pinctrl.dtsi
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) STMicroelectronics 2019 - All Rights Reserved
+ * Author: Alexandre Torgue <alexandre.torgue@st.com> for STMicroelectronics.
+ */
+
+&pinctrl {
+	st,package = <STM32MP_PKG_AC>;
+
+	gpioa: gpio@50002000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 0 16>;
+	};
+
+	gpiob: gpio@50003000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 16 16>;
+	};
+
+	gpioc: gpio@50004000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 32 16>;
+	};
+
+	gpiod: gpio@50005000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 48 16>;
+	};
+
+	gpioe: gpio@50006000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 64 16>;
+	};
+
+	gpiof: gpio@50007000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 80 16>;
+	};
+
+	gpiog: gpio@50008000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 96 16>;
+	};
+
+	gpioh: gpio@50009000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 112 16>;
+	};
+
+	gpioi: gpio@5000a000 {
+		status = "okay";
+		ngpios = <12>;
+		gpio-ranges = <&pinctrl 0 128 12>;
+	};
+};
+
+&pinctrl_z {
+	st,package = <STM32MP_PKG_AC>;
+
+	gpioz: gpio@54004000 {
+		status = "okay";
+		ngpios = <8>;
+		gpio-ranges = <&pinctrl_z 0 400 8>;
+	};
+};
diff --git a/arch/arm/boot/dts/stm32mp15xxad-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15xxad-pinctrl.dtsi
new file mode 100644
index 000000000000..b63e207de216
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp15xxad-pinctrl.dtsi
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) STMicroelectronics 2019 - All Rights Reserved
+ * Author: Alexandre Torgue <alexandre.torgue@st.com> for STMicroelectronics.
+ */
+
+&pinctrl {
+	st,package = <STM32MP_PKG_AD>;
+
+	gpioa: gpio@50002000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 0 16>;
+	};
+
+	gpiob: gpio@50003000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 16 16>;
+	};
+
+	gpioc: gpio@50004000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 32 16>;
+	};
+
+	gpiod: gpio@50005000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 48 16>;
+	};
+
+	gpioe: gpio@50006000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 64 16>;
+	};
+
+	gpiof: gpio@50007000 {
+		status = "okay";
+		ngpios = <6>;
+		gpio-ranges = <&pinctrl 6 86 6>;
+	};
+
+	gpiog: gpio@50008000 {
+		status = "okay";
+		ngpios = <10>;
+		gpio-ranges = <&pinctrl 6 102 10>;
+	};
+
+	gpioh: gpio@50009000 {
+		status = "okay";
+		ngpios = <2>;
+		gpio-ranges = <&pinctrl 0 112 2>;
+	};
+};
-- 
2.17.1

