Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30662C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0237B22D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbfHUR2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 13:28:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51712 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfHUR2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:28:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id E968C28CD18
Subject: Re: [PATCH] mfd: cros_ec: Update cros_ec_commands.h
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Yicheng Li <yichengli@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "kernel@collabora.com" <kernel@collabora.com>
References: <20190708181536.2125-1-yichengli@chromium.org>
 <CAPUE2uvnPfA8y1bqppC3-vZyRKRwdF4evGY8X4c-xP=YZi4HRw@mail.gmail.com>
 <e241dc48-5cb0-3b60-9b84-cad8e80eb617@collabora.com>
 <20190812072832.GO4594@dell>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <cab6242a-b9a2-ea93-9bfa-a9854949ee8a@collabora.com>
Date:   Wed, 21 Aug 2019 19:27:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812072832.GO4594@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 12/8/19 9:28, Lee Jones wrote:
> On Mon, 22 Jul 2019, Enric Balletbo i Serra wrote:
> 
>> Hi Lee,
>>
>> On 11/7/19 19:17, Gwendal Grignou wrote:
>>> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>>>
>>> Note there is a patch series that move cros_ec_commands.h from
>>> nclude/linux/mfd/ to include/linux/platform_data.
>>>
>>
>> I just sent a new version of the patches mentioned above now that rc1 is out [1]
>>
>> As Gwendal said this patch will conflict with them, so we have two options.
>>
>> 1. If Lee picks that patch I can rebase again my series on top of it.
> 
> Yes please.
> 

Perfect, preparing a new rebased version to send soon.

>> 2. If not, we can wait for Lee reviewing my patch series and then I don't mind
>> to rebase that patch on top of my series and carry the patch through
>> chrome-platform. Anyway I'll need an immutable branch from Lee.
> 
> I just reviewed your series.
> 

Thanks,

Enric
