Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38F3C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 23:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7B527032
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 23:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nFZDBs8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfEaXwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 19:52:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38708 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfEaXwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 19:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3wGlX09ThV78ZhwRXZYCSXCtvWFVlgTZB4/+Smzd1UY=; b=nFZDBs8VSLFtmN7+y341PHMEW
        7eyIuFiANsukXA+F0eH7xtfVBPBEZdimy2HJtX5nsqjIoqUsj+VrJX2s4yYvsAeQsCFMNDPoPGIaE
        k58RHPCRyiEl2OPMHhawhT9ZAP9MZUFphQ4iUGgPXViGtIu+gtMp96geL+2DCaDr73aYOmtZv5wIq
        fqKbMz/o/iuu840hoRRcmJX79DfUrd2KeoHGC4lAwvQEV+iGraVjSH2bzkr578rU+ZBN7ikYOQk2u
        40vvKNWgmAeHvW7LJmOay4jwwQFIGqCyCdDjS4DH76Ynzt6XXeGAKwPMtqqk1beqK5KV3NDCLChC1
        vLguXCTlw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWrJf-0006CE-6Y; Fri, 31 May 2019 23:52:07 +0000
Subject: Re: [PATCH RFC] Rough draft document on merging and rebasing
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
References: <20190530135317.3c8d0d7b@lwn.net>
 <7979b995-6b03-783b-e3d7-0023fabc43bc@infradead.org>
 <20190531173618.465ae659@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <90525060-9c28-6110-9bdd-b0a4a850ab05@infradead.org>
Date:   Fri, 31 May 2019 16:52:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531173618.465ae659@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/19 4:36 PM, Jonathan Corbet wrote:
> On Thu, 30 May 2019 17:45:23 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> On 5/30/19 12:53 PM, Jonathan Corbet wrote:
>>> +  git merge v5.2-rc1^0  
>>
>> That line is presented in my email client (Thunderbird) as
>>
>>      git merge v5.2-rc1{superscript 0}
>>
>> Could you escape/quote it to prevent that?
> 
> So I'm a wee bit confused.  That's a literal string that one needs to
> type to obtain the needed effect; if thunderbird is doing weird things
> with it, I think that the problem does not lie with the document...?  What
> change would you have me make here?

I dunno.  I just won't depend on my email client.
I'll read it some other way (like a text editor).

cheers.
-- 
~Randy
