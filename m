Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340FEC432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 13:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF422075C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 13:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfKQNBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 08:01:13 -0500
Received: from mailoutvs15.siol.net ([185.57.226.206]:57405 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726206AbfKQNBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 08:01:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id C83D0523A9E;
        Sun, 17 Nov 2019 14:01:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cUlbf8KFtL4E; Sun, 17 Nov 2019 14:01:09 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 8D38D522BA0;
        Sun, 17 Nov 2019 14:01:09 +0100 (CET)
Received: from localhost.localdomain (cpe-86-58-102-7.static.triera.net [86.58.102.7])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 34FBE523A9E;
        Sun, 17 Nov 2019 14:01:07 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Lange <linuxstuff@milaw.biz>
Subject: [PATCH v2 2/2] arm64: dts: allwinner: h6: tanix-tx6: Add IR remote mapping
Date:   Sun, 17 Nov 2019 14:00:58 +0100
Message-Id: <20191117130058.1341989-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191117130058.1341989-1-jernej.skrabec@siol.net>
References: <20191117130058.1341989-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tanix TX6 box comes with a remote. Add a mapping for it.

Suggested-by: Michael Lange <linuxstuff@milaw.biz>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch=
/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
index bccfe1e65b6a..898eee82888c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
@@ -85,6 +85,7 @@ &ohci3 {
 };
=20
 &r_ir {
+	linux,rc-map-name =3D "rc-tanix-tx5max";
 	status =3D "okay";
 };
=20
--=20
2.24.0

