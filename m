Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74EAC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F132146E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfGANlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 09:41:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49626 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfGANlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 09:41:24 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 01627260DF9
Subject: Re: [PATCH v3] platform/chrome: Expose resume result via debugfs
To:     Lee Jones <lee.jones@linaro.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
References: <20190627204446.52499-1-evgreen@chromium.org>
 <CAFqH_53cmq+1Y_uL3D4-84v_vDJsoB0Qxr_zTVnOzX1XD7VEgQ@mail.gmail.com>
 <20190701060137.GB4652@dell>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <14282971-65b1-f7db-26b9-d33636054ba6@collabora.com>
Date:   Mon, 1 Jul 2019 15:41:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190701060137.GB4652@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/7/19 8:01, Lee Jones wrote:
> On Thu, 27 Jun 2019, Enric Balletbo Serra wrote:
> 
>> Hi Evan, Lee,
>>
>> Missatge de Evan Green <evgreen@chromium.org> del dia dj., 27 de juny
>> 2019 a les 22:46:
>>>
>>> For ECs that support it, the EC returns the number of slp_s0
>>> transitions and whether or not there was a timeout in the resume
>>> response. Expose the last resume result to usermode via debugfs so
>>> that usermode can detect and report S0ix timeouts.
>>>
>>> Signed-off-by: Evan Green <evgreen@chromium.org>
>>
>> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>
>> Lee, actually this patch depends on some patches from chrome-platform
>> to apply cleanly. Once is fine with you and if you're happy to have
>> this merged for 5.3, I can just carry the patch with me, shouldn't be
>> any conflicts with your current changes or if you prefer I can create
>> an immutable branch for you.
> 
> I won't be taking any more patches this cycle, so if you're sure that
> it does not conflict, there is no need for an immutable branch.
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>
> 

Thanks Lee.

I think the patch is simple enough, I queued for the autobuilders to play with,
and if all goes well I'll add for 5.3 via chrome-platform.

Thanks,
~ Enric
