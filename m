Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E12C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B196208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732177AbfDXQEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:04:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbfDXQEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:04:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E8CC430BCE6E;
        Wed, 24 Apr 2019 16:04:00 +0000 (UTC)
Received: from treble (ovpn-123-99.rdu2.redhat.com [10.10.123.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E90A060C64;
        Wed, 24 Apr 2019 16:03:59 +0000 (UTC)
Date:   Wed, 24 Apr 2019 11:03:57 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Apr 17 (objtool)
Message-ID: <20190424160357.6olyocstevbz7wnw@treble>
References: <20190417173117.196b5ac6@canb.auug.org.au>
 <7114e2f5-0c1f-c5e4-177c-2a5c61d12d58@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7114e2f5-0c1f-c5e4-177c-2a5c61d12d58@infradead.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 24 Apr 2019 16:04:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 08:41:34AM -0700, Randy Dunlap wrote:
> On 4/17/19 12:31 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > News: there will be no linux-next release on Friday, Monday or Thursday
> > April 25.
> > 
> > Changes since 20190416:
> > 
> 
> on x86_64:
> 
>   CC      drivers/gpu/drm/i915/i915_gem_execbuffer.o
> drivers/gpu/drm/i915/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x18: redundant UACCESS disable
> 
> 
> obj file is attached.

Peter,

I haven't looked at this, do you know if this is the same issue as the
other note from Randy, or something else?

-- 
Josh
