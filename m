Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F77C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 06:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D355A206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 06:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfG3GxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 02:53:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:45426 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726833AbfG3GxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 02:53:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 71AB0AED6;
        Tue, 30 Jul 2019 06:53:21 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup@brainfault.org>,
        "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv\@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/16] KVM RISC-V Support
References: <20190729115544.17895-1-anup.patel@wdc.com>
X-Yow:  MERYL STREEP is my obstetrician!
Date:   Tue, 30 Jul 2019 08:53:21 +0200
In-Reply-To: <20190729115544.17895-1-anup.patel@wdc.com> (Anup Patel's message
        of "Mon, 29 Jul 2019 11:56:19 +0000")
Message-ID: <mvm5znkau8u.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ERROR: "riscv_cs_get_mult_shift" [arch/riscv/kvm/kvm.ko] undefined!
ERROR: "riscv_isa" [arch/riscv/kvm/kvm.ko] undefined!
ERROR: "smp_send_reschedule" [arch/riscv/kvm/kvm.ko] undefined!
ERROR: "riscv_timebase" [arch/riscv/kvm/kvm.ko] undefined!

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
