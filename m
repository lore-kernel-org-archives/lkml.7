Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9065AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D7220830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbfCYH6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:58:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5185 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729720AbfCYH6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 03:58:10 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8B72E526B28E73E71FD3;
        Mon, 25 Mar 2019 15:58:08 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Mon, 25 Mar 2019
 15:58:05 +0800
Subject: Re: [PATCH -next] ASoC: simple-card-utils: remove set but not used
 variable ''
To:     Mukesh Ojha <mojha@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <20190323020838.107533-1-yuehaibing@huawei.com>
 <6a0c2306-088f-cdbc-0730-60b899611c6f@codeaurora.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <ae41e273-1c0e-c178-cc94-7f0330b7559f@huawei.com>
Date:   Mon, 25 Mar 2019 15:58:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <6a0c2306-088f-cdbc-0730-60b899611c6f@codeaurora.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/25 15:42, Mukesh Ojha wrote:
> 
> On 3/23/2019 7:38 AM, YueHaibing wrote:
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> sound/soc/generic/simple-card-utils.c: In function 'asoc_simple_parse_clk':
>> sound/soc/generic/simple-card-utils.c:164:18: warning:
>>   parameter 'dai_name' set but not used [-Wunused-but-set-parameter]
>>
>> It's not used since commit 0580dde59438 ("ASoC: simple-card-utils: add
> 
> 
> I am not able to find this commit
> 
> 0580dde59438

It's now in linux-next tree.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=0580dde59438686d60762b6da9229ebec693b94f

> 
> 
>> asoc_simple_debug_info()"), so can be removed.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>   sound/soc/generic/simple-card-utils.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
>> index 4ed68348f939..db1458a19985 100644
>> --- a/sound/soc/generic/simple-card-utils.c
>> +++ b/sound/soc/generic/simple-card-utils.c
>> @@ -173,10 +173,8 @@ int asoc_simple_parse_clk(struct device *dev,
>>        * see
>>        *    soc-core.c :: snd_soc_init_multicodec()
>>        */
>> -    if (dlc) {
>> +    if (dlc)
>>           dai_of_node    = dlc->of_node;
>> -        dai_name    = dlc->dai_name;
> 
> I don't see any function like `asoc_simple_parse_clk`
> 
> but instead this `asoc_simple_card_parse_clk` and there the variable is used.
> 
> Can you double check latest code base ?
> 
> Thanks,
> Mukesh
> 
> 
>> -    }
>>         /*
>>        * Parse dai->sysclk come from "clocks = <&xxx>"
>>
>>
>>
>>
>>
> 
> .
> 

