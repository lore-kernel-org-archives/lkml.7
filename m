Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89438C76186
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 19:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F33208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 19:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388313AbfG0T7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 15:59:42 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:47129 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388264AbfG0T7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 15:59:38 -0400
X-Originating-IP: 195.189.32.242
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 0BC83E0004;
        Sat, 27 Jul 2019 19:59:34 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: iio/adc: Add AUX2 channel idx for JZ4770 SoC ADC
Date:   Sat, 27 Jul 2019 21:59:39 +0200
Message-Id: <20190727195940.14010-2-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190727195940.14010-1-contact@artur-rojek.eu>
References: <20190727195940.14010-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce support for AUX2 channel found in ADC hardware present on
Ingenic JZ4770 SoC.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes:

v2: no change

 include/dt-bindings/iio/adc/ingenic,adc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/iio/adc/ingenic,adc.h b/include/dt-bindings/iio/adc/ingenic,adc.h
index 82706b2706ac..42f871ab3272 100644
--- a/include/dt-bindings/iio/adc/ingenic,adc.h
+++ b/include/dt-bindings/iio/adc/ingenic,adc.h
@@ -6,5 +6,6 @@
 /* ADC channel idx. */
 #define INGENIC_ADC_AUX		0
 #define INGENIC_ADC_BATTERY	1
+#define INGENIC_ADC_AUX2	2
 
 #endif
-- 
2.22.0

