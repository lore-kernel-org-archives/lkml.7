Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E37C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E18E2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388817AbfFMPYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:24:38 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39100 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731606AbfFMMMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 08:12:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id p24so14885117lfo.6;
        Thu, 13 Jun 2019 05:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XhtZI7k0VVvHM8QZXtOQ9F9iiJHYuRfCT1gdZGw08zI=;
        b=bIdH2W7mljYwcHs8OZiAD5+vvOZuRYZUmdpaUB2APG2hJOCBboGwBGTg9VVf77lYF/
         IihvK8kaFh8tUdM1cw212vTPJbeg3rrOO3RyN9r4wV5FGGIS+mNBUHiQ3G4XcLFP1alJ
         Ldeov/NWs7X39+rX+Vqup7nKBr44+KxBqTdmcOnk9m6+jokqMRCRwNf8IFVmzF2svuRS
         vwsX+yvfKJZOYr/pskcjZFnl9zqlcrCEXjE82lnkjsIRVe7CR6B++QFobt75JhhaU2Lw
         rCFrV8ETNwgGecLxeTlRJC2uHTOMdMwwFZeL/I1Qnw254c46cA2N21YvFUhU131LUJnh
         D7Ww==
X-Gm-Message-State: APjAAAWG11i28YBKnrYuQ3B5Z0AK/kUW6NlBOknyUkx/1NsxETyStXbF
        s4ygThTjSDkHFl2xcHuVAv0=
X-Google-Smtp-Source: APXvYqzeODloMIOcd+0FfBvjnIDFeSvA8L7nVmwomx3tNTKhMp3bzPcTPN5wvX7jCaTILAyFYJiFGw==
X-Received: by 2002:ac2:569c:: with SMTP id 28mr30390848lfr.147.1560427970789;
        Thu, 13 Jun 2019 05:12:50 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id b25sm559358lff.42.2019.06.13.05.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 05:12:50 -0700 (PDT)
Date:   Thu, 13 Jun 2019 15:12:38 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: Add link to ROHM BD71847 Datasheet
Message-ID: <20190613121237.GA8984@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ROHM BD71847 PMIC datasheet was published.
Add datasheet link for BD71847 as well.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
index d5f68ac78d15..3c421bdbffc5 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
@@ -8,6 +8,8 @@ and 6 LDOs.
 
 Datasheet for BD71837 is available at:
 https://www.rohm.com/datasheet/BD71837MWV/bd71837mwv-e
+Datasheet for BD71847 is available at:
+https://www.rohm.com/datasheet/BD71847AMWV/bd71847amwv-e
 
 Required properties:
  - compatible		: Should be "rohm,bd71837" for bd71837
-- 
2.17.2


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
