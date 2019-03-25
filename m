Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NO_DNS_FOR_FROM,SIGNED_OFF_BY,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD51C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E0320850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbfCYMGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:06:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45382 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730837AbfCYMGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:06:12 -0400
Received: by mail-lf1-f65.google.com with SMTP id 5so5777938lft.12;
        Mon, 25 Mar 2019 05:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KKBXHzvog67yUCaBvdhsRhRauVNQhwJHQy9YwEFcU6w=;
        b=pVzzI/z9D2K7SoBIxHFBi45wMylmPspjrfWTnKQ8EE/Oob8kzyuCRiTDCcpEbg7Uaf
         2wJbidjI39qy9CRZ5UVgh/UeK/19Kak7aJiCvBnr32v5r2LpQtenXUpvHX9XPg8MlrCl
         OaS0ZG3n/6JeZWkaJ6+hykiDuIx/07ad+Qr/cEQU11duYqFB4TB9+4XOpVGCwPw9nFGK
         xbYazjSRs9APuvNZIeNiW/owYsiS2xM1G1vOcb99z6x1azwcWicYOydbEJbMUtp9gajV
         kKYI0c/U+eDTxf90M1qSsQXFU+KzwTfnVW/UWrYpVgw+t83LZfM9JvCuRjIVOVL1RJFU
         pDlA==
X-Gm-Message-State: APjAAAWOgQkmNu+dz4OBhyEosMbOqbatAN1H6DGVsxljg88iWKdlKjYc
        AB545YBvW2moUFmeE7BIhRU=
X-Google-Smtp-Source: APXvYqxMs54kM0ls7FeEFA+3VI6HThueP4FbU+glJEhfjNXV7OO8VJ/24psnTAmJYI9+gUSPCCYXSA==
X-Received: by 2002:a19:ec14:: with SMTP id b20mr12285475lfa.55.1553515568602;
        Mon, 25 Mar 2019 05:06:08 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id q64sm2240584ljq.76.2019.03.25.05.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 05:06:08 -0700 (PDT)
Date:   Mon, 25 Mar 2019 14:05:55 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
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
Subject: [PATCH v11 4/8] dt-bindings: mfd: Document first ROHM BD70528
 bindings
Message-ID: <c674ef76ca0a3298e6b13ade4ab29775edf36a76.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
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
 .../bindings/mfd/rohm,bd70528-pmic.txt        | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
new file mode 100644
index 000000000000..120462c17904
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
@@ -0,0 +1,102 @@
+* ROHM BD70528 Power Management Integrated Circuit bindings
+
+BD70528MWV is an ultra-low quiescet current general purpose single-chip
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
+/* external oscillator */
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
