Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6B6C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48B720842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfCEJE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 04:04:58 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:42265 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfCEJE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 04:04:57 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44D9vW1YBvz1r01l;
        Tue,  5 Mar 2019 10:04:54 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44D9vV4tTDz1qsGC;
        Tue,  5 Mar 2019 10:04:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id d0xFcn_OCexw; Tue,  5 Mar 2019 10:04:48 +0100 (CET)
X-Auth-Info: 6VFST/1W+J/lIPG2Oh71DqkMVyuw67MR5UP8JZTuvZXtUamfO2B/8trNURSSmObW
Received: from hawking (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  5 Mar 2019 10:04:48 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
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
X-Yow:  I have a very good DENTAL PLAN.  Thank you.
Date:   Tue, 05 Mar 2019 10:04:48 +0100
In-Reply-To: <alpine.LNX.2.21.1903051948290.147@nippy.intranet> (Finn Thain's
        message of "Tue, 5 Mar 2019 19:58:54 +1100 (AEDT)")
Message-ID: <mvmh8chzo7j.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mär 05 2019, Finn Thain <fthain@telegraphics.com.au> wrote:

> interesting that the kernel's strlen implementation in 
> include/linux/string.h can't achieve this.

This implementation is only available if ARCH_HAS_FORTIFY_SOURCE.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
