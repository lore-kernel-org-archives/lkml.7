Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE1AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FB52084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfCKKNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:13:44 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:55175 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfCKKNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 06:13:44 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44Hv8625nXz1rghm;
        Mon, 11 Mar 2019 11:13:42 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44Hv861K3Sz1qrh7;
        Mon, 11 Mar 2019 11:13:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id iK2EuWQwnvaM; Mon, 11 Mar 2019 11:13:39 +0100 (CET)
X-Auth-Info: PuUMWg16PZN5vIUhrFYiG6A2/X6ktOkszYb+6OrbTxV2BVTdGf38tDzRY5B9P3Td
Received: from hawking (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 11 Mar 2019 11:13:39 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [m68k:master 1174/1174] arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' forming offset 8 is out of the bounds [0, 7]
References: <201903042049.npxcZzps%fengguang.wu@intel.com>
        <CAMuHMdX365qmWiii=gQLADpW49EMkdDrVJDPWNBpAZuZM0WQFQ@mail.gmail.com>
        <alpine.LNX.2.21.1903051154200.135@nippy.intranet>
        <alpine.LNX.2.21.1903051357410.135@nippy.intranet>
        <CAMuHMdUuwudbk15GUPPxL+-Gt4zhhSomk-wMAHeTOkoaDOCUAA@mail.gmail.com>
        <alpine.LNX.2.21.1903051948290.147@nippy.intranet>
        <mvmh8chzo7j.fsf@linux-m68k.org>
        <alpine.LNX.2.21.1903071329140.513@nippy.intranet>
        <CAMuHMdVzLTO-yYJJ=HqVySX6gqes9cnyspungsB5maduzNt0RA@mail.gmail.com>
        <alpine.LNX.2.21.1903080838260.595@nippy.intranet>
        <CAMuHMdWr-Y7mfH3gFXfK0fWpEhhdoW9VUkOEwf0nFN8kfr4zrg@mail.gmail.com>
        <mvmo96hvin9.fsf@linux-m68k.org>
        <CAMuHMdU9gke1=5PfjpJWuUbSBQ=bPQjpEVD3+t3F3tHvh9szWg@mail.gmail.com>
X-Yow:  I hope something GOOD came in the mail today so I have
 a REASON to live!!
Date:   Mon, 11 Mar 2019 11:13:39 +0100
In-Reply-To: <CAMuHMdU9gke1=5PfjpJWuUbSBQ=bPQjpEVD3+t3F3tHvh9szWg@mail.gmail.com>
        (Geert Uytterhoeven's message of "Mon, 11 Mar 2019 11:05:44 +0100")
Message-ID: <mvmimwpvhv0.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mär 11 2019, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Andreas,
>
> On Mon, Mar 11, 2019 at 10:56 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
>> On Mär 11 2019, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> > On Thu, Mar 7, 2019 at 10:42 PM Finn Thain <fthain@telegraphics.com.au> wrote:
>> >> No, the link fails because the compiler still emits some references to
>> >> strlen().
>> >
>> > Despite -ffreestanding?!?
>>
>> *Because* of -ffreestanding.  Without that, strlen would be recognized
>> and turned into __builtin_strlen.
>
> Now I'm confused: if we have a static inline or #define for strlen(),

Do you?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
