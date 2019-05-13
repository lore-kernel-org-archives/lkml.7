Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F33CC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 04:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2587420B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 04:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="IoV5KJeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfEMEtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 00:49:06 -0400
Received: from mx1.cock.li ([185.10.68.5]:35457 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727506AbfEMEtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 00:49:05 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1557722939; bh=zmZBXhRlvHPqR2tpn+Czpv5UBLT56pH32P3+sPfdrUg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IoV5KJeBNFJxApQyVlZVf3cIkkeo7ydSu8xyewsTN3GCz+O5xIPwYtUMto7REko6L
         pR13CdDvfTjHJNODynTo4tjoH5/bD+ZdmgKAY7Up2jbrVRomJHvo8AmValFqw4gd3t
         rFoAFf5MxUbzPcmiUkb87Q1PwmwFbAZu8sYBv3Xrr2m7I/o7O5lff/2KQ9odbO8jtP
         aYHpndhNo/8uaNbyH2tU/PX85VsAFj14vimgvjcljqCbO6cQj7LGc0h9OnSCRR/e8+
         7ZoY02buVKNg3XhQNup09sdNK3iiVnViv/e6CIp1NP5IuWPLw0e7nOSfQEV9FxvD0K
         8QCxkCFIoPGhg==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 13 May 2019 04:48:58 +0000
From:   informator@redchan.it
To:     Randi Harper <randi@freebsdgirl.com>
Cc:     phk@phk.freebsd.dk, misc@openbsd.org, linux-kernel@vger.kernel.org,
        freebsd-chat@freebsd.org, freebsd-current@freebsd.org
Subject: Re: Regarding threats to "CoC" you. - You do have recourse - license
 rescission
In-Reply-To: <CAM9wqY8HhUujMkX8d3TLL5SHWxL-+XOMFaWPQoKnZjePQuTqmA@mail.gmail.com>
References: <68ed688fdca3c53b6a79d5da5bbe5412@redchan.it>
 <CAM9wqY8HhUujMkX8d3TLL5SHWxL-+XOMFaWPQoKnZjePQuTqmA@mail.gmail.com>
Message-ID: <bc79b6f34c41d558d0881fc99e28b2c5@redchan.it>
X-Sender: informator@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not seeking remuneration for the information, nor suggesting any 
specific attorney, nor will I profit from this is any way. Many of the 
programmers are completely unaware of their rights regarding their works 
of authorship and the FSF, SFLC and whomever else have been spreading 
misleading information. They deserve to know the truth so their works 
are not, effectively, converted, while they are cast aside.

As a BSD-grrl you probably have ample experience with such misleading 
statements from said outlets in the past, again and again and again and 
again.

As for whatever the webhost DNS string means: I don't keep up with 
social media.

On 2019-05-09 21:10, Randi Harper wrote:
> Hm.
> 
> You know, as a lawyer, it might be wise to not send people unsolicited
> legal advice. Most lawyers tend to shy away from that. But what do I
> know, I'm sure any email service that is associated with
> cryptocurrency and was named after an SVU episode where women
> developers were sexually assaulted by gamers is totally on the up and
> up. 100% legit. Thank you, sir, for this valuable service you have
> provided to the community. I applaud you and your bravery at ignoring
> common wisdom and legal convention. You have done us all a great
> service today.
> 
> -- randi
> 
> On Thu, May 9, 2019 at 8:25 AM <informator@redchan.it> wrote:
> 
>> Dear Poul-Henning "UNIX guru at large" Kamp;
>> Many have noticed threats made against you recently to seek your
>> ejectment from the FreeBSD project as retaliation for statements
>> you made protesting the ceaseless and ever on-going slaughter of
>> innocents; A transparent attempt to censor your political speech,
>> if there ever was one.
>> 
>> I am forwarding this message below to you because if such is
>> attempted, you do have recourse: and that is the rescind the
>> gratis license you have granted regarding the use of your works of
>> authorship. You may rescind these grantsfrom your attackers, those
>> who fail to defend your right to free speech, from the project
>> itself, or from all free-takers (if such is your wish).
>> 
>> Remeber: A non-exclusive license grant is not a transfer of
>> copyright, and such a license absent bargained-for consideration
>> is just that: a license (permission); it is not a contract and does
>> not
>> bind the /grantor/ to any terms. It can be revocated at
>> any time, for any or no reason.
>> 
>> This applies to all the "classic" free licenses, from the MIT
>> license, to the BSD license, to the GPL.
>> 
>> -------
>> The proclamations made by some as to the irrevocability of freely
>> given
>> non-exclusive licenses are incorrect.
>> 
>> If the non-exclusive licensee did not pay the copyright holder
>> consideration for receipt of the permissions given regarding the
>> copyrighted work, the copyright holder can freely rescind those
>> permissions _AT_ANY_TIME_ .
>> 
>> The reasons are as follows: For the licensee to "hold" the licensor
>> to
>> any promise regarding when and how rescission is to take place there
>> 
>> must be a contract between the two. A contract requires valid
>> bargained-for consideration. Otherwise any "promise" made is an
>> Illusory
>> Promise (unenforceable).
>> 
>> "Nothing" is not valid consideration.
>> 
>> Obeying a pre-existing duty is not valid consideration.
>> 
>> The licensee has a pre-existing duty to obey copyright law, without
>> permission from the copyright holder he may not
>> 
> use/modify/make-derivative-works-of/distribute/distribute-derivative-works-of.
>> 
>> That permission is what he is attempting to "contract" for. Saying
>> one
>> will follow those permissions is not valid consideration to "pay"
>> for
>> those permissions. Promising not to violate the copyright holder's
>> rights -by promising to only use the copyrighted works as freely
>> permitted by the copyright holder, is not valid consideration as
>> that is
>> a pre-existing duty.
>> 
>> Yes: you _C_A_N_ revoke GPL/BSD/MIT/etc permissions from free-takers
>> at
>> your will. And you should do so if that is needed for your
>> livelihood to
>> succeed.
>> 
>> You should do so if it is simply your want.
>> (And you should do so if you are attacked by those free-takers)
>> 
>> Do not the pennyless leaches intimidate you from making your own
>> decisions regarding your work of authorship. They gave you nothing,
>> you
>> asked for nothing, they have nothing. Remember: a non-exclusive
>> license
>> is not a transfer, it is permission. Permission that can be ended at
>> any
>> time unless there exists an attached interest (ie: the other side
>> payed
>> you for a license contract)
>> Also Remember: The FSF has _always_ (and still does) required
>> Copyright
>> Transfers before it would accept a contribution.
>> 
>> And yes: I am a lawyer.
>> 
>> Of course: consult your local copyright attorney. Strategy is
>> important
>> in these cases. The free-loaders feel they have the 9th circuit
>> judges
>> in the bag, and that the 9th circuit will invalidate the concept of
>> consideration if needed to protect the California tech industry (so
>> revoke from those outside the 9th circuit first).
>> 
>> For easy to read by lay-people discussions on this topic:
>> lkml.org/lkml/2019/5/4/334 [1]
>> lkml.org/lkml/2019/5/3/698 [2]
>> 
>> For legal articles and treatises that agree: no consideration from
>> GPL
>> free-taker, no contract, revocable by the copyright holder:
>> scholarship.law.duke.edu/faculty_scholarship/1857/ [3]
>> 
> www.amazon.com/Open-Source-Licensing-Software-Intellectual/dp/0131487876
>> [4]
>> papers.ssrn.com/sol3/papers.cfm?abstract_id=243237 [5]
>> 
>> Sincerely;
>> Pro-Bono Attorney
>> 
>> (Note: all discussion herein is in relevance to US law)
>> _______________________________________________
>> freebsd-chat@freebsd.org mailing list
>> https://lists.freebsd.org/mailman/listinfo/freebsd-chat
>> To unsubscribe, send any mail to
>> "freebsd-chat-unsubscribe@freebsd.org"
> 
> 
> Links:
> ------
> [1] http://lkml.org/lkml/2019/5/4/334
> [2] http://lkml.org/lkml/2019/5/3/698
> [3] http://scholarship.law.duke.edu/faculty_scholarship/1857/
> [4]
> http://www.amazon.com/Open-Source-Licensing-Software-Intellectual/dp/0131487876
> [5] http://papers.ssrn.com/sol3/papers.cfm?abstract_id=243237
