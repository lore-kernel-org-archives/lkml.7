Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92325C00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688F62077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfLINBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 08:01:22 -0500
Received: from out28-4.mail.aliyun.com ([115.124.28.4]:47818 "EHLO
        out28-4.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfLINBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 08:01:20 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3932429|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.177335-0.0135809-0.809084;DS=CONTINUE|ham_social|0.0124556-0.000255543-0.987289;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03311;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=22;RT=22;SR=0;TI=SMTPD_---.GDcmOki_1575896441;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.GDcmOki_1575896441)
          by smtp.aliyun-inc.com(10.147.41.138);
          Mon, 09 Dec 2019 21:00:56 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, paulburton@kernel.org,
        jhogan@kernel.org, mripard@kernel.org, shawnguo@kernel.org,
        mark.rutland@arm.com, ebiederm@xmission.com, ralf@linux-mips.org,
        heiko@sntech.de, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, krzk@kernel.org,
        geert+renesas@glider.be, paul@crapouillou.net,
        prasannatsmkumar@gmail.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, 772753199@qq.com
Subject: [PATCH v7 2/6] dt-bindings: Document yna vendor-prefix.
Date:   Mon,  9 Dec 2019 21:00:34 +0800
Message-Id: <1575896438-9562-3-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575896438-9562-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1575896438-9562-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "yna" is an acronym of the "YSH & ATIL".

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---

Notes:
    v1->v2:
    No change.
    
    v2->v3:
    No change.
    
    v3->v4:
    No change.
    
    v4->v5:
    No change.
    
    v5->v6:
    No change.
    
    v6->v7:
    Change my Signed-off-by from "Zhou Yanjie <zhouyanjie@zoho.com>"
    to "周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>" because
    the old mailbox is in an unstable state.

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 967e78c..47ddd88 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1054,6 +1054,8 @@ patternProperties:
     description: Xilinx
   "^xunlong,.*":
     description: Shenzhen Xunlong Software CO.,Limited
+  "^yna,.*":
+    description: YSH & ATIL
   "^yones-toptech,.*":
     description: Yones Toptech Co., Ltd.
   "^ysoft,.*":
-- 
2.7.4

