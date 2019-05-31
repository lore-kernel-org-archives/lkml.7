Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAF9C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF27F26B64
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfEaPNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:13:44 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34287 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfEaPNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:13:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Fnyr2t7Bz9s1c;
        Sat,  1 Jun 2019 01:13:40 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Jonathan Corbet <corbet@lwn.net>,
        Bhupesh Sharma <bhsharma@redhat.com>
Cc:     linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation/stackprotector: powerpc supports stack protector
In-Reply-To: <20190530081358.650930ad@lwn.net>
References: <1559212177-7072-1-git-send-email-bhsharma@redhat.com> <87v9xsnlu9.fsf@concordia.ellerman.id.au> <CACi5LpM9v1YC_6HhA-uKghawzkEu=TTPVkomMmv2i-LGi8X7+g@mail.gmail.com> <20190530081358.650930ad@lwn.net>
Date:   Sat, 01 Jun 2019 01:13:36 +1000
Message-ID: <87ef4eodwf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> writes:
> On Thu, 30 May 2019 18:37:46 +0530
> Bhupesh Sharma <bhsharma@redhat.com> wrote:
>
>> > This should probably go via the documentation tree?
>> >
>> > Acked-by: Michael Ellerman <mpe@ellerman.id.au>  
>> 
>> Thanks for the review Michael.
>> I am ok with this going through the documentation tree as well.
>
> Works for me too, but I don't seem to find the actual patch anywhere I
> look.  Can you send me a copy?

You can get it from lore:

  https://lore.kernel.org/linuxppc-dev/1559212177-7072-1-git-send-email-bhsharma@redhat.com/raw

Or patchwork (automatically adds my ack):

  https://patchwork.ozlabs.org/patch/1107706/mbox/

Or Bhupesh can send it to you :)

cheers
