Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B878AC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DAF420989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfEGOgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 10:36:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:51874 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726403AbfEGOgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 10:36:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C26BDAD55;
        Tue,  7 May 2019 14:36:02 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: fix locking violation in page fault handler
References: <mvm5zqmu35d.fsf@suse.de>
        <b2030f8c-010e-7088-271e-e2398f7d37db@suse.com>
        <mvmmujyqrpj.fsf@suse.de>
        <ae3297cc-8a8d-a48e-159e-741c7af41cf7@suse.com>
X-Yow:  I'm RELIGIOUS!!  I love a man with a HAIRPIECE!!
 Equip me with MISSILES!!
Date:   Tue, 07 May 2019 16:36:02 +0200
In-Reply-To: <ae3297cc-8a8d-a48e-159e-741c7af41cf7@suse.com> (Nikolay
        Borisov's message of "Tue, 7 May 2019 17:22:08 +0300")
Message-ID: <mvmef5aqqlp.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mai 07 2019, Nikolay Borisov <nborisov@suse.com> wrote:

> On 7.05.19 г. 17:12 ч., Andreas Schwab wrote:
>> On Mai 07 2019, Nikolay Borisov <nborisov@suse.com> wrote:
>> 
>>> At the very least the code under
>>> no_context label could go into it's own function since it just kills the
>>> process and never returns?
>> 
>> This is not true.
>
> Be more specific, according to do_task_dead after the last __schedule is
> called the calling context is no more?

	/* Are we prepared to handle this kernel fault? */
	if (fixup_exception(regs))
		return;

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
