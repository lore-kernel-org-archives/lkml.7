Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E42CC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329602075B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k1vjYN/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfHLQ2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 12:28:37 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41740 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfHLQ2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:28:36 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7CGSSO6082982;
        Mon, 12 Aug 2019 11:28:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565627308;
        bh=IsKWgqgOglbaA6eYIe/r12Zf5tXCWsmgx1YMeflw7pY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=k1vjYN/uiF81v43522pzxwnJM4QIt1smtzfCqAKw3TsOp5y3pigH2fwmguZGIpBV0
         f4F4jQPxhApuQ/gfhORnEtUSVrccfREOb7LHI4URSZ7wcH7fgQyDF5rULGOY5kJqf4
         OMgA6bShR1TPvJNx2CNByzAdBdw6d0sdEM4e2DY4=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7CGSSbf067422
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Aug 2019 11:28:28 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 12
 Aug 2019 11:28:27 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 12 Aug 2019 11:28:27 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7CGSRX0093082;
        Mon, 12 Aug 2019 11:28:27 -0500
Subject: Re: [PATCH] rpmsg: virtio_rpmsg_bus: replace "%p" with "%pK"
To:     "Andrew F. Davis" <afd@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20181024011909.21674-1-s-anna@ti.com>
 <1cc3d697-6fde-901b-2e35-2e2b53b44425@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <2ef5e274-df09-c3a0-41ed-a945d1902eaf@ti.com>
Date:   Mon, 12 Aug 2019 11:28:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1cc3d697-6fde-901b-2e35-2e2b53b44425@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/19 10:47 AM, Andrew F. Davis wrote:
> On 10/23/18 9:19 PM, Suman Anna wrote:
>> The virtio_rpmsg_bus driver uses the "%p" format-specifier for
>> printing the vring buffer address. This prints only a hashed
>> pointer even for previliged users. Use "%pK" instead so that
>> the address can be printed during debug using kptr_restrict
>> sysctl.
>>
> 
> 
> s/previliged/privileged

Bjorn,
Can you fix this up when applying.

> 
> You describe what the code does, but not why you need this. %pK is used
> for only about 1% of pointer printing, why do you want to leak this
> address to userspace at all?

Andrew,
Default behavior of %pK is same as %p, but it does allow you to control
the print. The reason is clearly mentioned in the last sentence in the
patch description.

regards
Suman

> 
> Andrew
> 
> 
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>>  drivers/rpmsg/virtio_rpmsg_bus.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
>> index f29dee731026..1345f373a1a0 100644
>> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
>> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
>> @@ -950,7 +950,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
>>  		goto vqs_del;
>>  	}
>>  
>> -	dev_dbg(&vdev->dev, "buffers: va %p, dma %pad\n",
>> +	dev_dbg(&vdev->dev, "buffers: va %pK, dma %pad\n",
>>  		bufs_va, &vrp->bufs_dma);
>>  
>>  	/* half of the buffers is dedicated for RX */
>>

