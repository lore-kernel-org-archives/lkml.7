Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED4CC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587C22082F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfF0JPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 05:15:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:51214 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726293AbfF0JPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 05:15:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C402AC41;
        Thu, 27 Jun 2019 09:15:29 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Troy Benjegerdes <troy.benjegerdes@sifive.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Olof Johansson <olof@lixom.net>,
        linux-riscv@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] RISC-V: defconfig: enable MMC & SPI for RISC-V
References: <20190625225636.9288-1-atish.patra@wdc.com>
        <6D4D90AF-59F9-4523-A916-7CFAC8E43C45@sifive.com>
X-Yow:  Are we THERE yet?  My MIND is a SUBMARINE!!
Date:   Thu, 27 Jun 2019 11:15:28 +0200
In-Reply-To: <6D4D90AF-59F9-4523-A916-7CFAC8E43C45@sifive.com> (Troy
        Benjegerdes's message of "Tue, 25 Jun 2019 18:58:20 -0500")
Message-ID: <mvmlfxntmmn.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 25 2019, Troy Benjegerdes <troy.benjegerdes@sifive.com> wrote:

> and I see this in the log
>
> [    1.106626] m25p80 spi0.0: unrecognized JEDEC id bytes: 9d 70 19 9d 70 19

You need the patchset "mtd: spi-nor: add support for is25wp256 spi-nor
flash".

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
