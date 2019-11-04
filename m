Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A54BCA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBEB20869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbfKDNxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:53:31 -0500
Received: from smtprelay0245.hostedemail.com ([216.40.44.245]:40440 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728613AbfKDNxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:53:31 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 5DE2B181D304D;
        Mon,  4 Nov 2019 13:53:29 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-HE-Tag: air76_580e2771dcc23
X-Filterd-Recvd-Size: 1758
Received: from grimm.local.home (unknown [146.247.46.6])
        (Authenticated sender: rostedt@goodmis.org)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon,  4 Nov 2019 13:53:24 +0000 (UTC)
Date:   Mon, 4 Nov 2019 08:53:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        amit.kachhap@arm.com, catalin.marinas@arm.com, deller@gmx.de,
        duwe@suse.de, James.Bottomley@HansenPartnership.com,
        james.morse@arm.com, jeyu@kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, linux-parisc@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, svens@stackframe.org,
        takahiro.akashi@linaro.org, will@kernel.org
Subject: Re: [PATCHv2 1/8] ftrace: add ftrace_init_nop()
Message-ID: <20191104085321.7636be56@grimm.local.home>
In-Reply-To: <20191104133836.GF45140@lakrids.cambridge.arm.com>
References: <20191029165832.33606-1-mark.rutland@arm.com>
        <20191029165832.33606-2-mark.rutland@arm.com>
        <20191104081620.732320a8@grimm.local.home>
        <20191104133836.GF45140@lakrids.cambridge.arm.com>
X-Mailer: Claws Mail 3.17.4git49 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Nov 2019 13:38:36 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>  
> 
> Thanks!
> 
> Just to check, are you happy if this were to go via the arm64 tree with
> the rest of the patches?

Yes, if I wasn't I would have said something. But I guess I should have
been explicit and stated that I'm fine with it going in your tree. My
current updates should not conflict with this.

-- Steve
