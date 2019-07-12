Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36759C742A1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 00:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1D2214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 00:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="EEftpfHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfGLAyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 20:54:17 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:24359 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbfGLAyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 20:54:17 -0400
Date:   Fri, 12 Jul 2019 00:54:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1562892854;
        bh=orTq4C3s0FSpoWnv+D1q0tFTbbD4MyDqjOUl1joNFtA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=EEftpfHj61KKgsS+rmEzgvdukLD7figa148IAEq3z5ZNmXccnatu94ktW+DBqqhJk
         4vx34SbjuL0ApoSav4PoqA5a4SYy8hcIWN88uzAXbVe51lrmW1RofXrFhqlunpiizO
         3tCYD96RUQTiJnX8MmAM2NpIfHDiHYXwEWtE82oc=
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
From:   =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Subject: =?UTF-8?Q?Re:_Fair_Pay_Project_is_now:_Od=C3=A9n_OS?=
Message-ID: <89Zq1KfvLyK64IMxS-irSTzW-SjgKlfZ_AE5gclbpZkddj4e6v-xBFe2VQz-YIByU6EpDpwBGYujFWCocws3MeQUnHwFbGQYgmKJKqrrq5o=@protonmail.com>
In-Reply-To: <a0fdd4ad-c2ab-4b31-9aaa-afbb13538242@metux.net>
References: <OlRBTjSHu2VQ5oCicx8H5NNsXwVoXplHBLzhInvc6TMUuaDnDLBeRc0NiAmSfkfS2Ne07fZQDYtsqlKS1CC18e19cTXTnrwmsYNKSXE4Cq0=@protonmail.com>
 <a0fdd4ad-c2ab-4b31-9aaa-afbb13538242@metux.net>
Feedback-ID: jE8CP55NmWCGfbi9g5qzrOGkxuwuSXpchSI6fmYzjd5UEveHXeJrmiWc0_sgJdqIHM8YAKf9EEyPwffaRmhZ0A==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I=C2=B4ve been a user of OSs since the early 90s, starting with the "Ir=
ix for homecomputers" Amiga. And gone through some thinkings with that. Unf=
ortunately Microsoft took over, and everybody hated that OS. Particulary he=
re in Scandinavia. We expected big money, but it seems not much happened wi=
th that. All that happened on the Amiga was early versions of streaming (mo=
dules), picturesharing, chat etc.

Money did not come. As I grew up I realized I could do it myself, and havin=
g had top 1% research on Academia edu, I took a stab at OS design myself. N=
ow including the finely granulated internet ecnonomy, aiming for autmated f=
inances in the kernel itself. One thing popculture never really could do, w=
as finances. So the traditional role of record company, publisher or even e=
mployer now is in the OS itself. Making all streams, data and files having =
attributes about re-use or not, taking part in this finely granulated inter=
net economy and making the best of this.

And with a good enough file catalog structure, say

WTTP://Category/Subcategory/Country/15.000km2 zone/Person/Groupings(can be =
several)

With pop-statistics pr. folder, people find what they want, and could comme=
nt on the files.

With Groupings being for instance an aggregator for instance for this versi=
on of news, using files from publishers for the content.

Peace.


Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Thursday 11. July 2019 kl. 19:53, Enrico Weigelt, metux IT consult <lkml=
@metux.net> wrote:

> On 11.07.19 15:01, Ywe C=C3=A6rlyn wrote:
>
> > I had the most brilliant idea - Fair Pay Project is now: Od=C3=A9n OS.
> > Us norse always liked a bit faster OS.
>
> What exactly do you wanna do differently ?
>
> --mtx
>
>
> -----------------------------------------------------
>
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287


