Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A28C5B57F
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 03:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF9320B7C
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 03:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="cxRkBFtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfF3D4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 23:56:34 -0400
Received: from knopi.disroot.org ([178.21.23.139]:46712 "EHLO
        knopi.disroot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfF3D4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 23:56:33 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Jun 2019 23:56:32 EDT
Received: from localhost (localhost [127.0.0.1])
        by disroot.org (Postfix) with ESMTP id 82CE435AD1;
        Sun, 30 Jun 2019 05:49:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at disroot.org
Received: from knopi.disroot.org ([127.0.0.1])
        by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RcVaHcMZLjIq; Sun, 30 Jun 2019 05:49:53 +0200 (CEST)
From:   Chinmaya Krishnan Mahesh <chinmaya.mahesh@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
        t=1561866593; bh=9Ans4RlZn8dOH7qDF/10KOpQwK7T65Z7lmdyjzSs6EM=;
        h=From:To:Cc:Subject:Date;
        b=cxRkBFtLkJqF49ZKRJOmdQPn1WiL+0gAI0IbH2izNDvE48VmypAe/M+yVswDVcpFO
         G0jOYvwIl4tfIuw0ErGts8jklgNnMtIWEvNlyZh8OcbO8t+B05MxH238awK/j5QT/v
         nbXssB0o4AV839WeDkBIp/uhnTDe0fbi/XVVhvPViaoGK6bTFZNUFLBjloaQ5Di5dq
         RXOmMjmDq8tGhSHt/U4rrmlPxmbRJOkNDNvw4+b26gcLLvKWHgsf5t5eQpesV8YC9v
         zQX855x2+tPa8WxqO2WIhB0VOjyXG2m+5kjkuCm5D5k7o7pU+3BZF6rvzObA8kfsqZ
         zhNvFdQA6TUqw==
Cc:     Chinmaya Krishnan Mahesh <chinmaya.mahesh@disroot.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: imx7-media-csi: Remove unneeded break after return
Date:   Sat, 29 Jun 2019 22:49:04 -0500
Message-Id: <20190630034905.7124-1-chinmaya.mahesh@disroot.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:

WARNING: break is not useful after a goto or return

Signed-off-by: Chinmaya Krishnan Mahesh <chinmaya.mahesh@disroot.org>
---
 drivers/staging/media/imx/imx7-media-csi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
index a708a0340eb1..c15acca1dc0d 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -1021,7 +1021,6 @@ static int imx7_csi_try_fmt(struct imx7_csi *csi,
 		break;
 	default:
 		return -EINVAL;
-		break;
 	}
 	return 0;
 }
-- 
2.22.0

