Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C3FC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0372A24654
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfLEKN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 05:13:26 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:46702 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729041AbfLEKNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 05:13:23 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Tk2.yQt_1575540761;
Received: from bn0418deMacBook-Pro.local(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0Tk2.yQt_1575540761)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 Dec 2019 18:13:12 +0800
Subject: Re: [PATCH v6 0/3] genirq/vfio: Introduce irq_update_devid() and
 optimize VFIO irq ops
To:     Thomas Gleixner <tglx@linutronix.de>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tao.ma@linux.alibaba.com,
        gerry@linux.alibaba.com, nanhai.zou@linux.alibaba.com
References: <cover.1567394624.git.luoben@linux.alibaba.com>
 <abb4080f-dfe2-1882-4bde-51bb7e660d4a@linux.alibaba.com>
 <20190913114452.5e05d8c4@x1.home>
 <alpine.DEB.2.21.1909161615230.1887@nanos.tec.linutronix.de>
From:   Ben Luo <luoben@linux.alibaba.com>
Message-ID: <8e7961d5-c27e-4921-45ff-af8cc8946ac3@linux.alibaba.com>
Date:   Thu, 5 Dec 2019 18:12:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909161615230.1887@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Could you please take a look at this again, just a friendly reminder :)

Thanks,

     Ben

在 2019/9/16 下午10:16, Thomas Gleixner 写道:
> On Fri, 13 Sep 2019, Alex Williamson wrote:
>
>> On Tue, 10 Sep 2019 14:30:16 +0800
>> Ben Luo <luoben@linux.alibaba.com> wrote:
>>
>>> A friendly reminder.
>> The vfio patch looks ok to me.  Thomas, do you have further comments or
>> a preference on how to merge these?  I'd tend to prefer the vfio
>> changes through my branch for testing and can pull the irq changes with
>> your approval, but we could do the reverse or split them and I could
>> follow with the vfio change once the irq changes are in mainline.
> I can provide you a branch, once I looked again at that stuff. It's
> somewhere in that huge conference induced backlog.
>
> Thanks,
>
> 	tglx
