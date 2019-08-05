Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBAAC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BF620880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfHEJfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:35:31 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52935 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfHEJfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:35:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 462CL73Nknz9sDB;
        Mon,  5 Aug 2019 19:35:27 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christian Brauner <christian@brauner.io>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, santosh@fossix.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.3-3 tag
In-Reply-To: <CAADWXX-B=twNfqs=2hbp0UFpnhqmUDMFZA3tjXFEjDp2dAD_YA@mail.gmail.com>
References: <87a7cpw3on.fsf@concordia.ellerman.id.au> <CAADWXX-B=twNfqs=2hbp0UFpnhqmUDMFZA3tjXFEjDp2dAD_YA@mail.gmail.com>
Date:   Mon, 05 Aug 2019 19:35:25 +1000
Message-ID: <877e7svtsy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Sun, Aug 4, 2019 at 4:49 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Please pull some more powerpc fixes for 5.3:
>
> Hmm. This was caught by the gmail spam-filter for some reason. I don't
> see anything particularly different from your normal pull requests, so
> don't ask me why.
>
> The fact that you have no email authentication (dkim/spf/whatever) for
> your email address tends to make gmail more suspicious of emails, so
> it's probably then some random other pattern that just happened to
> trigger it.
>
> I do check my spam fairly religiously, so it's not like it's usually a
> problem - and I obviously marked it as ham to hopefully teach gmail
> the error of its ways. So this is just a heads up.

Thanks.

> But if you do have the possibility of enabling DKIM or similar on
> ellerman.id.au, then that is always a good thing, of course. I hate
> spam, even even if DKIM and friends certainly aren't perfect, they are
> better than nothing.

I'll talk to sfr about getting DKIM/SPF setup, he's the brains behind my
mail setup.

cheers
