Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19347CA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBC3204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfJ3TX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 15:23:57 -0400
Received: from smtprelay0162.hostedemail.com ([216.40.44.162]:39650 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726268AbfJ3TX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 15:23:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id E1847180A8153;
        Wed, 30 Oct 2019 19:23:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: straw99_3f32d4013c734
X-Filterd-Recvd-Size: 2714
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed, 30 Oct 2019 19:23:54 +0000 (UTC)
Message-ID: <f665ec7b21527c7095a61dd5c2f48fd00df0d5c9.camel@perches.com>
Subject: Re: [PATCH linux-kselftest/test v6] lib/list-test: add a test for
 the 'list' doubly linked list
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>, shuah <shuah@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 30 Oct 2019 12:23:45 -0700
In-Reply-To: <20191030191255.GD18421@kadam>
References: <20191024224631.118656-1-davidgow@google.com>
         <0cb1d948-0da3-eb0f-c58f-ae3a785dd0dd@kernel.org>
         <CABVgOSmCHbGjZBjeWSbPEZbJw22SaBQnoO77xxNzN_ugAwzNiQ@mail.gmail.com>
         <20191030104217.GA18421@kadam>
         <42a8270d-ed6f-d29f-5e71-7b76a074b63e@kernel.org>
         <20191030191255.GD18421@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-30 at 22:12 +0300, Dan Carpenter wrote:
> On Wed, Oct 30, 2019 at 10:27:12AM -0600, shuah wrote:
> > > It's better to ignore checkpatch and other scripts when they are wrong.
> > > (unless the warning message inspires you to make the code more readable
> > > for humans).
> > > 
> > 
> > It gets confusing when to ignore and when not to. It takes work to
> > figure out and it is subjective.
> > 
> 
> In this case, it's not subjective because checkpatch is clearly not
> working as intended.

checkpatch _is_ working as intended.
It was never intended to be perfect.

checkpatch _always_ depended on a reviewer deciding
whether its output was appropriate.

> I don't feel like "checkpatch clean" is a useful criteria for applying
> patches.

Nor do I.

> The other things about warnings is that I always encourage people to
> just ignore old warnings.  If you're running Smatch and you see a
> warning in ancient code that means I saw it five years ago and didn't
> fix it so it's a false positive.  Old warnings are always 100% false
> positives.

That'd be not absolute either because it depended on your
historical judgment as to whether an old warning was in fact
a defect or not.

People make mistakes.
Regex based scripts are by design stupid and untrustworthy.

Mistakes will be made.
Just fix the actual defects in code as soon as possible.


