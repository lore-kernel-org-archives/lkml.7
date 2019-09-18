Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42411C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B57B21925
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="Y0tkvbKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbfIRMid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:38:33 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:39228 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725902AbfIRMid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:38:33 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id DA98A41240;
        Wed, 18 Sep 2019 12:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1568810309; x=
        1570624710; bh=JVBEx68PKtR7lY6AbA4MQ7MResBCcf/wDDeT5yaPGlA=; b=Y
        0tkvbKl8WxU93pISejDQMLdzeSHG3Qzo69RqLRLBUu1dSYKC9Ibc8B0qtgUKCSZE
        x+ZdI+jvEEZFT0MKDmjmbEY/ClQwkKWDhKj+qlvPBSa0jf4y42ssE2rMYn6C5Bn5
        G+U8YC2gwpvf3FVRdJivmcSLKGYuu5X6swFLWOBkV0=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cSRPBRppG3Ng; Wed, 18 Sep 2019 15:38:29 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id A7F604122E;
        Wed, 18 Sep 2019 15:38:27 +0300 (MSK)
Received: from bbwork.com (172.17.14.115) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 18
 Sep 2019 15:38:26 +0300
From:   Alexander Filippov <a.filippov@yadro.com>
To:     <linux-aspeed@lists.ozlabs.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Alexander Filippov <a.filippov@yadro.com>
Subject: [PATCH] ARM: dts: vesnin: Add power_green led
Date:   Wed, 18 Sep 2019 15:38:15 +0300
Message-ID: <20190918123815.20653-1-a.filippov@yadro.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.14.115]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a new power_green led to show the host state.

Signed-off-by: Alexander Filippov <a.filippov@yadro.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
index a27c88d23056..affd2c8743b1 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
@@ -43,6 +43,10 @@
 			gpios = <&gpio ASPEED_GPIO(N, 1) GPIO_ACTIVE_LOW>;
 		};
 
+		power_green {
+			gpios = <&gpio ASPEED_GPIO(F, 1) GPIO_ACTIVE_LOW>;
+		};
+
 		id_blue {
 			gpios = <&gpio ASPEED_GPIO(O, 0) GPIO_ACTIVE_LOW>;
 		};
-- 
2.21.0

