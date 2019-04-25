Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0370EC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B882053B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbfDYSmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:42:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55186 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726324AbfDYSmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:42:14 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3PIdN2s004038
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 14:42:13 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s3fcf7ydu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 14:42:08 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Thu, 25 Apr 2019 19:42:00 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Apr 2019 19:41:55 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3PIfsYE12976250
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Apr 2019 18:41:54 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92F00AE06B;
        Thu, 25 Apr 2019 18:41:54 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD97BAE05F;
        Thu, 25 Apr 2019 18:41:53 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.80.220.75])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 25 Apr 2019 18:41:53 +0000 (GMT)
Subject: Re: [PATCH v2 2/5 RFC] use event name instead of enum to make the
 call generic
To:     prsriva <prsriva@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, inux-security-module@vger.kernel.org,
        zohar@linux.ibm.com, ebiederm@xmission.com, vgoyal@redhat.com,
        Prakhar Srivastava <prsriva@microsoft.com>
References: <20190424001544.7188-1-prsriva02@gmail.com>
 <20190424001544.7188-2-prsriva02@gmail.com>
 <d38f32f8-7078-f205-ba11-9c4266ee40e8@linux.vnet.ibm.com>
 <4c313367-22dc-9532-54b5-cd3a79deb625@linux.microsoft.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Date:   Thu, 25 Apr 2019 14:41:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4c313367-22dc-9532-54b5-cd3a79deb625@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19042518-0060-0000-0000-000003340E27
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010994; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01194288; UDB=6.00626142; IPR=6.00975117;
 MB=3.00026596; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-25 18:41:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042518-0061-0000-0000-00004917CE00
Message-Id: <ccdcd117-9b34-ba01-b087-561642447af4@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904250114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/25/2019 01:19 PM, prsriva wrote:
> On 2019-04-25 4:48 a.m., Nayna wrote:
>>
>>
>> On 04/23/2019 08:15 PM, Prakhar Srivastava wrote:
>>> From: Prakhar Srivastava <prsriva02@gmail.com>
>>>
>>> Signed-off-by: Prakhar Srivastava <prsriva@microsoft.com>
>>> ---
>>>
>> The v2 version has to be on top of the HEAD of the repository itself, 
>> and not on the v1 version. Only the final reviewed and tested version 
>> makes to the upstream.
>>
>> Btw, which repository and its branch are you using ?
>>
> I am basing my changes off IMA branch:
> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git

Ok. Please use either next-integrity branch or James Morris next-general 
or next-testing.

Thanks & Regards,
       - Nayna


