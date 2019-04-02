Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,TRACKER_ID autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89104C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5124A2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfDBJAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:00:12 -0400
Received: from smtprelay0215.hostedemail.com ([216.40.44.215]:43937 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729162AbfDBJAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:00:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 1F86D8368EF5;
        Tue,  2 Apr 2019 09:00:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: road75_58642180c7c51
X-Filterd-Recvd-Size: 2107
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue,  2 Apr 2019 09:00:07 +0000 (UTC)
Message-ID: <a3d975a7a8e378c5a831d7ae6a98da1af9557c05.camel@perches.com>
Subject: Re: [PATCH 4.4 034/131] lib/int_sqrt: optimize small argument
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Anshul Garg <aksgarg1989@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        David Miller <davem@davemloft.net>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Davidson <md@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 02 Apr 2019 02:00:06 -0700
In-Reply-To: <20190402065958.GA21380@kroah.com>
References: <20190401170051.645954551@linuxfoundation.org>
         <20190401170055.035782875@linuxfoundation.org>
         <d153fa8079c3e49e1ad35a54c400298ba51184e3.camel@perches.com>
         <20190402065958.GA21380@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-02 at 08:59 +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 01, 2019 at 10:42:52AM -0700, Joe Perches wrote:
> > On Mon, 2019-04-01 at 19:01 +0200, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > If this is to be ported just for an optimization
> > (which I think is dubious as it's not a bug fix),
> 
> Yes, it was requested to be backported because of that.
> 
> > why not port the __fls optimization too?
> > 
> > __fls has a bigger effect on performance.
> 
> What commit are you referring to?

f8ae107eef209bff29a5816bc1aad40d5cd69a80

> thanks,
> 
> greg k-h

