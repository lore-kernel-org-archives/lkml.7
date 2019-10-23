Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8CBCA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC4021A4A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390928AbfJWJex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:34:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40475 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390165AbfJWJew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:34:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id u22so2314665lji.7;
        Wed, 23 Oct 2019 02:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sEQ9zSFknQ5RX9v6VO5JzIVVMvyimeBxeFDrpRcw3v8=;
        b=cwqPZr2DhJ7AkUuJAY/hQmSKlmwtTlt46sMIsXOROzfhDNbGAp/daW6uauhwpAl2li
         WcItL+9qnoyPyVk/KjjpG0atLm0ahX/UQZuskwuVS5CIY1lnozLPcK2rLegyMfBB57LO
         vyNQhJATJoSKAKOxVl71hh6w5FapBzCxn9TzR64hLswaETrpj3FK38BekP86suXPeV5z
         WWuG041Prb9Hp++f4lFuOgfbhe3pu7PcsD9c+7xpYFxtc/4sREHu4FA2dA1trwjwOagV
         xLS3Ng+Om6GXPTGKizBYAAoGC/04jJPfqGTUnaQmWRQb0nnEbwJ5Cj5GnSRLg+8W+W1p
         ZOKA==
X-Gm-Message-State: APjAAAWhgbtECfWT5ddFNQTIGLC97cf3X132w7zY2j1BPaY5RwSlgVg9
        T+8I9F8sz32pDcrPM0oWjmo=
X-Google-Smtp-Source: APXvYqzOztLkcfZE4lM2Jhw5qA4q5TDB61647ftMC4bUulC9/P9LlKwlAqZtIgZqea7TnsB2Nf3w3w==
X-Received: by 2002:a2e:9691:: with SMTP id q17mr5831618lji.223.1571823290485;
        Wed, 23 Oct 2019 02:34:50 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id g3sm10040533lja.61.2019.10.23.02.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 02:34:49 -0700 (PDT)
Date:   Wed, 23 Oct 2019 12:34:37 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH RESEND 2] dt-bindings: max77693: fix missing curly brace
Message-ID: <20191023093437.GA30570@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing curly brace to charger node example.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---

Resending once more.  Sorry again guys. This time I added also the DT folks
and used correct email for Bartlomiej.

 Documentation/devicetree/bindings/mfd/max77693.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/max77693.txt b/Documentation/devicetree/bindings/mfd/max77693.txt
index a3c60a7a3be1..0ced96e16c16 100644
--- a/Documentation/devicetree/bindings/mfd/max77693.txt
+++ b/Documentation/devicetree/bindings/mfd/max77693.txt
@@ -175,6 +175,7 @@ Example:
 			maxim,thermal-regulation-celsius = <75>;
 			maxim,battery-overcurrent-microamp = <3000000>;
 			maxim,charge-input-threshold-microvolt = <4300000>;
+		};
 
 		led {
 			compatible = "maxim,max77693-led";
-- 
2.21.0


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
