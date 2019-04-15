Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ECBC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6720120684
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfDOI6u convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:58:50 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44930 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfDOI6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:58:50 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hFxRs-0002td-HM; Mon, 15 Apr 2019 10:58:44 +0200
Date:   Mon, 15 Apr 2019 10:58:44 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v9 00/27] x86: load FPU registers on return to userland
Message-ID: <20190415085844.3agldw2574qx5hag@linutronix.de>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
 <20190412183059.GJ19808@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190412183059.GJ19808@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-12 20:30:59 [+0200], Borislav Petkov wrote:
> On Wed, Apr 03, 2019 at 06:41:29PM +0200, Sebastian Andrzej Siewior wrote:
> > v7…v8:
> > Rebased on top of v5.1-rc1. And then:
> 
> Ok, all applied and pushed here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-fpu
> 
> Pls have a quick look if all is still ok and not fat-fingered by me. :)

So I compared my v9 and against your HEAD (a5eff7259790d) and it all
looks sane.
Thank you for all that effort you put in it.

> Thx.

Sebastian
