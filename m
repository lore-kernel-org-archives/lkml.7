Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2923C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E89520823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbfCZNRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:17:05 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:53307 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726175AbfCZNRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:17:04 -0400
Received: from [172.18.205.202] (unknown [46.183.103.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id A0DFE604E3A59;
        Tue, 26 Mar 2019 14:17:02 +0100 (CET)
Subject: Re: Reading `/sys/kernel/debug/kmemleak` takes 3 s and content not
 shown
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <88e651e2-d876-376e-81fa-eab0729ebb47@molgen.mpg.de>
 <f18fb509-bee1-e411-3761-bd28a0d8aab7@molgen.mpg.de>
 <ad2278fd-ea56-d715-7efb-c4e0adb7314e@c-s.fr>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <33ad8e80-4275-d5bf-9b6a-052dd8afe7ef@molgen.mpg.de>
Date:   Tue, 26 Mar 2019 14:17:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <ad2278fd-ea56-d715-7efb-c4e0adb7314e@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Christophe,


On 26.03.19 13:55, Christophe Leroy wrote:

> Le 26/03/2019 à 13:49, Paul Menzel a écrit :

>> On 19.02.19 10:44, Paul Menzel wrote:
>>
>>> On a the IBM S822LC (8335-GTA) with Ubuntu 18.10, and Linux 5.0-rc5+
>>> accessing `/sys/kernel/debug/kmemleak` takes a long time. According to
>>> strace it takes three seconds.
>>>
>>> $ dmesg | grep leak
>>> [    4.407957] kmemleak: Kernel memory leak detector initialized
>>> [    4.407959] kmemleak: Automatic memory scanning thread started
>>> [745989.625624] kmemleak: 1 new suspected memory leaks (see 
>>> /sys/kernel/debug/kmemleak)
>>> [1002619.951902] kmemleak: 1 new suspected memory leaks (see 
>>> /sys/kernel/debug/kmemleak)
>>> ```
>>>
>>> Unfortunately, the leaks supposedly stored in that file are not shown
>>> either.
>>
>> The problem is still present with Linux 5.0. Do you have an idea, how 
>> to fix this?
> 
> Have you identified a previous version that works properly?

It seems to have worked with Linux 4.18-rc4+ [1].

> If so, have you been able to bisect the problem?

No, sorry, I have not. I do not have resources for this.


Kind regards,

Paul


[1]: https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-July/175658.html
