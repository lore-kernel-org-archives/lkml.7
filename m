Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F02CC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49EA320855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfKUMgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 07:36:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17182 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726532AbfKUMgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 07:36:09 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xALCWAGj133909
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 07:36:08 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wdfxu3yf5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 07:36:08 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <hoeppner@linux.ibm.com>;
        Thu, 21 Nov 2019 12:36:05 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Nov 2019 12:36:02 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xALCa1GP46268858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Nov 2019 12:36:01 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EC744C050;
        Thu, 21 Nov 2019 12:36:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC98B4C058;
        Thu, 21 Nov 2019 12:36:00 +0000 (GMT)
Received: from [9.152.212.204] (unknown [9.152.212.204])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 21 Nov 2019 12:36:00 +0000 (GMT)
Subject: Re: [PATCH] dasd_fba: Display '00000000' for zero page when dumping
 sense
To:     Hannes Reinecke <hare@suse.de>
Cc:     Stefan Haberland <sth@linux.ibm.com>, linux-s390@vger.kernel.org,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        Sebastian Parschauer <sparschauer@suse.de>
References: <20191118111226.56666-1-hare@suse.de>
From:   =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.ibm.com>
Date:   Thu, 21 Nov 2019 13:36:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191118111226.56666-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19112112-0008-0000-0000-00000335AFD2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112112-0009-0000-0000-00004A54D8D4
Message-Id: <d329f133-6ed7-0389-2c7f-64c6bdc364c5@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_02:2019-11-21,2019-11-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 clxscore=1011 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911210115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/19 12:12 PM, Hannes Reinecke wrote:
> When a discard I/O fails, dasd_fba_dump_sense() will crash as it
> tries to print out the CCW, and failing to take into account that
> for discard I/O we have only one data pointer, not one per sg.
> As the data pointer will always point to the zero page this patch
> replaces the data pointer output with '00000000' to avoid the crash.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> [sparschauer: replaced "ccw" with "act", "snprintf" with "sprintf"]
> [sparschauer v2: added missing curly braces to for loops]
> Signed-off-by: Sebastian Parschauer <sparschauer@suse.de>
> ---
>  drivers/s390/block/dasd_fba.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 

Hi Hannes,

thanks for the patch. However,

> diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
> index cbb770824226..4b867bd6b164 100644
> --- a/drivers/s390/block/dasd_fba.c
> +++ b/drivers/s390/block/dasd_fba.c
> @@ -717,10 +717,15 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
>  			       " CCW %p: %08X %08X DAT:",
>  			       act, ((int *) act)[0], ((int *) act)[1]);
>  		for (count = 0; count < 32 && count < act->count;
> -		     count += sizeof(int))
> +		     count += sizeof(int)) {
> +			if (act->flags & CCW_FLAG_SLI) {

I'm not quite happy with the usage of CCW_FLAG_SLI here.
We're currently looking into this issue in more detail to fully
understand the problem.

I'll let you know the outcome and possible improvements for the
patch as soon as possible.

regards,
Jan

