Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AB6C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 00:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AF62632C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 00:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=jilayne.com header.i=@jilayne.com header.b="SbhatUgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfEaAZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 20:25:25 -0400
Received: from mx1.supremebox.com ([198.23.53.39]:44668 "EHLO
        mx1.supremebox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfEaAZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 20:25:25 -0400
X-Greylist: delayed 481 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 May 2019 20:25:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jilayne.com
        ; s=default; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:
        In-Reply-To:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=k/C9xb81V037O/oC/z+Bizvf5Yy5p8dNCtVOTjweufk=; b=SbhatUgQC5kF8J80GYxhmIfQio
        8Jfsg0MLp4HStBZjymDXHn1mCxV+CBYg488J6R+D2BZlduX46YvzKgZY3K7ENMvXIWKQ+CsWcCzzS
        edCIk8TXdYshMxr5FVh1xL+fSihe+g/bfH8c4woIcSFmZMXc2z6VcpP+sSokLKwq1fU8=;
Received: from [67.164.173.226] (helo=[10.0.0.21])
        by mx1.supremebox.com with esmtpa (Exim 4.89)
        (envelope-from <opensource@jilayne.com>)
        id 1hWVMG-0006zj-C7; Fri, 31 May 2019 00:25:20 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [GIT PULL] SPDX update for 5.2-rc1 - round 1
From:   J Lovejoy <opensource@jilayne.com>
In-Reply-To: <B03F305C-F579-43E1-BEE7-D628BD44FF48@jilayne.com>
Date:   Thu, 30 May 2019 18:25:18 -0600
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <122EA7BE-97AE-4011-ACC6-7477EAED914E@jilayne.com>
References: <20190521133257.GA21471@kroah.com>
 <20190529131300.GV3274@piout.net>
 <27E3B830FA35C7429A77DAEEDEB7344771E641C9@IRSMSX103.ger.corp.intel.com>
 <B03F305C-F579-43E1-BEE7-D628BD44FF48@jilayne.com>
To:     Alexios Zavras <alexios.zavras@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Sender-Ident-agJab5osgicCis: opensource@jilayne.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI all,

Sorry I didn=E2=80=99t jump in here sooner. Just a bit of additional =
background info to what Thomas and Alexios have already provided below:

> On May 29, 2019, at 8:16 AM, Zavras, Alexios =
<alexios.zavras@intel.com> wrote:
>=20
>=20
>> -----Original Message-----
>> From: linux-spdx-owner@vger.kernel.org =
<linux-spdx-owner@vger.kernel.org>
>> On Behalf Of Alexandre Belloni
>> Sent: Wednesday, 29 May, 2019 15:13
>> Subject: Re: [GIT PULL] SPDX update for 5.2-rc1 - round 1
>>=20
>> Hello,
>>=20
>> On 21/05/2019 15:32:57+0200, Greg KH wrote:
>>>  - Add GPL-2.0-only or GPL-2.0-or-later tags to files where our scan
>>=20
>> I'm very confused by those two tags because they are not mentioned in =
the
>> SPDX 2.1 specification or the kernel documentation and seem to just =
be from
>> https://spdx.org/ids-howi which doesn't seem to be versionned =
anywhere.
>> While I understand the rationale behind those, I believe the correct =
way of
>> introducing them would be first to add them in the spec and =
documentation
>> and then make use of them.
>=20
> The "GPL-2.0-only" and "GPL-2.0-or-later" are license short =
identifiers.
> They do not belong to the SPDX spec, but rather on the license list.
> They were introduced in the SPDX License List v3.0 (current version is =
3.5):
> https://spdx.org/licenses/=20
>=20
> It seems the examples in the kernel documentation use identifiers
> from earlier versions of the license list.

As Thomas mentioned in another part of this thread, the identifiers for =
the GNU family of licenses was changed as of v3.0 of the SPDX License =
List in Dec 2017. See =
https://spdx.org/news/news/2018/01/license-list-30-released for a =
explanation and =
https://www.gnu.org/licenses/identify-licenses-clearly.html for the =
impetus of the change. (Note, the SPDX License List has its own =
versioning separate from the SPDX Spec.)  We don=E2=80=99t change the =
license identifiers lightly and have only done so for very specific and =
limited reasons, so you can be sure there was a LOT of discussion over =
this change. Unfortunately, the lengthy discussion happened to coincide =
with the beginning of the work here on using the SPDX identifiers in the =
kernel. In a perfect world, we would have completed that change before =
you all started this, but sometimes things don=E2=80=99t go according to =
best timing!

>=20
>=20
>> Now, what should we do with all the GPL-2.0 and GPL-2.0+ tags that we =
have?
>=20
> These are still valid identifiers (albeit deprecated),=20
> so there is no urgent need to have them replaced.

This is correct. It would be nice if any new identifiers used the =
current ones. If the old identifiers get updated as other patches are =
done to those files or something organic like that, that would be great, =
but no rush. We=E2=80=99ve got plenty to focus on with getting the =
identifiers in there, sorting out the =E2=80=9Cmessy=E2=80=9D files and =
so on!

Thanks again for all the work on this!

Jilayne
SPDX legal team co-lead

>=20
> -- zvr -
> Intel Deutschland GmbH
> Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
> Tel: +49 89 99 8853-0, www.intel.de
> Managing Directors: Christin Eisenschmid, Gary Kershaw
> Chairperson of the Supervisory Board: Nicole Lau
> Registered Office: Munich
> Commercial Register: Amtsgericht Muenchen HRB 186928
