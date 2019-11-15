Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E37C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F7F20733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKOJRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:17:10 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34364 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726196AbfKOJRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:17:09 -0500
X-IronPort-AV: E=Sophos;i="5.68,307,1569254400"; 
   d="scan'208";a="78503109"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Nov 2019 17:17:07 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 068A44CE1BF5;
        Fri, 15 Nov 2019 17:08:56 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Fri, 15 Nov 2019 17:17:16 +0800
Subject: Re: [RFC PATCH] x86/acpi: Drop duplicate BOOT table initialization
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
CC:     the arch/x86 maintainers <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20191115050613.1556-1-ruansy.fnst@cn.fujitsu.com>
 <CAJZ5v0jmQEKip=7530mTSzeY_bRSyJv_Y7B49AJuLiDaTjJqSQ@mail.gmail.com>
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <f0ecbe30-67e8-4376-0848-b1d67200fe30@cn.fujitsu.com>
Date:   Fri, 15 Nov 2019 17:18:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jmQEKip=7530mTSzeY_bRSyJv_Y7B49AJuLiDaTjJqSQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 068A44CE1BF5.AEEC8
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/19 5:09 PM, Rafael J. Wysocki wrote:
> On Fri, Nov 15, 2019 at 6:06 AM Shiyang Ruan <ruansy.fnst@cn.fujitsu.com> wrote:
>>
>> From: Cao jin <caoj.fnst@cn.fujitsu.com>
>>
>> ACPI BOOT table is initialized in both acpi_boot_table_init &
>> acpi_boot_init of setup_arch, but its usage is quite late at the end of
>> start_kernel. It should be safe to drop one of them. Since it is less
>> related with table init, drop it from there.
>>
>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> 
> Please resend with a CC to linux-acpi@vger.kernel.org
> 

Sure. It is better to let get_maintainer.pl tell the whole list.

-- 
Sincerely,
Cao jin


