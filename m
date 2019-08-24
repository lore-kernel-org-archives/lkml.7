Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF787C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A082520870
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="HLCnPEdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfHXU1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 16:27:11 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:12354 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727936AbfHXU06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 16:26:58 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 46G8sD20xTzX0;
        Sat, 24 Aug 2019 22:25:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1566678320; bh=yiTBq/DuyyKpDzXcgmYnUpaUSvdYXCpYBzYX6OrpC7I=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=HLCnPEdysqXSybASSetiJ6esb3pO/zLIItQaTDSr67J6FCKz1PPgVwOOhCbB4TBCB
         M0Z+QxSH05CeMcGS/qR0f9fZdjzJR8KUIgdKZgrGn+ao8YB4vGqo447fFXkW8EAa3N
         nCJN3DViDPex2opeTdzbwSm38sVs4n741ohb3XIa1qTVmNE5CCxShpM8GG/TBUMIdY
         mWZFJFXf/hvWrJF4GyRkOPdquVFpeWAoKk1vk7SZDd12eCl+6MVqSOcV713Bu4xKdB
         mPIe/UQjcm9XW53v8vEoLjzG0dFELFIwSRQ42ngEyNOHCJFjron35FaM+RJ+Aojm78
         vrYzHXR0Wp85Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.2 at mail
Date:   Sat, 24 Aug 2019 22:26:55 +0200
Message-Id: <9b85d5a7c7e788e9ed87d020323ad9292e3aeab7.1566677788.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1566677788.git.mirq-linux@rere.qmqm.pl>
References: <cover.1566677788.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 4/6] dt-bindings: misc: atmel-ssc: LRCLK from TF/RF pin
 option
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chas Williams <3chas3@gmail.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh-dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add single-pin LRCLK source options for Atmel SSC module.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

---
  v2: split from implementation patch

---
 Documentation/devicetree/bindings/misc/atmel-ssc.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/atmel-ssc.txt b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
index f9fb412642fe..c98e96dbec3a 100644
--- a/Documentation/devicetree/bindings/misc/atmel-ssc.txt
+++ b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
@@ -24,6 +24,11 @@ Optional properties:
        this parameter to choose where the clock from.
      - By default the clock is from TK pin, if the clock from RK pin, this
        property is needed.
+  - atmel,lrclk-from-tf-pin: bool property.
+  - atmel,lrclk-from-rf-pin: bool property.
+     - SSC in slave mode gets LRCLK from RF for receive and TF for transmit
+       data direction. This property makes both use single TF (or RF) pin
+       as LRCLK. At most one can be present.
   - #sound-dai-cells: Should contain <0>.
      - This property makes the SSC into an automatically registered DAI.
 
-- 
2.20.1

