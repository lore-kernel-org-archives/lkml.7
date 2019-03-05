Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84588C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5848A206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfCEBmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 20:42:19 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:52393 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbfCEBmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 20:42:18 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TM-4nQP_1551750133;
Received: from Alexs-MacBook-Pro.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TM-4nQP_1551750133)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 05 Mar 2019 09:42:13 +0800
Subject: Re: [PATCH 01/20] docs/zh_CN: add disclaimer file
To:     Li Yang <leoli@freescale.com>
Cc:     =?UTF-8?B?TGludXggS2VybmVsIOS4reaWh+ekvuWMug==?= 
        <linux-kernel@zh-kernel.org>, linux-doc@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, harryxiyou@gmail.com,
        Jonathan Corbet <corbet@lwn.net>,
        Li Zefan <lizefan@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Coly Li <colyli@suse.de>,
        Federico Vaga <federico.vaga@vaga.pv.it>
References: <20190304035744.155203-1-alex.shi@linux.alibaba.com>
 <20190304035744.155203-2-alex.shi@linux.alibaba.com>
 <CADRPPNT6=848XjB3uNAhgDRwFb+KsLY7pR3xFVaMLkGjqGpy5g@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <60c26f69-1113-26ba-3589-f4b7f03b73f9@linux.alibaba.com>
Date:   Tue, 5 Mar 2019 09:42:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CADRPPNT6=848XjB3uNAhgDRwFb+KsLY7pR3xFVaMLkGjqGpy5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/3/5 6:06 上午, Li Yang wrote:
> On Sun, Mar 3, 2019 at 10:03 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>> This a disclaimer file which will be included in Chinese files
>> as header. To reduce the same common contents copy.
> It is great for reducing the duplication.  But since this is in the
> translation folder, probably it will be even better to include a
> translated version of this disclaimer too?

Sure, I will update it with Chinese words. and resend whole threads.

Thanks Leo!

> Regards,
> Leo
>
>> Most of contents quoted from Federico Vaga's file:
>> Documentation/translations/it_IT/disclaimer-ita.rst.
>> Thanks a lot!
>>
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>> Cc: Harry Wei <harryxiyou@gmail.com>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Li Zefan <lizefan@huawei.com>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Cc: Fengguang Wu <fengguang.wu@intel.com>
>> Cc: Coly Li <colyli@suse.de>
>> Cc: Federico Vaga <federico.vaga@vaga.pv.it>
>> ---
>>  Documentation/translations/zh_CN/disclaimer-zh_CN.rst | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>  create mode 100644 Documentation/translations/zh_CN/disclaimer-zh_CN.rst
>>
>> diff --git a/Documentation/translations/zh_CN/disclaimer-zh_CN.rst b/Documentation/translations/zh_CN/disclaimer-zh_CN.rst
>> new file mode 100644
>> index 000000000000..0de5dfb069ca
>> --- /dev/null
>> +++ b/Documentation/translations/zh_CN/disclaimer-zh_CN.rst
>> @@ -0,0 +1,11 @@
>> +:orphan:
>> +
>> +.. warning::
>> +   The purpose of this file is to be easier to read and understand for Chinese
>> +   speakers and is not intended as a fork. So, if you have any comments or
>> +   updates for this file please try to update the original English file first.
>> +
>> +.. note::
>> +   If you find any difference between this document and the original file or a
>> +   problem with the translation, please contact the maintainer of this file,
>> +   or get help from Alex Shi <alex.shi@linux.alibaba.com>
>> --
>> 2.19.1.856.g8858448bb
>>
>

