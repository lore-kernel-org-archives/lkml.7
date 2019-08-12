Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0EEC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5079020679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PpzWiwYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfHLQjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 12:39:35 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59902 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfHLQje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:39:34 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7CGdSTf039298;
        Mon, 12 Aug 2019 11:39:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565627968;
        bh=md23hPTLe4IPvI8vg4S3vMldyp9598RszV7otPnzrZs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PpzWiwYY+VyKSb9Mw62MGjQE/ijWqwxSpROIsNucd4bNrj8stlEeOcJYZSMxW6tGr
         SVRSCTTVoGjk7hG6NDU5UHrTgfIyJGdrz7KmezWkUwx8LxIDRGmqFL6V0PqpxE8kYT
         oPQJ4Owxz/UsmfTfAhooMptKdIblr+JAQgn2wdyM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7CGdSJc080163
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Aug 2019 11:39:28 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 12
 Aug 2019 11:39:27 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 12 Aug 2019 11:39:28 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7CGdRfi108093;
        Mon, 12 Aug 2019 11:39:27 -0500
Subject: Re: [PATCH] rpmsg: virtio_rpmsg_bus: replace "%p" with "%pK"
To:     "Andrew F. Davis" <afd@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20181024011909.21674-1-s-anna@ti.com>
 <1cc3d697-6fde-901b-2e35-2e2b53b44425@ti.com>
 <2ef5e274-df09-c3a0-41ed-a945d1902eaf@ti.com>
 <92dc4403-8782-8dbf-b912-cc832ac748a7@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <ea1efb4e-43be-4efc-10f8-9d182313bf12@ti.com>
Date:   Mon, 12 Aug 2019 11:39:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <92dc4403-8782-8dbf-b912-cc832ac748a7@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/19 11:36 AM, Andrew F. Davis wrote:
> On 8/12/19 12:28 PM, Suman Anna wrote:
>> On 8/12/19 10:47 AM, Andrew F. Davis wrote:
>>> On 10/23/18 9:19 PM, Suman Anna wrote:
>>>> The virtio_rpmsg_bus driver uses the "%p" format-specifier for
>>>> printing the vring buffer address. This prints only a hashed
>>>> pointer even for previliged users. Use "%pK" instead so that
>>>> the address can be printed during debug using kptr_restrict
>>>> sysctl.
>>>>
>>>
>>>
>>> s/previliged/privileged
>>
>> Bjorn,
>> Can you fix this up when applying.
>>
>>>
>>> You describe what the code does, but not why you need this. %pK is used
>>> for only about 1% of pointer printing, why do you want to leak this
>>> address to userspace at all?
>>
>> Andrew,
>> Default behavior of %pK is same as %p, but it does allow you to control
>> the print. The reason is clearly mentioned in the last sentence in the
>> patch description.
>>
> 
> 
> Let me rephrase then, why would you ever set 'kptr_restrict' to anything
> other than 0, or why do you want to be able to leak this address to
> userspace at all? If the answer is just because you can, then all 12,000
> instances of %p in kernel could be converted for the same reason.

It is a dev_dbg statement, so it is already under dynamic debug control.
We would only ever use it during debug.

regards
Suman

> 
> Andrew
> 
> 
>> regards
>> Suman
>>
>>>
>>> Andrew
>>>
>>>
>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>>> ---
>>>>  drivers/rpmsg/virtio_rpmsg_bus.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
>>>> index f29dee731026..1345f373a1a0 100644
>>>> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
>>>> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
>>>> @@ -950,7 +950,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
>>>>  		goto vqs_del;
>>>>  	}
>>>>  
>>>> -	dev_dbg(&vdev->dev, "buffers: va %p, dma %pad\n",
>>>> +	dev_dbg(&vdev->dev, "buffers: va %pK, dma %pad\n",
>>>>  		bufs_va, &vrp->bufs_dma);
>>>>  
>>>>  	/* half of the buffers is dedicated for RX */
>>>>
>>

