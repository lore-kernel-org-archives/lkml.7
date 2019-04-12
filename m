Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D39BC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3481420850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfDLKcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:32:03 -0400
Received: from smtp2-4.goneo.de ([85.220.129.36]:50646 "EHLO smtp2-4.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfDLKcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:32:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id 5A19D23F6FD;
        Fri, 12 Apr 2019 12:31:59 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UxFPw4LLLmYE; Fri, 12 Apr 2019 12:31:58 +0200 (CEST)
Received: from [192.168.1.127] (dyndsl-091-248-139-154.ewe-ip-backbone.de [91.248.139.154])
        by smtp2.goneo.de (Postfix) with ESMTPSA id 25FB1240997;
        Fri, 12 Apr 2019 12:31:55 +0200 (CEST)
Subject: Re: [PATCH 0/8] Prepare files under Documentation/*.txt to build with
 Sphinx
To:     David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
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
References: <cover.1554889999.git.mchehab+samsung@kernel.org>
 <18261.1555064496@warthog.procyon.org.uk>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <94c47f05-0412-b938-908d-1ef8a91243ed@darmarit.de>
Date:   Fri, 12 Apr 2019 12:31:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <18261.1555064496@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 12.04.19 um 12:21 schrieb David Howells:
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
>> In the past, we did some efforts to ensure that almost all files under
>> Documentation/*.txt could be built with Sphinx.
> 
> Would recommend a URL.  Presumably this: http://www.sphinx-doc.org

I recommend the Sphinx reStructuredText Primer

- https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html

Which is already named in our 'How to write kernel documentation' introduction

- https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html#writing-documentation


-- Markus --
