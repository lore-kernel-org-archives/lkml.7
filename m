Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D098C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0138F2064B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbfFTPHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 11:07:48 -0400
Received: from shell.v3.sk ([90.176.6.54]:51682 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbfFTPHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:07:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 52E32CC52E;
        Thu, 20 Jun 2019 17:07:42 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yO6QnH-kjdUF; Thu, 20 Jun 2019 17:07:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id DC783CC536;
        Thu, 20 Jun 2019 17:07:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tKXEbdIxRtDi; Thu, 20 Jun 2019 17:07:29 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id BDCCCCC539;
        Thu, 20 Jun 2019 17:07:27 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 5/5] ARM: dts: mmp2: specify reg-shift for the UARTs
Date:   Thu, 20 Jun 2019 17:07:24 +0200
Message-Id: <20190620150724.1406757-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190620150724.1406757-1-lkundrak@v3.sk>
References: <20190620150724.1406757-1-lkundrak@v3.sk>
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
 arch/arm/boot/dts/mmp2.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 68b547077323..6a2f072c1d0a 100644
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

