Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7DDC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE36F217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="XWdYUIXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfKFRwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:52:55 -0500
Received: from mx1.cock.li ([185.10.68.5]:50641 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726963AbfKFRwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:52:55 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1573062770; bh=RPCmKA5OgUsS1NQUfaFKcUOpVglGaqnRtkrogQ11dnM=;
        h=Date:From:To:Subject:From;
        b=XWdYUIXozBoIU/BKC6Y/dhsUsfO1wHZkeoIFV+Dw2bUayEOTi+dR1l+DforwpcYVF
         Sh8hJTunpf6M0mJqWKwRldm7Lvmu2EHVeGnk9uoVq18UR0ABgjgb1bls35BZv8D5PP
         5AXgjdaJ4myDkOySfwTNn6axL1R18Qzy2Goo3WpZPBaDr8JkDiEM2xIPy308WikDPa
         +in3QaHokAmZ0IS45C0h2oBwrOG8C7Nu+aM1aOZBg7Ik9ZIhuDJy9aY0dld7s5zGCk
         wzvondWpH/O0vpa8jN4dr21iFfa9AO1KgD5RJrff8/xkmqWkwhVdcd2cnGSI+7Fol0
         hpNaNCx34W+9w==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 06 Nov 2019 17:52:50 +0000
From:   gameonlinux@redchan.it
To:     gnu-system-discuss@gnu.org
Subject: Coreboot vs Libreboot - GNU: Please use Coreboot without the blobs
 (compile time option).
Message-ID: <b1b6ab4e31856450d82afccaba587b0f@redchan.it>
X-Sender: gameonlinux@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Posting here because the technical reason Libreboot is now a bad option 
is because it doesn't work with newer systems, and the Libreboot 
"maintainer" has seemingly no will to update the project, and no 
technical ability to work
around the problems]

Coreboot is the actual project, it can be compiled without binary
blobs, and has an command line option to do so.
Libre boot is Coreboot without the binary blobs.

Libre boot has not been updated in 3 years. The "maintainer" does
nothing. Usually this would be fine for a program: at some point often
a program is completed and needs fewer code updates (then one should
focus on media updates and additions that use its capabilities), but
this particular program must be updated to work with new hardware
(new, ever more compromised hardware...)

The "maintainer" (again: here we have someone who is not a
main-programmer of the Work, being effectivly credited with the Work,
when the work on the Work consists simply of removing parts of the
Work, or just setting different complile options) in the past attacked
the FSF and RMS for some emotional issue he was having.

The "maintainer" recently had his genitals sawn off.
He posted pictures of it being done on his personal web page.
Americans (white) men and American (white) women cheer.

This is completely "Fine" and "good" according to Americans, this
"maintainer" has not been cancled, even though he is setting a True
harmful example (not doing any work, essentially plagirising, and
cutting off his manhood, encouraging others to follow his example in
all three cases).

However RMS making comments, that put him in the same camp as the
Authors of some of the books of the Torah, of some of the hadiths of
Islam, of some of the laws of the old Vedic religions, etc, comments
that, if followed, would be benificial to men as men; he is viciously
attacked for that. RMS is an actual programmer, not merely a
"maintainer" who /removes/ things: he built things from the ground up.

America hates men and wishes men to be removed and nullified: which is
why the actions of the Libreboot "maintainer" are lauded by proud
white american men:

1) The Libreboot "maintainer" does nothing
America wants men to be inert and docile, except when working to
support his owner (Ownership is Dominion and Control: women have that
over the "males" in the USA, and every Dominion of the USA)

2) The libreboot "maintainer" has castrated himself physically
America wants men to do this: cut off their genitals.
American women love this: the 80 percent of "males" they do not like
are removed from bothering them: existing only to work and maintain
the women's society.

3) The libreboot "maintainer" has castrated Coreboot
The same mental idea is used here. This may have cause the Libreboot
maintainer to entertain the idea in realitly aswell. Like follows
like. The brain makes objective connections between subjective matters.

All of you likely "respect" the Libre-Boot maintainer, revile the
Coreboot programers, and deeply-disagree with RMS's past comments on
paedophillia (men used to commonly marry girl children in the past:
this only stopped when _white_ America (a country run for the benifit
of white women) decided to effectivly outlaw it world wide by
murdering or tourturing any society that practiced this good-for-men
practice, _white_ (woman-run) America has also popularized men cutting
off their genitals the world over recently: white women like this to
be done to most men; the ones they do not favor and who are "useless"
to them), infact some of you are trying to oust him now.

You have also infected his mind and forced him to reverse his previous
3 statements, statements that the men support (not american men, but
american white men are not human beings: they exibit no agency of
their own so can be thought of as human shaped automatons instead)
since they are benificial to men (they are /harmful/ to white WOMEN:
yes: and what WOMEN want is harmful to men (a castrated economic
slave for money, plus some studs in addition)

I propose that Coreboot simply be used without the blobs, and
libreboot be thrown in the trash where the "maintainers" genitals have
been placed. (He has effectivly thrown it in the trash by not doing
anything with it and only using it as a way to gain attention for
himself: "Look what I do" "I'm a programmer" "Important" "Follow my
lead")

"Maintainers" should not steal the glory from the actual originators of
the Work. We see it happen here where "Maintainers" try to oust the
Authors. They should know their place, or not have one at all (their
position and role is more of one of plagirism than anything else)

It was better when the actual programmers ran things. We had none of
this whining that the white women do (they were ejected immediatly
since they didn't contribute anything and just tried to control the
men socially), and we built code, not tear it down and stick a new
name on it and then attack the hand that feeds.

Libre-boot brings shame to Free Software. Men do not want to have
anything to do with a man who cuts his genetals off, and does no
constructive work either. Libre-boot is very American.

RMS brought honour to Free Software. Men agree that marrying cute
young girls is good. RMS is constructive: built the compiler in a week
initially, and is the but-for cause of all of this. RMS was very
un-American, but has tried to become more American recently, sadly.

RMS: Why do you surround yourself with those who do nothing and do not
respect you? There are many who do respect you and respect you even
more for your statements which were benificial to men.

Why side with the enemies of your Class? Why place yourself in their
Prison? You could probably even have everything you might want in
Russia or South America or Japan or South-East Asia etc.

You're still respected there. But those are men's countries, not
white-women's countries. What have the Americans ever done for you?
(Other than throw you out, and make fun of you for exibiting a sign of
nervousness regarding public speaking once, and spreading rumours
about hygene constantly)?

[Notice: Libreboot author posting photos of his genitals being cut off 
is respected, while RMS posting /text/ suggesting Men perhaps could 
marry /girls/ causes absolute revulsion and hatread from the 
arachnid-like American white men and their rulers: the white women (the 
white women find it "disgusting", RMS's opinions, but are happy about 
Libreboot-"maintainers" photos and action of chopping his manhood off 
(because white women _HATE_ men: thus libreboot-"maintainer"'s shameful 
act is in keeping with their interests, while RMS's past text ideas are 
not: white women are _EVIL_ tyrants who encourage their men (and they 
are _their_ men) to MURDER COUNTLESS INNOCENT muslim men, women, 
children BECAUSE "they are p[a]edos: the men should be killed, the 
children are better of dead than living in that society"))]

...
For these reasons I propose coreboot with the no-blobs option be used 
over "libreboot". It is free-software without the blobs; but even 
blobless the spyware in your processor is still there either way 
(another gift of America).


