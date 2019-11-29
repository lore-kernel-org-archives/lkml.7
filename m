Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C6EC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 17:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715A1215F1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 17:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfK2RIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 12:08:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49200 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbfK2RIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 12:08:20 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iajkV-0002WT-0w; Fri, 29 Nov 2019 18:08:07 +0100
Date:   Fri, 29 Nov 2019 18:08:06 +0100
From:   'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Barret Rhoden <brho@google.com>, Borislav Petkov <bp@alien8.de>,
        Josh Bleecher Snyder <josharian@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "ian@airs.com" <ian@airs.com>,
        Austin Clements <austin@google.com>,
        David Chase <drchase@golang.org>
Subject: Re: [PATCH v2] x86/fpu: Don't cache access to fpu_fpregs_owner_ctx
Message-ID: <20191129170806.f6gvbpsom74njxpb@linutronix.de>
References: <c87e93c3-5f30-f242-74b7-6c7ccc91158a@google.com>
 <20191126202026.csrmjre6vn2nxq7c@linutronix.de>
 <e4d6406b-0d47-5cc5-f3a8-6d14bd90760b@google.com>
 <20191127124243.u74osvlkhcmsskng@linutronix.de>
 <20191127140754.GB3812@zn.tnic>
 <f4d5ca28-a388-c382-4b1a-4b65c9f9e6e7@google.com>
 <20191128085306.hxfa2o3knqtu4wfn@linutronix.de>
 <d99a4a85441d48b1b34a7fb648d12379@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d99a4a85441d48b1b34a7fb648d12379@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-29 16:57:42 [+0000], David Laight wrote:
> Should both fpregs_lock() and fpregs_unlock() contain a barrier() (or "memory" clobber)
> do stop the compiler moving anything across them?

They already do.

> 	David

Sebastian
