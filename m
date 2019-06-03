Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AA8C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57272567E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="eqgltZz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfFCPCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:02:34 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:19179 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbfFCPCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:02:33 -0400
Date:   Mon, 03 Jun 2019 15:02:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1559574149;
        bh=ARa+qk5Tsrw8fm3wuZvD9p33MEPavQgLuprwZPRBvGc=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:Feedback-ID:
         From;
        b=eqgltZz+TLEWSraf9cCQeTleJtLAmYECp5o3TbCi4J6Ya904L7szjCaSjrlN2uQCf
         0ImvwN+mPX6nr5S0Zojah1hJnUcEzFj46BC4OX07fL2TBlD6JXFyOmeJPyu/7jxR1V
         4ai1SrfuZ2EX46oaIkqwgl4O6m6KC2EZGvQEEg78=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Reply-To: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Subject: Re: Oasis Fair Streams O-S: The Philosophy Behind - To Those It May Concern
Message-ID: <QHWfq-0EeE8WNrF96nqrEG2iJ80Vg2v47yfm09SoY7VovFJT2MW2v4GWAC_OqYZ5nECg8rvwQgxbQujoiGhJQK6D1ZUWBkU6ISu8V5C2o1M=@protonmail.com>
In-Reply-To: <oWR_vTt6u5LsgUL_ty7WGBkXw2QezOIFVBBOfgCcOvcJg3D8FPeHcDOPZOdudpIZ8IulEsgPS8yzifjDuaIrVxXya7H32Vl4trwZxYLbYbA=@protonmail.com>
References: <oWR_vTt6u5LsgUL_ty7WGBkXw2QezOIFVBBOfgCcOvcJg3D8FPeHcDOPZOdudpIZ8IulEsgPS8yzifjDuaIrVxXya7H32Vl4trwZxYLbYbA=@protonmail.com>
Feedback-ID: jE8CP55NmWCGfbi9g5qzrOGkxuwuSXpchSI6fmYzjd5UEveHXeJrmiWc0_sgJdqIHM8YAKf9EEyPwffaRmhZ0A==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Came across this aswell: Krokodil Psychosis seems to be a proper name of St=
allmanic dances, LSD speeches, one-line religion, and all this a "god". htt=
ps://www.youtube.com/watch?v=3DAlpiNsyO7pg Enjoy!


Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Sunday 2. June 2019 kl. 15:57, Ywe C=C3=A6rlyn <ywecrn@protonmail.com> w=
rote:

> I think I=C2=B4ve said most things about what I am doing to LKML now.
>
> A correctly experienced will know much about his system and the design wi=
ll not go much from original idea.
> Which is what we see with Unix. I think this was the point of its origina=
l developers aswell, and a commentary on corporate mismanagement being "Pla=
n 9 from Outer Space".
>
> And Irix was an early desktop version, that influenced extremely popular =
computers like CBM, and one may want to go somewhere between, aiming for a =
replacement of the CBM LSD-god, that also was its demise, which we ofcourse=
 still see in difficult persons like Richard Stallman, who claimed the Avai=
lable Source of Unix, was his invention, and started his own project "GNU I=
s Not Unix", dancing lsd-god dances, and iterating one-line pseudo-religion=
. Psychosis ofcourse really is this, prolonged use of narcotics, such as Am=
anita, Opiates, or other hallucinatory drugs, and even worse claim it is a =
religious god! So not surprisingly "Psychosis". Also known as "The Difficul=
t Wino Problem". Psychiatry cannot reform such persons though, and it is va=
nity to think so. Rather the punishments of Islam, seems more appropriate, =
where false gods is the capital crime.
>
> And why the now little succesful Linux, compared to the original Unix der=
ivative BSD as now used in MacOS for quite a while. Why not just take BSD f=
urther, and the original Unix source, instead of being with the "Linux zeal=
ots", with discussed behavioural problems - the KNU (Krazy GNU User). I am =
sure any experienced person here easily could apply his patching on BSD asw=
ell, coming to more fruitition here, and Mac OS. And such solve any forthco=
ming debate, after the Stallmanic fog, when it lifts ofcourse his dances an=
d "GNU Is Not Unix" nonsense and claims of having something to do with Avai=
lable Source would seem problematic.
>
> With his claims of "hackership", and being a "programmer", questionable s=
ince he claimed this for a very long time but never managed to make a kerne=
l himself. The original hackers on Bell Labs, did ofcourse make the origina=
l Unix kernel also, and he is clearly not a "hacker" in this sense. And "hi=
s" compiler, have options like "wait for pop" on, even though "ricer" (unec=
essary optimization options) have been discussed with supposedly concluding=
 that such things are not necessary. With the "GNU" brainwashed putting 10m=
s timers into sched.c, for measuring CPU use, when at 10ms point, most in t=
he computer has already happened! And Linus suggests 1000hz timer, when I m=
yself find 90hz timer to be optimal, more like modest BSD settings. Hacker =
really referring the hacking sound of a typewriter, rather than any maniac =
GNU LSD version. To not speak of the horrible pointer variables in LADSPA. =
Did Linux even come much beyond Soundblaster mindset of the early 90s? Here=
 the BSD based Mac OS, has modern hardware and Logic Audio - a fully profes=
sional platform used by actual artists, rather than "noisebient artists" in=
 Linux crowds.
>
> And to be honest, on the windows side things are still the same, it has s=
imilar problems as it had since Windows 95, and never really got good did i=
t. It even still does not have proper priorities of threads! And the multim=
edia crowd always found it to be obscure. Here ofcourse also vanity in clai=
ming a different design than the original Unix, that already did design the=
 groundwork for modern OS's. A good thing is ofcourse Microsoft in these da=
ys, opening up to more of Unix.
>
> As indeed Mac did. Running in 4K, with Itunes and Mini formfactor. If eve=
ryone goes well with Mac, one might aswell just do the Mac thing, with Logi=
c Audio and all. Maybe they would make OS-X Oasis? We are there if it slows=
 down and becomes Windows like.
>
> Indie composition goes all the way back to C64 as a midi sequencer. The a=
cidhouse phenomena was big on computers, and pop-culture and CBM-culture se=
emed intertwined in the 90s, where a Trance musician might just be a resear=
cher otherwise. That is a long time with music and thinking. I myself have =
concluded with -10dB RMS masters, 96K processing (80bit for feedback paths)=
 and polyphase interpolation, and will promote that. And could even be in a=
 horizontal tracker app, for those wanting that, and polyphase interpolatio=
n does not guess points like a regular interpolator, but rather upsamples, =
and filters the aliases, adding no guesswork to the dataset, and a more pro=
bably reconstruction than guessing interpolators and its interpolation erro=
r, and is like an original variable DAC, that did not guess either, but was=
 popular in the 80s/90s probably for that reason, just with modern convenie=
nces such as alias filtering.
>
> There seems to be a lot of expertise out there. So why waste it on Linux?=
 In CBM days, expertise seemed more typical also, and LKML debates claim to=
 be this. Why not just take BSD further. With "cyberspace" indeed could nee=
d a graphical 4K/8K subpixel update itself in these days.
>
> The thorian LSD-god, should indeed be replaced with interculture and real=
ity, as is a perfect followup, rejecting its lack of finanical management, =
and rather extending the range of potential indeed, in a modern inforrmatio=
n technolopgy enligthenment, and a name of The G=C3=B4d, being As-Salam. (P=
eace).
>
> Including the streamingeconomy of the internet combining it with automati=
on, and combining it with law established Fair Labour principles, including=
 fair pay, and further work philosophy of right resources in the right plac=
e. That could go all the way to custom designed hardware. And a dream come =
true for independent resources having the skill to realize such things. And=
 I myself have suggested a CPU with more instructions, so more can be done =
pr. clock, and mini formfactor high ghz computers will probably be a home s=
tandard.
>
> Indeed a suitable metaphor for this is ofcourse technology having gone ce=
ntralized, that can now go de-centralized with networking, and estalish a m=
ore de-decentralized online economy. If you are more the city limits living=
 type person, or even more, with such a system, one now can be that, and be=
 part of a network economy sustaining this, and individual expertise and sk=
ill. Giving a positive synergy to the network overall.
>
> It all comes down to natural principles, and a whole religion of this is =
Islam, where I also use the z=C3=A9n concept of The G=C3=B4d, that works we=
ll in our culture.
>
> A perfected and peaceful intercultural conclusion indeed, free of false g=
ods.
>
> Oasis Fair Streams O-S. https://www.youtube.com/channel/UCR3gmLVjHS5A702w=
o4bol_Q
>
> Peace.
> Ywe C=C3=A6rlyn.


