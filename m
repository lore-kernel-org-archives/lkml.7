Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B8FC742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 19:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A69E21783
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 19:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Bva202LC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfGLTAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 15:00:16 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:15125 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfGLTAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 15:00:15 -0400
Date:   Fri, 12 Jul 2019 19:00:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1562958010;
        bh=9bsX4SGEmN0DCfBC0hggdLbBXzd2BZnAtcq9t+rnxXk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=Bva202LCLxmU3ya4oMo82fvcqnwDxB3GpEbsgsQyRRqJDdcI/sUL48/YA2R5KasEG
         TwOMUNCPeNM4jwphfqmBimGDghK2Gmml3JhV3qzXMjHnaaL3ogWAIS60/JnkCKqlGy
         EEqW9e6If84fUujWCbEar5CqOQJTXn4+69zCNJ+g=
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
From:   =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Subject: =?UTF-8?Q?Re:_Fair_Pay_Project_is_now:_Od=C3=A9n_OS?=
Message-ID: <QewkT_yMbOA1IT6cFBT5tzjO5v8x3f1-7Ssj87ldXG4jwoT82j4O6UOcGwbr_VfoZ61PTZ2_MI7Ll7MJNnUiQK_7HbdVOQtIaUXBFDZva2U=@protonmail.com>
In-Reply-To: <89Zq1KfvLyK64IMxS-irSTzW-SjgKlfZ_AE5gclbpZkddj4e6v-xBFe2VQz-YIByU6EpDpwBGYujFWCocws3MeQUnHwFbGQYgmKJKqrrq5o=@protonmail.com>
References: <OlRBTjSHu2VQ5oCicx8H5NNsXwVoXplHBLzhInvc6TMUuaDnDLBeRc0NiAmSfkfS2Ne07fZQDYtsqlKS1CC18e19cTXTnrwmsYNKSXE4Cq0=@protonmail.com>
 <a0fdd4ad-c2ab-4b31-9aaa-afbb13538242@metux.net>
 <89Zq1KfvLyK64IMxS-irSTzW-SjgKlfZ_AE5gclbpZkddj4e6v-xBFe2VQz-YIByU6EpDpwBGYujFWCocws3MeQUnHwFbGQYgmKJKqrrq5o=@protonmail.com>
Feedback-ID: jE8CP55NmWCGfbi9g5qzrOGkxuwuSXpchSI6fmYzjd5UEveHXeJrmiWc0_sgJdqIHM8YAKf9EEyPwffaRmhZ0A==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: The latinization Od=C5=84 might be even more accurate.

And we now officially support EU.

While Richard Stallman thinks "GNU is under attack by EU".

https://www.youtube.com/watch?v=3DKWQKpva0PY0

Peace!



Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Friday 12. July 2019 kl. 02:54, Ywe C=C3=A6rlyn <ywecrn@protonmail.com> =
wrote:

> Hi, I=C2=B4ve been a user of OSs since the early 90s, starting with the "=
Irix for homecomputers" Amiga. And gone through some thinkings with that. U=
nfortunately Microsoft took over, and everybody hated that OS. Particulary =
here in Scandinavia. We expected big money, but it seems not much happened =
with that. All that happened on the Amiga was early versions of streaming (=
modules), picturesharing, chat etc.
>
> Money did not come. As I grew up I realized I could do it myself, and hav=
ing had top 1% research on Academia edu, I took a stab at OS design myself.=
 Now including the finely granulated internet ecnonomy, aiming for autmated=
 finances in the kernel itself. One thing popculture never really could do,=
 was finances. So the traditional role of record company, publisher or even=
 employer now is in the OS itself. Making all streams, data and files havin=
g attributes about re-use or not, taking part in this finely granulated int=
ernet economy and making the best of this.
>
> And with a good enough file catalog structure, say
>
> WTTP://Category/Subcategory/Country/15.000km2 zone/Person/Groupings(can b=
e several)
>
> With pop-statistics pr. folder, people find what they want, and could com=
ment on the files.
>
> With Groupings being for instance an aggregator for instance for this ver=
sion of news, using files from publishers for the content.
>
> Peace.
>
> Sent with ProtonMail Secure Email.
>
> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original =
Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> On Thursday 11. July 2019 kl. 19:53, Enrico Weigelt, metux IT consult lkm=
l@metux.net wrote:
>
> > On 11.07.19 15:01, Ywe C=C3=A6rlyn wrote:
> >
> > > I had the most brilliant idea - Fair Pay Project is now: Od=C3=A9n OS=
.
> > > Us norse always liked a bit faster OS.
> >
> > What exactly do you wanna do differently ?
> > --mtx
> >
> > Enrico Weigelt, metux IT consult
> > Free software and Linux embedded engineering
> > info@metux.net -- +49-151-27565287


