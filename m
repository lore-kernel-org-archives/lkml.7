Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3BEC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DF82189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfGDHU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:20:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:57058 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725920AbfGDHU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:20:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4B9FBB116;
        Thu,  4 Jul 2019 07:20:27 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Alistair Francis <alistair.francis@wdc.com>,
        linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 0/2] RISC-V: Handle the siginfo_t offset problem
References: <20190703005202.7578-1-alistair.francis@wdc.com>
        <mvmk1czh9y6.fsf@suse.de>
        <CAKmqyKPn9GBg=n1j-ZpEdCN4Qfi5qfNtEVgpgF8rYRpof4eNDA@mail.gmail.com>
X-Yow:  First, I'm going to give you all the ANSWERS to today's test..
 So just plug in your SONY WALKMANS and relax!!
Date:   Thu, 04 Jul 2019 09:20:26 +0200
In-Reply-To: <CAKmqyKPn9GBg=n1j-ZpEdCN4Qfi5qfNtEVgpgF8rYRpof4eNDA@mail.gmail.com>
        (Alistair Francis's message of "Wed, 3 Jul 2019 11:40:39 -0700")
Message-ID: <mvmpnmqfepx.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 03 2019, Alistair Francis <alistair23@gmail.com> wrote:

> On Wed, Jul 3, 2019 at 12:08 AM Andreas Schwab <schwab@suse.de> wrote:
>>
>> On Jul 02 2019, Alistair Francis <alistair.francis@wdc.com> wrote:
>>
>> > In the RISC-V 32-bit glibc port [1] the siginfo_t struct in the kernel
>> > doesn't line up with the struct in glibc. In glibc world the _sifields
>> > union is 8 byte alligned (although I can't figure out why)
>>
>> Try ptype/o in gdb.
>
> That's a useful tip, I'll be sure to use that next time.

It was a serious note.  If the structs don't line up then there is a
mismatch in types that cannot be solved by adding spurious padding.  You
need to fix the types instead.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
