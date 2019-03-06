Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACC2C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B818920661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfCFOtV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:49:21 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:59198 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbfCFOtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:49:20 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 4865814CEA; Wed,  6 Mar 2019 14:49:19 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/3] auxdisplay: charlcd: make backlight initial state configurable
References: <20190301184816.784-1-mans@mansr.com>
        <20190301184816.784-3-mans@mansr.com>
        <CANiq72nFOhrjN0nfBQc28dDyY0XPwWrJwWSkXv0yxGb-B2M-JQ@mail.gmail.com>
Date:   Wed, 06 Mar 2019 14:49:19 +0000
In-Reply-To: <CANiq72nFOhrjN0nfBQc28dDyY0XPwWrJwWSkXv0yxGb-B2M-JQ@mail.gmail.com>
        (Miguel Ojeda's message of "Wed, 6 Mar 2019 10:56:21 +0100")
Message-ID: <yw1xy35s3vo0.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> On Fri, Mar 1, 2019 at 7:48 PM Mans Rullgard <mans@mansr.com> wrote:
>>
>> +#ifdef CONFIG_CHARLCD_BL_ON
>> +#define LCD_INIT_BL "\x1b[L+"
>> +#elif defined (CONFIG_CHARLCD_BL_FLASH)
>
> Style nitpick: no space after "elif defined". Do you mind if I change
> it before sending it to linux-next? Otherwise, looks fine to me.
> Thanks!

Of course I don't mind.

-- 
Måns Rullgård
