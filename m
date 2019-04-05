Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9C8C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3162217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbfDEMdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:33:20 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:58785 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfDEMdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:33:20 -0400
Received: from [192.168.1.110] ([95.114.101.225]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M8C8J-1hFyf20I3H-005HF2; Fri, 05 Apr 2019 14:32:43 +0200
Subject: Re: [PATCH] tty: Add NULL TTY driver
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        linux-kernel@vger.kernel.org
References: <20190403113327.3628-1-vincent.whitchurch@axis.com>
 <20190403131213.GA4246@kroah.com> <20190403141109.3mdmqbt3mjxrie6k@axis.com>
 <e8b1618a-545b-ee35-ec51-f831cbdff7fa@metux.net>
 <20190405090043.vnsftwpdm56cx2hr@axis.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <de23cde3-c77f-cdbf-0968-d7f44c723120@metux.net>
Date:   Fri, 5 Apr 2019 14:32:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190405090043.vnsftwpdm56cx2hr@axis.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:kycUXfgYd7q21EdW2ZVJXFslpqyKKrR9n7N3uQ3jC0Aq4ohFfkg
 C5v9QmVq0zt8nkoalB1T7tiXQyScNTYqesXpKA6so7XOnLIiXCL82yADBhuEhk85/8Q6MOo
 dCB5I3VED7pkitSnVS+NHTkobhr2+DjQ4Y0fFgySP91hk5Jjg3LedO+X2LEG81IAgm62kk9
 hb2xlujnfRcExGGbbQ3JA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tb7VGjqjxU8=:oXUBqTQaAvYC0j8aRk3+EZ
 jKJERXb/ZBf1+xWRSPdcmBf+eCfS/d2EoYg/NnPshE+R6/J06J6qdbCFqM8RA5LljOLY02vC3
 EjNQdGc0L3ePPt1rggjbfcEk6FV0/W5pT6DQABOsM8HDcTYopxfdM6JRtqNnPzLGbPSubTvra
 bl65L6baZYEBDhpez/fbfRclN8zN/mrnOyI72WH1dTOSU+roPKAmpQcHhGt17nq6h+lDa6lWM
 VlNo/LFCOXZ2uywMvqVhlcXm/3Acs9RHpaI1UZMx6RBXeC6f24Ef19qp1NXlJWVIgqmyWQ5+N
 27CfN2rSxNh66HTRUtQURRsecIxscyCLGq6T/JJAuH9xkbsMHkPQkJYe/DAeVDptiNXknV2zV
 LceTTzubDe+FVzSfzLjeLzSEPHxhl3wVP0Lr+x4AmRU6e7EmongRYp5mvryvencXWjO8nVckW
 amkKTTPiAnNL/DVYbG0Z5Y5JDfhxjhzVxVMQeXAWs7S8gJhXufYECgbjWIMPjYfpRGRbLbnWe
 hjAjkGdMLKCiLlCAcCKbovTP5GcfMc47NioZvIUtjddsMPyEhs999fQH1TqXmkKUWfZq0IuDE
 AuP2ldTn5NBGWjvAEmZL4fWq+RwPxOXbjXe+Uf7I8cnaFRVADQLu+42J3QwILgwnU40C00JQk
 7pR+K86X/IUlrO3NV2/JB/rXIf+wO0hGVGV0N6tZkm4N8C7Hcy6ZZMu9HAkZV8JTYZ8p4BlyX
 mT7HHbTkKEqSUEkeEfjoB1VH/MPul9wVDxiAyC2EDnPCBMhUljt3kAOdF8Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.04.19 11:00, Vincent Whitchurch wrote:
> On Fri, Apr 05, 2019 at 10:39:43AM +0200, Enrico Weigelt, metux IT consult wrote:
>> On 03.04.19 16:11, Vincent Whitchurch wrote:
>>
>>> Especially on embedded systems, it would be convenient to have a simple
>>> way to disable the console (both for kernel and userspace) on a system
>>> which normally uses it, to free up the UART for other things.
>>
>> Just symlinking to /dev/null does not work ?
> 
> No, /dev/null does not support the TTY ioctls.

hmm, wo (which programs) do you need, that really need them ?

>> OTOH, if you're introducing a dummy console, wouldn't a ringbuffer that,
>> can be read out later, a better option ?
> 
> There is already a ttyprintk driver in mainline to send these messages
> to the printk ring buffer if one is actually intrested in what is
> written to the console.  There's no option to enable it via console= in
> mainline but I have a patch for that too.

Great. IMHO, that would be the better way.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
