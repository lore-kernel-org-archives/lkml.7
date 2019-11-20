Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61532C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3979D224D2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbfKTNcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:32:21 -0500
Received: from ms.lwn.net ([45.79.88.28]:45212 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729366AbfKTNcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:32:20 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 096C1867;
        Wed, 20 Nov 2019 13:32:20 +0000 (UTC)
Date:   Wed, 20 Nov 2019 06:32:19 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, shuah <shuah@kernel.org>,
        David Gow <davidgow@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH linux-kselftest/test v3] Documentation: kunit: add
 documentation for kunit_tool
Message-ID: <20191120063219.1ad15b68@lwn.net>
In-Reply-To: <CAFd5g47+3TN4pOdeM0YmJpMP2uKnpJYUY_OXmqmZEn8OcVz6ow@mail.gmail.com>
References: <20191119003120.154041-1-brendanhiggins@google.com>
        <4a3aada5-fe8f-9c82-dfd4-0494acf59334@infradead.org>
        <CAFd5g47+3TN4pOdeM0YmJpMP2uKnpJYUY_OXmqmZEn8OcVz6ow@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2019 17:14:20 -0800
Brendan Higgins <brendanhiggins@google.com> wrote:

> On Tue, Nov 19, 2019 at 4:27 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > On 11/18/19 4:31 PM, Brendan Higgins wrote:  
> > > +How do I use kunit_tool?
> > > +=================================  
> >
> > Hi,
> > I haven't tested this, but Sphinx (or some doc tool) usually complains if the
> > underline length is not the same as the header text length.  (I.e., use fewer
> > = signs above.)  
> 
> Hmmm...Sphinx and checkpatch didn't complain. I wonder if it is a
> different script, or maybe I have to use a particular option with
> Sphinx.

Sphinx wants the underline to be at least as long as the subheading text
above; it's entirely happy if it's longer, though.

jon
