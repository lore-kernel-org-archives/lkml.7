Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DED0CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 17:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48BD2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 17:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfJaRQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 13:16:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:44788 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728547AbfJaRQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 13:16:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 21002B88F;
        Thu, 31 Oct 2019 17:16:43 +0000 (UTC)
Date:   Thu, 31 Oct 2019 18:16:41 +0100
From:   Torsten Duwe <duwe@suse.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        amit.kachhap@arm.com, catalin.marinas@arm.com, deller@gmx.de,
        James.Bottomley@hansenpartnership.com, james.morse@arm.com,
        jeyu@kernel.org, jpoimboe@redhat.com, jthierry@redhat.com,
        linux-parisc@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org, svens@stackframe.org,
        takahiro.akashi@linaro.org, will@kernel.org
Subject: Re: [PATCHv2 0/8] arm64: ftrace cleanup + FTRACE_WITH_REGS
Message-ID: <20191031171641.GB11684@suse.de>
References: <20191029165832.33606-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029165832.33606-1-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After yesterday's testing, now

Reviewed-by: Torsten Duwe <duwe@suse.de>

for the series. 

Executive summary: where I used x28 as scratch register in ftrace_regs_caller
which I had to save for that reason, you switched to x10, which is so obvious
that I failed to see it. Then the PLT initialisation on module load, and
finally the ftrace_init_nop() hook that got you started initially. The rest
I'd call more or less cosmetic deviations from my v8. IOW: fine with me.

	Torsten

