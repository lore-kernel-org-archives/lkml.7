Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E29FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E091921916
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfCTUca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:32:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbfCTUca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:32:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33D222192C;
        Wed, 20 Mar 2019 20:32:29 +0000 (UTC)
Date:   Wed, 20 Mar 2019 16:32:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <tzanussi@gmail.com>
Cc:     Pali =?UTF-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        linux-kernel@vger.kernel.org
Subject: Re: dell_smbios KASAN bug
Message-ID: <20190320163227.3aa924c2@gandalf.local.home>
In-Reply-To: <1553113736.2015.2.camel@gmail.com>
References: <1553106560.2080.5.camel@gmail.com>
        <20190320144146.08ecd5e4@gandalf.local.home>
        <1553108749.2079.1.camel@gmail.com>
        <20190320151353.1a223c0e@gandalf.local.home>
        <1553110221.2034.1.camel@gmail.com>
        <20190320154534.46ebab51@gandalf.local.home>
        <1553113736.2015.2.camel@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 15:28:56 -0500
Tom Zanussi <tzanussi@gmail.com> wrote:

> > > Unfortunately, no.  
> > 
> > That's really weird. I would recommend throwing in a bunch of printks
> > to see if things are being freed and set, to make sure this code is
> > hit
> > and something else isn't just corrupting it.
> >   
> 
> Actually the patch does make the KASAN bug go away - I'm so used to
> building without modules that I forgot to rebuild the module after
> applying the patch, sigh.

I wasn't about to say anything. That's why I suggested adding printks
and trying it again ;-)

-- Steve
