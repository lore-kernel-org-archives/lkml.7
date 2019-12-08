Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950E4C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 23:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9D420637
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 23:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLHXk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 18:40:29 -0500
Received: from smtprelay0136.hostedemail.com ([216.40.44.136]:47135 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726827AbfLHXk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 18:40:28 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 3733B837F24A;
        Sun,  8 Dec 2019 23:40:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shelf57_3e1971b1a1607
X-Filterd-Recvd-Size: 1623
Received: from perches-mx.perches.com (imap-ext [216.40.42.5])
        (Authenticated sender: webmail@joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sun,  8 Dec 2019 23:40:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 08 Dec 2019 17:40:26 -0600
From:   joe@perches.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [GIT PULL] treewide conversion to sizeof_member() for v5.5-rc1
In-Reply-To: <CAHk-=wgnaWN1V2G1zyk8zqTVQBdHBBHcdkB-rek5z2VeRq4nmA@mail.gmail.com>
References: <201912071144.768E249A4F@keescook>
 <CAHk-=wgnaWN1V2G1zyk8zqTVQBdHBBHcdkB-rek5z2VeRq4nmA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4-rc2
Message-ID: <8ad884f80c538efabc5c2442517c75c9@perches.com>
X-Sender: joe@perches.com
X-Originating-IP: [172.58.107.218]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-08 17:19, Linus Torvalds wrote:
> maybe it's
> the 13-year old in me, but "sizeof_member()" just makes me go "that's
> puerile.

The 13 year old in you could grow up one day.  Most 13 year olds don't 
even know that word btw.

> I _can_ see why we'd want to standardize on one of the tree versions
> we have, but I can't really see the problem with the existing #define
> that we have, and that is used (admittedly not all that much):
> sizeof_field()

Call it what the standard calls it.
