Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00592C00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F202077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfLINBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 08:01:15 -0500
Received: from out28-51.mail.aliyun.com ([115.124.28.51]:57134 "EHLO
        out28-51.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfLINBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 08:01:13 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09192725|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.525217-0.0198122-0.454971;DS=CONTINUE|ham_system_inform|0.0142513-0.000678578-0.98507;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16384;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=22;RT=22;SR=0;TI=SMTPD_---.GDcmOki_1575896441;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.GDcmOki_1575896441)
          by smtp.aliyun-inc.com(10.147.41.138);
          Mon, 09 Dec 2019 21:00:58 +0800
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
Subject: [PATCH v7 3/6] dt-bindings: MIPS: Add Ingenic XBurst based boards.
Date:   Mon,  9 Dec 2019 21:00:35 +0800
Message-Id: <1575896438-9562-4-git-send-email-zhouyanjie@wanyeetech.com>
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

Add Ingenic XBurst based boards, prepare for later dts.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---

Notes:
    v1->v2:
    No change.
    
    v2->v3:
    No change.
    
    v3->v4:
    Adjust the description to make it more reasonable.
    
    v4->v5:
    Adjust item naming to prevent conflicts with
    subsequent "CU Geo" boards.
    
    v5->v6:
    No change.
    
    v6->v7:
    Change my Signed-off-by from "Zhou Yanjie <zhouyanjie@zoho.com>"
    to "周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>" because
    the old mailbox is in an unstable state.

 .../devicetree/bindings/mips/ingenic/devices.yaml  | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/ingenic/devices.yaml

diff --git a/Documentation/devicetree/bindings/mips/ingenic/devices.yaml b/Documentation/devicetree/bindings/mips/ingenic/devices.yaml
new file mode 100644
index 00000000..78dcf6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/ingenic/devices.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mips/ingenic/devices.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ingenic XBurst based Platforms Device Tree Bindings
+
+maintainers:
+  - 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
+description: |
+  Devices with a Ingenic XBurst CPU shall have the following properties.
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+
+      - description: Qi Hardware Ben NanoNote
+        items:
+          - const: qi,lb60
+
+      - description: Game Consoles Worldwide GCW Zero
+        items:
+          - const: gcw,zero
+
+      - description: MIPS Creator CI20
+        items:
+          - const: img,ci20
+
+      - description: YSH & ATIL General Board CU Neo
+        items:
+          - const: yna,cu1000-neo
+...
-- 
2.7.4

