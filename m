Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31F5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72661218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfDXIb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:31:27 -0400
Received: from mail.netline.ch ([148.251.143.178]:51309 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfDXIb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:31:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 1DAC32AA104;
        Wed, 24 Apr 2019 10:31:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id pryLAOGWjk22; Wed, 24 Apr 2019 10:31:22 +0200 (CEST)
Received: from thor (116.245.63.188.dynamic.wline.res.cust.swisscom.ch [188.63.245.116])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id E445E2AA100;
        Wed, 24 Apr 2019 10:31:21 +0200 (CEST)
Received: from [::1]
        by thor with esmtp (Exim 4.92)
        (envelope-from <michel@daenzer.net>)
        id 1hJDJJ-0000N3-DS; Wed, 24 Apr 2019 10:31:21 +0200
Subject: Re: Support for 2D engines/blitters in V4L2 and DRM
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Dave Airlie <airlied@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
References: <0df3d4b5178d8a37b67b275e0771741c6c268de3.camel@bootlin.com>
 <20190418081816.GO13337@phenom.ffwll.local>
 <8265f098722d0cd5aae606d7ee6d955f168ac8f3.camel@ndufresne.ca>
 <987372acff18f4c66191ee52fa69dc2917e4a605.camel@bootlin.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Openpgp: preference=signencrypt
Autocrypt: addr=michel@daenzer.net; prefer-encrypt=mutual; keydata=
 mQGiBDsehS8RBACbsIQEX31aYSIuEKxEnEX82ezMR8z3LG8ktv1KjyNErUX9Pt7AUC7W3W0b
 LUhu8Le8S2va6hi7GfSAifl0ih3k6Bv1Itzgnd+7ZmSrvCN8yGJaHNQfAevAuEboIb+MaVHo
 9EMJj4ikOcRZCmQWw7evu/D9uQdtkCnRY9iJiAGxbwCguBHtpoGMxDOINCr5UU6qt+m4O+UD
 /355ohBBzzyh49lTj0kTFKr0Ozd20G2FbcqHgfFL1dc1MPyigej2gLga2osu2QY0ObvAGkOu
 WBi3LTY8Zs8uqFGDC4ZAwMPoFy3yzu3ne6T7d/68rJil0QcdQjzzHi6ekqHuhst4a+/+D23h
 Za8MJBEcdOhRhsaDVGAJSFEQB1qLBACOs0xN+XblejO35gsDSVVk8s+FUUw3TSWJBfZa3Imp
 V2U2tBO4qck+wqbHNfdnU/crrsHahjzBjvk8Up7VoY8oT+z03sal2vXEonS279xN2B92Tttr
 AgwosujguFO/7tvzymWC76rDEwue8TsADE11ErjwaBTs8ZXfnN/uAANgPLQjTWljaGVsIERh
 ZW56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD6IXgQTEQIAHgUCQFXxJgIbAwYLCQgHAwIDFQID
 AxYCAQIeAQIXgAAKCRBaga+OatuyAIrPAJ9ykonXI3oQcX83N2qzCEStLNW47gCeLWm/QiPY
 jqtGUnnSbyuTQfIySkK5AQ0EOx6FRRAEAJZkcvklPwJCgNiw37p0GShKmFGGqf/a3xZZEpjI
 qNxzshFRFneZze4f5LhzbX1/vIm5+ZXsEWympJfZzyCmYPw86QcFxyZflkAxHx9LeD+89Elx
 bw6wT0CcLvSv8ROfU1m8YhGbV6g2zWyLD0/naQGVb8e4FhVKGNY2EEbHgFBrAAMGA/0VktFO
 CxFBdzLQ17RCTwCJ3xpyP4qsLJH0yCoA26rH2zE2RzByhrTFTYZzbFEid3ddGiHOBEL+bO+2
 GNtfiYKmbTkj1tMZJ8L6huKONaVrASFzLvZa2dlc2zja9ZSksKmge5BOTKWgbyepEc5qxSju
 YsYrX5xfLgTZC5abhhztpYhGBBgRAgAGBQI7HoVFAAoJEFqBr45q27IAlscAn2Ufk2d6/3p4
 Cuyz/NX7KpL2dQ8WAJ9UD5JEakhfofed8PSqOM7jOO3LCA==
Message-ID: <1d6fb659-0516-41db-257b-258e6116a4f2@daenzer.net>
Date:   Wed, 24 Apr 2019 10:31:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <987372acff18f4c66191ee52fa69dc2917e4a605.camel@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-19 10:38 a.m., Paul Kocialkowski wrote:
> On Thu, 2019-04-18 at 20:30 -0400, Nicolas Dufresne wrote:
>> Le jeudi 18 avril 2019 à 10:18 +0200, Daniel Vetter a écrit :
>>>> It would be cool if both could be used concurrently and not just return
>>>> -EBUSY when the device is used with the other subsystem.
>>>
>>> We live in this world already :-) I think there's even patches (or merged
>>> already) to add fences to v4l, for Android.
>>
>> This work is currently suspended. It will require some feature on DRM
>> display to really make this useful, but there is also a lot of
>> challanges in V4L2. In GFX space, most of the use case are about
>> rendering as soon as possible. Though, in multimedia we have two
>> problems, we need to synchronize the frame rendering with the audio,
>> and output buffers may comes out of order due to how video CODECs are
>> made.
> 
> Definitely, it feels like the DRM display side is currently a good fit
> for render use cases, but not so much for precise display cases where
> we want to try and display a buffer at a given vblank target instead of
> "as soon as possible".
> 
> I have a userspace project where I've implemented a page flip queue,
> which only schedules the next flip when relevant and keeps ready
> buffers in the queue until then. This requires explicit vblank
> syncronisation (which DRM offsers, but pretty much all other display
> APIs, that are higher-level don't, so I'm just using a refresh-rate
> timer for them) and flip done notification.
> 
> I haven't looked too much at how to flip with a target vblank with DRM
> directly but maybe the atomic API already has the bits in for that (but
> I haven't heard of such a thing as a buffer queue, so that makes me
> doubt it).

Not directly. What's available is that if userspace waits for vblank n
and then submits a flip, the flip will complete in vblank n+1 (or a
later vblank, depending on when the flip is submitted and when the
fences the flip depends on signal).

There is reluctance allowing more than one flip to be queued in the
kernel, as it would considerably increase complexity in the kernel. It
would probably only be considered if there was a compelling use-case
which was outright impossible otherwise.


> Well, I need to handle stuff like SDL in my userspace project, so I have
> to have all that queuing stuff in software anyway, but it would be good
> if each project didn't have to implement that. Worst case, it could be
> in libdrm too.

Usually, this kind of queuing will be handled in a display server such
as Xorg or a Wayland compositor, not by the application such as a video
player itself, or any library in the latter's address space. I'm not
sure there's much potential for sharing code between display servers for
this.


>> In the first, we'd need a mechanism where we can schedule a render at a
>> specific time or vblank. We can of course already implement this in
>> software, but with fences, the scheduling would need to be done in the
>> driver. Then if the fence is signalled earlier, the driver should hold
>> on until the delay is met. If the fence got signalled late, we also
>> need to think of a workflow. As we can't schedule more then one render
>> in DRM at one time, I don't really see yet how to make that work.
> 
> Indeed, that's also one of the main issues I've spotted. Before using
> an implicit fence, we basically have to make sure the frame is due for
> display at the next vblank. Otherwise, we need to refrain from using
> the fence and schedule the flip later, which is kind of counter-
> productive.

Fences are about signalling that the contents of a frame are "done" and
ready to be presented. They're not about specifying which frame is to be
presented when.


> I feel like specifying a target vblank would be a good unit for that,

The mechanism described above works for that.

> since it's our native granularity after all (while a timestamp is not).

Note that variable refresh rate (Adaptive Sync / FreeSync / G-Sync)
changes things in this regard. It makes the vblank length variable, and
if you wait for multiple vblanks between flips, you get the maximum
vblank length corresponding to the minimum refresh rate / timing
granularity. Thus, it would be useful to allow userspace to specify a
timestamp corresponding to the earliest time when the flip is to
complete. The kernel could then try to hit that as closely as possible.


-- 
Earthling Michel Dänzer               |              https://www.amd.com
Libre software enthusiast             |             Mesa and X developer
