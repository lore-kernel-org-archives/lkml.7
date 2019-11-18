Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C4DC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DF42071B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="DgErWwwn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfKRKrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 05:47:16 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:41154 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726761AbfKRKrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 05:47:05 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id A56C2437FA;
        Mon, 18 Nov 2019 10:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1574074022; x=1575888423; bh=GLiHq3+6zZ2/iuahpZbFing2AcId/JGBvnZ
        w1df2dRQ=; b=DgErWwwnPvKdMchv4w9kZGj1VUAKnbZRCHtwDcXmMDAIJoz10wd
        5f0l2IJMCnQiGuPXdULAE4YuI7VTmbrphYfr/B0XNjyzwYmJGI7HBXPBGBezlak6
        SYRLPcZSc5FAvr3TM5pU85babdhxvrMO2w1+ZpRtcqrzeY1PavpQrw08=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id h_tS_nHrGAbK; Mon, 18 Nov 2019 13:47:02 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 5AE2E42F13;
        Mon, 18 Nov 2019 13:47:01 +0300 (MSK)
Received: from localhost.dev.yadro.com (172.17.15.69) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Mon, 18 Nov 2019 13:46:59 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <openbmc@lists.ozlabs.org>
Subject: [PATCH v3 1/3] aspeed: dts: add sd card for vesnin
Date:   Mon, 18 Nov 2019 13:46:44 +0300
Message-ID: <20191118104646.3838-2-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191118104646.3838-1-i.mikhaylov@yadro.com>
References: <20191118104646.3838-1-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.69]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presence signal is inverted for vesnin boards, 'cd-inverted' added
for invertion signal enablement. Vesnin BMC uses microSD, there is
no WP switch, 'disable-wp' is used for this purpose.

Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
index a27c88d23056..7ae3436e0d99 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
@@ -232,3 +232,16 @@
 &wdt2 {
 	aspeed,alt-boot;
 };
+
+&sdmmc {
+	status = "okay";
+};
+
+&sdhci1 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sd2_default>;
+	cd-inverted;
+	disable-wp;
+};
-- 
2.20.1

