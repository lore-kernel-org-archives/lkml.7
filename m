Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4A4C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA2D2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731538AbfCZMcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:32:12 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:57653 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfCZMcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:32:12 -0400
Received: from localhost ([89.247.163.190]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MzCMN-1gmfmZ2RMZ-00wCCK; Tue, 26 Mar 2019 13:31:48 +0100
Date:   Tue, 26 Mar 2019 13:31:47 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] devantech-srf04.txt: remove old DT documentation
Message-ID: <20190326123146.2ru6yu5vea2xha4r@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:J1IvtnjsYDmCbBuLUGJ0KDNWv/mRgevvaCPI/eth5+RFYBVGxfU
 x+GmvmeZgIP9PvNp5Kha1WkP+00Ys0ZQmRSKJaTq0Fd8zJ14Me95m8kc2RAFRYJj0LZgq0x
 ruyVbs+sFhmWZhne+13pewAJDht7clSm3cKFWsXlgvjW0ybVgieKQeH1V/jmhHPzGdakGe1
 dmXZ/oZohD8mKuSbTFD7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TC9I9ebi+zw=:DPv24boWwIo70nut1l8gcJ
 bY70w260yKn1GA+XgIsIfyZaBEWejl6synTmroAUyrday8QpTdzsGRWNfM71nNv4zno5KYFtu
 PmU2N9PDR/snLr2zdlrERkZhHmA1LfXnUB5S0FQ380mX4VUDRee4/rmMM173q2kh8g20k3EXK
 xSk8McVnLzyhiDsicM8g+2cA+KwwFTE7ywHSMku2s76Dbf5h+AxVxIrpVt1xyNceT4A4HWyOF
 mgkEWGC43B2LkOO75gaYrfjElDVzGHwoeIwFSkMJ94RYIzcBze/Ql1fIjThdquu2EvBRoV4mL
 Jw7Xgys3k39u4vZ6EZvV6FvH4OF6IAMpVcjBNdsGMpR8FO2kreGZrXMO3IsL4sc393RCRz3k1
 azHV+2nAzFvr/reitvG37U8q+o4/7LxCGYRku/E4AJSoBArKQkAvoaTkt9pGp5KjevcFQqTyD
 TfbLyaSv0OYJTWf7iR806wlo1bctazwmS4vyUOukmiGEofsLVby8fnGo1dK4Q0xyB6lS1O0mF
 iBLKnbeJDHNMu8u4G3CEalFG6vAwKKpTbfZLt7lRXJSdri3Tdl1yOoUY/NxJT79/OXWYHxLYj
 BMT8I6aGoRRJkGWjcIyuxRBc20xbP+13ek5cOvx+tC+4BmixLuWtMZscLHnGIPOftO2CGZQWy
 I3ggyPcrnTVPCrtyEiOdOTqfIuuRZyxTMVO5nc5XqYGGncnQCPVLycD98qbeqVL8qeRl/hkUF
 JFL+mH/+42O9Pq+an9cQ15pcij+5hwDAWxKtZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove the outdated DT documentation of devantech srf04 iio driver which
is replaced by devantech-srf04.yaml

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../bindings/iio/proximity/devantech-srf04.txt     | 28 ----------------------
 1 file changed, 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt

diff --git a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt
deleted file mode 100644
index d4dc7a227e2e..000000000000
--- a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-* Devantech SRF04 ultrasonic range finder
-  Bit-banging driver using two GPIOs
-
-Required properties:
- - compatible:	Should be "devantech,srf04"
-
- - trig-gpios:	Definition of the GPIO for the triggering (output)
-		This GPIO is set for about 10 us by the driver to tell the
-		device it should initiate the measurement cycle.
-
- - echo-gpios:	Definition of the GPIO for the echo (input)
-		This GPIO is set by the device as soon as an ultrasonic
-		burst is sent out and reset when the first echo is
-		received.
-		Thus this GPIO is set while the ultrasonic waves are doing
-		one round trip.
-		It needs to be an GPIO which is able to deliver an
-		interrupt because the time between two interrupts is
-		measured in the driver.
-		See Documentation/devicetree/bindings/gpio/gpio.txt for
-		information on how to specify a consumer gpio.
-
-Example:
-srf04@0 {
-	compatible = "devantech,srf04";
-	trig-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
-	echo-gpios = <&gpio2  6 GPIO_ACTIVE_HIGH>;
-};
-- 
2.11.0
