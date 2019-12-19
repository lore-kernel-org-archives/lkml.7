Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA121C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B114A20716
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skidata.com header.i=@skidata.com header.b="fMiGaPKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLSNMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:12:02 -0500
Received: from mail1.skidata.com ([91.230.2.99]:32414 "EHLO mail1.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbfLSNMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=skidata.com; i=@skidata.com; q=dns/txt; s=selector1;
  t=1576761122; x=1608297122;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v5I6HmyMZEfkk4cOh4zALwoYi8f2gqBVfg+2kVMeEaQ=;
  b=fMiGaPKKuzjK7FDtuSG+eMkzU1wAo87wWuv4yfakiDFMVnGO039dcvoI
   yby3RJh8KqUsYgwBEmWx5NC3I8RE6WyOWTxpcPeAlHQTP80c/QP20UoNO
   e1nZ4Y4MKmpFSegu6Uu/1tR/Sm51LSzyJGdSwhoIlLWTCu5zpbiTQwyir
   oIwEzkQmbQS07p3KSGzpQ6kiBEhR+TbJNiT+NB2xzIvQo/gkldD+gzLsX
   XPQ02WBF9OsrEdqbMWkiyUIozctUdAQLYswSEr2Dxy7BvL5eL9flq5ILL
   56EJeANycY4o5xLJhIU25Tk543nGKTaCqj/VJRN3u9ihSWv+E0ydXRtYw
   A==;
IronPort-SDR: rXbAXl7IN2U5RgHPwH21Zv+D0s59fW9LQVr0jcHMtkaDqp7hRM4Ia6i4EOH7iox+lOOTRA3bN+
 J0PEibFOsz2yC0/7UKg7j6sQ+lKIRyUUDhOUI7HxDMxF5AXoc8D/p5fYhNSfWdaDFP1FpYlnBG
 8+ivRwjBxnC4zkJ68gRdftG5+DZLkkI1lyhoQHSU0spy7jhHkCboC/Pq1ZYpVnaob5mOeKRzvE
 /bAwLVRS6VnXljJrDBvLWtU4k6DCbscWh2cY8qIVlO220Jt32mvJ83bidt6OyEli/GFhfDfESx
 fEw=
X-IronPort-AV: E=Sophos;i="5.69,332,1571695200"; 
   d="scan'208";a="21622553"
From:   Richard Leitner <richard.leitner@skidata.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH 2/2] ARM: dts: tegra20: add labels to host1x its subnodes
Date:   Thu, 19 Dec 2019 14:04:31 +0100
Message-ID: <20191219130431.30458-2-richard.leitner@skidata.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191219130431.30458-1-richard.leitner@skidata.com>
References: <20191219130431.30458-1-richard.leitner@skidata.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex4srv.skidata.net (192.168.111.82) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add labels to the host1x, dc and hdmi nodes of the Tegra20 SoC so we
just need to alias it from derived boards.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index e02f75757a7e..c569bd87550f 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -29,7 +29,7 @@
 		};
 	};
 
-	host1x@50000000 {
+	host1x: host1x@50000000 {
 		compatible = "nvidia,tegra20-host1x", "simple-bus";
 		reg = <0x50000000 0x00024000>;
 		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>, /* syncpt */
@@ -96,7 +96,7 @@
 			reset-names = "3d";
 		};
 
-		dc@54200000 {
+		dc1: dc@54200000 {
 			compatible = "nvidia,tegra20-dc";
 			reg = <0x54200000 0x00040000>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
@@ -113,7 +113,7 @@
 			};
 		};
 
-		dc@54240000 {
+		dc2: dc@54240000 {
 			compatible = "nvidia,tegra20-dc";
 			reg = <0x54240000 0x00040000>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
@@ -130,7 +130,7 @@
 			};
 		};
 
-		hdmi@54280000 {
+		hdmi: hdmi@54280000 {
 			compatible = "nvidia,tegra20-hdmi";
 			reg = <0x54280000 0x00040000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.21.0

