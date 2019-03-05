Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EA1C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253BC20848
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551798854;
	bh=kFKH0lUp9e60PbzSX6HumtYRz0tQySwYwF2kqdacjJg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=j/Etvt5cAD14rYRRMMdtB7VuGOiJLGKOF/fcRUmK8YY2l9Ubfj/Y8hkLFR2YTAEBA
	 iAA+UENCing23vXRP+xhnWfSq50OV4BgNDg+fOWGO6W3xDTvY8db64JqEpsD4e/R52
	 aTtyC1ugr4fc1EarHgRdqogJanSdOgyfl5u5J3YI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfCEPON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:14:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728332AbfCEPOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:14:12 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF09220848;
        Tue,  5 Mar 2019 15:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551798852;
        bh=kFKH0lUp9e60PbzSX6HumtYRz0tQySwYwF2kqdacjJg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=bq1oaII3KzMWyxtJKqdOz2ZjopjbV/qNSom4ZRDFD+XXspfj7OETiWCKinEI6q98E
         8U2MSvzmBSnNMsYzqFt33pGVIQWLBeyX21C3J3tm09S746S/GJK+sLIHKJhS9BrCva
         5VKp3wXYU0kR3gOAFxAct0SUisGIsei5dJfIew+Y=
Date:   Tue, 5 Mar 2019 16:14:08 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] livepatching for 5.1
In-Reply-To: <nycvar.YFH.7.76.1903051601280.19912@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1903051613100.19912@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1903051601280.19912@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2019, Jiri Kosina wrote:

> Linus,
> 
> please pull from
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git for-linus
> 
> to receive livepatching subsystem updates for 5.1 merge window:
> 
> =====
> - support for something we call 'atomic replace', and allows for much
>   better handling of cumulative patches (which is something very useful
>   for distros), from Jason Baron with help of Petr Mladek and Jason Baron.

Gah, this should've read

	" ... from Jason Baron with help of Petr Mladek and Joe Lawrence"

-- 
Jiri Kosina
SUSE Labs

