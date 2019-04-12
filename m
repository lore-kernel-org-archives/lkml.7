Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976FEC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC7D20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfDLQpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:45:50 -0400
Received: from smtp3.goneo.de ([85.220.129.37]:35808 "EHLO smtp3.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbfDLQpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:45:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 8BF8323FFBC;
        Fri, 12 Apr 2019 18:45:45 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 38SmQFMpvigx; Fri, 12 Apr 2019 18:45:43 +0200 (CEST)
Received: from [192.168.1.127] (dyndsl-091-248-139-154.ewe-ip-backbone.de [91.248.139.154])
        by smtp3.goneo.de (Postfix) with ESMTPSA id 24A2D23F802;
        Fri, 12 Apr 2019 18:45:43 +0200 (CEST)
Subject: Re: [PATCH 0/8] Prepare files under Documentation/*.txt to build with
 Sphinx
To:     Jonathan Corbet <corbet@lwn.net>
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
References: <94c47f05-0412-b938-908d-1ef8a91243ed@darmarit.de>
 <cover.1554889999.git.mchehab+samsung@kernel.org>
 <18261.1555064496@warthog.procyon.org.uk>
 <27303.1555071586@warthog.procyon.org.uk>
 <df609cad-fa5b-ac15-314f-ac8759771d90@darmarit.de>
 <20190412093947.62913186@lwn.net>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <06b2aeb4-825a-28d6-fa7d-f1f5900e53d8@darmarit.de>
Date:   Fri, 12 Apr 2019 18:45:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412093947.62913186@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 12.04.19 um 17:39 schrieb Jonathan Corbet:
> On Fri, 12 Apr 2019 14:34:25 +0200
> Markus Heiser <markus.heiser@darmarit.de> wrote:
> 
>> Am 12.04.19 um 14:19 schrieb David Howells:
>>> Markus Heiser <markus.heiser@darmarit.de> wrote:
>>>    
>>>> Which is already named in our 'How to write kernel documentation' introduction
>>>>
>>>> - https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html#writing-documentation
>>>
>>> This should really be in Documentation/ directory.
>>>    
>>
>> I agree with you, it is a kind of information hiding.  If you know proper
>> places, please send a patch to Jon.
> 
> As Jani pointed out, it's in Documentation/doc-guide.
> 
> If you're saying it should be in the top level, I kind of disagree.
> Documentation/ is an exercise in hiding information by placing it in the
> middle of 200 other, unrelated files.  We've made some progress on that,
> and I would like to continue to do so.

For those who are new and are willing to document, it migth be a good idea
to have a simple Documentation/README.txt  with a link to doc-guide?

Just a few words, I find with my editor, this is what I find often helpful
when I'am new to a project.

-- Markus --
