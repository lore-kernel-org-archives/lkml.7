Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082FCCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B29208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfJ3Qb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 12:31:57 -0400
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:34910 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbfJ3Qb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:31:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 78742100E7B4A;
        Wed, 30 Oct 2019 16:31:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wound59_10968ccdffb56
X-Filterd-Recvd-Size: 2106
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed, 30 Oct 2019 16:31:53 +0000 (UTC)
Message-ID: <af4a5d9d77482fb538b780989235d6d17d1f39cc.camel@perches.com>
Subject: Re: [PATCH linux-kselftest/test v6] lib/list-test: add a test for
 the 'list' doubly linked list
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        David Gow <davidgow@google.com>
Cc:     shuah <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 30 Oct 2019 09:31:45 -0700
In-Reply-To: <20191030104217.GA18421@kadam>
References: <20191024224631.118656-1-davidgow@google.com>
         <0cb1d948-0da3-eb0f-c58f-ae3a785dd0dd@kernel.org>
         <CABVgOSmCHbGjZBjeWSbPEZbJw22SaBQnoO77xxNzN_ugAwzNiQ@mail.gmail.com>
         <20191030104217.GA18421@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-30 at 13:42 +0300, Dan Carpenter wrote:
> On Wed, Oct 30, 2019 at 01:02:11AM -0700, David Gow wrote:
> > > ERROR: that open brace { should be on the previous line
> > > #869: FILE: lib/list-test.c:680:
> > > +static void list_test_list_for_each_entry_reverse(struct kunit *test)
> > > +{
> > > 
> > > 
> > > I am seeing these error and warns. As per our hallway conversation, the
> > > "for_each*" in the test naming is tripping up checkpatch.pl
> > > 
> > > For now you can change the name a bit to not trip checkpatch and maybe
> > > explore fixing checkpatch to differentiate between function names
> > > with "for_each" in them vs. the actual for_each usages in the code.
[]
> It's better to ignore checkpatch and other scripts when they are wrong.
> (unless the warning message inspires you to make the code more readable
> for humans).

True.


