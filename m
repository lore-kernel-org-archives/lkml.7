Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4C3C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 06:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9202087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 06:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfG3Gvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 02:51:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:45072 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726833AbfG3Gvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 02:51:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 97E03AE5C;
        Tue, 30 Jul 2019 06:51:46 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        "linux-riscv\@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "hch\@infradead.org" <hch@infradead.org>,
        "daniel.lezcano\@linaro.org" <daniel.lezcano@linaro.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "paul.walmsley\@sifive.com" <paul.walmsley@sifive.com>,
        "rkrcmar\@redhat.com" <rkrcmar@redhat.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "anup\@brainfault.org" <anup@brainfault.org>,
        "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        "palmer\@sifive.com" <palmer@sifive.com>,
        "pbonzini\@redhat.com" <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 13/16] RISC-V: KVM: Add timer functionality
References: <20190729115544.17895-1-anup.patel@wdc.com>
        <20190729115544.17895-14-anup.patel@wdc.com> <mvmpnlsc39p.fsf@suse.de>
        <d26a4582fad27d0f475cf8bca4d3e6c49987d37d.camel@wdc.com>
X-Yow:  This is a NO-FRILLS flight -- hold th' CANADIAN BACON!!
Date:   Tue, 30 Jul 2019 08:51:43 +0200
In-Reply-To: <d26a4582fad27d0f475cf8bca4d3e6c49987d37d.camel@wdc.com> (Atish
        Patra's message of "Mon, 29 Jul 2019 18:02:00 +0000")
Message-ID: <mvma7cwaubk.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 29 2019, Atish Patra <Atish.Patra@wdc.com> wrote:

> Strange. We never saw this error.

It is part of CONFIG_KERNEL_HEADER_TEST.  Everyone developing a driver
should enable it.

> #include <linux/types.h>
>
> Can you try it at your end and confirm please ?

Confirmed.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
