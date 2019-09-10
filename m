Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23E2C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7D4208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393399AbfIJOmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:42:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:42654 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732767AbfIJOmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:42:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CD812B742;
        Tue, 10 Sep 2019 14:42:33 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        paul.walmsley@sifive.com, linux-serial@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
References: <20190910055923.28384-1-hch@lst.de> <mvm4l1kskny.fsf@suse.de>
        <20190910070503.GA31743@lst.de> <mvmzhjcr2d4.fsf@suse.de>
        <20190910143630.GA6794@lst.de>
X-Yow:  I'm in DISGUISE as a BAGGAGE CHECKER....I can watch the house, if it's
 ORANGE...
Date:   Tue, 10 Sep 2019 16:42:33 +0200
In-Reply-To: <20190910143630.GA6794@lst.de> (Christoph Hellwig's message of
        "Tue, 10 Sep 2019 16:36:30 +0200")
Message-ID: <mvmftl4p606.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 10 2019, Christoph Hellwig <hch@lst.de> wrote:

> On Tue, Sep 10, 2019 at 10:18:15AM +0200, Andreas Schwab wrote:
>> > How so?  Wіth OF and a stdout path you just set earlycon on the
>> > command line without any arguments and it will be found.
>> 
>> Doesn't work for me.
>> 
>> [    0.000000] Malformed early option 'earlycon'
>
> That functionality is implemented by param_setup_earlycon and
> early_init_dt_scan_chosen_stdout.  Check why those aren't built into
> your kernel.

They are.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
