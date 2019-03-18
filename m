Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2315DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B6920879
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="JRrArYqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfCRPOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:14:38 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:24518 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfCRPO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1552922065;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Q3RUb7P1cGK2igFBjOnY9Ll/7tHJl44vEFOExhuJ7SY=;
        b=JRrArYqTH9toWthTJ6av5T/5hW5e3WgBMn6ArJSaY4oPdw2HclCBXFluaZQN5ydMjy
        27xlqRDpBUnKliO7+ef5gYVIHQd7ghGIbampjqYP7wt0RC0SGH7vJGnIfmpJFU3qeg5a
        BSz2X8oquPmiuGQfk0+e6uUspP35mj0+4l6F6isf+Nsgy9jZYeCEQtvcc/GJmcvkxBba
        ZxvOLvWkHVRSR7+jO7ew0KC9Znec49iW2pAeJqpKw99ZEZs4AEk2l5wVjuY/JbKDk/6B
        JTMxtloY5VrcZe9NF7QW9Kx5zSreAwQETMBVKUwyTOD92sS0Xr86fcAogYGaO+bydWfa
        2EOg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M7O2CKNdGj"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.16 DYNA|AUTH)
        with ESMTPSA id h04075v2IFEHEjj
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 18 Mar 2019 16:14:17 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Subject: [PATCH 2/2] dt-bindings: iio: add Bosch BMG160 gyroscope sensor
Date:   Mon, 18 Mar 2019 16:14:15 +0100
Message-Id: <1664da2e7a9cb687eece1f27501d275219bcc4ed.1552922054.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1552922054.git.hns@goldelico.com>
References: <cover.1552922054.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define bindings for "bosch,bmg160" and "bosch,bmi055_gyro".

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 .../bindings/iio/gyroscope/bmg160.txt         | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/bmg160.txt

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/bmg160.txt b/Documentation/devicetree/bindings/iio/gyroscope/bmg160.txt
new file mode 100644
index 000000000000..78e18a1e9c1d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/gyroscope/bmg160.txt
@@ -0,0 +1,20 @@
+* Bosch BMG160 triaxial rotation sensor (gyroscope)
+
+Required properties:
+
+  - compatible : should be "bosch,bmg160" or "bosch,bmi055_gyro"
+  - reg : the I2C address of the sensor (0x69)
+
+Optional properties:
+
+  - interrupts : interrupt mapping for GPIO IRQ, it should by configured with
+		flags IRQ_TYPE_EDGE_RISING
+
+Example:
+
+bmg160@69 {
+	compatible = "bosch,bmg160";
+	reg = <0x69>;
+	interrupt-parent = <&gpio6>;
+	interrupts = <18 (IRQ_TYPE_EDGE_RISING)>;
+};
-- 
2.19.1

