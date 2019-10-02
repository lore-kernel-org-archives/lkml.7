Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87178ECE58A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550DF222C4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570032496;
	bh=CKWsaVFJ1pyROvRofNrA9Sj5mcok/rVqOa4bO0jGwWY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jw606EOeFGZpKczjr5z0llo9vCkPONlIKdbXQxEkVpFjWfQFAUt4cokTopzvpm/qg
	 h4shSV19kHMwETd5rYIdsg+m5Jvg/7Pm2QDoHrmHpgsTIhFaO56Q+9NEwtaRq0QOBt
	 JA3CpLdSF4dTDgaEhtSEBNyurHklOg66y+UHtWz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfJBQIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 12:08:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728141AbfJBQIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:08:14 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6268A21D81;
        Wed,  2 Oct 2019 16:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570032493;
        bh=CKWsaVFJ1pyROvRofNrA9Sj5mcok/rVqOa4bO0jGwWY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HOgyQ6jTZyuTQSlfcd5EApZtCMwcAA+mL9QuokFlSO7ni1IlPpqFtsQ05do6ZvSjM
         stvNpVocU9CzdcHRUdoKxOm6ISLUvdb0eMcnJomw+YmGmLhDpH6TlkRLOXg6I9MAM5
         JadUGUH+ytR5T56T/0yFJsxQCKmOmjpwTuGwgx0s=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: rtc: s3c: Include generic dt-schema bindings
Date:   Wed,  2 Oct 2019 18:07:43 +0200
Message-Id: <20191002160744.11307-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002160744.11307-1-krzk@kernel.org>
References: <20191002160744.11307-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include the generic rtc.yaml bindings in Samsung S3C RTC bindings.  This
brings the requirement of proper node names and adds parsing of
additional properties.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/rtc/s3c-rtc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml b/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
index 4d91cdc9b998..76bbf8b7555b 100644
--- a/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
@@ -48,6 +48,7 @@ properties:
     maxItems: 2
 
 allOf:
+  - $ref: rtc.yaml#
   - if:
       properties:
         compatible:
-- 
2.17.1

