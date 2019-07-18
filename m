Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95141C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66BB72173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JHF5kY9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389475AbfGRIOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 04:14:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58488 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfGRIOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 04:14:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6I8E53H117444;
        Thu, 18 Jul 2019 08:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=MnWKO1aPepCSn5Io1XMEqlaALN7Sd2EdfHGfadQRpQ4=;
 b=JHF5kY9QipPRj5DmCnbVs9QEtCrzknotJLpXqBTUZTaFmEdGTSTpUGTCZc58/5J8/CeY
 vPYcSWEzZPyAV3kl+3eBhazuJbPiTJAuq15oMLk3uwLG4ShNc7zTR6kt0ptV8srOqhoC
 82qymY2E/0aM15M3GkdIDF2KhHvBgNW6ALcHkgnStqrSgFJd4MOgzewgmIQGrOpjmauY
 g9WaMa+AfVyrlmxRqAVCVC4hulJpfpL5/f1DZjeeLVCN72AYSyOoPWdvTQpZCLW/jS2r
 288C7wBo45PWhcjqU6CyPtlyC2CXgg0ahZzI1KHP+WvnIX6QW07Y7tttLKR7mcAQnPo/ Jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2tq6qtyet2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 08:14:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6I8CgO1054919;
        Thu, 18 Jul 2019 08:14:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2tt77hkg61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 08:14:04 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6I8DuVE018307;
        Thu, 18 Jul 2019 08:13:58 GMT
Received: from [10.191.31.100] (/10.191.31.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Jul 2019 08:13:56 +0000
Subject: Re: [PATCH] x86/boot/compressed/64: Remove unused variable
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
References: <1563283040-31101-1-git-send-email-zhenzhong.duan@oracle.com>
 <20190717143451.xbz6dkjnmxd7rcon@black.fi.intel.com>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <e513acb4-a893-8134-4853-d31bd3b87ef9@oracle.com>
Date:   Thu, 18 Jul 2019 16:13:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190717143451.xbz6dkjnmxd7rcon@black.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9321 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907180095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9321 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907180095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/7/17 22:34, Kirill A. Shutemov wrote:
> On Tue, Jul 16, 2019 at 01:17:20PM +0000, Zhenzhong Duan wrote:
>> Fix gcc warning:
>>
>> arch/x86/boot/compressed/pgtable_64.c: In function 'find_trampoline_placement':
>> arch/x86/boot/compressed/pgtable_64.c:43:16: warning: unused variable 'trampoline_start' [-Wunused-variable]
>>    unsigned long trampoline_start;
>>                  ^
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>
> Have no idea why I don't see the warning in my setup.

Try below:

make bzImage EXTRA_CFLAGS="-Wunused-variable"

Zhenzhong
