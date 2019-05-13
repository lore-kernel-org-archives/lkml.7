Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C1FC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E744421473
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="as+QUZkg";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="as+QUZkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfEMUX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 16:23:27 -0400
Received: from node.akkea.ca ([192.155.83.177]:47912 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfEMUXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 16:23:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id B8A204E2051;
        Mon, 13 May 2019 20:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557778986; bh=gNh7Uyxf9iAWSXDoAQKzkojnr+ABCxdVSR93YXCK1nU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=as+QUZkgM4v+n6rMYLDzmKhLzeZ+Jc4ydpP5slSM/mS2+WombQO/ehYDlcrNkWBcK
         IVfCY8RSWzA9izl4Beo0zhUlHp/J2kXz0AsV0em8Tuh8zdCdkzR3HLybVkardmnLzz
         b0Pii5ObaCzG0d01T9SPUSyqqP2phMP75ICB3IEg=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JShOuHyvJsxg; Mon, 13 May 2019 20:23:06 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id DADB44E204D;
        Mon, 13 May 2019 20:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557778986; bh=gNh7Uyxf9iAWSXDoAQKzkojnr+ABCxdVSR93YXCK1nU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=as+QUZkgM4v+n6rMYLDzmKhLzeZ+Jc4ydpP5slSM/mS2+WombQO/ehYDlcrNkWBcK
         IVfCY8RSWzA9izl4Beo0zhUlHp/J2kXz0AsV0em8Tuh8zdCdkzR3HLybVkardmnLzz
         b0Pii5ObaCzG0d01T9SPUSyqqP2phMP75ICB3IEg=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v11 1/4] MAINTAINERS: add an entry for for arm63 imx devicetrees
Date:   Mon, 13 May 2019 13:22:55 -0700
Message-Id: <20190513202258.30949-2-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513202258.30949-1-angus@akkea.ca>
References: <20190513202258.30949-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an explicit reference to imx* devicetrees

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7707c28628b9..9fc30f82ab81 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1624,6 +1624,7 @@ R:	NXP Linux Team <linux-imx@nxp.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
+F:	arch/arm64/boot/dts/freescale/imx*
 N:	imx
 N:	mxs
 X:	drivers/media/i2c/
-- 
2.17.1

