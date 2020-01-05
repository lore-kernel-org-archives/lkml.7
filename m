Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83600C00523
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 04:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BFC2176D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 04:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgAEEJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 23:09:54 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:53718 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgAEEJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 23:09:53 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1inxEH-0027yC-TE; Sun, 05 Jan 2020 04:09:37 +0000
Date:   Sun, 5 Jan 2020 04:09:29 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Evan Rudford <zocker76@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Is the Linux kernel underfunded? Lack of quality and security?
Message-ID: <20200105040929.GD8904@ZenIV.linux.org.uk>
References: <CAE90CG6SGWKXToVhY5VH-AzUjC6UEwRzoisUXM0OQe9XgcCHRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE90CG6SGWKXToVhY5VH-AzUjC6UEwRzoisUXM0OQe9XgcCHRA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2020 at 04:47:33AM +0100, Evan Rudford wrote:

> - Although the kernel will always remain in C, make serious efforts to
> introduce a safe language for kernel modules and perhaps for some
> subsystems.

Let me see if I've got it right - you suggest introducing an infrastructure
that would provide the bindings between the core kernel and those "safe
language modules" and maintaining its safety (from those languages' point
of view) through the changes of said core kernel *and* through the changes
of ABI of the languages in question?  That takes an impressive skillset
from the poor sods in question - on the level of people actively working
on the language implementation, _in_ _addition_ _to_ what's normally
required for the kernel work.  And that happy group would have to keep
track of the kernel changes.  That will certainly make everything more
secure; I just wonder where have you found the funding to cover the costs
of psychiatric care for the victims^Wproud members of that august group.
You do have that funding lined up, right?
