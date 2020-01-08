Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513ADC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4E9206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgAHQM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:12:59 -0500
Received: from mout.perfora.net ([74.208.4.196]:38479 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgAHQM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:12:58 -0500
Received: from marcel-nb-toradex-int.toradex.int ([31.10.206.124]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0M4Yxu-1jcU710aU8-00ycLZ; Wed, 08 Jan 2020 17:12:39 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] ARM: dts: imx7: Fix Toradex Colibri iMX7S 256MB NAND flash support
Date:   Wed,  8 Jan 2020 17:12:31 +0100
Message-Id: <20200108161232.327424-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NgfM57qzSnHZU6RlIq2nxaQLQoxcUkHwSvrd2wvK1n/CK2WmzBL
 mLr2Bbu8CFVuMfDzmap6ePR0nYAk7KDdFxRsbxKWT7RTbwwCWk4IPNl0dGJSu5dmPZMsbHf
 Y6meot00kKbCmeIFnF+RqptM88BoxCLh2aVH2dnCTtAAGA6qvIXtzBDDEuNnfQpe4XuDtXP
 Nks7b2X4yavDuHRjaHQXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:neE/JN6HsKo=:gGTUhhol46v+Et5a5oyyXH
 9j37vQDNIv7i5zQtlh8yuWO5ThM5slDWMGBxNSdTPQGunYx2v958TIJBlZ9ucdUcZafAHHA6M
 3i7IT5LtPCqOR5kstFfbJBPVL9KH7anvaqRq2f8H3C9dsvrt2tSes1Zl+0TZZX56NPYzyxhIp
 r/Mka8ln+NnMv9gbGcROVQ4+ARExsSPSBrKdkVt9yMF3ULOybn/z/3cLrLyPylJxPOFUdLf/+
 jnVh1f0nWg+lonSFvy8RR+6//8pXGkwdvB8vjz42SOwVKMKgSYgqvJVyXv5qyDlLJqCYnfQ7X
 B5+/uExm8ZDmZw63GQ9pXib/anExDpiFjnD1V0oZxsa4N2SuuyZoxxLjvkJ0smjJWZnDEWcMq
 epgjqrZKyexCSpW56bNhB7XCc7ktt6D0iTpWWj1cc8SuYNJ8wX2Twr+VtHEx3kwxcxydwgJ56
 zvrlMciwF4+WGpU370P6Bj0R161G1G1WUmAgvodV8EXgGdC9owbSIGUjZryJuB/QrNgyww0n/
 RnBHAeYXVGXcIJXK/811ADxsma4MxcIWjBYGRhFkjShexvEjORY8vXcU0h88hYbrzv9eqHrH3
 3HirsI2uhhnJtbkFyx3xTwK9w/Izu5qYez27aEeytkPfVT8xFvQkPj5aohOq2g/QY3KdGPTUK
 6hjZ2PMNjAulYcOHMxcJNcO6ZGX7qgWqxb1+Jh0gvH09ORsaMTu+P3nWtpuRnrhVTW3zIeOvA
 srTji2B59wlG7QmzVNgcWYujj8L2Rorwn3wGtT9arNui0cSr0qOGUEpdOQn7T9MulEzGnUQrr
 WUsJ/r+5ApDlaNoyLBVS9gZoCjd8tSNvQSx5lD70/wc8Ny5q47YQWu5HaNws4OXShEMTFRNEB
 lOXq3IZh8m98TjSpGBbg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Turns out when introducing the eMMC version the gpmi node required for
NAND flash support got enabled exclusively on Colibri iMX7D 512MB.

Fixes: f928a4a377e4 ("ARM: dts: imx7: add Toradex Colibri iMX7D 1GB (eMMC) support")

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/imx7s-colibri.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s-colibri.dtsi b/arch/arm/boot/dts/imx7s-colibri.dtsi
index 1fb1ec5d3d70..6d16e32aed89 100644
--- a/arch/arm/boot/dts/imx7s-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7s-colibri.dtsi
@@ -49,3 +49,7 @@ memory@80000000 {
 		reg = <0x80000000 0x10000000>;
 	};
 };
+
+&gpmi {
+	status = "okay";
+};
-- 
2.24.1

