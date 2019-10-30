Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6357CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924C12080F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfJ3VVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 17:21:19 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:36262 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfJ3VVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 17:21:19 -0400
Received: from belgarion ([90.55.204.252])
        by mwinf5d15 with ME
        id KxMG210075TFNlm03xMGp5; Wed, 30 Oct 2019 22:21:17 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 30 Oct 2019 22:21:17 +0100
X-ME-IP: 90.55.204.252
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 39/46] power: tosa: simplify probe function
References: <20191018154052.1276506-1-arnd@arndb.de>
        <20191018154201.1276638-39-arnd@arndb.de>
        <20191019090749.ps27yjfebzscw2pk@earth.universe>
X-URL:  http://belgarath.falguerolles.org/
Date:   Wed, 30 Oct 2019 22:21:16 +0100
In-Reply-To: <20191019090749.ps27yjfebzscw2pk@earth.universe> (Sebastian
        Reichel's message of "Sat, 19 Oct 2019 11:07:49 +0200")
Message-ID: <878sp2lyk3.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Reichel <sre@kernel.org> writes:

> Hi Arnd,
>
> On Fri, Oct 18, 2019 at 05:41:54PM +0200, Arnd Bergmann wrote:
>> We have three power supplies that need similar initialization.
>> As a preparation for the gpio lookup table conversion, split
>> out the initialization into a separate function.
>> 
>> Cc: Sebastian Reichel <sre@kernel.org>
>> Cc: linux-pm@vger.kernel.org
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>
> Assuming, that the whole series goes through ARM:
>
> Reviewed-by: Sebastian Reichel <sre@kernel.org>
> Acked-by: Sebastian Reichel <sre@kernel.org>
>
> If the series doesn't make it into 5.5, I can also apply
> this cleanup patch.
>
> -- Sebastian
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
