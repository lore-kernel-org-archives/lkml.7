Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B090C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 07:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BE3206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 07:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="pebb2n+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfEEHYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 03:24:40 -0400
Received: from mail-40135.protonmail.ch ([185.70.40.135]:25935 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfEEHYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 03:24:39 -0400
Date:   Sun, 05 May 2019 07:24:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1557041075;
        bh=VdHxU6jIgRNac3/CNB+ooXZuCMZdqb0iYkwXtL6A5tA=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:Feedback-ID:
         From;
        b=pebb2n+MJh4zZAMMpPuvOUGszdDpAUllt2pNeW8wuwHM74iDu0N1lNgzp84fo6LCY
         FlStCX++MIcB5zBc49u4p6OTFlarDKa+0dzw+Im1SH+DxjUzQ5t1qnJVGmF2xaGcnJ
         aEk1pOfVIGyHxnpwuFNKIKJrvwYHY+vaYGfT5Owc=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Reply-To: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Subject: Re: Conclusion on my work with Low-Jitter
Message-ID: <fgYTjcUU2eSHzAJ34fJvQ3Z8zNUROgD85sGHSY5WXYoG_btPUauAieTKLmB_NmisPjIigJ1dNuoRDZ8m_BRpDhtNUi5AJym0_xfsxvCluYU=@protonmail.com>
In-Reply-To: <H8-uyzc6-Lr9aHDPAup8yi09fFIU3sN9Voo4n8LUBr50hokh7kYFQSl6WHjuuEKkNUGQj9KVSTjkyZM0RIU3_9TzdW7u-0Z0fwl3_QpwGbI=@protonmail.com>
References: <H8-uyzc6-Lr9aHDPAup8yi09fFIU3sN9Voo4n8LUBr50hokh7kYFQSl6WHjuuEKkNUGQj9KVSTjkyZM0RIU3_9TzdW7u-0Z0fwl3_QpwGbI=@protonmail.com>
Feedback-ID: jE8CP55NmWCGfbi9g5qzrOGkxuwuSXpchSI6fmYzjd5UEveHXeJrmiWc0_sgJdqIHM8YAKf9EEyPwffaRmhZ0A==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also really the "Thor and Odin" style acidprophets we still see reflected i=
n people like Stallman is the big reggresion, and potentialiy block for gre=
ater economic flow, and should be replaced by intercultural thinking, takin=
g monotheistic developments, and going further to prosperity.

Oase is now Oase - Intercultural Operating System.

And I think I have solved all philosophical questions involved. So for all =
serious actors, acknowledge, and lets make it a big Fair Labour compliant C=
omputing Space.

Peace.
Ywe C=C3=A6rlyn
Researcher (+DSP-Programmer, Musician, Producer, Mastering-engineer.)
https://www.youtube.com/channel/UCR3gmLVjHS5A702wo4bol_Q


Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Tuesday 30. April 2019 kl. 13:37, Ywe C=C3=A6rlyn <ywecrn@protonmail.com=
> wrote:

> I worked with low-jitter on Linux, here earlier, and tested Available Sou=
rce, and found it to be of high quality, giving 172/3 frames with the jitte=
r sensitive 3-pass Doom 3 engine, from ID Software,then at 1080p res, some =
years ago, a good test for the fastest bus in the system, and giving a good=
 general idea of potential system performance.
>
> The Available Source Unix derivative Linux, turned out better than Micros=
oft Windows, that ofcourse without working priorities, one needs to turn of=
f tasks instead, and even with this, needed double CPU speed for similar pe=
rformance.
>
> As for multiple cpus, understanding low jitter as the time it takes to do=
 the inner loop, one cpu seems enough for most, with todays speeds of 4GHZ.=
 More becomes a bit of a luxury on desktops but could be used for parallel =
threads ofcourse. While phones will use minimal power technology, and big s=
ervers many-cpus for serving the masses.
>
> I also happened to see discussions in GNU space where "GNU has failed, it=
 is not happened on the desktop". But indeed BSD has, with OSX. So it is no=
t anything like that Available Source in general has failed, but indeed see=
ms to be of higher quality than closed alternatives, and the netbased discu=
ssions of much faster dynamics, than regular phonesupport indeed.
>
> Furthermore it seems Available Source is general seems to grow, and a one=
-system topology seems viable, but it needs to fuse with existing commercia=
l principles, and workunion principles of Fair Labour, that indeed is estab=
lished by law, and thus should also be part of the inner loop, of a low-jit=
ter system, then probably a BSD Unix derivative.
>
> This research was part of a greater research project on monotheism, that =
also addresses the behaviour problems we see online, and further concludes =
that a z=C3=A9n-concept of the divine, that works in our culture, and a Qur=
anic upgrade to the Bible is neccesary, perfecting the Abrahamic background=
 of a computer system.
>
> And indeed the internet is already much a technocracy, where relevance is=
 filtered in specialist workgroups, with leaders taking this to mainleader,=
 just as information needs to be handled to be handlable in a system aswell=
. Where one indeed needs results, and irrelevance goes out, being even more=
 democratic than democracy.
>
> So optimal information handling is low-jitter is technocratic, and an opt=
imal OS, and I suggest this being Oase aswell.
>
> Peace Go With Thee.
> Ywe C=C3=A6rlyn,
> Oase Initiative Taker.
> https://www.youtube.com/channel/UCR3gmLVjHS5A702wo4bol_Q


