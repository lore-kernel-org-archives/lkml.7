Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99BCC4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830E1217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfJBUVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 16:21:32 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36544 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfJBUVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 16:21:32 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8CE9315501857;
        Wed,  2 Oct 2019 13:21:31 -0700 (PDT)
Date:   Wed, 02 Oct 2019 13:21:21 -0700 (PDT)
Message-Id: <20191002.132121.402975401040540710.davem@davemloft.net>
To:     keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        pankaj.laxminarayan.bharadiya@intel.com, joe@perches.com,
        adobriyan@gmail.com, netdev@vger.kernel.org
Subject: Re: renaming FIELD_SIZEOF to sizeof_member
From:   David Miller <davem@davemloft.net>
In-Reply-To: <201910021115.9888E9B@keescook>
References: <CAHk-=wg8+eNK+SK1Ekqm0qNQHVM6e6YOdZx3yhsX6Ajo3gEupg@mail.gmail.com>
        <201909261347.3F04AFA0@keescook>
        <201910021115.9888E9B@keescook>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 02 Oct 2019 13:21:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Wed, 2 Oct 2019 11:19:16 -0700

> On Thu, Sep 26, 2019 at 01:56:55PM -0700, Kees Cook wrote:
>> On Thu, Sep 26, 2019 at 01:06:01PM -0700, Linus Torvalds wrote:
>> >  (a) why didn't this use the already existing and well-named macro
>> > that nobody really had issues with?
>> 
>> That was suggested, but other folks wanted the more accurate "member"
>> instead of "field" since a treewide change was happening anyway:
>> https://www.openwall.com/lists/kernel-hardening/2019/07/02/2
>> 
>> At the end of the day, I really don't care -- I just want to have _one_
>> macro. :)
>> 
>> >  (b) I see no sign of the networking people having been asked about
>> > their preferences.
>> 
>> Yeah, that's entirely true. Totally my mistake; it seemed like a trivial
>> enough change that I didn't want to bother too many people. But let's
>> fix that now... Dave, do you have any concerns about this change of
>> FIELD_SIZEOF() to sizeof_member() (or if it prevails, sizeof_field())?
> 
> David, can you weight in on this? Are you okay with a mass renaming of
> FIELD_SIZEOF() to sizeof_member(), as the largest user of the old macro
> is in networking?

I have no objection to moving to sizeof_member().
