Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BEEC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FAB21019
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="WXT5Y5ee";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="WXT5Y5ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfCQPsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 11:48:19 -0400
Received: from node.akkea.ca ([192.155.83.177]:34300 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727400AbfCQPsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 11:48:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 5C8E84E204E;
        Sun, 17 Mar 2019 15:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1552837693; bh=YtdSndT+Zi4H2ytZ+tYpf/nUtlDxjWqNqGUqu3RpO8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WXT5Y5eeTyc94+vTc0/e37cDBh224BQxoN7p9x9PnbPeRbt8H41sFu/IkjzHPuEym
         GarIvKTRJcwrA1YbjoAXtsajd6LEqXzhUf5Poe9qrE+Mpc7gA2zuk10g52+1ZA787x
         7gg3Y7bB5WotLxXnQysjN3PGLYJwNmHVforpDq1c=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xYlyr1HGZOkk; Sun, 17 Mar 2019 15:48:13 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 7C1714E204D;
        Sun, 17 Mar 2019 15:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1552837693; bh=YtdSndT+Zi4H2ytZ+tYpf/nUtlDxjWqNqGUqu3RpO8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WXT5Y5eeTyc94+vTc0/e37cDBh224BQxoN7p9x9PnbPeRbt8H41sFu/IkjzHPuEym
         GarIvKTRJcwrA1YbjoAXtsajd6LEqXzhUf5Poe9qrE+Mpc7gA2zuk10g52+1ZA787x
         7gg3Y7bB5WotLxXnQysjN3PGLYJwNmHVforpDq1c=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Tomas Novotny <tomas@novotny.cz>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] dt-bindings: iio: light: add vcnl4040 devicetree bindings
Date:   Sun, 17 Mar 2019 08:48:02 -0700
Message-Id: <20190317154802.15174-6-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190317154802.15174-1-angus@akkea.ca>
References: <20190317154802.15174-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the vishay VCNL4040 devicetree bindings.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 Documentation/devicetree/bindings/iio/light/vcnl4000.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4000.txt b/Documentation/devicetree/bindings/iio/light/vcnl4000.txt
index 4a9d558a412a..955af4555c90 100644
--- a/Documentation/devicetree/bindings/iio/light/vcnl4000.txt
+++ b/Documentation/devicetree/bindings/iio/light/vcnl4000.txt
@@ -1,6 +1,6 @@
 VISHAY VCNL4000 -  Ambient Light and proximity sensor
 
-This driver supports the VCNL4000/10/20 and VCNL4200 chips
+This driver supports the VCNL4000/10/20/40 and VCNL4200 chips
 
 Required properties:
 
@@ -8,11 +8,13 @@ Required properties:
         vishay,vcnl4000
         vishay,vcnl4010
         vishay,vcnl4020
+        vishay,vcnl4040
         vishay,vcnl4200
 
 	-reg: I2C address of the sensor, should be one from below based on the model:
         0x13
         0x51
+        0x60
 
 Example:
 
-- 
2.17.1

