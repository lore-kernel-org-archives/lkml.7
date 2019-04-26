Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE6AC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B04B2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfDZOLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:11:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59192 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726154AbfDZOLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:11:41 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3QEAwhD059515
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 10:11:39 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s43d4gmht-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 10:11:38 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Fri, 26 Apr 2019 15:11:37 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 26 Apr 2019 15:11:33 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3QEBWXK11206780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Apr 2019 14:11:32 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BC2BAE066;
        Fri, 26 Apr 2019 14:11:32 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6BA0AE05F;
        Fri, 26 Apr 2019 14:11:31 +0000 (GMT)
Received: from [9.80.210.106] (unknown [9.80.210.106])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 26 Apr 2019 14:11:31 +0000 (GMT)
Subject: Re: [PATCH v2 3/4] media: dt-bindings: aspeed-video: Add missing
 memory-region property
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        andrew@aj.id.au, joel@jms.id.au, robh+dt@kernel.org,
        mark.rutland@arm.com, mchehab@kernel.org, hverkuil@xs4all.nl
References: <1556119020-7609-1-git-send-email-eajames@linux.ibm.com>
 <1556119020-7609-4-git-send-email-eajames@linux.ibm.com>
 <20190424211732.GA18914@bogus>
From:   Eddie James <eajames@linux.ibm.com>
Date:   Fri, 26 Apr 2019 09:11:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424211732.GA18914@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19042614-0060-0000-0000-00000335033B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010999; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01194671; UDB=6.00626376; IPR=6.00975506;
 MB=3.00026608; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-26 14:11:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042614-0061-0000-0000-0000491B1609
Message-Id: <6fd356ba-815b-aa34-abd4-d3709daf453a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904260098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/24/19 4:17 PM, Rob Herring wrote:
> On Wed, 24 Apr 2019 10:16:59 -0500, Eddie James wrote:
>> Missed documenting this property in the initial commit.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>> Changes since v1:
>>   - Add missing semi-colon
>>
>>   Documentation/devicetree/bindings/media/aspeed-video.txt | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.


Yes, I left it off because I added a semi-colon (trivial, I know, but it 
did change). The change log is there below the commit message.

Thanks,

Eddie


>

