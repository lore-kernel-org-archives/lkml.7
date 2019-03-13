Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB81BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 06:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B562173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 06:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfCMGg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 02:36:59 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:48156 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfCMGg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 02:36:59 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1h3xVY-000461-A7 from Jiada_Wang@mentor.com ; Tue, 12 Mar 2019 23:36:56 -0700
Received: from [172.30.112.185] (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Tue, 12 Mar 2019 23:36:51 -0700
Subject: Re: [PATCH 5/5] ASoC: rsnd: dma: use extended audio dmac registers
 when available
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     <horms@verge.net.au>, <magnus.damm@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <geert@linux-m68k.org>,
        <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
References: <20190313055811.26135-1-jiada_wang@mentor.com>
 <87h8c7gv73.wl-kuninori.morimoto.gx@renesas.com>
 <87ef7bguqn.wl-kuninori.morimoto.gx@renesas.com>
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <51be4cda-aa39-ce95-e7ef-404d9b02f188@mentor.com>
Date:   Wed, 13 Mar 2019 15:36:49 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <87ef7bguqn.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: svr-orw-mbx-02.mgc.mentorg.com (147.34.90.202) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san

On 2019/03/13 15:33, Kuninori Morimoto wrote:
> 
> Hi Jiada
> 
>>> Some of SoCs have both basic and extended dmac registers set
>>> basic set only supports busif0 ~ busif3, in order to use
>>> busif4 ~ busif7, extended audio dmac registers need to be used.
>>>
>>> This patch changes to use extended dmac registers set when it is
>>> available in device-tree.
>>>
>>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>>> ---
>>
>> 1st of all, if you want to post this kind of patch-set,
>> you *should* post driver side patch 1st, and if it was accepted,
>> you need to post SoC side patch. Then, you need to indicate
>> to SoC maintainer which branch/commit should be based.
>> Otherwise, it will 100% breaks git-bisect.
> 
> Grr, orz
> my head was 100% broken.
> This time, your patch doesn't breaks git-bisect.
> I'm so sorry.
> 
right, no problem.
anyway, keep driver change before dts change,
is always a good practice

Thanks,
Jiada
> Best regards
> ---
> Kuninori Morimoto
> 
