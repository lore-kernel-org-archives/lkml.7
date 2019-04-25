Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67C9C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835142084B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbfDYLPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:15:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38231 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfDYLPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 07:15:52 -0400
Received: by mail-lf1-f68.google.com with SMTP id v1so4737339lfg.5;
        Thu, 25 Apr 2019 04:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=blDCyrEODowPa5clZ/fiSVTKEEZv9ME47UoHqDskt5U=;
        b=QuyCVyd9e6xzYZhPsijsGkQh/ROi37P82teo1R4UsEG02kXNranbO5G3sMTQrisOwc
         D9ZEYNnD5OjVBlGoP1m0lBPF339pwNcnZRSRqFDX+2CJ+SWyXEEVvJVVnpKFpMVvihRC
         gRt0nM4F0cMH6cD+hgvMqKprJnM5/++CyonbVnRVyDDG2Cy8mho0LmNi8qPfKgS3RSia
         VSJN9D2p+2MbHFlXxljGmVcnSpl2gx60csp9rABX4ZTxXH0grUf9Ap2h1dj69kkkiSC1
         HpbqzEs84JA85RvJeNiBPTOLdy/b5GXQeo+Xi2J8tOw3rUaxbStbsDWTU5GbpTCld9Zu
         PcZQ==
X-Gm-Message-State: APjAAAVLjNo5hbOHrvk+WsJcQVsv6/8wgrys2LaP5OyHEodcGRzgDA0b
        ts0hCyC6/pYwwoUPohRuWWE=
X-Google-Smtp-Source: APXvYqyQ38zclCVRN5N5GwHh4KA5xhpI4ZmxyGofcnobGAZXkE2fgOf7ofwZuyQCJ9GzThVplukEvg==
X-Received: by 2002:ac2:5582:: with SMTP id v2mr20247328lfg.19.1556190948724;
        Thu, 25 Apr 2019 04:15:48 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id z30sm4948330lfb.87.2019.04.25.04.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 04:15:48 -0700 (PDT)
Date:   Thu, 25 Apr 2019 14:15:35 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: [PATCH RESEND v13 4/8] dt-bindings: mfd: Document first ROHM BD70528
 bindings
Message-ID: <resend.9208a23a40127df32d3efc6e0ac02d9fcd49d80e.1554371464.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover2.1554371464.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover2.1554371464.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document bindings for regulators (3 bucks, 3 LDOs and 2 LED
drivers) and 4 GPIO pins which can be configured for I/O or
as interrupt sources withe configurable trigger levels.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
Changelog v13:
- No changes

Changelog v12:
- Minor grammar/styling fixes suggested by Lee Jones

 .../bindings/mfd/rohm,bd70528-pmic.txt        | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
new file mode 100644
index 000000000000..c3c02ce73cde
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
@@ -0,0 +1,102 @@
+* ROHM BD70528 Power Management Integrated Circuit bindings
+
+BD70528MWV is an ultra-low quiescent current general purpose, single-chip,
+power management IC for battery-powered portable devices. The IC
+integrates 3 ultra-low current consumption buck converters, 3 LDOs and 2
+LED Drivers. Also included are 4 GPIOs, a real-time clock (RTC), a 32kHz
+clock gate, high-accuracy VREF for use with an external ADC, flexible
+dual-input power path, 10 bit SAR ADC for battery temperature monitor and
+1S battery charger with scalable charge currents.
+
+Required properties:
+ - compatible		: Should be "rohm,bd70528"
+ - reg			: I2C slave address.
+ - interrupts		: The interrupt line the device is connected to.
+ - interrupt-controller	: To indicate BD70528 acts as an interrupt controller.
+ - #interrupt-cells	: Should be 2. Usage is compliant to the 2 cells
+			  variant of ../interrupt-controller/interrupts.txt
+ - gpio-controller	: To indicate BD70528 acts as a GPIO controller.
+ - #gpio-cells		: Should be 2. The first cell is the pin number and
+			  the second cell is used to specify flags. See
+			  ../gpio/gpio.txt for more information.
+ - #clock-cells		: Should be 0.
+ - regulators:		: List of child nodes that specify the regulators.
+			  Please see ../regulator/rohm,bd70528-regulator.txt
+
+Optional properties:
+ - clock-output-names	: Should contain name for output clock.
+
+Example:
+/* External oscillator */
+osc: oscillator {
+	compatible = "fixed-clock";
+	#clock-cells = <1>;
+	clock-frequency  = <32768>;
+	clock-output-names = "osc";
+};
+
+pmic: pmic@4b {
+	compatible = "rohm,bd70528";
+	reg = <0x4b>;
+	interrupt-parent = <&gpio1>;
+	interrupts = <29 GPIO_ACTIVE_LOW>;
+	clocks = <&osc 0>;
+	#clock-cells = <0>;
+	clock-output-names = "bd70528-32k-out";
+	#gpio-cells = <2>;
+	gpio-controller;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+
+	regulators {
+		buck1: BUCK1 {
+			regulator-name = "buck1";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3400000>;
+			regulator-boot-on;
+			regulator-ramp-delay = <125>;
+		};
+		buck2: BUCK2 {
+			regulator-name = "buck2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-boot-on;
+			regulator-ramp-delay = <125>;
+		};
+		buck3: BUCK3 {
+			regulator-name = "buck3";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-boot-on;
+			regulator-ramp-delay = <250>;
+		};
+		ldo1: LDO1 {
+			regulator-name = "ldo1";
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-boot-on;
+		};
+		ldo2: LDO2 {
+			regulator-name = "ldo2";
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-boot-on;
+		};
+
+		ldo3: LDO3 {
+			regulator-name = "ldo3";
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <3300000>;
+		};
+		led_ldo1: LED_LDO1 {
+			regulator-name = "led_ldo1";
+			regulator-min-microvolt = <200000>;
+			regulator-max-microvolt = <300000>;
+		};
+		led_ldo2: LED_LDO2 {
+			regulator-name = "led_ldo2";
+			regulator-min-microvolt = <200000>;
+			regulator-max-microvolt = <300000>;
+		};
+	};
+};
-- 
2.17.2


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
