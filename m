Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6D1C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D4C20861
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="VCxYJEsn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbfGOTgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:36:07 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:45406 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729948AbfGOTgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:36:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 7137B3F407;
        Mon, 15 Jul 2019 21:35:58 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=VCxYJEsn;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id A-dmPFBDnjrU; Mon, 15 Jul 2019 21:35:47 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 529403F21A;
        Mon, 15 Jul 2019 21:35:46 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id B24A5360135;
        Mon, 15 Jul 2019 21:35:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1563219345; bh=VuZsef8kEtw5XdYAWdiDMOKT/1YZxnwCnurJDOo/s/U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VCxYJEsnAvHrlrlOgHSCZdBAhXwpucfsMiLKp5FF6z/uAWF5vlAs7kG52g4HJQzzE
         Dj7mVm88s8PLkQriDlsmox+NCU38ZIU+DUF7C5F20+Ez45FW7E0R1V8K70+lGx3mU1
         1QsDX3sVv5G/MGN6hg3+eQM3B7UpBkGxNfnKAhgk=
Subject: Re: drm pull for v5.3-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <CAPM=9tzJQ+26n_Df1eBPG1A=tXf4xNuVEjbG3aZj-aqYQ9nnAg@mail.gmail.com>
 <CAPM=9twvwhm318btWy_WkQxOcpRCzjpok52R8zPQxQrnQ8QzwQ@mail.gmail.com>
 <CAHk-=wjC3VX5hSeGRA1SCLjT+hewPbbG4vSJPFK7iy26z4QAyw@mail.gmail.com>
 <CAHk-=wiD6a189CXj-ugRzCxA9r1+siSCA0eP_eoZ_bk_bLTRMw@mail.gmail.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas@shipmail.org>
Organization: VMware Inc.
Message-ID: <48890b55-afc5-ced8-5913-5a755ce6c1ab@shipmail.org>
Date:   Mon, 15 Jul 2019 21:35:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiD6a189CXj-ugRzCxA9r1+siSCA0eP_eoZ_bk_bLTRMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, All.

On 7/15/19 8:00 PM, Linus Torvalds wrote:
> On Mon, Jul 15, 2019 at 10:37 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> I'm not pulling this. Why did you merge it into your tree, when
>> apparently you were aware of how questionable it is judging by the drm
>> pull request.
> Looking at some of the fallout, I also see that you then added that
> "adjust apply_to_pfn_range interface for dropped token" patch that
> seems to be for easier merging of this all.
>
> But you remove the 'token' entirely in one place, and in another you
> keep it and just say "whatever, it's unused, pass in NULL". WHAA?
>
> As part of looking at this all, I also note that some of this is also
> very non-kernely.
>
> The whole thing with trying to implement a "closure" in C is simply
> not how we do things in the kernel (although I've admittedly seen
> signs of it in some drivers).
>
> If this should be done at all (and that's questionable), at least do
> it in the canonical kernel way: pass in a separate "actor" function
> pointer and an argument block, don't try to mix function pointers and
> argument data and call it a "closure".
>
> We try to keep data and functions separate. It's not even for security
> concerns (although those have caused some splits in the past - avoid
> putting function pointers in structures that you then can't mark
> read-only!), it's a more generic issue of just keeping arguments as
> arguments - even if you then make a structure of them in order to not
> make the calling convention very complicated.
>
> (Yes, we do have the pattern of sometimes mixing function pointers
> with "describing data", ie the "struct file_operations" structure
> isn't _just_ actual function pointers, it also contains the module
> owner, for example. But those aren't about mixing function pointers
> with their arguments, it's about basically "describing" an object
> interface with more than just the operation pointers).
>
> So some of this code is stuff that I would have let go if it was in
> some individual driver ("Closures? C doesn't have closures! But
> whatever - that driver writer came from some place that taught lamda
> calculus before techning C").
>
> But in the core mm code, I want reviews. And I want the code to follow
> normal kernel conventions.

Sorry for creating this mess, I guess I need to take another spin at 
this, but first I'd like to straighten out a few details:

- I've never had any kernel code more reviewed than this. It's been out 
on LKML and mm-list and maintainers I think 8 times including the RFC. 
The last time I was explicitly asking if anybody had any objections 
because I wanted to get it merged. It's not an internally-reviewed-only 
thing. There have been a number of people looking at the code and 
leaving comments and requesting fixes including Ralph Campbell, Jerome 
Glisse, Souptick Joarder, Nadav Amit and Christoph Hellwig. Perhaps I 
should have been more explicit in requesting R-Bs after fixing up all 
review comments, but I didn't. None of them had any issues similar to 
the ones you describe above.

- The combined callback / argument struct: It was strongly inspired by 
the struct mm_walk (mm.h), the page walk code being quite similar in 
functionality. "Closure" is perhaps a bad name. Originates in X server code.

Thanks,
Thomas


>                     Linus
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


