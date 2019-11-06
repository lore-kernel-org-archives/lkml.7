Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7D1C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1732173E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="lzdpTGi5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732683AbfKFWEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:04:41 -0500
Received: from mx1.cock.li ([185.10.68.5]:37585 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726957AbfKFWEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:04:40 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1573077877; bh=3JpdTRQeSUwGryhFQwse0VFJSngi9OZhnGVIKgZWnno=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=lzdpTGi58UqlyOF7yzQdWGAOddkZgXjsH6+NCBBLx/vB4NCmveObhLU3SHXN8Myw7
         resJzS0B1XUmR8zJGwrk6ePJy4enDjZfxNJzfg5ns5TYThg2NcXSc8spGZXEPa3X+n
         q0T9kDIZvUGK6IuyV5+8DzTZeGpac+6MGz43nnoswT36kUeFTBY51vrYCcB3FQ5FIA
         56bfKk9/poRoka/YiibNDsIpyH+VFMXcx3KgTbVE1LgMmspHuduuq+2Mmp3vvXZdEn
         EcXfM38ORsuUUlIjole/5D88A1e3gNsazNgin7awPvn2h5o28RYLMzJ90PNHEWAaIp
         4sQE2dSQLvtjg==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 06 Nov 2019 22:04:37 +0000
From:   gameonlinux@redchan.it
To:     linux-kernel@vger.kernel.org
Subject: Re: Coreboot vs Libreboot - GNU: Please use Coreboot without the
 blobs (compile time option). - Local politics in Software
In-Reply-To: <CAJsg1E-HrrexDVYxV=qf=LDT2PrY=tUH_JhrpYyDNu95Y2wpLw@mail.gmail.com>
References: <b1b6ab4e31856450d82afccaba587b0f@redchan.it>
 <CAJsg1E-HrrexDVYxV=qf=LDT2PrY=tUH_JhrpYyDNu95Y2wpLw@mail.gmail.com>
Message-ID: <07ebf4d78e2f257c68d39d2697a16e3d@redchan.it>
X-Sender: gameonlinux@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy: RMS was the victim of such local politics/religion (one can see 
said US belief system as a religion); his enemies opened the door.

And it is local. Even the foreign-to-us people that were attacking RMS 
and had him physically thrown out of his home at MIT were following 
local-American morals and beliefs, even if some of them were in Europe.

I am just expressing a weak opposition to what they used against RMS.

If they are able to call for RMS' removal from his OWN project (and yes: 
GNU is _his_ project), and they have threads on this that go on for 
centuries on -devel lists, and this is fine (it is seen as fine), then 
they have already opened the door.

They would like it to be closed after they said their piece, ofcourse.

They even got RMS to recant! RMS, recanting!
After they pressured him, and had him thrown out with bouncers from 
where he lived for 40 years. Because he offended /their/ 
religion/local-politics (which are global because the demon won't leave 
anyone alone)

On 2019-11-06 18:21, Andy Tai wrote:
> Please no politics of these "American" hate/evil stuff.  These are not
> qualified factors in making technical decisions.
> This is a global list.  Your opinions are of local nature and should
> not be imposed on anyone in your country or anywhere else.
> 
> On Wed, Nov 6, 2019 at 9:54 AM <gameonlinux@redchan.it> wrote:
>> 
>> 
>> (because white women _HATE_ men: thus libreboot-"maintainer"'s 
>> shameful
>> act is in keeping with their interests, while RMS's past text ideas 
>> are
>> not: white women are _EVIL_ tyrants who encourage their men (and they
>> are _their_ men) to MURDER COUNTLESS INNOCENT muslim men, women,
>> children BECAUSE "they are p[a]edos: the men should be killed, the
>> children are better of dead than living in that society"))]
>> 
>> ...
>> For these reasons I propose coreboot with the no-blobs option be used
>> over "libreboot". It is free-software without the blobs; but even
>> blobless the spyware in your processor is still there either way
>> (another gift of America).
>> 
>> 
>> 
