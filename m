Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F2FC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61D120818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="VatifGBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfDLSbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:31:07 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45730 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbfDLSbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 14:31:07 -0400
Received: from zn.tnic (p200300EC2F088400182D43E6467BCCF1.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:8400:182d:43e6:467b:ccf1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2B87C1EC04B9;
        Fri, 12 Apr 2019 20:31:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555093866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v9UDZcHZg5PJDbBmRy+k+Gqh5C/Rg/5krCLdxvkiyyY=;
        b=VatifGBkoH1AUNCU5j9nJBDBw3IfOzH4fwDuhHTUfxyImN1Rh9fc7RN/5HhghmfTGGBfop
        rPKJxGIZwI5jcsDPuwrxISkpRYKDJNZkRS4qBh67IG4s3IDvgL43CTLRc+gA7pThxSf2uJ
        SI2WBSJ06+RVsz+j4KkYYVX6BA9oxHs=
Date:   Fri, 12 Apr 2019 20:30:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v9 00/27] x86: load FPU registers on return to userland
Message-ID: <20190412183059.GJ19808@zn.tnic>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190403164156.19645-1-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 06:41:29PM +0200, Sebastian Andrzej Siewior wrote:
> v7…v8:
> Rebased on top of v5.1-rc1. And then:

Ok, all applied and pushed here:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-fpu

Pls have a quick look if all is still ok and not fat-fingered by me. :)

Will let the 0day bot chew on it and I'll run it through my boxes too.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
