Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38AFC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 23:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED4326550
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 23:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfEaXgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 19:36:21 -0400
Received: from ms.lwn.net ([45.79.88.28]:37358 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfEaXgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 19:36:20 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D10EA728;
        Fri, 31 May 2019 23:36:19 +0000 (UTC)
Date:   Fri, 31 May 2019 17:36:18 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC] Rough draft document on merging and rebasing
Message-ID: <20190531173618.465ae659@lwn.net>
In-Reply-To: <7979b995-6b03-783b-e3d7-0023fabc43bc@infradead.org>
References: <20190530135317.3c8d0d7b@lwn.net>
        <7979b995-6b03-783b-e3d7-0023fabc43bc@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2019 17:45:23 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 5/30/19 12:53 PM, Jonathan Corbet wrote:
> > +  git merge v5.2-rc1^0  
> 
> That line is presented in my email client (Thunderbird) as
> 
>      git merge v5.2-rc1{superscript 0}
> 
> Could you escape/quote it to prevent that?

So I'm a wee bit confused.  That's a literal string that one needs to
type to obtain the needed effect; if thunderbird is doing weird things
with it, I think that the problem does not lie with the document...?  What
change would you have me make here?

Thanks,

jon
