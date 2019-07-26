Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC41FC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF40D22C7E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564169368;
	bh=pz2N2DSFrXZ7yizpZ6S1tBZ///PIkF5RGe+1cbuHEEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BonebiSmytWTNf5BpDTjnOqNqta8erFS3WhpAA7ZKaSHoJxeyUGJhOYTyyNySd+LE
	 FHXnXSiFR4bTo9HtLnX0x5zTxAGliz0Hb9+Q/mScFLvdyaXLGzlqP+NFG/utkHSIK6
	 GYmmS2BonV9tRl1WWHoVsbNmeKTvmiIX/wDVaYi8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfGZT3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:29:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33894 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfGZT3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=G2cWhwH+TFVnMJ4q1Yub2IuXpV5EQZa4Ad+SN886NwY=; b=QuDit2Rr19OZdpKcKzqv4xuvNg
        p4aJsyMwnfMEZPaF+eBfZz481JTzJr6j5WLq0GuF59wQeAyDc5U7aloFkIshgbtDeD3mtoVU9yaHR
        Y54gowEnu/aDDcdbg7uPOXtGSPiwTiVZBdYB+0Km/WjeDG1DgnnB24mL4USAqwP9F944dN1O9KLTd
        0lONs7iW7ERC4K/E+ZbhuYarhNXdxRX0i8X5iygfc9ynRzohbp/fZtgBK0viEo5Ty7FVeK5kvxJJD
        PJCgC5mDjuCBUHFKbyQVzqFJAQWDvTnaoA2KzAPqNZOn4GUBUIGhwOd/psfK1Ziql2lL26Rf04EyQ
        +dVK+uXg==;
Received: from [179.95.31.157] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr5u2-00046v-BF; Fri, 26 Jul 2019 19:29:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hr5tz-0004yi-Kt; Fri, 26 Jul 2019 16:29:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 3/5] MAINTAINERS: fix a renamed DT reference
Date:   Fri, 26 Jul 2019 16:29:12 -0300
Message-Id: <cdaa19bceb4c747faa8bd141894af2dcbd8472b7.1564169297.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <5c44856436bbaeb4f2d4b750365b82de973ad054.1564169297.git.mchehab+samsung@kernel.org>
References: <5c44856436bbaeb4f2d4b750365b82de973ad054.1564169297.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix this rename:

	Documentation/devicetree/bindings/i2c/{i2c-mv64xxx.txt -> marvell,mv64xxx-i2c.yaml}

Fixes: f8bbde72ef44 ("dt-bindings: i2c: mv64xxx: Add YAML schemas")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b57dd8494c93..454a26c77fa0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7507,7 +7507,7 @@ I2C MV64XXX MARVELL AND ALLWINNER DRIVER
 M:	Gregory CLEMENT <gregory.clement@bootlin.com>
 L:	linux-i2c@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
+F:	Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
 F:	drivers/i2c/busses/i2c-mv64xxx.c
 
 I2C OVER PARALLEL PORT
-- 
2.21.0

