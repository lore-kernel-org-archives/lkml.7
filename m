Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC05CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8916620862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfJaNkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:40:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40512 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726803AbfJaNkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:40:47 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 670877ED1617A348749B;
        Thu, 31 Oct 2019 21:40:43 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.218) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Thu, 31 Oct 2019
 21:40:38 +0800
Message-ID: <5DBAE455.30406@huawei.com>
Date:   Thu, 31 Oct 2019 21:40:37 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Mark Brown <broonie@kernel.org>
CC:     <bardliao@realtek.com>, <oder_chiou@realtek.com>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Make rt5677_spi_pcm_page static
References: <1571919319-4205-1-git-send-email-zhongjiang@huawei.com> <20191031132010.GR4568@sirena.org.uk>
In-Reply-To: <20191031132010.GR4568@sirena.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.218]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/31 21:20, Mark Brown wrote:
> On Thu, Oct 24, 2019 at 08:15:19PM +0800, zhong jiang wrote:
>> The GCC complains the following warning.
>>
>> sound/soc/codecs/rt5677-spi.c:365:13: warning: symbol 'rt5677_spi_pcm_page' was not declared. Should it be static?
> It looks like this has been fixed already in the latest code.
Yes,  I has noticed that. 

Thanks,
zhong jiang

