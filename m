Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933DFC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 06:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6790B206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 06:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfLaGYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 01:24:36 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:54307 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbfLaGYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 01:24:36 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TmOH5Vc_1577773471;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TmOH5Vc_1577773471)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 31 Dec 2019 14:24:32 +0800
Subject: Re: [PATCH v3 1/3] docs/zh_CN: add Chinese version of embargoed
 hardware issues
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Fengguang Wu <fengguang.wu@intel.com>, lizefan@huawei.com,
        Harry Wei <harryxiyou@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Hutchings <ben@decadent.org.uk>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1576811085-30544-1-git-send-email-alex.shi@linux.alibaba.com>
 <20191230120105.7776cbb4@lwn.net>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <52513678-9ec4-b472-edc2-9656d8a3c3fa@linux.alibaba.com>
Date:   Tue, 31 Dec 2019 14:23:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191230120105.7776cbb4@lwn.net>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2019/12/31 ÉÏÎç3:01, Jonathan Corbet Ð´µÀ:
> On Fri, 20 Dec 2019 11:04:43 +0800
> Alex Shi <alex.shi@linux.alibaba.com> wrote:
> 
>> Embargoed hardware issues is a necessary process guide, but leak of
>> Chinese version, since there is more Chinese hardware vendors in market.
>> We'd better have a Chinese version of this guide.
>>
>> This patch translate the guide, add it into toctree. and also add a link
>> stub for the original doc.
> 
> I've applied this (and the other two as well), thanks.
> 

Thanks a lot! :)
Alex
