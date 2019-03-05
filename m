Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D46C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 246002082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oApk3sEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfCEVAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:00:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCEVAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 16:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fd7HlNj4BVhChnF/JU6V3ls1u236HBTBzQQ0AiL7ksM=; b=oApk3sEdw6pOQx4uuwXXezXtm
        haHQr0xy2HC+k8crumF4HNyoA8W/gHu64PlFaN/msolLByx+F1dpSHvkoVHmp5224Z8tKHf6RchZ1
        mrqddJedxx7UyWlyFhrr5KjHuOzFyqXo43xVvVwvZJC/9OrjOk3d+z8zV96FF1R5J2wS/hXdy9OTS
        KX4AUUopiXbitJJU/ajTw4G/QRGR3xXDILLdo0t6tgE9yt6qmw4sVwuNl60oPhljvsjpgdQnXJVvH
        0pCNuuxyr6L5/JVBGqV/OLUgGuBI1qYKIftih+pq4xYGJhLyLTEnLb/97g5jfRzi6m3PCZMowB34Q
        jWf/4bZTw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1HB4-0002IR-Bk; Tue, 05 Mar 2019 21:00:42 +0000
Subject: Re: [PATCH] docs: add extra integer types to printk-formats
To:     Joe Perches <joe@perches.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Louis Taylor <louis@kragniz.eu>, Jonathan Corbet <corbet@lwn.net>,
        pmladek@suse.com, geert+renesas@glider.be,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Jon Flatley <jflat@chromium.org>
References: <20190303123647.22020-1-louis@kragniz.eu>
 <20190303201016.GO9224@smile.fi.intel.com>
 <CAKwvOdm4uCWCtSMVQDVTSKavpT0dCo+ayuwvoXtewmk+ksn5sA@mail.gmail.com>
 <e244390e3d245c94d6d2fb036943e63111ada86d.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a13c431c-5bfe-1bef-78c8-dbac942ca02b@infradead.org>
Date:   Tue, 5 Mar 2019 13:00:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <e244390e3d245c94d6d2fb036943e63111ada86d.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/19 11:59 AM, Joe Perches wrote:
> On Mon, 2019-03-04 at 09:59 -0800, Nick Desaulniers wrote:
>> On Sun, Mar 3, 2019 at 12:10 PM Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>>> On Sun, Mar 03, 2019 at 12:36:47PM +0000, Louis Taylor wrote:
>>>> A few commonly used integer types were absent from this table, so add
>>>> them.
>>>
>>> I'm not against the patch, but isn't obvious by reading POSIX and / or man
>>> printf(3)?
>>
>> You'd think; but based on the sheer number of -Wformat warnings
>> (~450), I'm not so sure.
> 
> <shrug>  software defects are always present.
> 
> Many of the -Wformat warnings are bogus too.
> 
> There's nothing wrong with using %x for a unsigned int
> of less than long size. (u8/u16)
> 
>>   At least with this patch they're "above the
>> fold."
> 
> I'd personally go with
> "posix plus kernel specific deletions and extensions"

Yeah, I don't think that all of the "standard" types/formats need
to be in there.  Just the differences.

>> The kernel also has its own format flag extensions, and does not
>> implement %n (for good reason), so it's better to be explicit than
>> imply posix or glibc compat.
> 
> %i is also supported and used a few hundred times
> 
> 


-- 
~Randy
