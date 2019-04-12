Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B05C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594A42082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfDLPjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:39:55 -0400
Received: from ms.lwn.net ([45.79.88.28]:45164 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfDLPjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:39:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DF6C7308;
        Fri, 12 Apr 2019 15:39:50 +0000 (UTC)
Date:   Fri, 12 Apr 2019 09:39:47 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Markus Heiser <markus.heiser@darmarit.de>
Cc:     David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Alan Stern <stern@rowland.harvard.edu>,
        Akira Yokosawa <akiyks@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>
Subject: Re: [PATCH 0/8] Prepare files under Documentation/*.txt to build
 with Sphinx
Message-ID: <20190412093947.62913186@lwn.net>
In-Reply-To: <df609cad-fa5b-ac15-314f-ac8759771d90@darmarit.de>
References: <94c47f05-0412-b938-908d-1ef8a91243ed@darmarit.de>
        <cover.1554889999.git.mchehab+samsung@kernel.org>
        <18261.1555064496@warthog.procyon.org.uk>
        <27303.1555071586@warthog.procyon.org.uk>
        <df609cad-fa5b-ac15-314f-ac8759771d90@darmarit.de>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Apr 2019 14:34:25 +0200
Markus Heiser <markus.heiser@darmarit.de> wrote:

> Am 12.04.19 um 14:19 schrieb David Howells:
> > Markus Heiser <markus.heiser@darmarit.de> wrote:
> >   
> >> Which is already named in our 'How to write kernel documentation' introduction
> >>
> >> - https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html#writing-documentation  
> > 
> > This should really be in Documentation/ directory.
> >   
> 
> I agree with you, it is a kind of information hiding.  If you know proper
> places, please send a patch to Jon.

As Jani pointed out, it's in Documentation/doc-guide.

If you're saying it should be in the top level, I kind of disagree.
Documentation/ is an exercise in hiding information by placing it in the
middle of 200 other, unrelated files.  We've made some progress on that,
and I would like to continue to do so.

Thanks,

jon
