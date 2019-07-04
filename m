Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96245C5B578
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 01:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C7B218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 01:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfGDBXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 21:23:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8136 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726574AbfGDBXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 21:23:20 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 32C64764528F2CFDDA99;
        Thu,  4 Jul 2019 09:23:18 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Thu, 4 Jul 2019
 09:23:16 +0800
Subject: Re: [PATCH -next] integrity: Remove set but not used variable 'acl'
To:     David Howells <dhowells@redhat.com>
References: <20190703025518.6379-1-yuehaibing@huawei.com>
 <15691.1562162261@warthog.procyon.org.uk>
CC:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kairui Song <kasong@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Eric Biggers <ebiggers@google.com>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <be6aaeb1-13ab-50bc-81a6-c461d3748820@huawei.com>
Date:   Thu, 4 Jul 2019 09:23:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <15691.1562162261@warthog.procyon.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/3 21:57, David Howells wrote:
> YueHaibing <yuehaibing@huawei.com> wrote:
> 
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> security/integrity/digsig.c: In function 'integrity_init_keyring':
>> security/integrity/digsig.c:99:18: warning:
>>  variable 'acl' set but not used [-Wunused-but-set-variable]
>>
>> It seems 'acl' is needed in __integrity_init_keyring
> 
> I've folded this fix in, thanks.

Thanks, also I write a wrong patch title.

> 
> David
> 
> .
> 

