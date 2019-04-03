Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F31C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027F32084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfDCOfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:35:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726199AbfDCOfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:35:46 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33EZJdx056212
        for <linux-kernel@vger.kernel.org>; Wed, 3 Apr 2019 10:35:44 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rmx7dj1vh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 10:35:44 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Wed, 3 Apr 2019 15:35:42 +0100
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Apr 2019 15:35:23 +0100
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x33EZMRr14811234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Apr 2019 14:35:22 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BCA66A058;
        Wed,  3 Apr 2019 14:35:22 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 338C06A04F;
        Wed,  3 Apr 2019 14:35:21 +0000 (GMT)
Received: from [9.41.179.222] (unknown [9.41.179.222])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  3 Apr 2019 14:35:21 +0000 (GMT)
Subject: Re: [PATCH 2/5] media: platform: Aspeed: Make reserved memory
 optional
To:     Andrew Jeffery <andrew@aj.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        Joel Stanley <joel@jms.id.au>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        Rob Herring <robh+dt@kernel.org>
References: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com>
 <1554229504-5661-3-git-send-email-eajames@linux.ibm.com>
 <7effb2de-cc91-47af-88a2-a0075262e9c4@www.fastmail.com>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Wed, 3 Apr 2019 09:35:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <7effb2de-cc91-47af-88a2-a0075262e9c4@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19040314-0036-0000-0000-00000AA3E857
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010867; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183763; UDB=6.00619767; IPR=6.00964515;
 MB=3.00026278; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-03 14:35:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040314-0037-0000-0000-00004B41BA58
Message-Id: <dd017f44-5d1d-d657-b159-c9dbaadd795f@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904030099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/3/19 1:01 AM, Andrew Jeffery wrote:
>
> On Wed, 3 Apr 2019, at 04:55, Eddie James wrote:
>> Reserved memory doesn't need to be required; system memory would work
>> fine.
> I had to do a bit of legwork to understand what you were doing here. My
> understanding is that we allocate out of the default CMA region if the
> memory-region property isn't specified. Is that what you're expecting?
> Could be helpful to be a little less terse in the commit message.


Correct.


>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   drivers/media/platform/aspeed-video.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/drivers/media/platform/aspeed-video.c
>> b/drivers/media/platform/aspeed-video.c
>> index 55c55a6..8144fe3 100644
>> --- a/drivers/media/platform/aspeed-video.c
>> +++ b/drivers/media/platform/aspeed-video.c
>> @@ -1608,11 +1608,7 @@ static int aspeed_video_init(struct aspeed_video
>> *video)
>>   		return PTR_ERR(video->vclk);
>>   	}
>>   
>> -	rc = of_reserved_mem_device_init(dev);
>> -	if (rc) {
>> -		dev_err(dev, "Unable to reserve memory\n");
>> -		return rc;
>> -	}
>> +	of_reserved_mem_device_init(dev);
> You're ignoring *all* errors here with the expectation that the cause is the
> missing memory-region property. However, other errors can propagate
> out of of_reserved_mem_device_init() - e.g. ENOMEM. Rather than remove
> error checking, I think you should explicitly test for ENODEV, which is what is
> returned if the memory-region property is absent.


But it doesn't matter if it fails for any reason, any DMA allocation 
should fall back to default CMA memory. In the case of ENOMEM or other 
errors, then the later calls to allocate DMA may fail and we can deal 
with it then.


Thanks,

Eddie


>
> Cheers,
>
> Andrew
>
>>   
>>   	rc = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>>   	if (rc) {
>> -- 
>> 1.8.3.1
>>
>>

