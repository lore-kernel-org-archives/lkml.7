Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9629C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43E6214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfDYKMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:12:47 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:44359 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfDYKMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:12:46 -0400
Received: from [192.168.1.115] ([95.115.19.22]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MD9Kp-1hS9vl1CCH-0098F8; Thu, 25 Apr 2019 12:12:00 +0200
Subject: Re: [PATCH v17 1/3] proc: add /proc/<pid>/arch_status
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, aubrey.li@intel.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
References: <20190421183529.9141-1-aubrey.li@linux.intel.com>
 <alpine.DEB.2.21.1904242310040.1762@nanos.tec.linutronix.de>
 <da1fcb4f-e856-d31f-7c72-76c969af3935@linux.intel.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <6a9e6bd9-8e1a-9fe5-135d-c7a49697b5a4@metux.net>
Date:   Thu, 25 Apr 2019 12:11:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <da1fcb4f-e856-d31f-7c72-76c969af3935@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:DWjGVhgiGI0U4Fgy8cwJyEIbG2GwCDg7welyTjDp1E+6yFIiQ4F
 vbv+1EexMPp1mj9muUO2vON7JFGWLUBiAPxzf7vL3Wyv7DN1SK1/+Xr0X3sAXfNTOTOtLND
 UDOxCDoOpk+bejAxfySv6m1aTyiHDq7C7jV5XyLOkDZR8C/ouZNX8QT7Ot5hYMa6+oucFNT
 UqYtgVgmRJEiDTUaF8h1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FYaBFDv0zmI=:cKdKwldipML1oc0cgK9Ear
 f+//IBoo46/xRsCfDj41yayni+gO7VLuepM5tXztgtgS7dgO3ITvj9F7E8v+HwEm1tJwwcoB3
 SHBEDBhcck6au3BRqDjr5cJXUIBgDUCDbUwuhWshtFwU1GQnbx7u9tE6g2rBIYkhCwmXMQdtW
 t6euKN4FmDhs/QhWV/T/rFGEab/ZZm0D/3Nl1WBP0P4HTkR1HFn5y/v06nEkDkjGgHyqDtEXm
 5haPJUTi3qSkNkmEY4iGvFZkxcOnqpHwlVeumC8LRWqZfw6y1DeANmxeaKwW+RwuTwowkeBhV
 1RCtI50CUlqwFJ60B43vOvE+DD5KhNOEjCiQ/O/y8APpSvZEGyOXfjXrORNDxnrFvaAYYOm6y
 br6U8O9jvMAY5Xb0SM0I1+NTON2GA1su9b4VOEjc7r1B7HC7G6P/FydIpObj2lKA5tGFXFBo7
 bNNldJLXXQm5w3WSRe/k+ctXsg7WHkDGl2R4fx9YdP6c0dbCRUHbc/++zwaWZDycMyA9bODjp
 CY1mayBg9MJfKiWrG2wLm9Y1W1fPUbGB7QfgY8U9TaefRa4cbYeTQTwLnJLPFtWUTSaC5fMbd
 1HlHKNPLUwixmY1aHvSYoVWvZJYzUwILR/dTmo32gvLYxGydOOfFjzPYofFCW+jq7C0pySgnC
 StSyJ+tsZC5ee292xY2w/9almpJ6DsLMS+VCJ7UTPdrpAb8i3nVoPEv01cAqREBKYWrhEoEvw
 1Tv/XwDPbLlYGYoolShtK9cfAxAATIw5IZpBacpXsD5i36FvHR8UjwOGDII=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.19 03:50, Li, Aubrey wrote:

>>> +>>> +config PROC_PID_ARCH_STATUS>>> +	bool "Enable
/proc/<pid>/arch_status file">>>> Why is this switchable? x86 selects it
if PROC_FS is enabled and all other>> architectures are absolutely not
interested in this.> > Above and this, I was trying to avoid an empty
arch_file on other architectures.> In previous proposal the entry only
exists on the platform with AVX512.
Why not making it depend on those archs that actually support it ?

> In that way proc_task_arch_status() should be defined in asm/processor.h,> but proc_task_arch_status() has four parameters, I don't want
unnecessary> "struct pid_namespace *ns" and "struct pid *pid" leaked
into arch headers,> so I defined task_arch_status(m, task) to avoid that.

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
