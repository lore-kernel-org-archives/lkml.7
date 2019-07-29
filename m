Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1957CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB48D20578
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfG2ODd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:03:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:33142 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726281AbfG2ODd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:03:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11049AFE1;
        Mon, 29 Jul 2019 14:03:32 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Anup Patel <anup@brainfault.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Alan Kao <alankao@andestech.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-riscv\@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH 3/4] RISC-V: Support case insensitive ISA string parsing.
References: <20190726194638.8068-1-atish.patra@wdc.com>
        <20190726194638.8068-3-atish.patra@wdc.com>
        <alpine.DEB.2.21.9999.1907261346560.26670@viisi.sifive.com>
        <a8a6be2c-2dcb-fe58-2c32-e3baa357819c@wdc.com>
        <alpine.DEB.2.21.9999.1907261625220.26670@viisi.sifive.com>
        <MN2PR04MB6061790AFE4E0AAA838678028DC30@MN2PR04MB6061.namprd04.prod.outlook.com>
        <alpine.DEB.2.21.9999.1907270043190.26998@viisi.sifive.com>
        <CAAhSdy0Eycc0ORSnh6LJeC_D_x9yLOkoc7OkPNuN6qOcZEGVWg@mail.gmail.com>
        <alpine.DEB.2.21.9999.1907270108420.26998@viisi.sifive.com>
        <CAAhSdy1pqZP+M27idvfOB8eB8zhPD_7hx9S60FpOmWRHs-R2qg@mail.gmail.com>
X-Yow:  Did you GAIN WEIGHT in th' past 5 MINUTES or am I just DREAMING of two
 BROCCOLI FLORETS lying in an empty GAS TANK?
Date:   Mon, 29 Jul 2019 16:03:28 +0200
In-Reply-To: <CAAhSdy1pqZP+M27idvfOB8eB8zhPD_7hx9S60FpOmWRHs-R2qg@mail.gmail.com>
        (Anup Patel's message of "Sat, 27 Jul 2019 14:19:58 +0530")
Message-ID: <mvmy30haqfj.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 27 2019, Anup Patel <anup@brainfault.org> wrote:

> So, using strncasecmp() in-place of strncmp() and using tolower() for
> each character comparison is complex for you ?

Apparently too complex for you.

+			if (tolower(isa[0] != 's'))

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
