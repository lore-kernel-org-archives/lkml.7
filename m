Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9A0C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7D32339F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389453AbfHVT4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 15:56:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfHVT4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:56:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F8BB18C4261;
        Thu, 22 Aug 2019 19:56:30 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 623725D6A7;
        Thu, 22 Aug 2019 19:56:29 +0000 (UTC)
Date:   Thu, 22 Aug 2019 14:56:27 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry.kdev@gmail.com, raph.gault+kdev@gmail.com
Subject: Re: [RFC v4 00/18] objtool: Add support for arm64
Message-ID: <20190822195627.mzi3c4sjqnvnzaho@treble>
References: <20190816122403.14994-1-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190816122403.14994-1-raphael.gault@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Thu, 22 Aug 2019 19:56:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 01:23:45PM +0100, Raphael Gault wrote:
> Hi,
> 
> Changes since RFC V3:
> * Rebased on tip/master: Switch/jump table had been refactored
> * Take Catalin Marinas comments into account regarding the asm macro for
>   marking exceptions.
> 
> As of now, objtool only supports the x86_64 architecture but the
> groundwork has already been done in order to add support for other
> architectures without too much effort.
> 
> This series of patches adds support for the arm64 architecture
> based on the Armv8.5 Architecture Reference Manual.
> 
> Objtool will be a valuable tool to progress and provide more guarentees
> on live patching which is a work in progress for arm64.
> 
> Once we have the base of objtool working the next steps will be to
> port Peter Z's uaccess validation for arm64.

Hi Raphael,

Sorry about the long delay.  I have some comments coming shortly.

One general comment: I noticed that several of the (mostly minor)
suggested changes I made for v1 haven't been fixed.

I'll try to suggest them again here for v4, so you don't need to go back
and find them.  But in the future please try to incorporate all the
comments from previous patch sets before posting new versions.  I'm sure
it wasn't intentional, as you did acknowledge and agree to most of the
changes.  But it does waste people's time and goodwill if you neglect to
incorporate their suggestions.  Thanks.

-- 
Josh
