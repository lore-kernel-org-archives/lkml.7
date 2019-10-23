Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828B7CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A3A21906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390133AbfJWIEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:04:52 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43338 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbfJWIEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:04:51 -0400
Received: by mail-lf1-f66.google.com with SMTP id 21so6315413lft.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 01:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NeqnZ3Qk3e6zBbQjecUiItSUA0qK+Z4aoz7vPDfCcII=;
        b=MlIAsj0ocKuafnoHsWCLvHu5awy5frZSWzEOca9GYF1LSzGHqtc9lD+ser2k9I4VAJ
         5PyYOhiDSAcpFxy+yD6keW64ZikLaox7yRnRbBRD2muAaYOr7MBtlxrHJ/XWIvVY+bYk
         7fK4aAace+3uJsf/Cvu9raHU//AMllshffUsddsDqxmsf5kiDsrLp4HCiXB6/cyWjkEd
         Ib5Kjb1OgRd0KIN5FaAzvb/W+kI2d7CpJb7x239b0yRVhpq+11SevJM3VsKKaEXpJJ+G
         BIQjctipbOn68xtY+tc8DZKgsqLoO9Me+urrLmh40ElgqI/JDL1FKP6gqFcT6iMBKp59
         wm5Q==
X-Gm-Message-State: APjAAAUqNH8rKveGV4Ovw/C7/J0URTKXG8jcP4DM9IbyWTznF2MFYDeS
        8earLx8VCRIaxMZi7OVJjJY=
X-Google-Smtp-Source: APXvYqy0qWG64UvUeq7pFNaTcGlBtxlG5ISmwt1HvKZOrEEwACy8BGRNwOdz82SB67aSa8gQrRkIjA==
X-Received: by 2002:a19:cc47:: with SMTP id c68mr8511862lfg.95.1571817889828;
        Wed, 23 Oct 2019 01:04:49 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id u10sm3155746lfu.94.2019.10.23.01.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 01:04:49 -0700 (PDT)
Date:   Wed, 23 Oct 2019 11:04:27 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        BartlomiejZolnierkiewicz@localhost.localdomain,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] dt-bindings: max77693: fix missing curly brace
Message-ID: <20191023080427.GA18784@localhost.localdomain>
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
---

Resending as I forgot to add the LKML in first attempt. Sorry peeps.

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
