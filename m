Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB226C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 19:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864F921019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 19:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfEUTEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 15:04:33 -0400
Received: from ms.lwn.net ([45.79.88.28]:42506 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbfEUTEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 15:04:33 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C646A6EC;
        Tue, 21 May 2019 19:04:32 +0000 (UTC)
Date:   Tue, 21 May 2019 13:04:31 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the jc_docs tree
Message-ID: <20190521130431.2ab4c8f7@lwn.net>
In-Reply-To: <1640847.rHWZmc4HWd@sven-edge>
References: <20190521074435.7a277fd6@canb.auug.org.au>
        <1654747.HbZAs67LzE@sven-edge>
        <20190521124603.658acbd3@lwn.net>
        <1640847.rHWZmc4HWd@sven-edge>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019 20:52:46 +0200
Sven Eckelmann <sven@narfation.org> wrote:

> > I'm hoping that's meant to be a joke...?  This is certainly not a big
> > problem on any scale...  
> 
> Not really. If you are so frustrated that you start your reply with "<sigh>" 
> then I think that it was not enough for me to explain what I did wrong and 
> that I am sorry about copying the wrong git commit + not noticing it when 
> pasting it to the commit message. What else should I do? Jump back in time?

It was just a sigh because there was a little mess that I needed to clean
up — one that I had failed to clean up correctly on my first attempt.
That's all. Apologies for giving you any other sort of impression, that
was not intended.  Things happen, life goes on.

jon
