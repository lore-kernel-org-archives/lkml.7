Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A576C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBCC218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbfB1HE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:04:59 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38876 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731129AbfB1HE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:04:58 -0500
Received: by mail-lf1-f68.google.com with SMTP id 131so5217595lfa.5;
        Wed, 27 Feb 2019 23:04:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N3Q2yab8FBxM2Rj485aM5M2Va2G75P8uQ2vaebYj/tY=;
        b=qfrZTqr2iUsEEcZ24jx/GjWKOb8uGQ7BbhdGPbz6yRyTTbGlZ7YPPWqF67bUyS3iOT
         p8wSmIYD/VxXVc5pMGC03ne7qejF9De4wMlcGxJeoRIXyoI3hUviLs4cufjoue7gsjLf
         q8DevV/J8PB+jszDyxY2hHrdEv0gRr5OlRn6F5pueswldnTMijU6pGEVvgvfbJtfkPEY
         2o1xR1ETGm7hyZHiG6z9WCGHppIaOF5RGOQmCIOPJAmVJnMb42Rysrphh8noZsipXTIm
         Wz0g8eOAIcn39wTpe++QaYVMpKPGKqpEP+pVJiauueOrXpYJfBtDVOMih06YWViPSYoM
         J1/g==
X-Gm-Message-State: AHQUAuYHLZqoTng3wZ6AFFuNIkf2Vu9RJ0UMaEbaxEjfzWykk3vm7r+9
        7I8HIUT4Dr5pnV7EYfk23XI=
X-Google-Smtp-Source: AHgI3IY1E/z38f6ZLrBhmMYU1kBD2JVAz37+kW9T6ietL93d6CduZg7qekfcurzu6+Ne+8d6XswNMQ==
X-Received: by 2002:ac2:54b6:: with SMTP id w22mr3425266lfk.132.1551337494486;
        Wed, 27 Feb 2019 23:04:54 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id e21sm1291882lfc.90.2019.02.27.23.04.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 23:04:53 -0800 (PST)
Date:   Thu, 28 Feb 2019 09:04:50 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com
Cc:     Guenter Roeck <linux@roeck-us.net>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, bogdan-petru.chircu-mare@nxp.com
Subject: Re: [PATCH v10 0/9] support ROHM BD70528 PMIC
Message-ID: <20190228070450.GB3773@localhost.localdomain>
References: <cover.1550148989.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1550148989.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lee and Mark,

On Thu, Feb 14, 2019 at 03:02:37PM +0200, Matti Vaittinen wrote:
> Patch series introducing support for ROHM BD70528 PMIC
> 
> ROHM BD70528 is a programmable Power Management IC for battery
> powered 'ultra low power' systems like the pre-announced NXP
> i.MX7 ULP. This patch series introduces support for the PMIC. Please
> note that this driver only supports HW setup where PMIC is connected
> to I2C on A7 core. The other scenario is to use M4 as a power manager
> and connect pmic to M4. On such setups the A7 can only access pmic
> via M4 core using RPMSG virtio. Such setup depends on RPMSG
> implementation on M4 core and is currently not supported by this
> patch series.
> 

I was wondering if there is anything that could be done to allow the MFD
part of this series to end up in upstream without having to wait the
regmap-irq changes
(https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git/commit/?h=topic/irq)
 to be merged from Linus' tree to MFD tree? If I see it correctly, the
regmap-irq (main-irq-reg support) changes are not targeted to linux 5.1.
To me it looks like getting them to MFD via Linus' tree will take a while.

The MFD part depends on the regmap-irq changes and I think that most
other subsystems want to have the MFD changes in before taking rest of
the driver in their trees. So it will be a while untill all the changes
are in. It would really be nice to have the drive in-tree sooner - hence
I ask if theres a way. (I don't want to push, just ask if it is possible :])

Best Regards
	Matti Vaittinen

