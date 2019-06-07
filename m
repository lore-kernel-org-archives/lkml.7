Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBB2C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2717B2080C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="Zz3GGW7G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfFGLLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 07:11:43 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:31125 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbfFGLLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 07:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1559905889;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=z2Lawv9tCJkbiMtjftVTXc595vid1xyVceWlHWvLNYs=;
        b=Zz3GGW7G7Yo8KUmRQfhOMyJXG3FylGTMLTtHutz5Myo45QPc8oh6B9Ns/oZW1Iiy1S
        uSrodozZy1drqsX+TsmXf4/3a0HN3SYopBJMN40WfainsicWAo4CqCCh+z5VuTAUfAGE
        5q/Icje+cuDJKCeADoW6PEBsDHrVW7OiPy0sNSnU1iSWkIbprH9fn7dZBKVfXAs60boN
        LafBALv43YUSxDFy0lp4A2tcNRUENvvl3zGE5UGKd6gJQ5/44A46rquVi9FsasDHI7wE
        0y3fSoqsj/7Qg3QysdXaTghnAv1Bz8Wt/Nnebn/xsWIBKjdLjSbqZGO7nDjLjawqlIDC
        lx5w==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0pAwkq13LM="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.22 DYNA|AUTH)
        with ESMTPSA id i01b98v57BBFPaT
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 7 Jun 2019 13:11:15 +0200 (CEST)
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
Subject: [PATCH v3 5/5] dt-bindings: drm/panel: simple: add sharp,lq070y3dg3b panel
Date:   Fri,  7 Jun 2019 13:11:11 +0200
Message-Id: <ee90ed56d2c294ce8ac3b44bf2229c5ab9f85e91.1559905870.git.hns@goldelico.com>
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
 .../bindings/display/panel/sharp,lq070y3dg3b.txt     | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,lq070y3dg3b.txt

diff --git a/Documentation/devicetree/bindings/display/panel/sharp,lq070y3dg3b.txt b/Documentation/devicetree/bindings/display/panel/sharp,lq070y3dg3b.txt
new file mode 100644
index 000000000000..95534b55ee5f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sharp,lq070y3dg3b.txt
@@ -0,0 +1,12 @@
+Sharp LQ070Y3DG3B 7.0" WVGA landscape TFT LCD panel
+
+Required properties:
+- compatible: should be "sharp,lq070y3dg3b"
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

