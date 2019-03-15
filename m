Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F82C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F4B218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="iiljei4R";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="iiljei4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfCOVys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:54:48 -0400
Received: from node.akkea.ca ([192.155.83.177]:35194 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbfCOVyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:54:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 6CBE74E2050;
        Fri, 15 Mar 2019 21:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1552686882; bh=BsalUFUGDnuU1gmk1OM0HEsQ97AZH5ENK6vFAeLWEas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iiljei4Re7/vqAELvXd6EkSLRRjwLjRRtvMBhXZxqmullNsoYL3UWmlKTeLfa0Hrh
         MrU8YR0V+WgKUk4bbXOtJna/T2tiwPhzgx+mvZJssS3RMD2hyJvXtlIIgFyVNVrBQU
         yxV6ystmUwQr4JpXggrtRM/bc+rGRoEqYe6CREZ4=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Qjs8QZLnqIGv; Fri, 15 Mar 2019 21:54:42 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 6234E4E204B;
        Fri, 15 Mar 2019 21:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1552686882; bh=BsalUFUGDnuU1gmk1OM0HEsQ97AZH5ENK6vFAeLWEas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iiljei4Re7/vqAELvXd6EkSLRRjwLjRRtvMBhXZxqmullNsoYL3UWmlKTeLfa0Hrh
         MrU8YR0V+WgKUk4bbXOtJna/T2tiwPhzgx+mvZJssS3RMD2hyJvXtlIIgFyVNVrBQU
         yxV6ystmUwQr4JpXggrtRM/bc+rGRoEqYe6CREZ4=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tomas Novotny <tomas@novotny.cz>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Brian Masney <masneyb@onstation.org>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Parthiban Nallathambi <pn@denx.de>, ryang <decatf@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: iio: light: Document the VCNL4xx0 device tree bindings
Date:   Fri, 15 Mar 2019 14:54:25 -0700
Message-Id: <20190315215425.24140-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190315215425.24140-1-angus@akkea.ca>
References: <20190315215425.24140-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devicetree hooks where added to the VCNL4xx0 light and proximity
sensor driver.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 .../devicetree/bindings/iio/light/vcnl4xx0.txt    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4xx0.txt

diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4xx0.txt b/Documentation/devicetree/bindings/iio/light/vcnl4xx0.txt
new file mode 100644
index 000000000000..d61cf3c121c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/vcnl4xx0.txt
@@ -0,0 +1,15 @@
+VISHAY VCNL4xx0 -  Ambient Light and proximity sensor
+
+This driver supports the VCNL4000/10/20/40 and VCNL4200
+
+Required properties:
+
+	-compatible: should be "vishay,vcnl4000" or "vishay,vcnl4040"
+	-reg: I2C address of the sensor, should be 0x60
+
+Example:
+
+light-sensor@60 {
+	compatible = "vishay,vcnl4040";
+	reg = <0x60>;
+};
-- 
2.17.1

