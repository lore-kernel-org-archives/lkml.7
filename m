Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DD0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C90420878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbfDXPA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:00:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40686 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730764AbfDXPA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:00:56 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OF0qRi049726
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 11:00:55 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s2rmcn01r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 11:00:49 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Wed, 24 Apr 2019 16:00:34 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 24 Apr 2019 16:00:31 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3OF0UYN18808980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 15:00:30 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AF12B2075;
        Wed, 24 Apr 2019 15:00:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A445AB2064;
        Wed, 24 Apr 2019 15:00:28 +0000 (GMT)
Received: from [9.41.179.222] (unknown [9.41.179.222])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 24 Apr 2019 15:00:28 +0000 (GMT)
Subject: Re: [PATCH 0/5] Aspeed: Enable video engine
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Eddie James <eajames@linux.ibm.com>,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        joel@jms.id.au, andrew@aj.id.au, mchehab@kernel.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org
References: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com>
 <b524e352-2e9d-6360-5517-18eee2e02c2c@xs4all.nl>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Wed, 24 Apr 2019 10:00:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b524e352-2e9d-6360-5517-18eee2e02c2c@xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19042415-0072-0000-0000-0000041E5973
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010987; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01193741; UDB=6.00625810; IPR=6.00974565;
 MB=3.00026577; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-24 15:00:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042415-0073-0000-0000-00004BF14B21
Message-Id: <f3cacd11-c68d-9097-4a86-3ebeab046b93@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904240117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/24/19 5:50 AM, Hans Verkuil wrote:
> Hi Eddie,
>
> On 4/2/19 8:24 PM, Eddie James wrote:
>> This series enables the video engine on Aspeed BMC platforms. The video engine
>> clocking is added to the Aspeed clock driver. The use of the video engine reset
>> line, originally planned to be made externally available in the clock driver,
>> is removed from the video engine driver. Finally a node for the video engine is
>> added to the AST2500 devicetree.
>> The series also includes a missing property for reserved memory in the
>> devicetree documentation, and a small change to make the video engine driver
>> start without reserved memory.
> I assume you'll post a v3 since there were some comments?


Sure... The only change would be a missing semi-colon in the devicetree 
doc. And we're only on v2 :)


>
> If you want to get it in for 5.2, then be aware that you should post it tomorrow
> at the latest.
>
> Regards,
>
> 	Hans
>
>> Eddie James (5):
>>    media: platform: Aspeed: Remove use of reset line
>>    media: platform: Aspeed: Make reserved memory optional
>>    media: dt-bindings: aspeed-video: Add missing memory-region property
>>    clk: Aspeed: Setup video engine clocking
>>    ARM: dts: aspeed-g5: Add video engine
>>
>>   .../devicetree/bindings/media/aspeed-video.txt     |  6 ++++
>>   arch/arm/boot/dts/aspeed-g5.dtsi                   | 10 ++++++
>>   drivers/clk/clk-aspeed.c                           | 42 ++++++++++++++++++++--
>>   drivers/media/platform/aspeed-video.c              | 33 ++++-------------
>>   4 files changed, 61 insertions(+), 30 deletions(-)
>>

