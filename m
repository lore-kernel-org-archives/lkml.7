Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F7EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906FD20679
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XLiVMvIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfH0WPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 18:15:48 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36636 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfH0WPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 18:15:48 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7RMFd06100214;
        Tue, 27 Aug 2019 17:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566944139;
        bh=clXFNBgwSck9rTxOo247PkRKSEoFPXqKlO574sWJ6g8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XLiVMvIbFuncOMbTT3YqzwHC9y7m9HjI5Rn/Hjxm0jv2eqE4fuo31vq8cgKx/Csyk
         jrdp5xsA6NaAPe3v8rn4JJdWGMpsdoXQjvX9c3yaYoW12ci2DhLXaS1X99ekDZyp9z
         igOJ8Jl7X8TeYHkv8Cb3D0guRTiFTDhDDlbUA/y4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7RMFdHM063545
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Aug 2019 17:15:39 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 27
 Aug 2019 17:15:39 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 27 Aug 2019 17:15:39 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7RMFdwq130567;
        Tue, 27 Aug 2019 17:15:39 -0500
Subject: Re: [PATCH] rpmsg: virtio_rpmsg_bus: replace "%p" with "%pK"
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20181024011909.21674-1-s-anna@ti.com>
 <40831f80-1e36-66ca-b8e5-684d46ba167e@ti.com> <20190827051007.GK1263@builder>
 <8d36d695-dd66-c21f-f49e-f6dc3dbdfc5a@ti.com> <20190827220711.GK6167@minitux>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <619b06b0-c3cc-e36f-c3e5-d13e98520c9c@ti.com>
Date:   Tue, 27 Aug 2019 17:15:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190827220711.GK6167@minitux>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/19 5:07 PM, Bjorn Andersson wrote:
> On Tue 27 Aug 13:25 PDT 2019, Suman Anna wrote:
> 
>> Hi Bjorn,
>>
>> On 8/27/19 12:10 AM, Bjorn Andersson wrote:
>>> On Fri 09 Aug 13:25 PDT 2019, Suman Anna wrote:
>>>
>>>> Hi Bjorn,
>>>>
>>>
>>> Hi Suman
>>>
>>>> On 10/23/18 8:19 PM, Suman Anna wrote:
>>>>> The virtio_rpmsg_bus driver uses the "%p" format-specifier for
>>>>> printing the vring buffer address. This prints only a hashed
>>>>> pointer even for previliged users. Use "%pK" instead so that
>>>>> the address can be printed during debug using kptr_restrict
>>>>> sysctl.
>>>>
>>>> Seems to have been lost among the patches, can you pick up this trivial
>>>> patch for 5.4? Should apply cleanly on the latest HEAD as well.
>>>>
>>>
>>> I share Andrew's question regarding what benefit you have from knowing
>>> this value. Should we not just remove the va from the print? Or do you
>>> actually have a use case for it?.
>>
>> I mainly use it during debug when comparing against kernel_page_tables
>> and vmallocinfo. The pools that we use are not always guaranteed to be
>> from linear memory, and behavior changes when using with CMA or DMA pools.
>>
> 
> Thanks Suman. It seems to me that there's room for improvement to aid
> this kind of debugging. But your usecase seems reasonable, so I'm
> merging the patch.

Thanks Bjorn.

> 
>> Note that usage of %pK does not leak the addresses automatically, but
>> atleast enables me to get the values when needed. The changes also bring
>> the usage in rpmsg core in sync with the remoteproc core.
>>
> 
> Sounds like shouldn't have merged them in remoteproc then ;P

Slightly different reasoning looking at the commit, it was probably when
%p was leaking the addresses.

regards
Suman

> 
> Thanks,
> Bjorn
> 
>> regards
>> Suman
>>
>>>
>>> Regards,
>>> Bjorn
>>>
>>>> regards
>>>> Suman
>>>>
>>>>>
>>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>>>> ---
>>>>>  drivers/rpmsg/virtio_rpmsg_bus.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
>>>>> index f29dee731026..1345f373a1a0 100644
>>>>> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
>>>>> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
>>>>> @@ -950,7 +950,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
>>>>>  		goto vqs_del;
>>>>>  	}
>>>>>  
>>>>> -	dev_dbg(&vdev->dev, "buffers: va %p, dma %pad\n",
>>>>> +	dev_dbg(&vdev->dev, "buffers: va %pK, dma %pad\n",
>>>>>  		bufs_va, &vrp->bufs_dma);
>>>>>  
>>>>>  	/* half of the buffers is dedicated for RX */
>>>>>
>>>>
>>

