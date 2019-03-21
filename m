Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_SPAM,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3583BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A47B218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="ugI49wG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfCUXP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:15:58 -0400
Received: from cock.li ([185.100.85.212]:34124 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfCUXP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 19:15:58 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1553210152; bh=BwGBpGdDx2qbobT7UXiR7E2gAsdY/nAdqfz7Dfl3G54=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ugI49wG9yaNNi0fN52QB551SJom4AnEcqQEVphiPONIO2FjXSBFaGjHrM4NJayIzq
         ctJuDkm8DH46L4EmGrQECrMcFoEuHrhgVsfchyxPZeeu0omwydfWG/Eywo53q42sT2
         7AOeYuZOITQIugtYcvH++MfLbQGTBKiSY92UCRSDRZCcgX7n5g/MFz2SHyZkP9m1cD
         alPalcUHtrLyYIDhxrGjx7KpLTyIR8BSFvlznsrPdAK6CzN5GT/iYKvAi5fLfY99b4
         bO+rGdBJ9YVM9Jpk51c5mkYniSN6S/AKZa22AaUyAcEX+ACaU0uc46PQ2EAcnXHj17
         kLlGCO2RZV+Rg==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 21 Mar 2019 23:15:52 +0000
From:   mikeeusa@redchan.it
To:     Martin Schroeder <mkschreder.uk@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, freebsd-chat@freebsd.org,
        misc@openbsd.org, editor@lulz.com, news@theregister.co.uk,
        esr@thyrsus.com, torvalds@osdl.org, rms@gnu.org
Subject: Re: DMCA takedown notice
In-Reply-To: <CAGmj6qvwS9dvD1rP-7t5pttB-8vZuUF3BnL3RD5ceFmA4fCdYA@mail.gmail.com>
References: <5c51daed7c023_2fcf3fe7576d45c417207b@github-lowworker-89d05ac.cp1-iad.github.net.mail>
 <5c51ee838b18f_74e53fd6ff0d45c41780e2@github-lowworker-5909e27.cp1-iad.github.net.mail>
 <5c522f5b6cb8a_60733fc5256d45b412831@github-lowworker-39ccb07.cp1-iad.github.net.mail>
 <5c534f0336ca6_19ae3fcbf5cd45b4186161@github-lowworker-e55e3e3.cp1-iad.github.net.mail>
 <5c535110f0f30_3aa13fafe46d45c4222962@github-lowworker-dcc078e.cp1-iad.github.net.mail>
 <061a28afa26cf5ad7d11f8074353a9cf@redchan.it>
 <5c5489478eb20_56f33fd9e9ad45b43146ec@github-lowworker-4f62d42.cp1-iad.github.net.mail>
 <5c55ecdcb298_3a283fd6dfcd45c4309246@github-lowworker-63e61ec.cp1-iad.github.net.mail>
 <5c563190ae6cc_18c33fcb464d45bc1523b0@github-lowworker-39ccb07.cp1-iad.github.net.mail>
 <5c586b095281b_4c6d3ffba28d45b8120450@github-lowworker-e51511d.cp1-iad.github.net.mail>
 <5c58a56f8ded7_36e93f9cb4ad45b8932e7@github-lowworker-e55e3e3.cp1-iad.github.net.mail>
 <312c3d91f6c4a71c34b96728a2efb385@redchan.it>
 <5c5b1609a1561_1ac23fbe2d6d45b88762d0@github-lowworker-dcc078e.cp1-iad.github.net.mail>
 <discussions/31b6c69e24b211e98081e6b282f84ff2/comments/5812163@github.com>
 <2ba97dc3492f9c2eac75f118782c04f3@redchan.it>
 <CAGmj6qvwS9dvD1rP-7t5pttB-8vZuUF3BnL3RD5ceFmA4fCdYA@mail.gmail.com>
Message-ID: <35ff7172d2c1df973d8172bbc7c46533@redchan.it>
X-Sender: mikeeusa@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Should your effort succeed then it is a problem with the law and not 
> with the license.

"The law is wrong because it doesn't commit a taking regarding things 
that were not transfered" is what this marxist is saying.


> A license that grants certain rights to a copy of a work provided that 
> certain conditions outlined in the license are met should never be 
> revocable from THAT particular copy of the work,
unless the terms of the license itself are broken.

That is so: if you paid for those terms. If you paid nothing you get 
nothing. The linux kernel contributors did not GIVE anything away, they 
allowed USE of a thing THEY own. If they wanted to GIVE their property 
away they could have done so by _TRANSFERING_ it to a non profit such as 
the FSF, or declaring it the domain of the public. They chose to do 
neither.

> Having the possibility to arbitrarily revoke rights granted by a 
> license for any other reason than conditions that the licensee was 
> aware of when they accepted the license

There was no acceptance required. YOU are not allowed to use the owners 
property WITHOUT his permission, YOU do not have the right to "accept or 
reject" his dictats regarding his PROPERTY. You must OBEY the owner's 
demands regarding HIS property. There is no contract, terms, negotiation 
here.

YOU give nothing, YOU get nothing.


> would have tremendous negative consequences and
disruptions to many areas of the society.

Society is "women and their (female) children". Why should men care for 
their enemies and slave masters?

How is YOU not getting something for free harming "society"? It's how 
society functions. You must pay Society (Women) your whole life for a 
little taste, and then they send you to prison or the poorhouse once 
they're done with you.

> If the law has a loophole
This is not a loop hole. It is a basic function of US contracting and 
licensing law. Just because you don't like that a gratis non-exclusive 
license that you have benefited under while also trying to use to 
convert the Author's property whilst kicking him to the curb, is 
revocable by that Author, doesn't mean there is some "loophole" here. It 
works as designed: the Copyright owner is a property owner and can 
decide how his property is to be used. If you want a 
non-revocable-outside-the-terms license you must contract for one and 
pay the author good consideration.

> like that then the best thing that we all can do is ensure that it 
> doesn't have it anymore in the near future.
Who the FUCK is "WE"
WHO is "WE"

"WE" isn't me. And I damn sure am a Open Source progammer, music 
producer, media creator, 3d modeler, game designer, etc.

And I am NOT "WE".

Maybe "WE" is faggot hangers-on like yourself? Who just take from the 
"males" and then try to dispossess them of even their dignity while 
converting their works?


On 2019-03-06 04:48, Martin Schroeder wrote:
> The fact that you even spend this much time on trying to take back
> your gift to the community instead of just accepting your
> responsibility for your own actions is impressive. And unless you sign
> with your legal name and your copyright notices uses your legal name
> as well as details of your location then your claims have no effect at
> all because it is literally impossible to even speculate that you are
> the copyright holder - let alone proving it beyond any reasonable
> doubt that it is the case. So if you are serious about this and not
> just simulating a possible angle of attack on the GPL that somebody
> else could take to illustrate a possible weakness in the GPL, then
> stop hiding behind anonymity and file an actual real claim with a
> court.
> 
> Should your effort succeed then it is a problem with the law and not
> with the license. A license that grants certain rights to a copy of a
> work provided that certain conditions outlined in the license are met
> should never be revocable from THAT particular copy of the work,
> unless the terms of the license itself are broken. Having the
> possibility to arbitrarily revoke rights granted by a license for any
> other reason than conditions that the licensee was aware of when they
> accepted the license would have tremendous negative consequences and
> disruptions to many areas of the society. If the law has a loophole
> like that then the best thing that we all can do is ensure that it
> doesn't have it anymore in the near future.
> 
> On Tue, Feb 12, 2019 at 12:10 AM <mikeeusa@redchan.it> wrote:
>> 
>> You take it down or I sue you, simple as that.
>> 
>> I have revoked the license from a number of people, including the John
>> Doe who has chosen to violate my copyright thence-forth.
>> 
>> I have signed using my 2 decades long held pen-name.
>> 
>> The U.S. Code defines an electronic signature for the purpose of US 
>> law
>> as "an electronic sound, symbol, or process, attached to or logically
>> associated with a contract or other record and executed or adopted by 
>> a
>> person with the intent to sign the record."
>> 
>> My signing with my pen-name suffices for this purpose. What is 
>> important
>> is my intent to sign the record, which I have evinced.
>> 
>> I have also posted the information on my long-held project page, so 
>> that
>> you may know that I am me:
>> https://sourceforge.net/projects/gpcslots2/files/notes/
>> 
>> https://sourceforge.net/projects/gpcslots2/files/notes/tkdnreq_github.txt/download
>> https://sourceforge.net/projects/gpcslots2/files/notes/takedownreq_vs_johndoe-of-8ch.txt/download
>> 
>> (I have also uploaded this response to said /notes/ directory)
>> 
>> In addition to many other places.
>> Your contention that I must do anything greater at this point is 
>> legally
>> inefficacious.
>> 
>> I _DEMAND_ that you take the offending material down immediately.
>> 
>> --MikeeUSA--
>> (Author of GPC-Slots 2)
>> (electronic signature)
>> 
>> On 2019-02-06 21:20, GitHub Staff wrote:
>> > Hi MikeeUSA,
>> >
>> > Thank you for your notices, the most recent of which is included below
>> > for reference.
>> >
>> > This DMCA notice is incomplete. It lacks "A physical or electronic
>> > signature of a person authorized to act on behalf of the owner of an
>> > exclusive right that is allegedly infringed" and "Information
>> > reasonably sufficient to permit the service provider to contact the
>> > complaining party."
>> >
>> > Unfortunately, an electronic signature must be a legal name, not a
>> > monicker or username, and we cannot accept disposable or temporary
>> > email addresses as reliable contact information for a DMCA notice.
>> >
>> > Once you've revised your notice to include the required details,
>> > please send back the entire revised notice, and not only the corrected
>> > sections. Once we've received a complete and actionable notice, we'll
>> > process it expeditiously.
>> >
>> > Thanks,
>> >
>> > GitHub Staff
>> > -------------------------
>> >
>> > I have a good faith belief that use of the copyrighted materials
>> > described above on the infringing web pages is not authorized by the
>> > copyright owner, or its agent, or the law. I have taken fair use into
>> > consideration.
>> >
>> > I swear, under penalty of perjury, that the information in this
>> > notification is accurate and that I am the copyright owner, or am
>> > authorized to act on behalf of the owner, of an exclusive right that
>> > is allegedly infringed.
>> > :
>> >
>> > As you may know, In the United States; a license, absent an attached
>> > interest, is revocable.
>> >
>> > A "John Doe" had his non-exclusive license regarding the game
>> > "GPC-Slots2" terminated by the copyright owner (me: MikeeUSA).
>> > The copyright owner may do this as-of-right, unless there is an
>> > attached interest (ie: unless the licensee paid good consideration for
>> > the license).
>> >
>> > The "John Doe" then proceeded to belligerently upload a copy of
>> > "GPC-Slots2" to your host, GitHub.
>> > This violated Author's (my) copyright, since "John Doe"'s gratuitous
>> > bare license had been terminated by the copyright holder (me).
>> >
>> > The "John Doe" then proceeded to modify my work, which again violated
>> > my copyright since I had previously revoked his license.
>> > The license flows from me, the copyright owner, not any text. It is
>> > permission to use, redistribute, modify, etc. Instructions on how to
>> > use my property.
>> > When such permission is not supported by any consideration, it may be
>> > rescinded by the owner, at his will.
>> > (/Regardless/ of the "terms". "Terms" are only enforceable against the
>> > grantor if the licensee has paid consideration for them, essentially,
>> > under US law.)
>> >
>> > I have done so.
>> >
>> > I reiterated to the "John Doe" that his license had been terminated.
>> >
>> > "John Doe" then informed me that I "can't do that". I tried to explain
>> > to him US law.
>> > "John Doe" declared that he did not care and would keep the violating
>> > work up, in defiance of me.
>> > (IE: he would "pirate" it)
>> >
>> > He then cited works from a discredited paralegal while I cited
>> > published works by lawyers studied in their field.
>> >
>> > (Note: I make no claim to PERL, the color ansi library, any supporting
>> > libraries, or the -2 split screen function. My copyright covers the
>> > game code of GPC-Slots2. I (MikeeUSA) am the original author of the
>> > work and never signed over copyright to the work.)
>> > (Note: "obeying the terms" (obeying the copyright holders instructions
>> > regarding the use of his property) is not consideration: it is a
>> > preexisting legal duty: outside of the "terms" there is no right for
>> > the licensee to copy, modify, make derivative works, distribute,
>> > distribute derivative works)
>> >
>> > [Additionally "John Doe" registered a fraudulent account under my
>> > long-held non-de-gurre, adding a Code of Conduct ("CoC"), something I
>> > would never do (being opposed to "CoC" for gratis projects on
>> > principal)]
>> >
>> > I now have no choice but to issue a DMCA take-down request, to you,
>> > GitHub.
>> >
>> > Regrettably;
>> > --MikeeUSA--
>> > (electronic signature)
>> > Jan 29, 2019
>> >
>> > (Addendum: "John Doe" then uploaded the modified work to gitlab.com
>> > and bitbucket.org
>> >
>> > Contact information:
>> > email: mikeeusa@redchan.it
>> >
>> > infringing content: github.com/MikeeUSA/GPC-Slots-2
>> > gitlab.com/MikeeUSA/GPC-Slots-2
>> > bitbucket.org/MikeeUSA/gpc-slots-2
>> > The material is not authorized by me, the copyright owner of the
>> > GPC-Slots2 game code, as I explicitly rescinded the license from the
>> > "John Doe", and he acknowledged that I had informed him of such and
>> > communicated that he would defy my will regarding my property and
>> > copyright.
>> > Everything stated within this above communication is accurate to the
>> > best of my knowledge and ability.
>> >
>> > Some notices to you, github (and now gitlab and bitbucket):
>> > 1) Yes I viewed your page at:
>> > https://help.github.com/articles/guide-to-submitting-a-dmca-takedown-notice/
>> > 2) Yes this is "opensource" code.
>> > 3) No that does not matter:
>> > The GPL(any version), being a bare license, is revocable
>> > ("retroactively").
>> > Just as any bare license, not supported by an interest, in the US.
>> > The "John Doe" is not in privity of contract with me and has paid me
>> > no consideration.
>> > He cannot "bind" me (the grantor) to the terms.
>> > It is his duty to abide by my instructions regarding my property.
>> > I did not transfer my property away, the license is just that: a
>> > license (temporary permission, that can be rescinded unless a "term"
>> > was indeed "purchased")
>> > It is also his duty to cease all use, modification, distribution of my
>> > property at my demand.
>> > I have made such a demand.
>> > 4) Yes I will consider taking legal action against you if you do not
>> > heed my request.
>> > Cite the paralegal from groklaw, ZDnet, the FSF, and the SFConservancy
>> > all you want.
>> > They are wrong on the law and have been wrong for 10 years.
