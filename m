Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F7BC004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C47520675
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="bCXmNwBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfEHAKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 20:10:07 -0400
Received: from mx1.cock.li ([185.10.68.5]:58579 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726604AbfEHAKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 20:10:04 -0400
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 May 2019 20:10:03 EDT
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1557273851; bh=8G0TzcOzwSFxmUI0oP71wqUIU3dz/rah4Bu4Hn2AW4Q=;
        h=Date:From:To:Cc:Subject:From;
        b=bCXmNwBdPf/drfE7nppPOCJziilvIQJ8RYnE4Fnc6yOxcb7WmSzMRdY3TavehAigG
         ZyIYBvSLxELl30ck/QIc8sxQn7RlAqX92Xk4xzydlGKZYCvxM5EYd8qx93DS8Km7KQ
         1K4n12eV3QOON89chJDZN5fDVWwfkNeXWBG5IcS1ZMx+2uoVhutWT8K5a+5t13TOuc
         3r6Ozf941wmCEGM4ExhOu77ZjiW1TLRBp2aotTT0QsU7zaEI/dnVk8weFulhkjx6Kp
         /2jAqie5hhxKNn9//VoYXvRJQrThHKUMZTGP6CXAb7E60aIUClMcLfyBCA+Rt36Y5U
         wmjVZwEiDNXxw==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 08 May 2019 00:04:11 +0000
From:   informator@redchan.it
To:     andrew@rainway.io
Cc:     linux-kernel@vger.kernel.org
Subject: To: Andrew Sampson: Rights granted by the GPL _can_ be
 "retroactively" retracted. Yes I am a lawyer
Message-ID: <cfc2a12664356a6d14078b58fc1ddbf0@redchan.it>
X-Sender: informator@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Andrew Sampson;
The proclamations given in the thread: 
github.com/Codeusa/Borderless-Gaming/issues/312 are incorrect.

If the non-exclusive licensee did not pay the copyright holder 
consideration for receipt of the permissions given regarding the 
copyrighted work, the copyright holder can freely rescind those 
permissions _AT_ANY_TIME_ .

The reasons are as follows: For the licensee to "hold" the licensor to 
any promise regarding when and how rescission is to take place there 
must be a contract between the two. A contract requires valid 
bargained-for consideration. Otherwise any "promise" made is an Illusory 
Promise (unenforceable).

"Nothing" is not valid consideration.

Obeying a pre-existing duty is not valid consideration.

The licensee has a pre-existing duty to obey copyright law, without 
permission from the copyright holder he may not 
use/modify/make-derivative-works-of/distribute/distribute-derivative-works-of. 
That permission is what he is attempting to "contract" for. Saying one 
will follow those permissions is not valid consideration to "pay" for 
those permissions. Promising not to violate the copyright holder's 
rights -by promising to only use the copyrighted works as freely 
permitted by the copyright holder, is not valid consideration as that is 
a pre-existing duty.

Yes: Codeusa: you _C_A_N_ revoke GPL permissions from free-takers at 
your will. And you should do so if that is needed for your livelihood to 
succeed.

You should do so if it is simply your want.

Do not the pennyless leaches intimidate you from making your own 
decisions regarding your work of authorship. They gave you nothing, you 
asked for nothing, they have nothing. Remember: a non-exclusive license 
is not a transfer, it is permission. Permission that can be ended at any 
time unless there exists an attached interest (ie: the other side payed 
you for a license contract)
Also Remember: The FSF has _always_ (and still does) required Copyright 
Transfers before it would accept a contribution.

And yes: I am a lawyer.

Of course: consult your local copyright attorney. Strategy is important 
in these cases. The free-loaders feel they have the 9th circuit judges 
in the bag, and that the 9th circuit will invalidate the concept of 
consideration if needed to protect the California tech industry (so 
revoke from those outside the 9th circuit first).






For easy to read by lay-people discussions on this topic:
lkml.org/lkml/2019/5/4/334
lkml.org/lkml/2019/5/3/698

For legal articles and treatises that agree: no consideration from GPL 
free-taker, no contract, revocable by the copyright holder:
scholarship.law.duke.edu/faculty_scholarship/1857/
www.amazon.com/Open-Source-Licensing-Software-Intellectual/dp/0131487876
papers.ssrn.com/sol3/papers.cfm?abstract_id=243237



Note: I tried to inform you of this on your github account but was 
immediatly "hell banned" by github.


Sincerely;
Pro-Bono Attorney



