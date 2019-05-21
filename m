Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C2AC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178B52173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfEUPbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:31:09 -0400
Received: from ms.lwn.net ([45.79.88.28]:41548 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728628AbfEUPbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:31:09 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A6DC06A2;
        Tue, 21 May 2019 15:31:08 +0000 (UTC)
Date:   Tue, 21 May 2019 09:31:07 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the jc_docs tree
Message-ID: <20190521093107.79790d12@lwn.net>
In-Reply-To: <2143236.hFqxAeOdFG@bentobox>
References: <20190521074435.7a277fd6@canb.auug.org.au>
        <20190520155423.2ad5d16a@lwn.net>
        <2143236.hFqxAeOdFG@bentobox>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019 09:18:21 +0200
Sven Eckelmann <sven@narfation.org> wrote:

> On Monday, 20 May 2019 23:54:23 CEST Jonathan Corbet wrote:
> [...]
> > Argh, sorry, I should have caught that.  Fixed, thanks.  
> 
> Thanks for trying. Unfortunately it was changed to the wrong value. The actual 
> commit I wanted to reference in both places of the commit message was:
> 
>     8ea8814fcdcb ("LICENSES: Clearly mark dual license only licenses")
> 
> It seems I've copied the wrong commit id for some reason when I send it though 
> the git-fixes alias and it didn't occur to me that I just referenced my own 
> patch. Sorry about the confusion.

<sigh>

We want those tags to be right.  I'm going to fix this and force-push,
hopefully nobody will get too made at me...

jon
