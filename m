Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5D2C5B577
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3D020B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfF1AWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 20:22:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfF1AWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:22:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4989DC057E65;
        Fri, 28 Jun 2019 00:22:13 +0000 (UTC)
Received: from treble (ovpn-126-66.rdu2.redhat.com [10.10.126.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 07713600CC;
        Fri, 28 Jun 2019 00:22:11 +0000 (UTC)
Date:   Thu, 27 Jun 2019 19:22:08 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Michael Forney <mforney@mforney.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        elftoolchain-developers@lists.sourceforge.net
Subject: Re: [PATCH 1/2] objtool: Rename elf_open to prevent conflict with
 libelf from elftoolchain
Message-ID: <20190628002208.v6brs6b6hf7b6sth@treble>
References: <20190616231500.8572-1-mforney@mforney.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190616231500.8572-1-mforney@mforney.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 28 Jun 2019 00:22:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 04:14:59PM -0700, Michael Forney wrote:
> Signed-off-by: Michael Forney <mforney@mforney.org>
> ---
>  tools/objtool/check.c | 2 +-
>  tools/objtool/elf.c   | 2 +-
>  tools/objtool/elf.h   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Sorry for the delay, I was out for a bit and I'm still trying to get
caught back up on email.

These patches look fine.  I'll try to send them on to the -tip tree
shortly.

Just curious, have you done much testing with the elftoolchain version
of libelf and objtool?  So far objtool has only been successfully used
with the elfutils version, so I'm just curious how compatible your
libelf is with the elfutils version.

-- 
Josh
