Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19063C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F4E2166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406138AbfHIKAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 06:00:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4652 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406037AbfHIKAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 06:00:08 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AA1DC8056351D9C7BCC4;
        Fri,  9 Aug 2019 18:00:06 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Fri, 9 Aug 2019
 18:00:02 +0800
Subject: Re: [alsa-devel] [PATCH -next] ALSA: Au88x0 - remove some unused
 const variables
To:     Takashi Iwai <tiwai@suse.de>
References: <20190809090620.70496-1-yuehaibing@huawei.com>
 <s5hk1bmhe9t.wl-tiwai@suse.de>
CC:     <perex@perex.cz>, <tiwai@suse.com>, <broonie@kernel.org>,
        <rfontana@redhat.com>, <kstewart@linuxfoundation.org>,
        <allison@lohutok.net>, <armijn@tjaldur.nl>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <85696583-655b-06dd-d851-c8bfdaab7924@huawei.com>
Date:   Fri, 9 Aug 2019 18:00:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <s5hk1bmhe9t.wl-tiwai@suse.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/9 17:35, Takashi Iwai wrote:
> On Fri, 09 Aug 2019 11:06:20 +0200,
> YueHaibing wrote:
>>
>> sound/pci/au88x0/au88x0_xtalk.c:121:28: warning: asXtalkWideCoefsRightXt defined but not used [-Wunused-const-variable=]
>> sound/pci/au88x0/au88x0_xtalk.c:152:28: warning: asXtalkNarrowCoefsRightXt defined but not used [-Wunused-const-variable=]
>> sound/pci/au88x0/au88x0_xtalk.c:175:28: warning: asXtalkCoefsNegPipe defined but not used [-Wunused-const-variable=]
>> sound/pci/au88x0/au88x0_xtalk.c:183:28: warning: asXtalkCoefsNumTest defined but not used [-Wunused-const-variable=]
>> sound/pci/au88x0/au88x0_xtalk.c:191:28: warning: asXtalkCoefsDenTest defined but not used [-Wunused-const-variable=]
>> sound/pci/au88x0/au88x0_xtalk.c:199:28: warning: asXtalkOutStateTest defined but not used [-Wunused-const-variable=]
>> sound/pci/au88x0/au88x0_xtalk.c:20:20: warning: sXtalkWideKRightXt defined but not used [-Wunused-const-variable=]
>> sound/pci/au88x0/au88x0_xtalk.c:231:28: warning: asDiamondCoefsRightXt defined but not used [-Wunused-const-variable=]
>> sound/pci/au88x0/au88x0_xtalk.c:24:20: warning: sXtalkWideShiftRightXt defined but not used [-Wunused-const-variable=]
>> sound/pci/au88x0/au88x0_xtalk.c:30:20: warning: sXtalkNarrowKRightXt defined but not used [-Wunused-const-variable=]
>> sound/pci/au88x0/au88x0_xtalk.c:34:20: warning: sXtalkNarrowShiftRightXt defined but not used [-Wunused-const-variable=]
>> sound/pci/au88x0/au88x0_xtalk.c:38:28: warning: asXtalkGainsDefault defined but not used [-Wunused-const-variable=]
>> sound/pci/au88x0/au88x0_xtalk.c:43:28: warning: asXtalkGainsTest defined but not used [-Wunused-const-variable=]
>> sound/pci/au88x0/au88x0_xtalk.c:48:28: warning: asXtalkGains1Chan defined but not used [-Wunused-const-variable=]
>> sound/pci/au88x0/au88x0_xtalk.c:67:28: warning: alXtalkDlineTest defined but not used [-Wunused-const-variable=]
>> sound/pci/au88x0/au88x0_xtalk.c:77:30: warning: asXtalkInStateTest defined but not used [-Wunused-const-variable=]
>> sound/pci/au88x0/au88x0_xtalk.c:92:20: warning: sDiamondKRightXt defined but not used [-Wunused-const-variable=]
>> sound/pci/au88x0/au88x0_xtalk.c:96:20: warning: sDiamondShiftRightXt defined but not used [-Wunused-const-variable=]
> 
> Some of them are rather a bug, likely the wrong register and data is
> used (left instead of right).  They have to be fixed instead of
> removing.
> 
> And some are indeed unused, but I'd leave them with ifdef or such.
> Such magical values do have some meaning (as the driver code was the
> result from reverse-engineering) and blindly removing it also loses
> the information -- though, the driver is tad old and likely broken, so
> practically seen no big impact.

Agree, just leave them this, Thanks!

> 
> 
> thanks,
> 
> Takashi
> 
> .
> 

