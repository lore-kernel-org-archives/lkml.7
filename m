Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C158EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E68A2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VkzgUTj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbfCSPZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:25:10 -0400
Received: from mout.gmx.net ([212.227.15.15]:37021 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfCSPZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553009086;
        bh=nb0C5rRkoVkrLbGI/+Uko6W3kPIm+SmqJ2g43abCtI0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VkzgUTj83MDC+s2Nhdqo6W77DWmaPWD5TqSbSSreKkUC9UtHRts2mZe3+9gZz/11E
         gVb9SXGAH+6Qys5nsnj3cbQrpLBfxJs56L0eNxuv7k60nF3NCyYyuOVScM7Takb7s6
         M81qqED/n/GwDXIN8LmtFVTpa/YVEg/jD9xdGB58=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LkPBT-1gZfoD0qRn-00cO70; Tue, 19
 Mar 2019 16:24:46 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <treding@nvidia.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 4/5] ARM: dts: imx50-kobo-aura: Enable USB support
Date:   Tue, 19 Mar 2019 16:24:19 +0100
Message-Id: <20190319152421.16179-5-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190319152421.16179-1-j.neuschaefer@gmx.net>
References: <20190319152421.16179-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0cHFUBU+V3xPJK5bnKVc39JMOGsAGPjkYMvryFj2TD6JJ5SrRjD
 LOBPVgYxuUz4Lqua5tbJ9efDYwNoniQDKI4IgeBiRXH/mGOAoXTmLv9XtvXByoSMLr54swN
 2QLtWDz2OgesEadrVE7Vskk2ZhBYdThGDgGlk5HpkDitcZaX3Q/QJve67OVyHXWS/AL+gkk
 CThEoWQpMjPDZImOf+iYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tsxlXrPyxcQ=:kTpSYAJVJGymsLWQxjoovE
 AxUfZ+FANXjd63QbUwJ85xbMvKb7TVmM+zWagk9pznKXXos4BJanefZwj27P1Hj9wDyetK4ia
 HT4Vd+twnPk9EBuEhWw7frRMpaDhKL/8JZD2DzHS+6Bc1RgP7wr2K5iOh3/ba9JJQlcOChNfg
 pWuKgiMW1OSRr4tCHwh8vfMy6erYIIe0zksPWS8i4ftRvfw6Bj24PtsoJwhbg+KVXWmuR5qQo
 93KtCP1iTGbAxm1gHN29kojg6vlYyYBliVG9nYn0zsKITHVrQPXUOlOtK8lCNLGHGcEloQS8G
 dOpV7K9zq/O4Xdlt5wkW+bq8aC5+VFy9l/PMbrM6xXqGfgY2YJ3+e0JXq5qQp+jxAvyecVtLw
 VrslhEtBA9zuPtg3h5mk6w2tCSAACa6yg6/kJdcwA89xmlr0aN/w8oc2RBWshcRzxEKjZ6SMr
 mlXT4QOGltKN6wJTP82tYIA8hGPs0zGVZ/JCNVje6aQ+1+Fhkj3BkHuTjA+6mmy2J7Xc/kRbR
 d1+KsG7p4hDIeHSvh7f0JtaHxUGwoH4a+i0QgP0IrOWbO2JJLGqBIhP3rb0Wj2NLq9H4L+hQD
 whQQ0a7DBUwxhMCfKWu5i8RvBg3yfYBkwx2awc58/n+M04+ZmwqabXv63xcqBrSv0biUt4qWA
 SDKzXXSXyfFQG4BlMaKmmZNJN6HVDkDuMwG2lLwyQnBcJEzzKl27JMAiV6BTMkaVYVgRkYGP4
 JuSkOdZ8ocY6MQSAy+uC4YbwrwRlJZF4Bp0s55R9U2XLE9ZL6hQs67h5u9QT9j72N3jVpkydP
 9K4W9PNgZpFfXIe/1bHpmnluMuLAiH35C2+oqYX1Kt5zJsUjVf349xJFIw0CtU0cKKbhM0H5L
 Y5vGZQBdh6w5UoYYlXWj7XcxQqBH9vZSIFn6gP12cz+qI7ZC3F0Bbqq1mFD21wpmeA6fJGxGq
 PR7cL6YAQNQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the USBOTG controller in device mode, and also enable the
corresponding PHY. The presence of Vbus is detected via a GPIO.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 arch/arm/boot/dts/imx50-kobo-aura.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx50-kobo-aura.dts b/arch/arm/boot/dts/imx=
50-kobo-aura.dts
index e778a677c752..d0dc20d99d99 100644
=2D-- a/arch/arm/boot/dts/imx50-kobo-aura.dts
+++ b/arch/arm/boot/dts/imx50-kobo-aura.dts
@@ -87,6 +87,12 @@
 		>;
 	};

+	pinctrl_usbphy: usbphy {
+		fsl,pins =3D <
+			MX50_PAD_ECSPI2_SS0__GPIO4_19		0x0
+		>;
+	};
+
 	pinctrl_i2c1: i2c1 {
 		fsl,pins =3D <
 			MX50_PAD_I2C1_SCL__I2C1_SCL		0x400001fd
@@ -180,6 +186,18 @@
 	status =3D "okay";
 };

+&usbotg {
+	status =3D "okay";
+	phy_type =3D "utmi_wide";
+	dr_mode =3D "peripheral";
+};
+
+&usbphy0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_usbphy>;
+	vbus-detect-gpio =3D <&gpio4 19 GPIO_ACTIVE_LOW>;
+};
+
 &i2c1 {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&pinctrl_i2c1>;
=2D-
2.20.1

