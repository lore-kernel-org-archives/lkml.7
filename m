Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89574C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B2D2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbfDJJ3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:29:43 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:55455 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727583AbfDJJ3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:29:42 -0400
Received: from [IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f] ([IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f])
        by smtp-cloud8.xs4all.net with ESMTPA
        id E9Y2hpKidUjKfE9Y3hgwJv; Wed, 10 Apr 2019 11:29:40 +0200
Subject: Re: [PATCH v3 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Kamil Debski <kamil@wypas.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jeongtae Park <jtp.park@samsung.com>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <andrew-ct.chen@mediatek.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>
References: <20190124100419.26492-1-tfiga@chromium.org>
 <20190124100419.26492-2-tfiga@chromium.org>
 <1554461965.3060.5.camel@pengutronix.de>
 <8f05866a-1244-5e85-9b37-409526970779@xs4all.nl>
 <1554829036.5799.6.camel@pengutronix.de>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <394033d7-b3ec-4c2f-8fc0-caf8ce860998@xs4all.nl>
Date:   Wed, 10 Apr 2019 11:29:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1554829036.5799.6.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHRWfczFqNU2nhEOYUbyBU87S4ejVkoVyY914tUDXZlLaYhoVepWK9hbWbUnZDld9WgTFzgOweOqhAaHjKh8Q0VvptZxTgOMNOnNGJyptskGUy7QLrtw
 zan5zi/sk2/roauJjFOESb6O1TnpexXzEoyzQdnzsoGMCagM5z6eMJPGRAqGg8O4do7ck5NSLurOf6K+vFqFKcMDXScNadSnfktU+a70V7yCuBC1qJkXocIS
 CRdQcWRPH7V2N7Iw+v7xRAsCgBEVDAAXMb9VfzZ+cpo3AkQJLd4qZ7VgcXGrUD7PZs2IkIYRuqNCRmVKlj7nl+hmTXMlsx2L4TN2cJzmSah1CNEX/y/uLan6
 VFaBSVXNHmrpohseM2d1uOhD2A3yK3xjLE0P73XAH/frt84RK4FR6HwlvAdaJXg4TvIYmC6Zy3Lyi8gKAodb/fbDTmV57vBPIeIbRntlydc3AotevsB281Gr
 E3sqIcPpDLTWQGbSGdl5CRR58I03pq7QGmKuLVhklqk3V3rnLJDY6uwe0grES9stLApySNy1AC87A3YnwfvPgf91Ij2Bn3dE4cLkxYkMRbL9n9pIJ/K97VR9
 G4cj3A3MiTmuInVUrCnIHaFvlngh8mx5tN2n+E8ICeIK2P8hRWM/EZCk30b92+MwnkHhFJUOthy2QPkD0LxOzPxYjT4R+DVDnHN82fxqEMFm1gGTXb1xh3hN
 9/yAVgWX5UJMqe+mRiJFId7E6LNIsnUUIqutipenVog/f1CKXjwM1D12WSH5bvKxYIx5L+2uRhkcdQaX4JNIMgk18aFW+R99inFkQT6vVyD/SL4qAXG7GnMF
 cmHHGUq4zwpreMA9M4LbLA1fIlvLhRuxkyNRKIAXrH9tDiOTnfdmxryU9FMF0OX5F+ScY8ojF3VVKReYkhcBIhCpzVB5LZ4KHJgyEqnA4Fl5CeXlmOevjzl8
 TgkwRhJ5IJmCZIYdgyASoLm0SLOPy8atiPsyTJvUAfiuyISA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/19 6:57 PM, Philipp Zabel wrote:
> On Fri, 2019-04-05 at 13:21 +0200, Hans Verkuil wrote:
>> On 4/5/19 12:59 PM, Philipp Zabel wrote:
>>> On Thu, 2019-01-24 at 19:04 +0900, Tomasz Figa wrote:
>>>> Due to complexity of the video decoding process, the V4L2 drivers of
>>>> stateful decoder hardware require specific sequences of V4L2 API calls
>>>> to be followed. These include capability enumeration, initialization,
>>>> decoding, seek, pause, dynamic resolution change, drain and end of
>>>> stream.
>>>>
>>>> Specifics of the above have been discussed during Media Workshops at
>>>> LinuxCon Europe 2012 in Barcelona and then later Embedded Linux
>>>> Conference Europe 2014 in Düsseldorf. The de facto Codec API that
>>>> originated at those events was later implemented by the drivers we already
>>>> have merged in mainline, such as s5p-mfc or coda.
>>>>
>>>> The only thing missing was the real specification included as a part of
>>>> Linux Media documentation. Fix it now and document the decoder part of
>>>> the Codec API.
>>>>
>>>> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
>>>> ---
>>>>  Documentation/media/uapi/v4l/dev-decoder.rst  | 1076 +++++++++++++++++
>>>>  Documentation/media/uapi/v4l/dev-mem2mem.rst  |    5 +
>>>>  Documentation/media/uapi/v4l/pixfmt-v4l2.rst  |    5 +
>>>>  Documentation/media/uapi/v4l/v4l2.rst         |   10 +-
>>>>  .../media/uapi/v4l/vidioc-decoder-cmd.rst     |   40 +-
>>>>  Documentation/media/uapi/v4l/vidioc-g-fmt.rst |   14 +
>>>>  6 files changed, 1135 insertions(+), 15 deletions(-)
>>>>  create mode 100644 Documentation/media/uapi/v4l/dev-decoder.rst
>>>>
>>>> diff --git a/Documentation/media/uapi/v4l/dev-decoder.rst b/Documentation/media/uapi/v4l/dev-decoder.rst
>>>> new file mode 100644
>>>> index 000000000000..b7db2352ad41
>>>> --- /dev/null
>>>> +++ b/Documentation/media/uapi/v4l/dev-decoder.rst
>>>> @@ -0,0 +1,1076 @@
>>>> +.. -*- coding: utf-8; mode: rst -*-
>>>> +
>>>> +.. _decoder:
>>>> +
>>>> +*************************************************
>>>> +Memory-to-memory Stateful Video Decoder Interface
>>>> +*************************************************
>>>> +
>>>
>>> [...]
>>>> +
>>>> +Drain
>>>> +=====
>>>> +
>>>
>>> [...]
>>>> +
>>>> +3. Once all the ``OUTPUT`` buffers queued before the ``V4L2_DEC_CMD_STOP`` call
>>>> +   are dequeued and the last ``CAPTURE`` buffer is dequeued, the decoder is
>>>> +   stopped and it will accept, but not process, any newly queued ``OUTPUT``
>>>> +   buffers until the client issues any of the following operations:
>>>> +
>>>
>>> [...]
>>>> +
>>>> +.. note::
>>>> +
>>>> +   Once the drain sequence is initiated, the client needs to drive it to
>>>> +   completion, as described by the steps above, unless it aborts the process by
>>>> +   issuing :c:func:`VIDIOC_STREAMOFF` on any of the ``OUTPUT`` or ``CAPTURE``
>>>> +   queues.  The client is not allowed to issue ``V4L2_DEC_CMD_START`` or
>>>> +   ``V4L2_DEC_CMD_STOP`` again while the drain sequence is in progress and they
>>>> +   will fail with -EBUSY error code if attempted.
>>>
>>> Should the V4L2_DEC_CMD_STOP documentation in
>>> Documentation/media/uapi/v4l/vidioc-decoder-cmd.rst:
>>>
>>>   * - ``V4L2_DEC_CMD_STOP``
>>>     - 1
>>>     - Stop the decoder. When the decoder is already stopped, this
>>>       command does nothing.
>>>
>>> be updated to mention that for mem2mem decoders this not only does
>>> nothing, but returns an -EBUSY error return value?
>>
>> Yes. Basically in this case the STOP is still in progress, so returning
>> EBUSY makes sense and should be documented.
>>
>>>
>>> Also, if V4L2_DEC_CMD_STOP_IMMEDIATELY is set, should the decoder drop
>>> all pending buffers and signal EOS immediately? Should this be mentioned
>>> here?
>>
>> Hmm, the decoder spec says that flags should be set to 0, and current codec
>> drivers explicitly disallow a non-0 flags value.
>>
>> I'm not sure if there is a practical use-case for V4L2_DEC_CMD_STOP_IMMEDIATELY
>> in the context of a decoder. If you want to stop immediately, then just call
>> streamoff on the OUTPUT queue.
> 
> v4l2-compliance currently complains if V4L2_DEC_CMD_STOP_IMMEDIATELY is
> not supported:
> 
>                 fail: v4l2-test-codecs.cpp(104): ret != 0
>         test VIDIOC_(TRY_)DECODER_CMD: FAIL
> 
> Should testDecoder be changed to set the V4L2_DEC_CMD_STOP_IMMEDIATELY
> flag only if node->codec_mask does not have the STATEFUL_DECODER bit
> set?

Yes. I see that the vicodec driver doesn't handle the DECODER_CMD ioctl
correctly, which is why I haven't noticed this v4l2-compliance issue before.

Regards,

	Hans

> 
> regards
> Philipp
> 

