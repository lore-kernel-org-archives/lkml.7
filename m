Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA28FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3062177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GLFVHrp4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfCSPZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:25:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:49433 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbfCSPZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553009088;
        bh=vNO7KDNNqcpkSNGHEUVtq/MYroMhBlPDJKFNSL2aYDA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GLFVHrp4YrkqBHQgU2PcP/UXenliE/GO2k1KoZLupodCuZUzueoP5LKI4sp/YplI6
         P1yEE+7U2TDcCmTnmibxh9RwvLW1Np9AAfNdwc2Sy6NIsmG2Ia/QmOpcKd966wPkco
         hvuFGn+ugCvdm65NCSA2kg9owx5rt5OuyA5rVpdo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lk81O-1gZwvi002E-00cCKB; Tue, 19
 Mar 2019 16:24:48 +0100
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
Subject: [PATCH 5/5] ARM: dts: imx50: Fix the numbering of the I2C controllers
Date:   Tue, 19 Mar 2019 16:24:20 +0100
Message-Id: <20190319152421.16179-6-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190319152421.16179-1-j.neuschaefer@gmx.net>
References: <20190319152421.16179-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e3Ml0KWZ7zW46/BM0/+7mb6IExHETapNVdGmdG4MxkuGY3aUYhh
 1fi3HU+7hr46EWAbSxD/uREV/vCCk5sMtCSvJ5YwHmU750Ktn6ZrXrA0CqDq1EG+AQiOByU
 hVqt2jYjWKEwcSPxz+pvuxeHONtiSNT4kvHI4gO/AFVKdHzlqWIXtzqvC5A6Whhg+hoPJX3
 ++W0Vr2omGfqnu0j2AWjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FEBRrhRBonM=:05g6vchLlBZPpRHYVG5s6q
 BX88XuHZaCD0Dl4LEnBD14hpjDoJZwUiZKbcUQnbNbmGosg57FYsANqVw0v3Syrpe3xjR9NSq
 vQR+/afvGUPJZlAlAL/YAuntldxRAvFSDORvwB7qBCBLcwu4mrCUjidNOz7T2+8C3BR8YOUbD
 mhuNw65tTAl3UDddUU7yIFF77vvyslegOP95ruzekZFQjW9WO3uoMYoq0N3YKsYguZ4FuBFBB
 Vj2rZ2xDb1m6cZ+EfijSEnTJyp8kqZk4+xb0/b5cPh6JxU+el6oW/75vg5xNYZ7+ySHv2z3BT
 5CBnyIUFvsfm2RemODtZ8GeJTxc3hG+HA8+sQU6RwAIElJPJzwV1m0hzuPJBJ2Vz7S/Wb4fQr
 LcNlzCShUfhlsZktXB+AGgOwo/de7+3EikQcEA1RvBYlAKrQn/dfPo94Rk/BW2LQBh3PtXs27
 kwxJXixP75/8rQrDxcL8U4EUFQpWFkmtZzYlHVB3QGdCO65k8Qgh5bgLZixpjyUiPjXCHrglt
 AhYhjFTa3uCpbZ67NOHtYqLS4UvwoEO/fmyRwMay9DXyq8mFQmO/QkCpfcqh3cSt+x7CBrA1P
 rutKn5eQ+SQn85vdpsULoYiOWzwoyeS8SWe19KN9Myyrc0yuHIZ6E6cSNELw2i5vHWRpH75z6
 eoKYgjXQayHMNrxr2LmBD7D/GNgEkPRz/dC7VL/4rF72ntg1GVcdE4hlDZhoFNAva8B9QzWAW
 5UcPvxR/dyKtlzpAtvopiyvigciOxun+hJ5sWm0Rlyzc2nUMq4QWY09wxbsDSK0AEkCbQj+4p
 eUwlPmtIPDOWK6JRMe1wD0OQykBH18p+iHEG3CFg/s3ao+tt4Un4QvM+3yIYYoENRjEw6Kkwr
 ea8jZncnci1qXMq99qxI7IY4ZKT1WMSMY2qHPM/AbN3vJ7KNDP1+BZgMcQXExHppHbT44Gctu
 9TPRn6oRl9A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that the i2c buses are reported to userspace (for example to
i2cdetect) in the same order as they are numbered in the SoC's
documentation by adding aliases to the devicetree.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 arch/arm/boot/dts/imx50.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index e5632ce24ba0..8cab0ab3bd4e 100644
=2D-- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -26,6 +26,9 @@
 		gpio3 =3D &gpio4;
 		gpio4 =3D &gpio5;
 		gpio5 =3D &gpio6;
+		i2c0 =3D &i2c1;
+		i2c1 =3D &i2c2;
+		i2c2 =3D &i2c3;
 		serial0 =3D &uart1;
 		serial1 =3D &uart2;
 		serial2 =3D &uart3;
=2D-
2.20.1

