Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94065C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643A520830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfCYDDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:03:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60934 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729285AbfCYDDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:03:24 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 150B9484E29389A54F05;
        Mon, 25 Mar 2019 11:03:22 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Mon, 25 Mar 2019
 11:03:19 +0800
Subject: Re: [PATCH -next] ASoC: simple-card-utils: remove set but not used
 variable ''
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <20190323020838.107533-1-yuehaibing@huawei.com>
 <87a7hjitm0.wl-kuninori.morimoto.gx@renesas.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Katsuhiro Suzuki" <suzuki.katsuhiro@socionext.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <c216f899-fdfc-6f99-3f76-5ee64680b2fe@huawei.com>
Date:   Mon, 25 Mar 2019 11:03:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <87a7hjitm0.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/25 10:31, Kuninori Morimoto wrote:
> 
> Hi
> 
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> sound/soc/generic/simple-card-utils.c: In function 'asoc_simple_parse_clk':
>> sound/soc/generic/simple-card-utils.c:164:18: warning:
>>  parameter 'dai_name' set but not used [-Wunused-but-set-parameter]
>>
>> It's not used since commit 0580dde59438 ("ASoC: simple-card-utils: add
>> asoc_simple_debug_info()"), so can be removed.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
> 
> I think dai_name parameter itself is no longer needed for this function,
> but, it will be removed if all driver switched to modern dai_link style.
> So, it is not a big deal.
> 
> 	Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, yes, this just a code cleanup.

> 
> Best regards
> ---
> Kuninori Morimoto
> 
> .
> 

