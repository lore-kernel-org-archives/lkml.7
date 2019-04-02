Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAF2C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AB920840
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfDBGW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:22:26 -0400
Received: from mx.socionext.com ([202.248.49.38]:39568 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfDBGW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:22:26 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 02 Apr 2019 15:22:24 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 14C9A6117D;
        Tue,  2 Apr 2019 15:22:24 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Tue, 2 Apr 2019 15:22:24 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id E92C840221;
        Tue,  2 Apr 2019 15:22:23 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.234.213])
        by yuzu.css.socionext.com (Postfix) with ESMTP id B6C66120487;
        Tue,  2 Apr 2019 15:22:23 +0900 (JST)
Cc:     kanematsu.shinji@socionext.com, robh+dt@kernel.org,
        mark.rutland@arm.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        orito.takao@socionext.com, sugaya.taichi@socionext.com,
        kasai.kazuhiro@socionext.com
Subject: Re: [PATCH 0/2] Add Updown Counter support for Milbeaut M10V SoC
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
References: <1553581954-13487-1-git-send-email-kanematsu.shinji@socionext.com>
 <20190330183603.55886d4f@archlinux> <20190331020932.GA4108@icarus>
From:   =?UTF-8?B?S2FuZW1hdHN1LCBTaGluamkv5YW85p2+IOS8uOasoQ==?= 
        <kanematsu.shinji@socionext.com>
Message-ID: <bddfd8ca-c82a-68f8-ba05-45ce6df9bd4f@socionext.com>
Date:   Tue, 2 Apr 2019 15:22:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20190331020932.GA4108@icarus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

On 2019/03/31 11:09, William Breathitt Gray wrote:
> On Sat, Mar 30, 2019 at 06:36:03PM +0000, Jonathan Cameron wrote:
>> On Tue, 26 Mar 2019 15:32:34 +0900
>> Shinji Kanematsu <kanematsu.shinji@socionext.com> wrote:
>>
>>> This is a series of patch which adds Updown Counter support on
>>> Milbeaut M10V SoC.
>>>
>>> The Updown Counter counts input pulse signal from external quadrature encoder.
>>> It also has input pulse signal counter function.
>> Hi Shinji,
>>
>> Are you aware of the counter subsystem that has been proposed (and
>> as far as I am concerned is ready to be merged)?
>>
>> https://patchwork.kernel.org/project/linux-iio/list/?series=147
>> (I think that's the latest version posted)..
>> William, perhaps you could give an update?
>>
>> (bad luck, you are getting popular ;)
>>
>> I'll take a quick review as it stands, as some issues may carry over.
>> I appreciate that it's always unfortunate to try to upstream stuff at the
>> same time as a new framework is being developed / upstreamed, but I don't
>> intend to take any additional counter drivers into IIO.  We just
>> end up having to maintain old interfaces in more and more drivers.
>>
>> Thanks,
>>
>> Jonathan
> 
> Shinji,
> 
> If you reimplement this driver to use the new Generic Counter API, I can
> pick it up and include it with my next patchset submission. Please base
> your patches ontop of the "generic_counter_v10" branch from my personal
> repository:
> 
> https://gitlab.com/vilhelmgray/iio/commits/generic_counter_v10
> 
> Documentation can be found at:
> 
> 	Documentation/driver-api/generic-counter.rst
> 	Documentation/ABI/testing/sysfs-bus-counter
> 
> Look at the existing drivers inside the drivers/counter directory to
> serve as references:
> 
> 	drivers/counter/ftm-quaddec.c
> 	drivers/counter/stm32-timer-cnt.c
> 
> If you have any troubles or difficulties with the API, send me a message
> and I will be happy to help. :-)
> 

Thank you for your information.
I read and understand the new Generic Counter API.

Thank you,
Kanematsu

> Thank you,
> 
> William Breathitt Gray
> 
>>
>>>
>>> Shinji Kanematsu (2):
>>>    dt-bindings: iio: counter: Add Milbeaut Updown Counter
>>>    iio: counter: Add support for Milbeaut Updown Counter
>>>
>>>   .../bindings/iio/counter/milbeaut-updown_cnt.txt   |  22 ++
>>>   drivers/iio/counter/Kconfig                        |  12 +
>>>   drivers/iio/counter/Makefile                       |   1 +
>>>   drivers/iio/counter/milbeaut-updown.h              |  38 ++
>>>   drivers/iio/counter/milbeaut-updown_cnt.c          | 385 +++++++++++++++++++++
>>>   5 files changed, 458 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/iio/counter/milbeaut-updown_cnt.txt
>>>   create mode 100644 drivers/iio/counter/milbeaut-updown.h
>>>   create mode 100644 drivers/iio/counter/milbeaut-updown_cnt.c
>>>
>>

