Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61457C3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C55D23430
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfH3XnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 19:43:16 -0400
Received: from smtprelay0040.hostedemail.com ([216.40.44.40]:52317 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728122AbfH3XnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 19:43:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id F37E6182244EB;
        Fri, 30 Aug 2019 23:43:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: seat34_55d04a6b29a5b
X-Filterd-Recvd-Size: 2303
Received: from XPS-9350.home (unknown [47.151.137.30])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri, 30 Aug 2019 23:43:09 +0000 (UTC)
Message-ID: <91042c66d0e8fd6cb0b3baf0325bc1f8340738a3.camel@perches.com>
Subject: Re: [PATCH v2] kunit: fix failure to build without printk
From:   Joe Perches <joe@perches.com>
To:     Brendan Higgins <brendanhiggins@google.com>, Tim.Bird@sony.com
Cc:     shuah@kernel.org, sergey.senozhatsky.work@gmail.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
        sboyd@kernel.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, rdunlap@infradead.org, sfr@canb.auug.org.au
Date:   Fri, 30 Aug 2019 16:43:08 -0700
In-Reply-To: <20190830233710.GA101591@google.com>
References: <20190828093143.163302-1-brendanhiggins@google.com>
         <20190828094929.GA14038@jagdpanzerIV>
         <8b2d63bf-56cd-e8f5-e8ee-2891c2c1be8f@kernel.org>
         <f2d5b474411b2940d62198490f06e77890fbdb32.camel@perches.com>
         <20190830183821.GA30306@google.com>
         <bc688b00b2995e4b11229c3d4d90f532e00792c7.camel@perches.com>
         <ECADFF3FD767C149AD96A924E7EA6EAF977A8392@USCULXMSG01.am.sony.com>
         <ca01d8c4823c63db52fc0f18d62334aeb5634a50.camel@perches.com>
         <CAFd5g45X8bOiTWn5TMe3iEFwASafr6dWo6c4bG32uRKbQ+r5oA@mail.gmail.com>
         <ECADFF3FD767C149AD96A924E7EA6EAF977A8416@USCULXMSG01.am.sony.com>
         <20190830233710.GA101591@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-30 at 16:37 -0700, Brendan Higgins wrote:
> I thought you and Joe were arguing that "Joe's" resulted in a smaller
> object size than "Mine" (not to be confused with the actual patch I
> presented here, which is what Sergey suggested I do on a different
> thread).
> 
> I really don't feel strongly about what Sergey suggested I do (which is
> what this patch originally introduced), versus, what Joe suggested,
> versus what I suggested in response to Joe (or any of the things
> suggested on other threads). I just want to pick one, fix the breakage
> in linux-next, and move on with my life.

Well, if we are voting, I vote for mine! ;)

cheers, Joe

