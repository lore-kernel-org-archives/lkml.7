Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54020ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BB320640
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfJKOCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:02:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36334 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727950AbfJKOCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:02:50 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 76EFCB49CA212EB64715;
        Fri, 11 Oct 2019 22:02:47 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Fri, 11 Oct 2019
 22:02:44 +0800
Subject: Re: [PATCH -next] ASoC: fsl_mqs: fix old-style function declaration
To:     Andreas Schwab <schwab@linux-m68k.org>
References: <20191011105606.19428-1-yuehaibing@huawei.com>
 <87mue7ifxw.fsf@igel.home>
CC:     <timur@kernel.org>, <nicoleotsuka@gmail.com>,
        <Xiubo.Lee@gmail.com>, <festevam@gmail.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <35eea200-2f74-05f8-c5e6-729f7f60cd44@huawei.com>
Date:   Fri, 11 Oct 2019 22:02:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <87mue7ifxw.fsf@igel.home>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/11 21:12, Andreas Schwab wrote:
> On Okt 11 2019, YueHaibing <yuehaibing@huawei.com> wrote:
> 
>> gcc warn about this:
>>
>> sound/soc/fsl/fsl_mqs.c:146:1: warning:
>>  static is not at beginning of declaration [-Wold-style-declaration]
> 
> It's not a function, though.

Oh..., will fix this, thanks!

> 
> Andreas.
> 

