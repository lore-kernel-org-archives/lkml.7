Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47665C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 01:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E82520882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 01:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e2fEVBQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437064AbfITBO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 21:14:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47270 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390887AbfITBO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 21:14:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8K1EREo029238;
        Fri, 20 Sep 2019 01:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=RzT6HGN5ilPEj3ysgPyiLqhQNYwu/YsTmBPbFV7k16U=;
 b=e2fEVBQuQqGhaxn8BGbSwPLu2nDDjWRhocRSxe79g0ssyw9O0PTIn4sWvFoLnEGOp1zF
 XJOMNrTEhC92R51QFkvO/Jbsizal5XVvxkvEUeRp01ayQGr4QExoA+BkvUINKonF5EwA
 WIXhV8tVUlYEdDjCbsK1SsUXCQy7ZEkA/4hGXcycAeeb06Q7bzJht4XxGxv7AhzhaFYR
 8SXdGTjIlfEKbhPbq/tTBfHixH+1V2HUm8ZlcVadUmMC2ti281Dc4fmtvA1k7TrT5kew
 PkMIGxAd1Kj5EqNc40zVmFjQvkHxKxmsQJKPF41V0eTQcskCq+LoZQqG7W4r5mxsH8QE pg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2v3vb57a76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Sep 2019 01:14:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8K1DE3g155216;
        Fri, 20 Sep 2019 01:14:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2v3vbh6mw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Sep 2019 01:14:28 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8K1ERIj023644;
        Fri, 20 Sep 2019 01:14:27 GMT
Received: from [192.168.86.205] (/69.181.241.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Sep 2019 18:14:27 -0700
Subject: Re: [PATCH 1/2] soc: ti: big cleanup of Kconfig file
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>
Cc:     Olof Johansson <olof@lixom.net>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Sandeep Nair <sandeep_n@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>,
        Tony Lindgren <tony@atomide.com>
References: <8437a1f9-18f2-dd03-4fea-de5ba71f25c9@infradead.org>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <97a9a11e-7784-111e-c134-ef88bd6b51ec@oracle.com>
Date:   Thu, 19 Sep 2019 18:14:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <8437a1f9-18f2-dd03-4fea-de5ba71f25c9@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9385 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909200012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9385 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909200012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/19 3:33 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Cleanup drivers/soc/ti/Kconfig:
> - delete duplicate words
> - end sentences with '.'
> - fix typos/spellos
> - Subsystem is one word
> - capitalize acronyms
> - reflow lines to be <= 80 columns
> 
> Fixes: 41f93af900a2 ("soc: ti: add Keystone Navigator QMSS driver")
> Fixes: 88139ed03058 ("soc: ti: add Keystone Navigator DMA support")
> Fixes: afe761f8d3e9 ("soc: ti: Add pm33xx driver for basic suspend support")
> Fixes: 5a99ae0092fe ("soc: ti: pm33xx: AM437X: Add rtc_only with ddr in self-refresh support")
> Fixes: a869b7b30dac ("soc: ti: Add Support for AM654 SoC config option")
> Fixes: cff377f7897a ("soc: ti: Add Support for J721E SoC config option")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: Sandeep Nair <sandeep_n@ti.com>
> Cc: Dave Gerlach <d-gerlach@ti.com>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
> @Santosh: MAINTAINERS says that you maintain drivers/soc/ti/*,
> but there is more that Keystone-related code in that subdirectory
> now... just in case you want to update that info.
>
Yes am aware there more drivers and so far I have been taking
care of everything in drivers/soc/ti/*

>   drivers/soc/ti/Kconfig |   20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
Patch looks fine to me. Do you want me to pick this up ?

