Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BF8C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 05:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148AE206A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 05:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="ch8oPCB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfKFFR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 00:17:28 -0500
Received: from mx1.cock.li ([185.10.68.5]:58249 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbfKFFR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 00:17:27 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1573017443; bh=qzVKmAyukV0WEYbHunXThyByRJq44w/56UWNOlO9+rE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ch8oPCB0Jtd+1zTh1n9QP8Qh9ETPS5US7wQLB+7xPyuyugeEJDEZ3A2eqGEMbTqab
         9Gjl65oZB9C5yyqk9wO46/8Kj8qK1JeJgI02c2vrkqA/PPhs57KmgBd/8/fByUFhQK
         6HwA/4D6ZIAZAH1I9GdzSvovSxrmBY1HZS/gWjKc9lwMc/x1jI2KltOn94FkSJbCen
         Re+f7HnbQ0tbCVmHsTz+Rz5vJSOQ1KP7h7dZhEKOxrFTS1icxPnQDIkguVNk+daD98
         ax0MR1zkhJv7B8HayyYXYOCLK8gcJPulQ2xZUFmWodSbAdu/NdBkgMKYMMA3uFi+jx
         giK7lt09I0aQQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 06 Nov 2019 05:17:23 +0000
From:   gameonlinux@redchan.it
To:     licensing@fsf.org
Cc:     linux-kernel@vger.kernel.org, license-discuss@lists.opensource.org
Subject: Re: Why will no-one sue GrSecurity for their blatant GPL violation
 (of GCC and the linux kernel)?
In-Reply-To: <a80f18d3-392f-ec2e-2e46-1d4442328d9f@gnu.org>
References: <faef8790e9278ee48789719afb4d78b4@redchan.it>
 <a80f18d3-392f-ec2e-2e46-1d4442328d9f@gnu.org>
Message-ID: <b3b33c0f41bc43b73229250e159387d4@redchan.it>
X-Sender: gameonlinux@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am a lawyer. GrSecurity is violating section 6 of version 2 of the 
GPL, which is the license in question.

GrSecurity does not have an independent right to create nor distribute 
non-separable derivative works of the Work(s) in question. By default 
they have NO right to do so.

The copyright holders have unilaterally granted permission (it is not a 
contract: there is no consideration (payment) on the side of GrSecurity 
in-order to receive these permissions) to others, but not in an 
unlimited fastion.

The Copyright holders have chosen to decide that any derivative work can 
ONLY be distributed if NO additional restrictive terms are proffered 
between the licensee and furthur licensees.

Section 6 states this. If the licensee proffers additional restrictive 
terms his license is terminated [(note: the copyright holder, in this 
case, can also step in and terminate the license for any reason he 
wishes: the free-licensee does not have any contract-law 
breach-of-contract defenses to raise against the copyright owner since 
there is no contract: only a copyright license (permission) (not a 
copyright license contract (bargained for rights purchased from the 
copyright owner))].

Here GrSecurity (Open Source Security) has, indeed, produced an 
additional restrictive term governing the relationship between it and 
the further-licensees relating back to the Work(s) in question.

GrSecurity's restrictive covenant can also be shown to the court to have 
been a success additionally: no down-the-line licensee has defied it and 
released the source code.

Under the Original Copyright Owners writing, which is explained in 
detail in the license, the down-the-line licensees are to have Free 
choice in distributing any derivative work (obviously the derivative 
work has to be non-seperable, grsec is non-seperable, that is not in 
dispute). Here GrSecurity requires them to agree /not/ to ever exercise 
that which the Copyright holders explicitly permitted and forbade the 
excision of.

Yes, GrSecurity's writing is an additional restrictive term, yes they 
are violating the express terms of the license, yes they are committing 
copyright infringement, yes their license has terminated.

And yes IAAL.

The courts do NOT take your 
absolute-literal-we-can't-do-anything-about-it programmer's approach.

Anyway, I was not asking if you think it is a violation: I know it is a 
violation, and a blatant one at that: I'm asking why no-one will SUE 
them for it, so far.

You can read a good write-up here:
perens.com/2017/06/28/warning-grsecurity-potential-contributory-infringement-risk-for-customers/




On 2019-11-05 11:19, Paolo Bonzini wrote:
> On 31/10/19 20:23, gameonlinux@redchan.it wrote:
>> RMS:
>> Could you share your thoughts, if any, of why no one will sue 
>> GrSecurity
>> ("Open Source Security" (a Pennsylvania company)) for their blatant
>> violation of section 6 of version 2 of the GNU General Public License?
>> 
>> Both regarding their GCC plugins and their Linux-Kernel patch which is 
>> a
>> non-separable derivative work?
>> 
>> They distribute such under a no-redistribution agreement to paying
>> customers (the is the only distribution they do). If the customer
>> redistributes the derivative works they are punished.
> 
> IANAL, but see after my signature an email about a similar case.
> Unfortunately some pieces of that story are lost to bitrot and broken
> links, but the text quoted there is from a former GPL compliance 
> manager
> at the FSF.
> 
> tl;dr, the GPL does not forbid GrSecurity from rejecting money from
> people that have exercised their rights under the GPL.  And anyway, if
> anything it would be a breach of contract law (similar to some episodes
> involving gay marriage) and not copyright.
> 
> Should a future GPLv4 cover this case?  Is it even possible?  I have no
> idea and this is off topic anyway, so let's all cut this thread short.
> 
> Paolo
> 
>> Xref: main.gmane.org gmane.org.freifunk.wlanware:251
>> 
>> [...]
>> 
>> Subject: [WRT54G] FSF fully aproces the Sveasoft subscription model
>> Date: Freitag 18 Juni 2004 00:47
>> From: "sveasoft" <james.ewing-yJk5bNGmrfNWk0Htik3J/w@public.gmane.org>
>> To: WRT54G-hHKSG33TihhbjbujkaE4pw@public.gmane.org
>> 
>> The final word on the Sveasoft subscription model has been rendered
>> by the FSF. The FSF concludes that the Sveasoft model is fully
>> compliant with the GNU license stipulations.
>> 
>> Transcript:
>>>   Okay, so here is the Sveasoft business model, as I understand
>>>   it:
>>> 
>>>     1. Sveasoft produces GPL'ed code which runs on a GNU/Linux based
>>>    router.
>>> 
>>>     2. Sveasoft distributes pre-releases of their software on a
>>>    subscription basis and provides priority support to the 
>>> subscribers.
>>> 
>>>     3. The pre-releases are offered under the GPL and subscribers
>>>     are entitled to distribute them publicly if desired.
>>> 
>>>     4. If a subscriber *does* redistribute the pre-release code
>>>     publicly, before it becomes a production release, they are
>>>     considered to have "forked" the code and do not receive future
>>>     pre-releases under the subscription program.
>>> 
>>>     5. Once a pre-release works its way through the testing
>>>     program and becomes a production release, it is made available 
>>> under
>>>     the GPL for public download, both "free-as-in-speech" and 
>>> "free-as-in-
>>>     beer".
>>> 
>>>   James, please step in here if I've missed anything, or if I
>>>   haven't accurately characterized some piece of the above.
>>> 
>>>   I look forward to getting the FSF compliance lab's feedback on
>>>   Sveasoft's business model.  Thanks for your help!
>>> 
>>> Hi Rob,
>>> 
>>> I would just underscore that whenever we distribute binaries they
>>> are *always* accompanied by the source code.
>>> 
>>> Subscribers are free to do whatever they like with the
>>> pre-releases with the proviso that if they distribute it publicly
>>> we are not responsible for support and they need to develop the
>>> code further themselves from that point forward.
>> 
>> I see no problems with this model. If the software is licensed
>> under the GPL, and you distribute the source code with the binaries 
>> (as
>> opposed to making an offer for source code), you are under no 
>> obligation to
>> supply future releases to anyone.
>> 
>> Please be clear that the subscription is for the support and
>> distribution and not for a license.
>> 
>> Peter Brown
>> GPL Compliance Manager
>> Free Software Foundation
