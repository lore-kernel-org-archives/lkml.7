Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D74DC76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40DB2238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391621AbfGYLIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 07:08:02 -0400
Received: from shell.v3.sk ([90.176.6.54]:37760 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391597AbfGYLH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:07:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0D705D4F3E;
        Thu, 25 Jul 2019 13:07:56 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UfzzaiPVJk8z; Thu, 25 Jul 2019 13:07:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D903BD4F40;
        Thu, 25 Jul 2019 13:07:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8RJeYukaesxL; Thu, 25 Jul 2019 13:07:38 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id A86E9D4F42;
        Thu, 25 Jul 2019 13:07:34 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 5/5] ARM: dts: mmp2: specify reg-shift for the UARTs
Date:   Thu, 25 Jul 2019 13:07:31 +0200
Message-Id: <20190725110731.3294411-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725110731.3294411-1-lkundrak@v3.sk>
References: <20190725110731.3294411-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the 8250_of driver happy. There are two more drivers in the
tree that bind to mrvl,mmp-uart compatibles: pxa and 8250_pxa and
neither of them requires the reg-shift property, assuming it's always 2.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Updated the subject to fit the style of the DTS updates
---
 arch/arm/boot/dts/mmp2.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 68b5470773232..6a2f072c1d0a8 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -214,6 +214,7 @@
 				interrupts =3D <27>;
 				clocks =3D <&soc_clocks MMP2_CLK_UART0>;
 				resets =3D <&soc_clocks MMP2_CLK_UART0>;
+				reg-shift =3D <2>;
 				status =3D "disabled";
 			};
=20
@@ -223,6 +224,7 @@
 				interrupts =3D <28>;
 				clocks =3D <&soc_clocks MMP2_CLK_UART1>;
 				resets =3D <&soc_clocks MMP2_CLK_UART1>;
+				reg-shift =3D <2>;
 				status =3D "disabled";
 			};
=20
@@ -232,6 +234,7 @@
 				interrupts =3D <24>;
 				clocks =3D <&soc_clocks MMP2_CLK_UART2>;
 				resets =3D <&soc_clocks MMP2_CLK_UART2>;
+				reg-shift =3D <2>;
 				status =3D "disabled";
 			};
=20
@@ -241,6 +244,7 @@
 				interrupts =3D <46>;
 				clocks =3D <&soc_clocks MMP2_CLK_UART3>;
 				resets =3D <&soc_clocks MMP2_CLK_UART3>;
+				reg-shift =3D <2>;
 				status =3D "disabled";
 			};
=20
--=20
2.21.0

