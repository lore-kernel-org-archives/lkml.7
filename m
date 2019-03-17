Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05B0C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70212087C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfCQUfj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 16:35:39 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:40277 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfCQUfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 16:35:38 -0400
Received: from localhost ([46.189.28.83]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N6bHC-1gxGm02N2s-01808Z; Sun, 17 Mar 2019 21:35:02 +0100
Date:   Sun, 17 Mar 2019 21:35:00 +0100
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
Subject: [PATCH v3 1/4] dt-bindings: Add vendor prefix for MaxBotix
Message-ID: <20190317203458.bgculdjvtt44zkch@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:PadraYS2CHdeeQ8MfeWDYWE5JnY1aKhKbbmPgDJiLM4EzslKJCb
 mcqth62D4voTEtXSdIbMoQFN46QKybpN1GIROlpKWzeVrZh4u4iu2EwYyAttTa7sAWx1En0
 +qtKvlwNB3QbV7pm98S+i7omI0SCwlkfW8AA/lzoUkV7pLqG0hS0XYKw1EGhn/2Llr+pnXQ
 3VTuKMfV1o2YD5ceuSdXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NqtOF6OOMv0=:F70TIV1pUGUUsy8o53xP3B
 Gvhlm+PClgnAcQ+N9NI3ydrFrD2XGfBaZCYrEjFBp4e6jr3JagMkLkteUukcoMsSG9dq9YSQX
 EZpdBcBdP1Q9EgRKq0QRIkHhVgAQLYLEZbmAzUMNym7bOOSIIFV3dGURE26ylAb2QiOnpFNzk
 5Gw70ubo/uMO/eNPKiQHb1uyFJ8wZ0uekeveUbry5HGmhjtcuprGwp1pdc/QmVZvllKU9bzJH
 P64i+h/0QljVICEFG3PTpFExGM96CT9/iY3fZp42juyy9vbwIyIJryIqXkWxhtWgf3z/dH2qa
 h3PCc8kceg/xNr9zpIReqPO8yePJDdK4ofW9JBn9Zl+FDz9fvBGXLatugevRUtrehmVb4ANBb
 /8GAlvFNa2+csVkZbd6ZZ/RRSjzXjoU+qGGH3zu4WubnxhSNIPZ5ypGP2wKCPhQRL1oGBdSqj
 uST7fQAbnk7zzcCWKTWMkeOmXsbuEvHYbpHwSzWnMQn6F/k2aXZe9lhV5CTwy9liJqRkENVHI
 6EoSrwCSnH1pECeo7ub0kc4wLrRJA8fXl1JjcSqN90LWV9LPpcZe/vGlpCnXr8bnxB0RwC+1v
 iLGlr94picr7azOriwf/Pt7iImwrdfm1IQ0ir1nIE4pynQOGcqaXfRHIPUO3OoN53vqztg6rB
 WgIOxKZI9Y0UReQqRPmzgZB8OJZksEcffAQVmAJkEPMnA0QynC904YAzwQSVgH/cVXxC7VKnQ
 sB04ShpMFDZsLW51ViF514fYoawyLSIMLqKUEg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MaxBotix, which is a vendor of ultrasonic rangers in different
varieties and interfaces.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Reviewed-by: Andreas Färber <afaerber@suse.de>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389508584f48..added54a1108 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -225,6 +225,7 @@ lsi	LSI Corp. (LSI Logic)
 lwn	Liebherr-Werk Nenzing GmbH
 macnica	Macnica Americas
 marvell	Marvell Technology Group Ltd.
+maxbotix	MaxBotix Inc.
 maxim	Maxim Integrated Products
 mbvl	Mobiveil Inc.
 mcube	mCube
-- 
2.11.0
