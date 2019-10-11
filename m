Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E74C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082F6214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbfJKNo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:44:28 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:34128 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfJKNo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:44:27 -0400
Received: from [167.98.27.226] (helo=[10.35.5.173])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iIvDV-0005kC-UC; Fri, 11 Oct 2019 14:44:26 +0100
Subject: Re: [PATCH] arm: add kernel/fork.c function definitions
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@lists.codethink.co.uk,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191009140637.12443-1-ben.dooks@codethink.co.uk>
 <20191009153316.GA25186@infradead.org>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <12dd599c-e7e8-2cdb-4363-fdf18c023bef@codethink.co.uk>
Date:   Fri, 11 Oct 2019 14:44:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191009153316.GA25186@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2019 16:33, Christoph Hellwig wrote:
> On Wed, Oct 09, 2019 at 03:06:37PM +0100, Ben Dooks wrote:
>> Add the definitions of arch_release_task_struct,
>> arch_task_cache_init and arch_dup_task_struct which
>> are used in kernel/fork.c but defined in various
>> architecture's <asm/thread_info.h>.
> 
> So please lift them into a common header.  In fact I'm pretty sure
> I had that comment before when people did the same blind sparse
> cleanups for riscv..

Does anyone have a preference to where these should go?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
