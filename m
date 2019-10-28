Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE6ECA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5A721835
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733150AbfJ1U1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 16:27:46 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:18835 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbfJ1U1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 16:27:45 -0400
Received: from belgarion ([90.55.204.252])
        by mwinf5d17 with ME
        id K8Tj210075TFNlm038Tjba; Mon, 28 Oct 2019 21:27:43 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 28 Oct 2019 21:27:43 +0100
X-ME-IP: 90.55.204.252
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Paul Parsons <lost.distance@yahoo.com>
Subject: Re: [PATCH 12/46] ARM: pxa: make addr-map.h header local
References: <20191018154052.1276506-1-arnd@arndb.de>
        <20191018154201.1276638-12-arnd@arndb.de>
X-URL:  http://belgarath.falguerolles.org/
Date:   Mon, 28 Oct 2019 21:27:43 +0100
In-Reply-To: <20191018154201.1276638-12-arnd@arndb.de> (Arnd Bergmann's
        message of "Fri, 18 Oct 2019 17:41:27 +0200")
Message-ID: <87mudkmx8g.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> Drivers should not rely on the contents of this file, so
> move it into the platform directory directly.
>
> Cc: Philipp Zabel <philipp.zabel@gmail.com>
> Cc: Paul Parsons <lost.distance@yahoo.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Mmmh for this one, my jenkins is a bit grumpy :

Bisectability test results for configuration "pxa_defconfig,arm,arm-linux-gnueabi-"

Failed to build patch #12: 15fb575e5d52 ARM: pxa: make addr-map.h header local
Configuration: "pxa_defconfig, architecture arm".


In file included from drivers/pcmcia/pxa2xx_trizeps4.c:23:
arch/arm/mach-pxa/include/mach/trizeps4.h:14:10: fatal error: addr-map.h: No such file or directory
 #include "addr-map.h"
          ^~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.build:265: drivers/pcmcia/pxa2xx_trizeps4.o] Error 1

-- 
Robert
