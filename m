Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAAEC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F8A205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfFZKiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 06:38:04 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:54570 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727172AbfFZKiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:38:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 9F0B2FB06;
        Wed, 26 Jun 2019 12:37:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wWQJtkj0v59K; Wed, 26 Jun 2019 12:37:53 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 9CEEE48EB1; Wed, 26 Jun 2019 12:37:51 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Purism Kernel Team <kernel@puri.sm>
Subject: [PATCH v2 3/4] dt-bindings: display/panel: jh057n00900: Document power supply properties
Date:   Wed, 26 Jun 2019 12:37:50 +0200
Message-Id: <ec5ee11786036dc8826a3f8555cbb1dce4dbca25.1561542477.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1561542477.git.agx@sigxcpu.org>
References: <cover.1561542477.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the vcc-supply and iovcc-supply properties of the Rocktech
jh057n00900 panel.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 .../bindings/display/panel/rocktech,jh057n00900.txt          | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
index 1b5763200cf6..a372c5d84695 100644
--- a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
+++ b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
@@ -5,6 +5,9 @@ Required properties:
 - reg: DSI virtual channel of the peripheral
 - reset-gpios: panel reset gpio
 - backlight: phandle of the backlight device attached to the panel
+- vcc-supply: phandle of the regulator that provides the vcc supply voltage.
+- iovcc-supply: phandle of the regulator that provides the iovcc supply
+  voltage.
 
 Example:
 
@@ -14,5 +17,7 @@ Example:
 			reg = <0>;
 			backlight = <&backlight>;
 			reset-gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
+			vcc-supply = <&reg_2v8_p>;
+			iovcc-supply = <&reg_1v8_p>;
 		};
 	};
-- 
2.20.1

