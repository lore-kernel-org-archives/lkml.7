Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74523C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C3C206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbfDDUlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:41:00 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:52420 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729958AbfDDUk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:40:59 -0400
Received: from belgarion ([90.76.58.102])
        by mwinf5d74 with ME
        id wLgh1z0032CLFkS03Lgnxj; Thu, 04 Apr 2019 22:40:56 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Thu, 04 Apr 2019 22:40:56 +0200
X-ME-IP: 90.76.58.102
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, Guan Xuetao <gxt@pku.edu.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Mack <daniel@zonque.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-mips@vger.kernel.org (open list:MIPS)
Subject: Re: [PATCH 1/7] thermal/drivers/core: Remove the module Kconfig's option
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
X-URL:  http://belgarath.falguerolles.org/
Date:   Thu, 04 Apr 2019 22:40:41 +0200
In-Reply-To: <20190402161256.11044-1-daniel.lezcano@linaro.org> (Daniel
        Lezcano's message of "Tue, 2 Apr 2019 18:12:44 +0200")
Message-ID: <87h8bdpkqe.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> The module support for the thermal subsystem makes little sense:
>  - some subsystems relying on it are not modules, thus forcing the
>    framework to be compiled in
>  - it is compiled in for almost every configs, the remaining ones
>    are a few platforms where I don't see why we can not switch the thermal
>    to 'y'. The drivers can stay in tristate.
>  - platforms need the thermal to be ready as soon as possible at boot time
>    in order to mitigate
>
> Usually the subsystems framework are compiled-in and the plugs are as module.
>
> Remove the module option. The removal of the module related dead code will
> come after this patch gets in or is acked.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Guenter Roeck <groeck@chromium.org>
> For mini2440:
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
For pxa:
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
