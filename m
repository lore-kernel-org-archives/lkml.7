Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D88C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 12:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFADD20896
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 12:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfDNMib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 08:38:31 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:52201 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfDNMib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 08:38:31 -0400
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 8D675200011;
        Sun, 14 Apr 2019 12:38:27 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: power: supply: Add charge-status-gpios property
Date:   Sun, 14 Apr 2019 14:40:38 +0200
Message-Id: <20190414124039.10040-1-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the "charge-status-gpios" property.
Update the "gpios" property with a valid example.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes:

v2: - add a better description for the "status-gpios" property,
    - add valid examples for the "gpios" and "status-gpios" properties

v3: rename the "status-gpios" property to "charge-status-gpios"

 .../devicetree/bindings/power/supply/gpio-charger.txt       | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
index adbb5dc5b6e9..30349332f051 100644
--- a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
+++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
@@ -14,12 +14,16 @@ Required properties :
      usb-cdp (USB charging downstream port)
      usb-aca (USB accessory charger adapter)
 
+Optional properties:
+ - charge-status-gpios: GPIO indicating whether a battery is charging.
+
 Example:
 
 	usb_charger: charger {
 		compatible = "gpio-charger";
 		charger-type = "usb-sdp";
-		gpios = <&gpf0 2 0 0 0>;
+		gpios = <&gpd 28 GPIO_ACTIVE_LOW>;
+		charge-status-gpios = <&gpc 27 GPIO_ACTIVE_LOW>;
 	}
 
 	battery {
-- 
2.21.0

