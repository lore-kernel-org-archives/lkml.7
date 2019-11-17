Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31035C432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 12:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CE620727
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 12:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfKQMxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 07:53:02 -0500
Received: from mailoutvs20.siol.net ([185.57.226.211]:41108 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726037AbfKQMxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 07:53:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id EEA88522B56;
        Sun, 17 Nov 2019 13:52:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Cc8JBiWqQWmV; Sun, 17 Nov 2019 13:52:58 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id AE514522A5A;
        Sun, 17 Nov 2019 13:52:58 +0100 (CET)
Received: from localhost.localdomain (cpe-86-58-102-7.static.triera.net [86.58.102.7])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id C6E5F522B5D;
        Sun, 17 Nov 2019 13:52:55 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: sun8i: h3: Add rc map for Beelink X2
Date:   Sun, 17 Nov 2019 13:52:50 +0100
Message-Id: <20191117125250.1339829-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beelink X2 box comes with a remote. Add a mapping for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dt=
s/sun8i-h3-beelink-x2.dts
index ac9e26b1d906..45a24441ff18 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -143,6 +143,7 @@ hdmi_out_con: endpoint {
 };
=20
 &ir {
+	linux,rc-map-name =3D "rc-tanix-tx3mini";
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&r_ir_rx_pin>;
 	status =3D "okay";
--=20
2.24.0

