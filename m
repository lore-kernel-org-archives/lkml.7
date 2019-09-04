Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A320C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1055B2087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XfzOvHMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731643AbfIDRfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:35:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34690 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfIDRfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:35:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x84HXaJ6178061;
        Wed, 4 Sep 2019 17:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=oKAkTwSIfkLy1nyeOp7Bhpf8xnCuOFObRzurrxywKfg=;
 b=XfzOvHMWY/mrSSg9OA3+35NYIVw1A8UGcpvQvqJfD4G+PPLpa4dvKXqyaeQFs+Ik99Hk
 gclX6tHZ/fAbx6AAnqpSQXewCEhk4kKchGGNdQ39SjqA2ThB7h6i/JzAAKUshzbKsPRz
 aoVIm4fv7GzuKBriNZsIICBVIjsMdjr8hsN0J2/RcjoI7C1CWzUKyAsRrOqxSvBgRkMa
 dascJ8PVldmFQETpIop4ryhCxsVGJTGRC5AqUxmXU24c7Jn0tvVO2D83ZCNaLKt/bKoJ
 DZWMMgXOFb2j9CpYXw3v088ByYCXqCPPWiipTG70FBaZBJ4daVkfMiJ7er07ZT4OqHXr XQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2uthkbr35c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Sep 2019 17:35:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x84HXLJS194806;
        Wed, 4 Sep 2019 17:35:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2usu53e1ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Sep 2019 17:35:41 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x84HZe9E026221;
        Wed, 4 Sep 2019 17:35:40 GMT
Received: from [10.209.243.89] (/10.209.243.89)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Sep 2019 10:35:39 -0700
Subject: Re: [GIT PULL] SOC: TI soc updates for 5.4
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1566875507-8067-1-git-send-email-santosh.shilimkar@oracle.com>
 <CAK8P3a3_NWWBFrpNpbPH9+47Segi_EaYx2jx5jvPhYJJqR+a7A@mail.gmail.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <3af4da24-2246-ff94-b83d-2b6ada4fc362@oracle.com>
Date:   Wed, 4 Sep 2019 10:35:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3_NWWBFrpNpbPH9+47Segi_EaYx2jx5jvPhYJJqR+a7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9370 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909040175
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9370 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909040175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/19 6:13 AM, Arnd Bergmann wrote:
> On Tue, Aug 27, 2019 at 5:12 AM Santosh Shilimkar
> <santosh.shilimkar@oracle.com> wrote:
> 
>> ----------------------------------------------------------------
>> soc: TI soc updates for 5.4
>>
>>   -  Update firmware to support PM domain shared and exclusive support
>>   -  Update driver and dt binding docs for the same.
>>
>> ----------------------------------------------------------------
>>
>> Lokesh Vutla (3):
>>    firmware: ti_sci: Allow for device shared and exclusive requests
>>    dt-bindings: ti_sci_pm_domains: Add support for exclusive and shared
>>      access
>>    soc: ti: ti_sci_pm_domains: Add support for exclusive and shared
>>      access
> 
> Hi Santosh,
> 
> I noticed that your branch is based on top of v5.3-rc2, while my
> arm/drivers branch started out from -rc1.
> 
> Do you have any dependencies on -rc2 in your changes? If not,
> could you please resubmit after rebasing? I can also just
> cherry-pick those three commits if that's easier.
> 
No dependencies. Can you please cherry pick them this time ?
Will use rc1 for future pull request(s). Thanks !!

Regards,
Santosh
