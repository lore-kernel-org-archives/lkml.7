Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A4FCA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F0E20856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfJ3RSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 13:18:55 -0400
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:58027 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726602AbfJ3RSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 13:18:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id B056A181D3417;
        Wed, 30 Oct 2019 17:18:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: books65_87a83c243a247
X-Filterd-Recvd-Size: 2019
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed, 30 Oct 2019 17:18:52 +0000 (UTC)
Message-ID: <fad58e4f48237894de0d511adf1d663a42a2eee7.camel@perches.com>
Subject: Re: [PATCH linux-kselftest/test v6] lib/list-test: add a test for
 the 'list' doubly linked list
From:   Joe Perches <joe@perches.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        shuah <shuah@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 30 Oct 2019 10:18:44 -0700
In-Reply-To: <CAFd5g47OZ8x9=etJUj4Sgsw38VQb0j=omOUsubc7+pb2rJi0bQ@mail.gmail.com>
References: <20191024224631.118656-1-davidgow@google.com>
         <0cb1d948-0da3-eb0f-c58f-ae3a785dd0dd@kernel.org>
         <CABVgOSmCHbGjZBjeWSbPEZbJw22SaBQnoO77xxNzN_ugAwzNiQ@mail.gmail.com>
         <20191030104217.GA18421@kadam>
         <42a8270d-ed6f-d29f-5e71-7b76a074b63e@kernel.org>
         <CAFd5g47OZ8x9=etJUj4Sgsw38VQb0j=omOUsubc7+pb2rJi0bQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-30 at 09:35 -0700, Brendan Higgins wrote:
> Agreed. I can see the point of not wanting to write an exception into
> checkpatch for every exception of it's general rules; however, it
> would be nice if there was a way to maybe have a special comment or
> something that could turn off a checkpatch error. That way, a
> checkpatch error/warning always means some action should be taken, and
> if a rule is being ignored, there is always documentation as to why.

That couldn't work when a comment which may exist
in a file is out of scope of the patch context.


