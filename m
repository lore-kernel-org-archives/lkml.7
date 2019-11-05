Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C7CC17460
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26BE21D71
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="WuJG2FXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389512AbfKEOLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:11:20 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48558 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389498AbfKEOLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:11:20 -0500
Received: from zn.tnic (p200300EC2F0EF00014F02C62D0694FB9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:f000:14f0:2c62:d069:4fb9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 52C4C1EC0CBD;
        Tue,  5 Nov 2019 15:11:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1572963078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VLGdGmL4o83jCrt3NglitjfnxuiENc0LwmjR/cg2SAE=;
        b=WuJG2FXEUCrCHbWqqcqfaoU3VmoDQyIbm/eHdxtmPHaJmct/1PN8ggyB0Y9mbcTVojpskw
        yVz3X1aKvHEm2s/Z/mRCFaCh6rDecpYY1t91sSuWq/u4e5lL+ueZQzKjaJ68XvbGN/hsAe
        z3x6zsYWV/6Aojg6hszBMget9tjW+6o=
Date:   Tue, 5 Nov 2019 15:11:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arthur Gautier <baloo@gandi.net>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: uaccess: fix regression in unsafe_get_user
Message-ID: <20191105141112.GB28418@zn.tnic>
References: <4F2693EA-1553-4F09-9475-781305540DBC@amacapital.net>
 <20190216234702.GP2217@ZenIV.linux.org.uk>
 <20190217034121.bs3q3sgevexmdt3d@khany>
 <20190217042201.GU2217@ZenIV.linux.org.uk>
 <alpine.DEB.2.21.1902181347500.1549@nanos.tec.linutronix.de>
 <CALCETrXyard2OXmOafiLks3YuyO=ObbjDXB6NJo_08rL4M6azw@mail.gmail.com>
 <20190218215150.xklqbfckwmbtdm3t@khany>
 <20190926095825.zkdpya55yjusvv4g@khany>
 <20190926140939.GD18383@zn.tnic>
 <20191010164951.kr2epy5lyywgngt6@khany>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191010164951.kr2epy5lyywgngt6@khany>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 04:49:51PM +0000, Arthur Gautier wrote:
> I did not receive neither the patch Andy provided, nor the comments made
> on it. But I'd be happy to help and/or take over to fix those if someone could
> send me both.

Yes, please do, it seems Andy's busy. You can find the whole thread here:

https://lore.kernel.org/lkml/20190215235901.23541-1-baloo@gandi.net/

and you can download it in mbox format.

Care to take Andy's patch, work in the comments I made to it, test it,
write a commit message, i.e., productize it?

So that we get this thing moving...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
