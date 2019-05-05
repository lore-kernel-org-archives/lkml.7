Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826ABC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 05:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B008920675
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 05:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="ZkM7nTTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfEEFAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 01:00:07 -0400
Received: from mx1.cock.li ([185.10.68.5]:60651 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725814AbfEEFAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 01:00:07 -0400
X-Greylist: delayed 527 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 May 2019 01:00:05 EDT
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1557031875; bh=I2FCNmKK327bFSGvkmTu/8fw2JSN3TtQWsMD6AuP8w0=;
        h=Date:From:To:Cc:Subject:From;
        b=ZkM7nTTLiE2shejN5xCCMnCuCC3XaQ5JGBDl9ju9ynAnsCYHLtc+eV2ORRJ11ksXm
         9IQ/hJfxrpZzjx3X5cXqJqXx1DaCuxeEpQHRcemqV/FipOX+YFP88QM8rLv1fGvhfj
         rRgJhDIwkUV9m2fRjpP5juUm/DHl87njhsUaInIEOf4eB5ovWlEL8rXq5hXXS7uc+X
         ZZl7HDPFgi930bAo5+9q+EUBR1SOuWjazFUJjj7SWR+u60/aYtc9xFkunlagwPorqc
         L95oW27MZjVCsEniJ7cKlT0nEN5hSyFlfIWYZ4X9rDtDpP6lYlTh4i/gbG7lGxd1iZ
         hplrntcj/ztpQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 05 May 2019 04:51:15 +0000
From:   vsnsdualce2@redchan.it
To:     rhkramer@gmail.com
Cc:     debian-user@lists.debian.org, linux-kernel@vger.kernel.org,
        Ivan Ivanov <qmastery16@gmail.com>, mailinglists@mattcrews.com,
        jhasler@newsguy.com, scdbackup@gmx.net, richard@walnut.gen.nz,
        curty@free.fr, jmtd@debian.org, mick.crane@gmail.com,
        tomas@tuxteam.de, steve@einval.com, joe@jretrading.com,
        rms@gnu.org, esr@thyrsus.com
Subject: Re: Can a recipients rights under GNU GPL be revoked? - Bradley M.
 Kuhn is not an attorney (he should go get his JD and get licensed).
Message-ID: <60c1b08305c5326e3503f51d81622541@redchan.it>
X-Sender: vsnsdualce2@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> of the GPL.  (And Bradley Kuhn is a lawyer -- my older mind can't 
> remember if
> he was the lawyer who argued (and lost) a previous free software case 
> (don't
> remember the details) in front of the US Supreme Court.  (Sometimes 
> referred

rhkramer@gmail.com:
Bradley M. Kuhn is not an attorney, which is why he had to step down as 
head
of his organization and hire a lawyer to head the organization
in his place: Bar rules do not allow lawyers to serve under a non-lawyer 
in
an organization, and the organization was essentially a pro-bono law 
firm
(which really needed a attorney in it's ranks...)

https://en.wikipedia.org/wiki/Bradley_M._Kuhn

Yes the "oh I just stepped down because we need a woman to head this 
organization
now" claim he makes is, in fact, disingenuous. What they needed is a 
lawyer in
the organization: and the lawyer could not be directed by non-lawyers.

http://ebb.org/bkuhn/
> Kuhn holds a summa cum laude B.S. in Computer Science from Loyola 
> University in Maryland, and an M.S. in Computer Science from the 
> University of Cincinnati.

http://ebb.org/bkuhn/resume/
No J.D., No law license.


I have both.

I don't want to drag someone down, but I had to correct your mistake.
Once he applies to law school, gets his degree, and later his license 
I'm sure he will correct his as well.


On 2019-01-28 00:35, rhkramer@gmail.com wrote:
> On Sunday, January 27, 2019 07:24:17 PM rhkramer@gmail.com wrote:
>> Resending to the list -- I didn't notice that Ivan had sent this to me
>> only, and my reply, of course, then went to him only.
>> 
>> On Sunday, January 27, 2019 10:06:46 AM Ivan Ivanov wrote:
>> > Yes: The linux devs can rescind their license grant. GPLv2 is a bare
>> > license and is revocable by the grantor. Search for "vsnsdualce" "gpl"
>> > online to find his messages which prove that, he is a lawyer and has
>> > investigated this subject very well. I am CC'ing him in case you'd
>> > like to request more information. So if you didn't like the Code of
>> > Conduct covertly accepted behind the scenes against your will, and
>> > maybe some other questionable political decisions in technical
>> > projects
> 
> ...
> 
>> I *might* go read some of the stuff by vsnsdualce, but the Weboob 
>> situation
>> is not an example of a (free or GPL) license being rescinded.  (You 
>> didn't
>> quite say it was, but one could infer that is what you are trying to 
>> say
>> by its inclusion in the same paragraph.)
> 
> Ok, I went and read a few things by "vsnsdualce" re the GPL, in 
> particular:
> 
> http://readlist.com/lists/gentoo.org/gentoo-user/42/213256.html
> 
> And from that, I went to:
> 
> https://copyleft.org/guide/comprehensive-gpl-guidech8.html#x11-540007.4
> 
> It seems clear that this is one of those things that I talked about in 
> my
> previous last paragraph (the aside, still quoted below) -- vsnsdualce 
> is
> stating his opinion / taking a position that is in opposition to the 
> postions
> / opinions of other lawyers.
> 
> I don't know how far he is willing to go to try to confirm his 
> position, but
> until a court case or something similar (and probably appeals) decides 
> the
> issue, there are two opinions.
> 
> If I had to guess / be which would prevail, I would bet on the side of
> copyleft.org who, in a way are the successors (mcow) to the original 
> author(s)
> of the GPL.  (And Bradley Kuhn is a lawyer -- my older mind can't 
> remember if
> he was the lawyer who argued (and lost) a previous free software case 
> (don't
> remember the details) in front of the US Supreme Court.  (Sometimes 
> referred
> to as "the supremes", but they don't really sing that well (well, to be 
> fair,
> I guess I never heard them sing ;-)
> 
> Even if he was the guy that lost that case (I'm fairly sure it was 
> someone
> else), he is certainly a very experienced lawyer, and very familiar 
> with the
> issues around this license.  I would trust his opinion more that I 
> would
> "vsnsdualce"'s.
> 
> ...
> 
>> 
>> Just another aside: One of my takes on lawyers is that they interpret 
>> laws
>> and take legal positions for various reasons, often to further their 
>> own
>> or their client's interests, and then are willing to fight the legal
>> battle that may ensue.  A lawyer expressing an opinion does not make 
>> that
>> opinion correct / legal.
