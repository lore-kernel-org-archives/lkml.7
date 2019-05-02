Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D71C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDF620449
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810672;
	bh=aBA3X7FuxLlroKe0SJG5PrCLCpDFfcYin13GTVdv5F0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rN28HfcObxh+847Fyv80FJzJcw/OZrmQto7Lf1IMGzuKxIu/V98Ot+gBu3+jxfihi
	 p9r94/f2Q4mEDn1Kg2QheZse3seoLZivGmcZUUUo7etb0UWLdmVihk4z1cPwXf4NUD
	 NZfSGJUEPVyBDK+E58skf7Rf0MQ9J2+NBDtX/nCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfEBPYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:24:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727302AbfEBPY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:24:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37E4B20449;
        Thu,  2 May 2019 15:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810667;
        bh=aBA3X7FuxLlroKe0SJG5PrCLCpDFfcYin13GTVdv5F0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qbRJe/0Afz9PMBsqA2DZ9LJkY/pZ30OpvSIDM6PAqQMiDNgLeSorHRXOn31NFmLKU
         FFlJ1nub/HNckLEdAVNQu9EzkHcGG4Rmw/4+QW1KNiAcff3wkBilPPpUo6Nm/AKR/4
         2X1aZE/XMQXhQfadxJ+EpZCT9jG6APWvsNmoA3Oo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helen Koike <helen.koike@collabora.com>,
        Eric Anholt <eric@anholt.net>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.14 08/49] ARM: dts: bcm283x: Fix hdmi hpd gpio pull
Date:   Thu,  2 May 2019 17:20:45 +0200
Message-Id: <20190502143325.214138528@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143323.397051088@linuxfoundation.org>
References: <20190502143323.397051088@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 544e784188f1dd7c797c70b213385e67d92005b6 ]

Raspberry pi board model B revison 2 have the hot plug detector gpio
active high (and not low as it was in the dts).

Signed-off-by: Helen Koike <helen.koike@collabora.com>
Fixes: 49ac67e0c39c ("ARM: bcm2835: Add VC4 to the device tree.")
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
index 4bc70efe43d6..3178a5664942 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
@@ -93,7 +93,7 @@
 };
 
 &hdmi {
-	hpd-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
+	hpd-gpios = <&gpio 46 GPIO_ACTIVE_HIGH>;
 };
 
 &uart0 {
-- 
2.19.1



