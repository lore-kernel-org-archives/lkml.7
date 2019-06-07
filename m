Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95D1C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B517E2080C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="EMO5sv3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbfFGLLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 07:11:35 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:26095 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbfFGLLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 07:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1559905889;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=YxaKPjqXcTdJ1RT47nqVNBUPSDUyfTIHs2pr3yZQlAE=;
        b=EMO5sv3/EpKhB7M0tA0VWX3TBo+QXCfDJo7zVrAsEEa1DUafDK6ewtZeTVKxchOWiU
        Xvhpe88EOvDzdhyTu4iEfrvLDPt6YrrOCyhqvI0D5q3xcsxCDRa4a1tA0OXqVYRXAPP0
        DLOVn2161eaAtcxg7Va7Jh13A/vp7Jk76W0GUqOZe3QY4CXPje/5eOOhpycxmZk1cv68
        5YvBSxPK5x/EiqCyBV5D1/YeLVLxYrZhmygC2hxMJIz+k0vNdKRY2qR7LM4nYsqd+AUZ
        S5MzmKESbwXl4fP8ehAFvEFnyPDSGW3Ocf2DWJe7o0BqaQi6anzRtdHYy4tqsEw4mlGX
        qIOA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0pAwkq13LM="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.22 DYNA|AUTH)
        with ESMTPSA id i01b98v57BBEPaR
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 7 Jun 2019 13:11:14 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, tomi.valkeinen@ti.com,
        imirkin@alum.mit.edu, marek.belisko@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, letux-kernel@openphoenux.org,
        devicetree@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 3/5] dt-bindings: drm/panel: simple: add ortustech,com37h3m05dtc panel
Date:   Fri,  7 Jun 2019 13:11:09 +0200
Message-Id: <a650cb8df1bdf58ec3c8a182532692db16b77f70.1559905870.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559905870.git.hns@goldelico.com>
References: <cover.1559905870.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 .../display/panel/ortustech,com37h3m05dtc.txt        | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ortustech,com37h3m05dtc.txt

diff --git a/Documentation/devicetree/bindings/display/panel/ortustech,com37h3m05dtc.txt b/Documentation/devicetree/bindings/display/panel/ortustech,com37h3m05dtc.txt
new file mode 100644
index 000000000000..c16907c02f80
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ortustech,com37h3m05dtc.txt
@@ -0,0 +1,12 @@
+OrtusTech COM37H3M05DTC Blanview 3.7" VGA portrait TFT-LCD panel
+
+Required properties:
+- compatible: should be "ortustech,com37h3m05dtc"
+
+Optional properties:
+- enable-gpios: GPIO pin to enable or disable the panel
+- backlight: phandle of the backlight device attached to the panel
+- power-supply: phandle of the regulator that provides the supply voltage
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
-- 
2.19.1

