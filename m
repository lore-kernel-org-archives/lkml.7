Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABFCC282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 13:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12C227939
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 13:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="qnrDvZMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfFBN6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 09:58:02 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:33532 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfFBN6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 09:58:02 -0400
Date:   Sun, 02 Jun 2019 13:57:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1559483878;
        bh=m72aSJBBiPYonc6B3mWl4ntMsNBGaaFMRUwXzIrx/GA=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=qnrDvZMhrY/44v4b9ttzUAe3KrVsCF1YkrmSHeUrCBtc4yfm5oPTnWxEg7oGUTNmB
         Zdn4ALPnVnPX13mg/zRWC5ahWs12th8DL2jSa8wMm/v6mQLfPUNQNnMcrLiS8Z3Lw2
         O60XDs8tf6Dx1eLBmd6cpdawb9Z8bP4Ouaz7ebRA=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Reply-To: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Subject: Oasis Fair Streams O-S: The Philosophy Behind - To Those It May Concern
Message-ID: <oWR_vTt6u5LsgUL_ty7WGBkXw2QezOIFVBBOfgCcOvcJg3D8FPeHcDOPZOdudpIZ8IulEsgPS8yzifjDuaIrVxXya7H32Vl4trwZxYLbYbA=@protonmail.com>
Feedback-ID: jE8CP55NmWCGfbi9g5qzrOGkxuwuSXpchSI6fmYzjd5UEveHXeJrmiWc0_sgJdqIHM8YAKf9EEyPwffaRmhZ0A==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think I=C2=B4ve said most things about what I am doing to LKML now.

A correctly experienced will know much about his system and the design will=
 not go much from original idea.
Which is what we see with Unix. I think this was the point of its original =
developers aswell, and a commentary on corporate mismanagement being "Plan =
9 from Outer Space".

And Irix was an early desktop version, that influenced extremely popular co=
mputers like CBM, and one may want to go somewhere between, aiming for a re=
placement of the CBM LSD-god, that also was its demise, which we ofcourse s=
till see in difficult persons like Richard Stallman, who claimed the Availa=
ble Source of Unix, was his invention, and started his own project "GNU Is =
Not Unix", dancing lsd-god dances, and iterating one-line pseudo-religion. =
Psychosis ofcourse really is this, prolonged use of narcotics, such as Aman=
ita, Opiates, or other hallucinatory drugs, and even worse claim it is a re=
ligious god! So not surprisingly "Psychosis". Also known as "The Difficult =
Wino Problem". Psychiatry cannot reform such persons though, and it is vani=
ty to think so. Rather the punishments of Islam, seems more appropriate, wh=
ere false gods is the capital crime.

And why the now little succesful Linux, compared to the original Unix deriv=
ative BSD as now used in MacOS for quite a while. Why not just take BSD fur=
ther, and the original Unix source,  instead of being with the "Linux zealo=
ts", with discussed behavioural problems - the KNU (Krazy GNU User). I am s=
ure any experienced person here easily could apply his patching on BSD aswe=
ll, coming to more fruitition here, and Mac OS. And such solve any forthcom=
ing debate, after the Stallmanic fog, when it lifts ofcourse his dances and=
 "GNU Is Not Unix" nonsense and claims of having something to do with Avail=
able Source would seem problematic.

With his claims of "hackership", and being a "programmer", questionable sin=
ce he claimed this for a very long time but never managed to make a kernel =
himself. The original hackers on Bell Labs, did ofcourse make the original =
Unix kernel also, and he is clearly not a "hacker" in this sense. And "his"=
 compiler, have options like "wait for pop" on, even though "ricer" (uneces=
sary optimization options) have been discussed with supposedly concluding t=
hat such things are not necessary. With the "GNU" brainwashed putting 10ms =
timers into sched.c, for measuring CPU use, when at 10ms point, most in the=
 computer has already happened! And Linus suggests 1000hz  timer, when I my=
self find 90hz timer to be optimal, more like modest BSD settings. Hacker r=
eally referring the hacking sound of a typewriter, rather than any maniac G=
NU LSD version. To not speak of the horrible pointer variables in LADSPA. D=
id Linux even come much beyond Soundblaster mindset of the early 90s? Here =
the BSD based Mac OS, has modern hardware and Logic Audio - a fully profess=
ional platform used by actual artists, rather than "noisebient artists" in =
Linux crowds.

And to be honest, on the windows side things are still the same, it has sim=
ilar problems as it had since Windows 95, and never really got good did it.=
 It even still does not have proper priorities of threads! And the multimed=
ia crowd always found it to be obscure. Here ofcourse also vanity in claimi=
ng a different design than the original Unix, that already did design the g=
roundwork for modern OS's. A good thing is ofcourse Microsoft in these days=
, opening up to more of Unix.

As indeed Mac did. Running in 4K, with Itunes and Mini formfactor. If every=
one goes well with Mac, one might aswell just do the Mac thing, with Logic =
Audio and all. Maybe they would make OS-X Oasis? We are there if it slows d=
own and becomes Windows like.

Indie composition goes all the way back to C64 as a midi sequencer. The aci=
dhouse phenomena was big on computers, and pop-culture and CBM-culture seem=
ed intertwined in the 90s, where a Trance musician might just be a research=
er otherwise. That is a long time with music and thinking. I myself have co=
ncluded  with -10dB RMS masters, 96K processing (80bit for feedback paths) =
and polyphase interpolation, and will promote that. And could even be in a =
horizontal tracker app, for those wanting that, and polyphase interpolation=
 does not guess points like a regular interpolator, but rather upsamples, a=
nd filters the aliases, adding no guesswork to the dataset, and a more prob=
ably reconstruction than guessing interpolators and its interpolation error=
, and is like an original variable DAC, that did not guess either, but was =
popular in the 80s/90s probably for that reason, just with modern convenien=
ces such as alias filtering.

There seems to be a lot of expertise out there. So why waste it on Linux? I=
n CBM days, expertise seemed more typical also, and LKML debates claim to b=
e this. Why not just take BSD further. With "cyberspace" indeed could need =
a graphical 4K/8K subpixel update itself in these days.

The thorian LSD-god, should indeed be replaced with interculture and realit=
y, as is a perfect followup, rejecting its lack of finanical management, an=
d rather extending the range of potential indeed, in a modern inforrmation =
technolopgy enligthenment, and a name of The G=C3=B4d, being As-Salam. (Pea=
ce).

Including the streamingeconomy of the internet combining it with automation=
, and combining it with law established Fair Labour principles, including f=
air pay, and further work philosophy of right resources in the right place.=
 That could go all the way to custom designed hardware. And a dream come tr=
ue for independent resources having the skill to realize such things. And I=
 myself have suggested a CPU with more instructions, so more can be done pr=
. clock, and mini formfactor high ghz computers will probably be a home sta=
ndard.

Indeed a suitable metaphor for this is ofcourse technology having gone cent=
ralized, that can now go de-centralized with networking, and estalish a mor=
e de-decentralized online economy. If you are more the city limits living t=
ype person, or even more, with such a system, one now can be that, and be p=
art of a network economy sustaining this, and individual expertise and skil=
l. Giving a positive synergy to the network overall.

It all comes down to natural principles, and a whole religion of this is Is=
lam, where I also use the z=C3=A9n concept of The G=C3=B4d, that works well=
 in our culture.

A perfected and peaceful intercultural conclusion indeed, free of false god=
s.

Oasis Fair Streams O-S. https://www.youtube.com/channel/UCR3gmLVjHS5A702wo4=
bol_Q


Peace.
Ywe C=C3=A6rlyn.

