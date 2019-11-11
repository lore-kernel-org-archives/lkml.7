Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C58C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBCC214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKKOcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:32:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:42024 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726832AbfKKOcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:32:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1CEA7B53B;
        Mon, 11 Nov 2019 14:32:18 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv\@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Enable SYSCON reboot and poweroff drivers
References: <20191111133421.14390-1-anup.patel@wdc.com>
        <mvmv9rqcxpq.fsf@suse.de>
        <MN2PR04MB60616625B9BEFF634FA680728D740@MN2PR04MB6061.namprd04.prod.outlook.com>
X-Yow:  I'm a fuschia bowling ball somewhere in Brittany
Date:   Mon, 11 Nov 2019 15:32:16 +0100
In-Reply-To: <MN2PR04MB60616625B9BEFF634FA680728D740@MN2PR04MB6061.namprd04.prod.outlook.com>
        (Anup Patel's message of "Mon, 11 Nov 2019 14:21:17 +0000")
Message-ID: <mvm5zjqcwlr.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 11 2019, Anup Patel wrote:

>> -----Original Message-----
>> From: Andreas Schwab <schwab@suse.de>
>> Sent: Monday, November 11, 2019 7:38 PM
>> To: Anup Patel <Anup.Patel@wdc.com>
>> Cc: Palmer Dabbelt <palmer@sifive.com>; Paul Walmsley
>> <paul.walmsley@sifive.com>; Atish Patra <Atish.Patra@wdc.com>; Alistair
>> Francis <Alistair.Francis@wdc.com>; Christoph Hellwig <hch@lst.de>; Anup
>> Patel <anup@brainfault.org>; linux-riscv@lists.infradead.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH] RISC-V: Enable SYSCON reboot and poweroff drivers
>> 
>> On Nov 11 2019, Anup Patel wrote:
>> 
>> > We can use SYSCON reboot and poweroff drivers for the SiFive test
>> > device found on QEMU virt machine and SiFive SOCs.
>> 
>> I don't see any syscon-reboot compatible in the device tree.
>
> I have sent patch to QEMU as well for generating SYSCON DT nodes.

What about the kernel DT?

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
