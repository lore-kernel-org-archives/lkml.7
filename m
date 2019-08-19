Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812C3C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 04:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD492082C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 04:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfHSEJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 00:09:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:24771 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbfHSEJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 00:09:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Aug 2019 21:09:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="261713793"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by orsmga001.jf.intel.com with ESMTP; 18 Aug 2019 21:09:32 -0700
Subject: Re: [RFC PATCH 04/15] drivers/acrn: add the basic framework of acrn
 char device driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Mingqiang Chi <mingqiang.chi@intel.com>,
        Jack Ren <jack.ren@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Liu Shuo <shuo.a.liu@intel.com>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
 <1565922356-4488-5-git-send-email-yakui.zhao@intel.com>
 <20190816070559.GB1368@kroah.com>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <cedb90e7-da98-9075-e647-075fa3a3e7ae@intel.com>
Date:   Mon, 19 Aug 2019 12:02:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190816070559.GB1368@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年08月16日 15:05, Greg KH wrote:
> On Fri, Aug 16, 2019 at 10:25:45AM +0800, Zhao Yakui wrote:
>> ACRN hypervisor service module is the important middle layer that allows
>> the Linux kernel to communicate with the ACRN hypervisor. It includes
>> the management of virtualized CPU/memory/device/interrupt for other ACRN
>> guest. The user-space applications can use the provided ACRN ioctls to
>> interact with ACRN hypervisor through different hypercalls.
>>
>> Add one basic framework firstly and the following patches will
>> add the corresponding implementations, which includes the management of
>> virtualized CPU/memory/interrupt and the emulation of MMIO/IO/PCI access.
>> The device file of /dev/acrn_hsm can be accessed in user-space to
>> communicate with ACRN module.
>>
>> Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
>> Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
>> Co-developed-by: Jack Ren <jack.ren@intel.com>
>> Signed-off-by: Jack Ren <jack.ren@intel.com>
>> Co-developed-by: Mingqiang Chi <mingqiang.chi@intel.com>
>> Signed-off-by: Mingqiang Chi <mingqiang.chi@intel.com>
>> Co-developed-by: Liu Shuo <shuo.a.liu@intel.com>
>> Signed-off-by: Liu Shuo <shuo.a.liu@intel.com>
>> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
>> ---
>>   drivers/staging/Kconfig         |   2 +
> 
> Also, your subject line for all of these patches are wrong, it is not
> drivers/acrn :(

Thanks for the pointing out it.

It will be fixed.

> 
> And you forgot to cc: the staging maintainer :(

Do you mean that the maintainer of staging subsystem is also added in 
the patch commit log?


> 
> As I have said with NUMEROUS Intel patches in the past, I now refuse to
> take patches from you all WITHOUT having it signed-off-by someone from
> the Intel "OTC" group (or whatever the Intel Linux group is called these
> days).  They are a resource you can not ignore, and if you do, you just
> end up making the rest of the kernel community grumpy by having us do
> their work for them :(
> 
> Please work with them.

OK. I will work with some peoples in OTC group to prepare the better 
ACRN driver.

> 
> greg k-h
> 
