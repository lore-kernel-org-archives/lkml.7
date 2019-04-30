Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6574C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D4421670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="cqZ27+vr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfD3Lhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:37:40 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:44977 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbfD3Lhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:37:38 -0400
Date:   Tue, 30 Apr 2019 11:37:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1556624255;
        bh=fwjYckBrKvo80wn2gT59OOUfaAE+FLzxUa8O/wCHELc=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=cqZ27+vrA9ihQaOqckRNJql+iJ+KnD7rFSG+7bBXWEk/CMRpS+Kv+fYrhIhEUTBey
         WF4itA2/sxAkPx8CZjcapNWyMAIL6zvKFbr/5mx7F9vGPWDzOWGB6u00mps4hk1SRg
         2gHJJUH9R/QzWVGqT3yCDeCY4XZcQR4ER21T8iTU=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Reply-To: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Subject: Conclusion on my work with Low-Jitter
Message-ID: <H8-uyzc6-Lr9aHDPAup8yi09fFIU3sN9Voo4n8LUBr50hokh7kYFQSl6WHjuuEKkNUGQj9KVSTjkyZM0RIU3_9TzdW7u-0Z0fwl3_QpwGbI=@protonmail.com>
Feedback-ID: jE8CP55NmWCGfbi9g5qzrOGkxuwuSXpchSI6fmYzjd5UEveHXeJrmiWc0_sgJdqIHM8YAKf9EEyPwffaRmhZ0A==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I worked with low-jitter on Linux, here earlier, and tested Available Sourc=
e, and found it to be of high quality, giving 172/3 frames with the jitter =
sensitive 3-pass Doom 3 engine, from ID Software,then at 1080p res, some ye=
ars ago, a good test for the fastest bus in the system, and giving a good g=
eneral idea of potential system performance.

The Available Source Unix derivative Linux, turned out better than Microsof=
t Windows, that ofcourse without working priorities, one needs to turn off =
tasks instead, and even with this, needed double CPU speed for similar perf=
ormance.

As for multiple cpus, understanding low jitter as the time it takes to do t=
he inner loop, one cpu seems enough for most, with todays speeds of 4GHZ. M=
ore becomes a bit of a luxury on desktops but could be used for parallel th=
reads ofcourse. While phones will use minimal power technology, and big ser=
vers many-cpus for serving the masses.

I also happened to see discussions in GNU space where "GNU has failed, it i=
s not happened on the desktop". But indeed BSD has, with OSX. So it is not =
anything like that Available Source in general has failed, but indeed seems=
 to be of higher quality than closed alternatives, and the netbased discuss=
ions of much faster dynamics, than regular phonesupport indeed.

Furthermore it seems Available Source is general seems to grow, and a one-s=
ystem topology seems viable, but it needs to fuse with existing commercial =
principles, and workunion principles of Fair Labour, that indeed is establi=
shed by law, and thus should also be part of the inner loop, of a low-jitte=
r system, then probably a BSD Unix derivative.

This research was part of a greater research project on monotheism, that al=
so addresses the behaviour problems we see online, and further concludes th=
at a z=C3=A9n-concept of the divine, that works in our culture, and a Quran=
ic upgrade to the Bible is neccesary, perfecting the Abrahamic background o=
f a computer system.

And indeed the internet is already much a technocracy, where relevance is f=
iltered in specialist workgroups, with leaders taking this to mainleader, j=
ust as information needs to be handled to be handlable in a system aswell. =
Where one indeed needs results, and irrelevance goes out, being even more d=
emocratic than democracy.

So optimal information handling is low-jitter is technocratic, and an optim=
al OS, and I suggest this being Oase aswell.

Peace Go With Thee.
Ywe C=C3=A6rlyn,
Oase Initiative Taker.
https://www.youtube.com/channel/UCR3gmLVjHS5A702wo4bol_Q

