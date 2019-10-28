Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD19ACA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A3820830
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388226AbfJ1UsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 16:48:10 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:25464 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJ1UsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 16:48:10 -0400
Received: from belgarion ([90.55.204.252])
        by mwinf5d17 with ME
        id K8o72100G5TFNlm038o8cg; Mon, 28 Oct 2019 21:48:08 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 28 Oct 2019 21:48:08 +0100
X-ME-IP: 90.55.204.252
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 15/46] ARM: pxa: maybe fix gpio lookup tables
References: <20191018154052.1276506-1-arnd@arndb.de>
        <20191018154201.1276638-15-arnd@arndb.de>
X-URL:  http://belgarath.falguerolles.org/
Date:   Mon, 28 Oct 2019 21:48:07 +0100
In-Reply-To: <20191018154201.1276638-15-arnd@arndb.de> (Arnd Bergmann's
        message of "Fri, 18 Oct 2019 17:41:30 +0200")
Message-ID: <87eeywmwag.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> From inspection I found a couple of GPIO lookups that are
> listed with device "gpio-pxa", but actually have a number
> from a different gpio controller.
>
> Try to rectify that here, with a guess of what the actual
> device name is.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Ah yes that's a good catch, maybe something like this could be added :
Fixes: 32d1544880aa ("ARM: pxa: Add gpio descriptor lookup tables for MMC CD/WP")
Fixes: 9b00bc7b901f ("spi: spi-gpio: Rewrite to use GPIO descriptors")

Thanks for fixing this.

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
