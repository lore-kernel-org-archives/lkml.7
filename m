Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6E7C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6302070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="n9OP31un"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfECNJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 09:09:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58858 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfECNJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 09:09:57 -0400
Received: from zn.tnic (p200300EC2F0CA900F543088CBF4231E9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:a900:f543:88c:bf42:31e9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1A4601EC09C0;
        Fri,  3 May 2019 15:09:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1556888996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mZNcZfMl/0nZIvjvo19T6lSgrEJQEtjtgRa6F7AhlVY=;
        b=n9OP31un7l7xi1PSyIDxBghylRSD3qfE7vimYCIU/ry1ab1m9BPyuhmOzveI7PD13JHf0h
        zEcT7AeBJfGvZgpQPl26RAnBoE2/Rdp2hVupMF/ixZmH0rZL8+sSOZrN1anYK8pwZFeAD2
        CmM7bAFJRZut77q8ecDnuJbSTzDfg+U=
Date:   Fri, 3 May 2019 15:09:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Changbin Du <changbin.du@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/27] Include linux x86 docs into Sphinx TOC tree
Message-ID: <20190503130950.GD5020@zn.tnic>
References: <20190502070633.9809-1-changbin.du@gmail.com>
 <20190503064347.1d027e87@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190503064347.1d027e87@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 06:43:47AM -0600, Jonathan Corbet wrote:
> x86 folks: how would you like to handle this set?  Take it yourselves,
> have me take it, print it out and set it on fire, ...?

However you prefer. Just don't print it out! :-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
