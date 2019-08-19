Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77352C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8E02184E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfHSJOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 05:14:40 -0400
Received: from ssh248.corpemail.net ([210.51.61.248]:17774 "EHLO
        ssh248.corpemail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfHSJOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 05:14:40 -0400
Received: from ([60.208.111.195])
        by ssh248.corpemail.net (Antispam) with ASMTP (SSL) id KRH58026;
        Mon, 19 Aug 2019 17:14:26 +0800
Received: from localhost (10.100.1.52) by Jtjnmail201617.home.langchao.com
 (10.100.2.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 19 Aug
 2019 17:14:26 +0800
From:   John Wang <wangzqbj@inspur.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <trivial@kernel.org>,
        <linux@roeck-us.net>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
        <duanzhijia01@inspur.com>, <mine260309@gmail.com>, <joel@jms.id.au>
Subject: [PATCH v6 1/2] dt-bindings: Add ipsps1 as a trivial device
Date:   Mon, 19 Aug 2019 17:14:25 +0800
Message-ID: <20190819091425.29094-1-wangzqbj@inspur.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.1.52]
X-ClientProxiedBy: jtjnmail201605.home.langchao.com (10.100.2.5) To
 Jtjnmail201617.home.langchao.com (10.100.2.17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ipsps1 is an Inspur Power System power supply unit

Signed-off-by: John Wang <wangzqbj@inspur.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v6:
    - No changes
v5:
    - No changes
v4:
    - Rebased on 5.3-rc4 instead of 5.2, No changes
v3:
    - Fix adding entry to the inappropriate line
v2:
    - No changes.
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 2e742d399e87..870ac52d2225 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -104,6 +104,8 @@ properties:
           - infineon,slb9645tt
             # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
           - infineon,tlv493d-a1b6
+            # Inspur Power System power supply unit version 1
+          - inspur,ipsps1
             # Intersil ISL29028 Ambient Light and Proximity Sensor
           - isil,isl29028
             # Intersil ISL29030 Ambient Light and Proximity Sensor
-- 
2.17.1

