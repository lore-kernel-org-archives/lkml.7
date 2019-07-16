Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8EDC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 08:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC492145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 08:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbfGPISc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 04:18:32 -0400
Received: from ns.iliad.fr ([212.27.33.1]:43784 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbfGPISb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 04:18:31 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 458F02070A;
        Tue, 16 Jul 2019 10:18:30 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 298DB206EA;
        Tue, 16 Jul 2019 10:18:30 +0200 (CEST)
Subject: Re: [PATCH v1] clk: Add devm_clk_{prepare,enable,prepare_enable}
To:     Guenter Roeck <linux@roeck-us.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <1d7a1b3b-e9bf-1d80-609d-a9c0c932b15a@free.fr>
 <ec00d8d0-6551-274c-8a8d-a9d4c5b45d7c@roeck-us.net>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <71456cc6-d3fb-6d90-c853-fc460a207c55@free.fr>
Date:   Tue, 16 Jul 2019 10:18:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ec00d8d0-6551-274c-8a8d-a9d4c5b45d7c@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Jul 16 10:18:30 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/2019 02:25, Guenter Roeck wrote:

> On 7/15/19 8:34 AM, Marc Gonzalez wrote:
> 
>> Provide devm variants for automatic resource release on device removal.
>> probe() error-handling is simpler, and remove is no longer required.
>>
>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> 
> Again ?
> 
> https://lore.kernel.org/patchwork/patch/755667/

IMHO, my proposal is very simple and (somewhat) easier to review.

I'm sure it will enthrall Stephen/Mike, thus they'll merge it in a heart-beat ^_^


> This must be at least the third time this is tried. I don't think anything changed
> since the previous submissions. I long since gave up and use devm_add_action_or_reset()
> in affected drivers instead.

"Tonight's the night we're gonna make it happen
Tonight we'll put all other things aside" ^_^

It's silly to have driver authors worry about probe() error-handling
in 2020. (What? It's not 2020 yet?!)

If I could get two or three reviews, it would help to show support
for this essential, yet still missing, API.

Regards.
