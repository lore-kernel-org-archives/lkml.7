Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E15C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E612087C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfCQUjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 16:39:08 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:33085 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfCQUjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 16:39:08 -0400
Received: from localhost ([46.189.28.64]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M2fM1-1h23ui0Ypj-004CDZ; Sun, 17 Mar 2019 21:38:31 +0100
Date:   Sun, 17 Mar 2019 21:38:29 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        afaerber@suse.de, arnd@arndb.de, davem@davemloft.net,
        gregkh@linuxfoundation.org, johan@kernel.org, khilman@baylibre.com,
        knaack.h@gmx.de, lars@metafoo.de, linux-kernel@vger.kernel.org,
        martin.blumenstingl@googlemail.com, mchehab+samsung@kernel.org,
        m.othacehe@gmail.com, nicolas.ferre@microchip.com,
        pmeerw@pmeerw.net, robh@kernel.org, songqiang1304521@gmail.com,
        treding@nvidia.com, techsupport@maxbotix.com
Subject: [PATCH v3 4/4] MAINTAINERS: add maintainer for maxbotix ultrasonic
 driver
Message-ID: <20190317203827.ocgsj24itlqzqjvc@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:qPNL7kc4ifmmZvoWQ1c7Q0xrViiHLGYKe4xdT643yPVyEPmTonq
 OGfvCOxVUMJaKI/vpimJr7l5tPKVy5xP/C+7udw5VGRI+Mv7eXr24iYAKe2ccY7KTo5xfTa
 sx94EMhpLvJIskwsROn9HUJ2uOxEXVVdIXN97TZwUvC+gOxxIA9QlgMVdqBOGKlT/RoWvtx
 ixGeAn3k8O9De+M4ZlHPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:31Xcbi7fnYw=:gTJHj9gWotClFEx0uc7VNk
 j4Hi8yaDqPOG7cOYDUbDukyPU/jhCXxhsrhNYvr5gCpdTMWodloSOs8FwR0+HCO/86ugQZokw
 TSnsnpzkh2dzX7/NSS/llmx1qC0wj5IxlEDg1ZOAQlLIh2jepc+lHVM1KLZ2QEyk5jmbANwQ5
 OioSa/67jUesM2jo8PLu8jwqxzSeFP3cTMXkpgUVekRsvlIGH9kllKAzYXscOYC3OrLPypVUJ
 umbZcpYq+nTfqeSh+FbP6U51NhSdlVpE2wxyP2X2DhE3evzSNQdBi5HjEQA6lBimNwNCStvHl
 ixpCZYNvRAbYZTCL5fLtayVgOzPJcYT+pJ6T1+tYt+y+k4/YYs0zh1eh2kvJF2NTQDQu3x292
 +6te1+f6lh8KnLUI6lGRZ8B5U0QGdZiF8Oz7IE8Te8dsvqoRCSObf5HWPNS4dE4hnSFueFtJI
 qdnBPhlrbOn/O0UUVhxb+xpnY9Qxkv1mNTna/hKVjJRB78gqWy1ojD8KIgX3u3oOn3ZuplYEx
 k0La4ZnMxnreZzNspJ9BGaSXPdFxi+IClSoUhvDMo8vWW8oxRfPBHryxbLm3gSu55hLvpHShk
 B5wKQShco7P3bTf+mQN1SfntIsSVcL45c5x2hGP7I3/unafgBffxaxyU7sJOQqK7dtsbKIRBh
 Ea7DHZecg0XDsM/F2YArF/4b5HjDZRa3E4yBy4wgduiuPPlgLJ7WPGFLO3DIaPwmt26Ikg88A
 7YQY8XYITL+bry4+1gWRAD7E1sfJwjZXHKWCTQ6bx632/5eFJG+yp6O2NewDTVUqTLy2aupaz
 yKOsM7Op6AHluECfOCMaU/HI42wPEnkDaUQTKCmfMDP2VYx1XkTwvxMqE3PfsflA4piO0h1Bn
 7qi4fk2nYv4iv92WbPhhHSvQ0D2UiTyCwRdwrAQQThVp06cddc6xaDY6uJYwuPC7QVwOwFqxo
 7jOro3khI4w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add a maintainer for the newly created ultrasonic driver family of maxbotix

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dce5c099f43c..fa054f8cc7fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9234,6 +9234,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/max9860.txt
 F:	sound/soc/codecs/max9860.*
 
+MAXBOTIX ULTRASONIC RANGER IIO DRIVER
+M:	Andreas Klinger <ak@it-klinger.de>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt
+F:	drivers/iio/proximity/mb1232.c
+
 MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
 M:	Javier Martinez Canillas <javier@dowhile0.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.11.0
