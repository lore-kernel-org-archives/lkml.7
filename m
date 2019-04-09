Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87C7C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0462084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfDITLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:11:21 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:44423 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfDITLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 15:11:21 -0400
Received: from localhost ([2.171.41.193]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MfZ9C-1ggoK83GMS-00g2KU; Tue, 09 Apr 2019 21:10:56 +0200
Date:   Tue, 9 Apr 2019 21:10:55 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        songqiang1304521@gmail.com, robh@kernel.org, m.othacehe@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/3] devantech-srf04.yaml: add Maxbotix ultrasonic iio
 proximity sensors
Message-ID: <20190409191054.va6y2l5lyhyoo5p4@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:p1NqKgFr89i3dKH9K5oUkFO5Im4IcAVaAra/mTLITGBfWBekWkN
 jJsnO8i9Z/EeSt5ozmCNVXqjK6T4VLxb2wGhz4aRxR+/DZCE/LafvYRSQFaxFvv0zA9aOy6
 fk+CTEQPLV5nS2MDgZgFQ3RetfaAowWP98crSjjR4hvR0nZu0ft2PhjWB5crVrShaTxLWNh
 YAoh73LNsJmu9CwmfcASg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SBxbRLpUIns=:+yqKsjmR38CQ3XPYj3JT9x
 JMyrgxsa0VSs87kpDoCquMXz/gLDiPSHE4kNAkDhZOqI0Xrm4uEWisla02Z9dM3WncA4d7BPt
 aF/4RQyuaYW6tbvYAW7Pcz//4/QIMrUpDvFuRdit6uTVIGnSyp3CFzzJfxRMdkpuO0lJo9ZDb
 NzqAOV4AncVZQgMK52Y6ar9U2ISwTDaCFwtG9Z+cue03z9tLYhlx+DOw6ttKxB/Dzj5ki+53r
 zJfOCZQuDCYxoOE7j9e3+/x/PLFr8erq4uMtyGJQgzI85HnebGjR41mFFJWz1uNPN2u+qHk7b
 nULVEK2vrABmTQiQFgp0UfZOhOyBfhsaALdFIL+MQVXkU9iSqJnYzf6Zc1Gl6A5/32ZhyM3W8
 Xgl8DfaaGh0cFInzDXwFPAjgNpaySRvg9aeCFkEBSRA//2DV4QDorTTsuhwxoAS7pMGeO8S15
 mol6eTiqOtloKNvMCv4MFunUZF2zO77vDCAC6zYmh7FliqQJ+NZ3dr4lYINhzJKwYbNgBKGjQ
 MZW0hJrSpmKB1blGmNnD3mzT7VLdoXawSMaoCgePDwe0XgQn9/5rI70nMZm/OKoea4FC+n8O+
 P5m5cXdzd4UMggBGNhbvmAaj8udPHIe3lLc41vjylV7UWz0K1tMuyHDEzXnNbXT/TvgB0HDwM
 DtKNGbNhjDnczYpygUXeKZvxpVDDYX4oCoICxXI/NjhxFfbp1SPmWUY6quYckAMQeszcJURwU
 BZ1RDKqRqRt95ZjsPY3FMif/PICKrgK6Gdurrg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add compatibles for Maxbotix ultrasonic iio sensor types to yaml
documentation

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../bindings/iio/proximity/devantech-srf04.yaml    | 25 ++++++++++++++--------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
index e7aab785c97d..4e80ea7c1475 100644
--- a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/proximity/devantech-srf04.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Devantech SRF04 ultrasonic range finder
+title: Devantech SRF04 and Maxbotix mb1000 ultrasonic range finder
 
 maintainers:
   - Andreas Klinger <ak@it-klinger.de>
@@ -16,19 +16,28 @@ description: |
   - echo-gpio is held high by the sensor after sending ultrasonic burst
     until it is received once again
 
-  Specifications about the driver can be found at:
+  Specifications about the devices can be found at:
   http://www.robot-electronics.co.uk/htm/srf04tech.htm
 
+  http://www.maxbotix.com/documents/LV-MaxSonar-EZ_Datasheet.pdf
+
 properties:
   compatible:
-    items:
-      - const: devantech,srf04
+    enum:
+      - devantech,srf04
+      - maxbotix,mb1000
+      - maxbotix,mb1010
+      - maxbotix,mb1020
+      - maxbotix,mb1030
+      - maxbotix,mb1040
 
   trig-gpios:
     description:
-      Definition of the GPIO for the triggering (output) This GPIO is set
-      for about 10 us by the driver to tell the device it should initiate
-      the measurement cycle.
+      Definition of the GPIO for the triggering (output)
+      This GPIO is set for about 10 us by the driver to tell the device it
+      should initiate the measurement cycle.
+      See Documentation/devicetree/bindings/gpio/gpio.txt for information
+      on how to specify a consumer gpio.
     maxItems: 1
 
   echo-gpios:
@@ -40,8 +49,6 @@ properties:
       trip.
       It needs to be an GPIO which is able to deliver an interrupt because
       the time between two interrupts is measured in the driver.
-      See Documentation/devicetree/bindings/gpio/gpio.txt for information
-      on how to specify a consumer gpio.
     maxItems: 1
 
 required:
-- 
2.11.0
