Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB242C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878242178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbfKHIQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 03:16:01 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38448 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfKHIQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 03:16:01 -0500
Received: by mail-lf1-f66.google.com with SMTP id q28so3755025lfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 00:15:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7k/5GJxPcjAfS2IRT6Q2if910Z82awVpE2h4G5vntbk=;
        b=b8+kML5NXkWezdP//cLP5dWSWoD5nHYoxlLAwIndW+2vrRmVPFus8gDgxCEsvWGBIb
         3XtR8Vh35ZQ61e4HeSEhu8U10O9O8Jpb0Xj0uAXKdHq6p/Nmu6sHNomM1aX4k2+x83y2
         Nw+v9PNb6hd1I67XzWiyQdQ5mEwcipana1wx293LG11b4cVwl48UKsk6PM4RlYTH+OGq
         Dgju/863TWDEn38KYVGgM8ZVllBnEnqkUNzmQ9qpugVGuXcz41cBQ896eJNZ4lgckoGY
         0y+AmiOil9KWvXRe7UthxmMKozfT+WpAYyMaI2+rU1Z4fZBY/cQSxzZULKStgB8daAyG
         mqAQ==
X-Gm-Message-State: APjAAAWWA7BeSs67vd/H9wOofDgnmqpRU+CPv1o5q1iRd0/FL4uXGUP0
        ozJMed7hI6tSZDDbYz92P7WVyU607PA=
X-Google-Smtp-Source: APXvYqzqKPpdprXbx1ZrVMhXyZAYmPFfcEan4B3qXAiZ2zTTC+XLDPvdq7YGVdM9Dm3ys2NCiCx+TA==
X-Received: by 2002:ac2:46e3:: with SMTP id q3mr5773132lfo.9.1573200959106;
        Fri, 08 Nov 2019 00:15:59 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id r22sm2097145ljk.31.2019.11.08.00.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 00:15:58 -0800 (PST)
Date:   Fri, 8 Nov 2019 10:15:51 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: bd70528: Staticize bit value definitions
Message-ID: <20191108081551.GA19788@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make bit definitions static to reduce the scope.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/mfd/rohm-bd70528.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/rohm-bd70528.c b/drivers/mfd/rohm-bd70528.c
index 55599d5c5c86..ef6786fd3b00 100644
--- a/drivers/mfd/rohm-bd70528.c
+++ b/drivers/mfd/rohm-bd70528.c
@@ -105,15 +105,14 @@ static struct regmap_config bd70528_regmap = {
  * register.
  */
 
-/* bit [0] - Shutdown register */
-unsigned int bit0_offsets[] = {0};	/* Shutdown register */
-unsigned int bit1_offsets[] = {1};	/* Power failure register */
-unsigned int bit2_offsets[] = {2};	/* VR FAULT register */
-unsigned int bit3_offsets[] = {3};	/* PMU register interrupts */
-unsigned int bit4_offsets[] = {4, 5};	/* Charger 1 and Charger 2 registers */
-unsigned int bit5_offsets[] = {6};	/* RTC register */
-unsigned int bit6_offsets[] = {7};	/* GPIO register */
-unsigned int bit7_offsets[] = {8};	/* Invalid operation register */
+static unsigned int bit0_offsets[] = {0};	/* Shutdown */
+static unsigned int bit1_offsets[] = {1};	/* Power failure */
+static unsigned int bit2_offsets[] = {2};	/* VR FAULT */
+static unsigned int bit3_offsets[] = {3};	/* PMU interrupts */
+static unsigned int bit4_offsets[] = {4, 5};	/* Charger 1 and Charger 2 */
+static unsigned int bit5_offsets[] = {6};	/* RTC */
+static unsigned int bit6_offsets[] = {7};	/* GPIO */
+static unsigned int bit7_offsets[] = {8};	/* Invalid operation */
 
 static struct regmap_irq_sub_irq_map bd70528_sub_irq_offsets[] = {
 	REGMAP_IRQ_MAIN_REG_OFFSET(bit0_offsets),

base-commit: d6d5df1db6e9d7f8f76d2911707f7d5877251b02
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
