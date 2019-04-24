Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8858C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA8021900
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732820AbfDXQyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:54:45 -0400
Received: from mail.netline.ch ([148.251.143.178]:36001 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731366AbfDXQyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:54:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 111BC2AA104;
        Wed, 24 Apr 2019 18:54:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id I1ChxfgMDZhc; Wed, 24 Apr 2019 18:54:40 +0200 (CEST)
Received: from thor (116.245.63.188.dynamic.wline.res.cust.swisscom.ch [188.63.245.116])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id EF5AA2AA100;
        Wed, 24 Apr 2019 18:54:39 +0200 (CEST)
Received: from [::1]
        by thor with esmtp (Exim 4.92)
        (envelope-from <michel@daenzer.net>)
        id 1hJLAN-0003wF-GL; Wed, 24 Apr 2019 18:54:39 +0200
Subject: Re: Support for 2D engines/blitters in V4L2 and DRM
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Daniel Vetter <daniel@ffwll.ch>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Dave Airlie <airlied@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
References: <0df3d4b5178d8a37b67b275e0771741c6c268de3.camel@bootlin.com>
 <20190418081816.GO13337@phenom.ffwll.local>
 <8265f098722d0cd5aae606d7ee6d955f168ac8f3.camel@ndufresne.ca>
 <987372acff18f4c66191ee52fa69dc2917e4a605.camel@bootlin.com>
 <1d6fb659-0516-41db-257b-258e6116a4f2@daenzer.net>
 <7479b8df108c66b1711eb89efbfeb4a16480533d.camel@ndufresne.ca>
 <8e091392-2365-6c52-1fc2-84ebdc9e83fe@daenzer.net>
 <93c8e6834728b7e5979013df757017d309ee6a89.camel@bootlin.com>
 <CAKMK7uFewmCuc97Qp_2zzk9YvMPmK8zE=a6XGszsLq+SLy-vJA@mail.gmail.com>
 <9230d330e3b57af0643abc834bcf207095cc4bd7.camel@ndufresne.ca>
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
Message-ID: <65a37cec-5040-e2f0-5cd5-c9c3111827ad@daenzer.net>
Date:   Wed, 24 Apr 2019 18:54:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9230d330e3b57af0643abc834bcf207095cc4bd7.camel@ndufresne.ca>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ckb6yNZotNLsMNKkLOlTwC2n5j2Fhyb4v"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ckb6yNZotNLsMNKkLOlTwC2n5j2Fhyb4v
Content-Type: multipart/mixed; boundary="ya97kToJ99IR0B2C1eWWwFyOOCfRxKxJK";
 protected-headers="v1"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
To: Nicolas Dufresne <nicolas@ndufresne.ca>, Daniel Vetter <daniel@ffwll.ch>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: Alexandre Courbot <acourbot@chromium.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Tomasz Figa
 <tfiga@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Dave Airlie <airlied@redhat.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Message-ID: <65a37cec-5040-e2f0-5cd5-c9c3111827ad@daenzer.net>
Subject: Re: Support for 2D engines/blitters in V4L2 and DRM
References: <0df3d4b5178d8a37b67b275e0771741c6c268de3.camel@bootlin.com>
 <20190418081816.GO13337@phenom.ffwll.local>
 <8265f098722d0cd5aae606d7ee6d955f168ac8f3.camel@ndufresne.ca>
 <987372acff18f4c66191ee52fa69dc2917e4a605.camel@bootlin.com>
 <1d6fb659-0516-41db-257b-258e6116a4f2@daenzer.net>
 <7479b8df108c66b1711eb89efbfeb4a16480533d.camel@ndufresne.ca>
 <8e091392-2365-6c52-1fc2-84ebdc9e83fe@daenzer.net>
 <93c8e6834728b7e5979013df757017d309ee6a89.camel@bootlin.com>
 <CAKMK7uFewmCuc97Qp_2zzk9YvMPmK8zE=a6XGszsLq+SLy-vJA@mail.gmail.com>
 <9230d330e3b57af0643abc834bcf207095cc4bd7.camel@ndufresne.ca>
In-Reply-To: <9230d330e3b57af0643abc834bcf207095cc4bd7.camel@ndufresne.ca>

--ya97kToJ99IR0B2C1eWWwFyOOCfRxKxJK
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable

On 2019-04-24 5:44 p.m., Nicolas Dufresne wrote:
> Le mercredi 24 avril 2019 =C3=A0 17:06 +0200, Daniel Vetter a =C3=A9cri=
t :
>> On Wed, Apr 24, 2019 at 4:41 PM Paul Kocialkowski
>> <paul.kocialkowski@bootlin.com> wrote:
>>> On Wed, 2019-04-24 at 16:39 +0200, Michel D=C3=A4nzer wrote:
>>>> On 2019-04-24 2:01 p.m., Nicolas Dufresne wrote:
>>>>>
>>>>> Rendering a video stream is more complex then what you describe her=
e.
>>>>> Whenever there is a unexpected delay (late delivery of a frame as a=
n
>>>>> example) you may endup in situation where one frame is ready after =
the
>>>>> targeted vblank. If there is another frame that targets the followi=
ng
>>>>> vblank that gets ready on-time, the previous frame should be replac=
ed
>>>>> by the most recent one.
>>>>>
>>>>> With fences, what happens is that even if you received the next fra=
me
>>>>> on time, naively replacing it is not possible, because we don't kno=
w
>>>>> when the fence for the next frame will be signalled. If you simply
>>>>> always replace the current frame, you may endup skipping a lot more=

>>>>> vblank then what you expect, and that results in jumpy playback.
>>>>
>>>> So you want to be able to replace a queued flip with another one the=
n.
>>>> That doesn't necessarily require allowing more than one flip to be
>>>> queued ahead of time.
>>>
>>> There might be other ways to do it, but this one has plenty of
>>> advantages.
>>
>> The point of kms (well one of the reasons) was to separate the
>> implementation of modesetting for specific hw from policy decisions
>> like which frames to drop and how to schedule them. Kernel gives
>> tools, userspace implements the actual protocols.
>>
>> There's definitely a bit a gap around scheduling flips for a specific
>> frame or allowing to cancel/overwrite an already scheduled flip, but
>> no one yet has come up with a clear proposal for new uapi + example
>> implementation + userspace implementation + big enough support from
>> other compositors that this is what they want too.

Actually, the ATOMIC_AMEND patches propose a way to replace a scheduled
flip?


>>>> Note that this can also be done in userspace with explicit fencing (=
by
>>>> only selecting a frame and submitting it to the kernel after all
>>>> corresponding fences have signalled), at least to some degree, but t=
he
>>>> kernel should be able to do it up to a later point in time and more
>>>> reliably, with less risk of missing a flip for a frame which becomes=

>>>> ready just in time.
>>>
>>> Indeed, but it would be great if we could do that with implicit fenci=
ng
>>> as well.
>>
>> 1. extract implicit fences from dma-buf. This part is just an idea,
>> but easy to implement once we have someone who actually wants this.
>> All we need is a new ioctl on the dma-buf to export the fences from
>> the reservation_object as a sync_file (either the exclusive or the
>> shared ones, selected with a flag).
>> 2. do the exact same frame scheduling as with explicit fencing
>> 3. supply explicit fences in your atomic ioctl calls - these should
>> overrule any implicit fences (assuming correct kernel drivers, but we
>> have helpers so you can assume they all work correctly).
>>
>> By design this is possible, it's just that no one yet bothered enough
>> to make it happen.
>> -Daniel
>=20
> I'm not sure I understand the workflow of this one. I'm all in favour
> leaving the hard work to userspace. Note that I have assumed explicit
> fences from the start, I don't think implicit fence will ever exist in
> v4l2, but I might be wrong. What I understood is that there was a
> previous attempt in the past but it raised more issues then it actually=

> solved. So that being said, how do handle exactly the follow use cases:=

>=20
>  - A frame was lost by capture driver, but it was schedule as being the=

> next buffer to render (normally previous frame should remain).

Userspace just doesn't call into the kernel to flip to the lost frame,
so the previous one remains.

>  - The scheduled frame is late for the next vblank (didn't signal on-
> time), a new one may be better for the next vlbank, but we will only
> know when it's fence is signaled.

Userspace only selects a frame and submits it to the kernel after all
its fences have signalled.

> Better in this context means the the presentation time of this frame is=

> closer to the next vblank time. Keep in mind that the idea is to
> schedule the frames before they are signal, in order to make the usage
> of the fence useful in lowering the latency.

Fences are about signalling completion, not about low latency.

With a display server, the client can send frames to the display server
ahead of time, only the display server needs to wait for fences to
signal before submitting frames to the kernel.


> Of course as Michel said, we could just always wait on the fence and
> just schedule. But if you do that, why would you care implementing the
> fence in v4l2 to start with, DQBuf does just that already.

A fence is more likely to work out of the box with non-V4L-related code
than DQBuf?


--=20
Earthling Michel D=C3=A4nzer               |              https://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer


--ya97kToJ99IR0B2C1eWWwFyOOCfRxKxJK--

--ckb6yNZotNLsMNKkLOlTwC2n5j2Fhyb4v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSwn681vpFFIZgJURRaga+OatuyAAUCXMCUzwAKCRBaga+Oatuy
ALoKAJ9hrpaHjUI8UeMtAFIeKCLfFjLIOACfVZqmzm4oj6ZZs3WQmLMFZ9s2apM=
=kbkc
-----END PGP SIGNATURE-----

--ckb6yNZotNLsMNKkLOlTwC2n5j2Fhyb4v--
