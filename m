Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAEBC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA81121738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbfDEKDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:03:47 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:52375 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729820AbfDEKDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 06:03:47 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id CLhDhd0dNiLOmCLhGhrFDC; Fri, 05 Apr 2019 12:03:43 +0200
Subject: Re: [PATCH v3 2/2] media: docs-rst: Document memory-to-memory video
 encoder interface
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Kamil Debski <kamil@wypas.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jeongtae Park <jtp.park@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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
 <20190124100419.26492-3-tfiga@chromium.org>
 <4bbe4ce4-615a-b981-0855-cd78c7a002d9@xs4all.nl>
 <471720b7-e304-271b-256d-a3dd394773c9@xs4all.nl>
 <CAAFQd5Au_=08pVom1z3C1nHKdKak8Y4d5odR6fiNB4urDhfjKQ@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <787ddc1f-388d-82be-2702-0d7d256f636c@xs4all.nl>
Date:   Fri, 5 Apr 2019 12:03:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAAFQd5Au_=08pVom1z3C1nHKdKak8Y4d5odR6fiNB4urDhfjKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOY1lRnNDWEg6IJlzAuJtN8x5RH0fSvxxXB66GgktJPsFG+5H3R5mwK9SRjDYiJURWxxOoHT8w2FfLcVNMn47eefs9IE8FGrZ5rjQIvTA0ZCBdE7Wa3N
 3jnWDD90zJckFH3BHuCUW/eB/VQE2430SmtEqZaZZ8AdRvQrKfEe9Le9g6IoIjB5xVbb5odyrHFW6hZIRNOozmlI+sT/oHRiafbTrb55Hrq+sURhUoZ+fEzc
 omfwqqDUNQNFpUtBEmq7fuq8nRta21MbbR4dXxlRaStt5W3yB6r2JVYtVc3HdbAVy7+2CCvtzHdvxDz/n8dSgng1cRlNEXnm9A74gF7junZX8saEiaJbJlTW
 dLsiitDiB3plee08sGpwjZXT6T5S89D0USpQOaqIEjGQUb1qZUKzaxXemteDXldU5ueUM1kav7DavybCFLtHmjzlVYhGbCAtOgFUFlzYVV0n9zdUnB3XEnoM
 Yd5BCgO5CEbfowPGpmiqguM+lhVF0pR05ljm60lp0BGdLb4AMMJNJ1TsEK7eQipLK73y3Idfb7OaOpQY3FqMit3869rT3WvhC1J8G7VzKuDxQ1YIxw0adfae
 3odIw8B0nwhBCoH+zuRQY/ThgVwBLVQbwzkCp6S/EmBIjgHKSgBmOkbTu69IboHsByKA8zqspYDhNKnZl66cUITI94e3L/8Kb9paNtzsuSdWfJ3gRq8ea/Zn
 hYMJBVPPAuSBg4FaWED8myX98jiL7HRF6BGFHNK4lSN19AIFt5+hsh4akaL6++be5IoA6nLWQSYjSH9FNAMi5mdWwYJ5sB9SG1sA1HMO7WEfbLqdJAKqWxxr
 a8V2VfcBRhL73EriE12IV4PhF3chKnW5jWXOBuFtFkYsXfpdsTM3vHb537pf0T3TZfOZsT/G9eN7d25+hxM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/19 10:12 AM, Tomasz Figa wrote:
> On Thu, Mar 14, 2019 at 10:57 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>
>> Hi Tomasz,
>>
>> Some more comments...
>>
>> On 1/29/19 2:52 PM, Hans Verkuil wrote:
>>> Hi Tomasz,
>>>
>>> Some comments below. Nothing major, so I think a v4 should be ready to be
>>> merged.
>>>
>>> On 1/24/19 11:04 AM, Tomasz Figa wrote:
>>>> Due to complexity of the video encoding process, the V4L2 drivers of
>>>> stateful encoder hardware require specific sequences of V4L2 API calls
>>>> to be followed. These include capability enumeration, initialization,
>>>> encoding, encode parameters change, drain and reset.
>>>>
>>>> Specifics of the above have been discussed during Media Workshops at
>>>> LinuxCon Europe 2012 in Barcelona and then later Embedded Linux
>>>> Conference Europe 2014 in Düsseldorf. The de facto Codec API that
>>>> originated at those events was later implemented by the drivers we already
>>>> have merged in mainline, such as s5p-mfc or coda.
>>>>
>>>> The only thing missing was the real specification included as a part of
>>>> Linux Media documentation. Fix it now and document the encoder part of
>>>> the Codec API.
>>>>
>>>> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
>>>> ---
>>>>  Documentation/media/uapi/v4l/dev-encoder.rst  | 586 ++++++++++++++++++
>>>>  Documentation/media/uapi/v4l/dev-mem2mem.rst  |   1 +
>>>>  Documentation/media/uapi/v4l/pixfmt-v4l2.rst  |   5 +
>>>>  Documentation/media/uapi/v4l/v4l2.rst         |   2 +
>>>>  .../media/uapi/v4l/vidioc-encoder-cmd.rst     |  38 +-
>>>>  5 files changed, 617 insertions(+), 15 deletions(-)
>>>>  create mode 100644 Documentation/media/uapi/v4l/dev-encoder.rst
>>>>
>>>> diff --git a/Documentation/media/uapi/v4l/dev-encoder.rst b/Documentation/media/uapi/v4l/dev-encoder.rst
>>>> new file mode 100644
>>>> index 000000000000..fb8b05a132ee
>>>> --- /dev/null
>>>> +++ b/Documentation/media/uapi/v4l/dev-encoder.rst
>>>> @@ -0,0 +1,586 @@
>>>> +.. -*- coding: utf-8; mode: rst -*-
>>>> +
>>>> +.. _encoder:
>>>> +
>>>> +*************************************************
>>>> +Memory-to-memory Stateful Video Encoder Interface
>>>> +*************************************************
>>>> +
>>>> +A stateful video encoder takes raw video frames in display order and encodes
>>>> +them into a bitstream. It generates complete chunks of the bitstream, including
>>>> +all metadata, headers, etc. The resulting bitstream does not require any
>>>> +further post-processing by the client.
>>>> +
>>>> +Performing software stream processing, header generation etc. in the driver
>>>> +in order to support this interface is strongly discouraged. In case such
>>>> +operations are needed, use of the Stateless Video Encoder Interface (in
>>>> +development) is strongly advised.
>>>> +
>>>> +Conventions and notation used in this document
>>>> +==============================================
>>>> +
>>>> +1. The general V4L2 API rules apply if not specified in this document
>>>> +   otherwise.
>>>> +
>>>> +2. The meaning of words "must", "may", "should", etc. is as per `RFC
>>>> +   2119 <https://tools.ietf.org/html/rfc2119>`_.
>>>> +
>>>> +3. All steps not marked "optional" are required.
>>>> +
>>>> +4. :c:func:`VIDIOC_G_EXT_CTRLS` and :c:func:`VIDIOC_S_EXT_CTRLS` may be used
>>>> +   interchangeably with :c:func:`VIDIOC_G_CTRL` and :c:func:`VIDIOC_S_CTRL`,
>>>> +   unless specified otherwise.
>>>> +
>>>> +5. Single-planar API (see :ref:`planar-apis`) and applicable structures may be
>>>> +   used interchangeably with multi-planar API, unless specified otherwise,
>>>> +   depending on decoder capabilities and following the general V4L2 guidelines.
>>>> +
>>>> +6. i = [a..b]: sequence of integers from a to b, inclusive, i.e. i =
>>>> +   [0..2]: i = 0, 1, 2.
>>>> +
>>>> +7. Given an ``OUTPUT`` buffer A, then A’ represents a buffer on the ``CAPTURE``
>>>> +   queue containing data that resulted from processing buffer A.
>>>> +
>>>> +Glossary
>>>> +========
>>>> +
>>>> +Refer to :ref:`decoder-glossary`.
>>>> +
>>>> +State machine
>>>> +=============
>>>> +
>>>> +.. kernel-render:: DOT
>>>> +   :alt: DOT digraph of encoder state machine
>>>> +   :caption: Encoder state machine
>>>> +
>>>> +   digraph encoder_state_machine {
>>>> +       node [shape = doublecircle, label="Encoding"] Encoding;
>>>> +
>>>> +       node [shape = circle, label="Initialization"] Initialization;
>>>> +       node [shape = circle, label="Stopped"] Stopped;
>>>> +       node [shape = circle, label="Drain"] Drain;
>>>> +       node [shape = circle, label="Reset"] Reset;
>>>> +
>>>> +       node [shape = point]; qi
>>>> +       qi -> Initialization [ label = "open()" ];
>>>> +
>>>> +       Initialization -> Encoding [ label = "Both queues streaming" ];
>>>> +
>>>> +       Encoding -> Drain [ label = "V4L2_DEC_CMD_STOP" ];
>>>> +       Encoding -> Reset [ label = "VIDIOC_STREAMOFF(CAPTURE)" ];
>>>> +       Encoding -> Stopped [ label = "VIDIOC_STREAMOFF(OUTPUT)" ];
>>>> +       Encoding -> Encoding;
>>>> +
>>>> +       Drain -> Stopped [ label = "All CAPTURE\nbuffers dequeued\nor\nVIDIOC_STREAMOFF(CAPTURE)" ];
>>>> +       Drain -> Reset [ label = "VIDIOC_STREAMOFF(CAPTURE)" ];
>>>> +
>>>> +       Reset -> Encoding [ label = "VIDIOC_STREAMON(CAPTURE)" ];
>>>> +       Reset -> Initialization [ label = "VIDIOC_REQBUFS(OUTPUT, 0)" ];
>>>> +
>>>> +       Stopped -> Encoding [ label = "V4L2_DEC_CMD_START\nor\nVIDIOC_STREAMON(OUTPUT)" ];
>>>> +       Stopped -> Reset [ label = "VIDIOC_STREAMOFF(CAPTURE)" ];
>>>> +   }
>>>> +
>>>> +Querying capabilities
>>>> +=====================
>>>> +
>>>> +1. To enumerate the set of coded formats supported by the encoder, the
>>>> +   client may call :c:func:`VIDIOC_ENUM_FMT` on ``CAPTURE``.
>>>> +
>>>> +   * The full set of supported formats will be returned, regardless of the
>>>> +     format set on ``OUTPUT``.
>>>> +
>>>> +2. To enumerate the set of supported raw formats, the client may call
>>>> +   :c:func:`VIDIOC_ENUM_FMT` on ``OUTPUT``.
>>>> +
>>>> +   * Only the formats supported for the format currently active on ``CAPTURE``
>>>> +     will be returned.
>>>> +
>>>> +   * In order to enumerate raw formats supported by a given coded format,
>>>> +     the client must first set that coded format on ``CAPTURE`` and then
>>>> +     enumerate the formats on ``OUTPUT``.
>>>> +
>>>> +3. The client may use :c:func:`VIDIOC_ENUM_FRAMESIZES` to detect supported
>>>> +   resolutions for a given format, passing desired pixel format in
>>>> +   :c:type:`v4l2_frmsizeenum` ``pixel_format``.
>>>> +
>>>> +   * Values returned by :c:func:`VIDIOC_ENUM_FRAMESIZES` for a coded pixel
>>>> +     format will include all possible coded resolutions supported by the
>>>> +     encoder for given coded pixel format.
>>>> +
>>>> +   * Values returned by :c:func:`VIDIOC_ENUM_FRAMESIZES` for a raw pixel format
>>>> +     will include all possible frame buffer resolutions supported by the
>>>> +     encoder for given raw pixel format and coded format currently set on
>>>> +     ``CAPTURE``.
>>>> +
>>>> +4. Supported profiles and levels for the coded format currently set on
>>>> +   ``CAPTURE``, if applicable, may be queried using their respective controls
>>>> +   via :c:func:`VIDIOC_QUERYCTRL`.
>>>> +
>>>> +5. Any additional encoder capabilities may be discovered by querying
>>>> +   their respective controls.
>>>> +
>>>> +Initialization
>>>> +==============
>>>> +
>>>> +1. Set the coded format on the ``CAPTURE`` queue via :c:func:`VIDIOC_S_FMT`
>>>> +
>>>> +   * **Required fields:**
>>>> +
>>>> +     ``type``
>>>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``CAPTURE``
>>>> +
>>>> +     ``pixelformat``
>>>> +         the coded format to be produced
>>>> +
>>>> +     ``sizeimage``
>>>> +         desired size of ``CAPTURE`` buffers; the encoder may adjust it to
>>>> +         match hardware requirements
>>>> +
>>>> +     ``width``, ``height``
>>>> +         ignored (always zero)
>>>> +
>>>> +     other fields
>>>> +         follow standard semantics
>>>> +
>>>> +   * **Return fields:**
>>>> +
>>>> +     ``sizeimage``
>>>> +         adjusted size of ``CAPTURE`` buffers
>>>> +
>>>> +   .. important::
>>>> +
>>>> +      Changing the ``CAPTURE`` format may change the currently set ``OUTPUT``
>>>> +      format. The encoder will derive a new ``OUTPUT`` format from the
>>>> +      ``CAPTURE`` format being set, including resolution, colorimetry
>>>> +      parameters, etc. If the client needs a specific ``OUTPUT`` format, it
>>>> +      must adjust it afterwards.
>>>
>>> Hmm, "including resolution": if width and height are set to 0, what should the
>>> OUTPUT resolution be? Up to the driver? I think this should be clarified since
>>> at a first reading of this paragraph it appears to be contradictory.
>>
>> I think the driver should just return the width and height of the OUTPUT
>> format. So the width and height that userspace specifies is just ignored
>> and replaced by the width and height of the OUTPUT format. After all, that's
>> what the bitstream will encode. Returning 0 for width and height would make
>> this a strange exception in V4L2 and I want to avoid that.
>>
> 
> Hmm, however, the width and height of the OUTPUT format is not what's
> actually encoded in the bitstream. The right selection rectangle
> determines that.
> 
> In one of the previous versions I though we could put the codec
> resolution as the width and height of the CAPTURE format, which would
> be the resolution of the encoded image rounded up to full macroblocks
> +/- some encoder-specific constraints. AFAIR there was some concern
> about OUTPUT format changes triggering CAPTURE format changes, but to
> be honest, I'm not sure if that's really a problem. I just decided to
> drop that for the simplicity.

I'm not sure what your point is.

The OUTPUT format has the coded resolution, so when you set the
CAPTURE format it can just copy the OUTPUT coded resolution unless the
chosen CAPTURE pixelformat can't handle that in which case both the
OUTPUT and CAPTURE coded resolutions are clamped to whatever is the maximum
or minimum the codec is capable of.

That said, I am fine with just leaving it up to the driver as suggested
before. Just as long as both the CAPTURE and OUTPUT formats remain valid
(i.e. width and height may never be out of range).

> 
>>>
>>>> +
>>>> +2. **Optional.** Enumerate supported ``OUTPUT`` formats (raw formats for
>>>> +   source) for the selected coded format via :c:func:`VIDIOC_ENUM_FMT`.
>>>> +
>>>> +   * **Required fields:**
>>>> +
>>>> +     ``type``
>>>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
>>>> +
>>>> +     other fields
>>>> +         follow standard semantics
>>>> +
>>>> +   * **Return fields:**
>>>> +
>>>> +     ``pixelformat``
>>>> +         raw format supported for the coded format currently selected on
>>>> +         the ``CAPTURE`` queue.
>>>> +
>>>> +     other fields
>>>> +         follow standard semantics
>>>> +
>>>> +3. Set the raw source format on the ``OUTPUT`` queue via
>>>> +   :c:func:`VIDIOC_S_FMT`.
>>>> +
>>>> +   * **Required fields:**
>>>> +
>>>> +     ``type``
>>>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
>>>> +
>>>> +     ``pixelformat``
>>>> +         raw format of the source
>>>> +
>>>> +     ``width``, ``height``
>>>> +         source resolution
>>>> +
>>>> +     other fields
>>>> +         follow standard semantics
>>>> +
>>>> +   * **Return fields:**
>>>> +
>>>> +     ``width``, ``height``
>>>> +         may be adjusted by encoder to match alignment requirements, as
>>>> +         required by the currently selected formats
>>>
>>> What if the width x height is larger than the maximum supported by the
>>> selected coded format? This should probably mention that in that case the
>>> width x height is reduced to the largest allowed value. Also mention that
>>> this maximum is reported by VIDIOC_ENUM_FRAMESIZES.
>>>
>>>> +
>>>> +     other fields
>>>> +         follow standard semantics
>>>> +
>>>> +   * Setting the source resolution will reset the selection rectangles to their
>>>> +     default values, based on the new resolution, as described in the step 5
>>>
>>> 5 -> 4
>>>
>>> Or just say: "as described in the next step."
>>>
>>>> +     below.
>>
>> It should also be made explicit that:
>>
>> 1) the crop rectangle will be set to the given width and height *before*
>> it is being adjusted by S_FMT.
>>
> 
> I don't think that's what we want here.
> 
> Defining the default rectangle to be exactly the same as the OUTPUT
> resolution (after the adjustment) makes the semantics consistent - not
> setting the crop rectangle gives you exactly the behavior as if there
> was no cropping involved (or supported by the encoder).

I think you are right. This seems to be what the coda driver does as well.
It is convenient to be able to just set a 1920x1080 format and have that
resolution be stored as the crop rectangle, since it avoids having to call
s_selection afterwards, but it is not really consistent with the way V4L2
works.

> 
>> Open question: should we support a compose rectangle for the CAPTURE that
>> is the same as the OUTPUT crop rectangle? I.e. the CAPTURE format contains
>> the adjusted width and height and the compose rectangle (read-only) contains
>> the visible width and height. It's not strictly necessary, but it is
>> symmetrical.
> 
> Wouldn't it rather be the CAPTURE crop rectangle that would be of the
> same resolution of the OUTPUT compose rectangle? Then you could
> actually have the CAPTURE compose rectangle for putting that into the
> desired rectangle of the encoded stream, if the encoder supports that.
> (I don't know any that does, so probably out of concern for now.)

Yes, you are right.

But should we support this?

I actually think not for this initial version. It can be added later, I guess.

> 
>>
>> 2) the CAPTURE format will be updated as well with the new OUTPUT width and
>> height. The CAPTURE sizeimage might change as well.
>>
>>>> +
>>>> +4. **Optional.** Set the visible resolution for the stream metadata via
>>>> +   :c:func:`VIDIOC_S_SELECTION` on the ``OUTPUT`` queue.
>>
>> I think you should mention that this is only necessary if the crop rectangle
>> that is set when you set the format isn't what you want.
>>
> 
> Ack.
> 
>>>> +
>>>> +   * **Required fields:**
>>>> +
>>>> +     ``type``
>>>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
>>>> +
>>>> +     ``target``
>>>> +         set to ``V4L2_SEL_TGT_CROP``
>>>> +
>>>> +     ``r.left``, ``r.top``, ``r.width``, ``r.height``
>>>> +         visible rectangle; this must fit within the `V4L2_SEL_TGT_CROP_BOUNDS`
>>>> +         rectangle and may be subject to adjustment to match codec and
>>>> +         hardware constraints
>>>> +
>>>> +   * **Return fields:**
>>>> +
>>>> +     ``r.left``, ``r.top``, ``r.width``, ``r.height``
>>>> +         visible rectangle adjusted by the encoder
>>>> +
>>>> +   * The following selection targets are supported on ``OUTPUT``:
>>>> +
>>>> +     ``V4L2_SEL_TGT_CROP_BOUNDS``
>>>> +         equal to the full source frame, matching the active ``OUTPUT``
>>>> +         format
>>>> +
>>>> +     ``V4L2_SEL_TGT_CROP_DEFAULT``
>>>> +         equal to ``V4L2_SEL_TGT_CROP_BOUNDS``
>>>> +
>>>> +     ``V4L2_SEL_TGT_CROP``
>>>> +         rectangle within the source buffer to be encoded into the
>>>> +         ``CAPTURE`` stream; defaults to ``V4L2_SEL_TGT_CROP_DEFAULT``
>>>> +
>>>> +         .. note::
>>>> +
>>>> +            A common use case for this selection target is encoding a source
>>>> +            video with a resolution that is not a multiple of a macroblock,
>>>> +            e.g.  the common 1920x1080 resolution may require the source
>>>> +            buffers to be aligned to 1920x1088 for codecs with 16x16 macroblock
>>>> +            size. To avoid encoding the padding, the client needs to explicitly
>>>> +            configure this selection target to 1920x1080.
>>
>> This last sentence contradicts the proposed behavior of S_FMT(OUTPUT).
>>
> 
> Sorry, which part exactly and what part of the proposal exactly? :)
> (My comment above might be related, though.)

Ignore my comment. We go back to explicitly requiring userspace to set the OUTPUT
crop selection target, so this note remains valid.

> 
>>>> +
>>>> +     ``V4L2_SEL_TGT_COMPOSE_BOUNDS``
>>>> +         maximum rectangle within the coded resolution, which the cropped
>>>> +         source frame can be composed into; if the hardware does not support
>>>> +         composition or scaling, then this is always equal to the rectangle of
>>>> +         width and height matching ``V4L2_SEL_TGT_CROP`` and located at (0, 0)
>>>> +
>>>> +     ``V4L2_SEL_TGT_COMPOSE_DEFAULT``
>>>> +         equal to a rectangle of width and height matching
>>>> +         ``V4L2_SEL_TGT_CROP`` and located at (0, 0)
>>>> +
>>>> +     ``V4L2_SEL_TGT_COMPOSE``
>>>> +         rectangle within the coded frame, which the cropped source frame
>>>> +         is to be composed into; defaults to
>>>> +         ``V4L2_SEL_TGT_COMPOSE_DEFAULT``; read-only on hardware without
>>>> +         additional compose/scaling capabilities; resulting stream will
>>>> +         have this rectangle encoded as the visible rectangle in its
>>>> +         metadata
>>
>> I think the compose targets for OUTPUT are only needed if the hardware can
>> actually do scaling and/or composition. Otherwise they can (must?) be
>> dropped.
>>
> 
> Note that V4L2_SEL_TGT_COMPOSE is defined to be the way for the
> userspace to learn the target visible rectangle that's going to be
> encoded in the stream metadata. If we omit it, we wouldn't have a way
> that would be consistent between encoders that can do
> scaling/composition and those that can't.

I'm not convinced about this. The standard API behavior is not to expose
functionality that the hardware can't do. So if scaling isn't possible on
the OUTPUT side, then it shouldn't expose OUTPUT compose rectangles.

I also believe it very unlikely that we'll see encoders capable of scaling
as it doesn't make much sense. I would prefer to drop this to simplify the
spec, and when we get encoders that can scale, then we can add support for
compose rectangles (and I'm sure we'll need to think about how that
influences the CAPTURE side as well).

For encoders without scaling it is the OUTPUT crop rectangle that defines
the visible rectangle.

> 
> However, with your proposal of actually having selection rectangles
> for the CAPTURE queue, it could be solved indeed. The OUTPUT queue
> would expose a varying set of rectangles, depending on the hardware
> capability, while the CAPTURE queue would always expose its rectangle
> with that information.

I think we should keep it simple and only define selection rectangles
when really needed.

So encoders support CROP on the OUTPUT, and decoders support CAPTURE
COMPOSE (may be read-only). Nothing else.

Once support for scaling is needed (either on the encoder or decoder
side), then the spec should be enhanced. But I prefer to postpone that
until we actually have hardware that needs this.

> 
>>>> +
>>>> +   .. warning::
>>>> +
>>>> +      The encoder may adjust the crop/compose rectangles to the nearest
>>>> +      supported ones to meet codec and hardware requirements. The client needs
>>>> +      to check the adjusted rectangle returned by :c:func:`VIDIOC_S_SELECTION`.
>>>> +
>>>> +5. Allocate buffers for both ``OUTPUT`` and ``CAPTURE`` via
>>>> +   :c:func:`VIDIOC_REQBUFS`. This may be performed in any order.
>>>> +
>>>> +   * **Required fields:**
>>>> +
>>>> +     ``count``
>>>> +         requested number of buffers to allocate; greater than zero
>>>> +
>>>> +     ``type``
>>>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT`` or
>>>> +         ``CAPTURE``
>>>> +
>>>> +     other fields
>>>> +         follow standard semantics
>>>> +
>>>> +   * **Return fields:**
>>>> +
>>>> +     ``count``
>>>> +          actual number of buffers allocated
>>>> +
>>>> +   .. warning::
>>>> +
>>>> +      The actual number of allocated buffers may differ from the ``count``
>>>> +      given. The client must check the updated value of ``count`` after the
>>>> +      call returns.
>>>> +
>>>> +   .. note::
>>>> +
>>>> +      To allocate more than the minimum number of OUTPUT buffers (for pipeline
>>>> +      depth), the client may query the ``V4L2_CID_MIN_BUFFERS_FOR_OUTPUT``
>>>> +      control to get the minimum number of buffers required, and pass the
>>>> +      obtained value plus the number of additional buffers needed in the
>>>> +      ``count`` field to :c:func:`VIDIOC_REQBUFS`.
>>>> +
>>>> +   Alternatively, :c:func:`VIDIOC_CREATE_BUFS` can be used to have more
>>>> +   control over buffer allocation.
>>>> +
>>>> +   * **Required fields:**
>>>> +
>>>> +     ``count``
>>>> +         requested number of buffers to allocate; greater than zero
>>>> +
>>>> +     ``type``
>>>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
>>>> +
>>>> +     other fields
>>>> +         follow standard semantics
>>>> +
>>>> +   * **Return fields:**
>>>> +
>>>> +     ``count``
>>>> +         adjusted to the number of allocated buffers
>>>> +
>>>> +6. Begin streaming on both ``OUTPUT`` and ``CAPTURE`` queues via
>>>> +   :c:func:`VIDIOC_STREAMON`. This may be performed in any order. The actual
>>>> +   encoding process starts when both queues start streaming.
>>>> +
>>>> +.. note::
>>>> +
>>>> +   If the client stops the ``CAPTURE`` queue during the encode process and then
>>>> +   restarts it again, the encoder will begin generating a stream independent
>>>> +   from the stream generated before the stop. The exact constraints depend
>>>> +   on the coded format, but may include the following implications:
>>>> +
>>>> +   * encoded frames produced after the restart must not reference any
>>>> +     frames produced before the stop, e.g. no long term references for
>>>> +     H.264,
>>>> +
>>>> +   * any headers that must be included in a standalone stream must be
>>>> +     produced again, e.g. SPS and PPS for H.264.
>>>> +
>>>> +Encoding
>>>> +========
>>>> +
>>>> +This state is reached after the `Initialization` sequence finishes
>>>> +successfully.  In this state, the client queues and dequeues buffers to both
>>>> +queues via :c:func:`VIDIOC_QBUF` and :c:func:`VIDIOC_DQBUF`, following the
>>>> +standard semantics.
>>>> +
>>>> +The contents of encoded ``CAPTURE`` buffers depend on the active coded pixel
>>>> +format and may be affected by codec-specific extended controls, as stated
>>>> +in the documentation of each format.
>>>> +
>>>> +Both queues operate independently, following standard behavior of V4L2 buffer
>>>> +queues and memory-to-memory devices. In addition, the order of encoded frames
>>>> +dequeued from the ``CAPTURE`` queue may differ from the order of queuing raw
>>>> +frames to the ``OUTPUT`` queue, due to properties of the selected coded format,
>>>> +e.g. frame reordering.
>>>> +
>>>> +The client must not assume any direct relationship between ``CAPTURE`` and
>>>> +``OUTPUT`` buffers and any specific timing of buffers becoming
>>>> +available to dequeue. Specifically:
>>>> +
>>>> +* a buffer queued to ``OUTPUT`` may result in more than 1 buffer produced on
>>>> +  ``CAPTURE`` (if returning an encoded frame allowed the encoder to return a
>>>> +  frame that preceded it in display, but succeeded it in the decode order),
>>>> +
>>>> +* a buffer queued to ``OUTPUT`` may result in a buffer being produced on
>>>> +  ``CAPTURE`` later into encode process, and/or after processing further
>>>> +  ``OUTPUT`` buffers, or be returned out of order, e.g. if display
>>>> +  reordering is used,
>>>> +
>>>> +* buffers may become available on the ``CAPTURE`` queue without additional
>>>> +  buffers queued to ``OUTPUT`` (e.g. during drain or ``EOS``), because of the
>>>> +  ``OUTPUT`` buffers queued in the past whose decoding results are only
>>>> +  available at later time, due to specifics of the decoding process,
>>>> +
>>>> +* buffers queued to ``OUTPUT`` may not become available to dequeue instantly
>>>> +  after being encoded into a corresponding ``CATPURE`` buffer, e.g. if the
>>>> +  encoder needs to use the frame as a reference for encoding further frames.
>>>> +
>>>> +.. note::
>>>> +
>>>> +   To allow matching encoded ``CAPTURE`` buffers with ``OUTPUT`` buffers they
>>>> +   originated from, the client can set the ``timestamp`` field of the
>>>> +   :c:type:`v4l2_buffer` struct when queuing an ``OUTPUT`` buffer. The
>>>> +   ``CAPTURE`` buffer(s), which resulted from encoding that ``OUTPUT`` buffer
>>>> +   will have their ``timestamp`` field set to the same value when dequeued.
>>>> +
>>>> +   In addition to the straightforward case of one ``OUTPUT`` buffer producing
>>>> +   one ``CAPTURE`` buffer, the following cases are defined:
>>>> +
>>>> +   * one ``OUTPUT`` buffer generates multiple ``CAPTURE`` buffers: the same
>>>> +     ``OUTPUT`` timestamp will be copied to multiple ``CAPTURE`` buffers,
>>>> +
>>>> +   * the encoding order differs from the presentation order (i.e. the
>>>> +     ``CAPTURE`` buffers are out-of-order compared to the ``OUTPUT`` buffers):
>>>> +     ``CAPTURE`` timestamps will not retain the order of ``OUTPUT`` timestamps
>>>> +     and thus monotonicity of the timestamps cannot be guaranteed.
>>>
>>> Drop "and thus monotonicity of the timestamps cannot be guaranteed": this was never
>>> guaranteed since timestamps are just copied from OUTPUT to CAPTURE.
>>>
>>> This phrase doesn't occur in the decoder spec, so it should be removed here as well.
>>>
>>>> +
>>>> +.. note::
>>>> +
>>>> +   To let the client distinguish between frame types (keyframes, intermediate
>>>> +   frames; the exact list of types depends on the coded format), the
>>>> +   ``CAPTURE`` buffers will have corresponding flag bits set in their
>>>> +   :c:type:`v4l2_buffer` struct when dequeued. See the documentation of
>>>> +   :c:type:`v4l2_buffer` and each coded pixel format for exact list of flags
>>>> +   and their meanings.
>>>> +
>>>> +Encoding parameter changes
>>>> +==========================
>>>> +
>>>> +The client is allowed to use :c:func:`VIDIOC_S_CTRL` to change encoder
>>>> +parameters at any time. The availability of parameters is encoder-specific
>>>> +and the client must query the encoder to find the set of available controls.
>>>> +
>>>> +The ability to change each parameter during encoding is encoder-specific, as
>>>> +per the standard semantics of the V4L2 control interface. The client may
>>>> +attempt to set a control during encoding and if the operation fails with the
>>>> +-EBUSY error code, the ``CAPTURE`` queue needs to be stopped for the
>>>> +configuration change to be allowed. To do this, it may follow the `Drain`
>>>> +sequence to avoid losing the already queued/encoded frames.
>>>> +
>>>> +The timing of parameter updates is encoder-specific, as per the standard
>>>> +semantics of the V4L2 control interface. If the client needs to apply the
>>>> +parameters exactly at specific frame, using the Request API
>>>> +(:ref:`media-request-api`) should be considered, if supported by the encoder.
>>>> +
>>>> +Drain
>>>> +=====
>>>> +
>>>> +To ensure that all the queued ``OUTPUT`` buffers have been processed and the
>>>> +related ``CAPTURE`` buffers are given to the client, the client must follow the
>>>> +drain sequence described below. After the drain sequence ends, the client has
>>>> +received all encoded frames for all ``OUTPUT`` buffers queued before the
>>>> +sequence was started.
>>>> +
>>>> +1. Begin the drain sequence by issuing :c:func:`VIDIOC_ENCODER_CMD`.
>>>> +
>>>> +   * **Required fields:**
>>>> +
>>>> +     ``cmd``
>>>> +         set to ``V4L2_ENC_CMD_STOP``
>>>> +
>>>> +     ``flags``
>>>> +         set to 0
>>>> +
>>>> +     ``pts``
>>>> +         set to 0
>>>> +
>>>> +   .. warning::
>>>> +
>>>> +      The sequence can be only initiated if both ``OUTPUT`` and ``CAPTURE``
>>>> +      queues are streaming. For compatibility reasons, the call to
>>>> +      :c:func:`VIDIOC_ENCODER_CMD` will not fail even if any of the queues is
>>>> +      not streaming, but at the same time it will not initiate the `Drain`
>>>> +      sequence and so the steps described below would not be applicable.
>>>> +
>>>> +2. Any ``OUTPUT`` buffers queued by the client before the
>>>> +   :c:func:`VIDIOC_ENCODER_CMD` was issued will be processed and encoded as
>>>> +   normal. The client must continue to handle both queues independently,
>>>> +   similarly to normal encode operation. This includes:
>>>> +
>>>> +   * queuing and dequeuing ``CAPTURE`` buffers, until a buffer marked with the
>>>> +     ``V4L2_BUF_FLAG_LAST`` flag is dequeued,
>>>> +
>>>> +     .. warning::
>>>> +
>>>> +        The last buffer may be empty (with :c:type:`v4l2_buffer`
>>>> +        ``bytesused`` = 0) and in that case it must be ignored by the client,
>>>> +        as it does not contain an encoded frame.
>>>> +
>>>> +     .. note::
>>>> +
>>>> +        Any attempt to dequeue more buffers beyond the buffer marked with
>>>> +        ``V4L2_BUF_FLAG_LAST`` will result in a -EPIPE error from
>>>> +        :c:func:`VIDIOC_DQBUF`.
>>>> +
>>>> +   * dequeuing processed ``OUTPUT`` buffers, until all the buffers queued
>>>> +     before the ``V4L2_ENC_CMD_STOP`` command are dequeued,
>>>> +
>>>> +   * dequeuing the ``V4L2_EVENT_EOS`` event, if the client subscribes to it.
>>>> +
>>>> +   .. note::
>>>> +
>>>> +      For backwards compatibility, the encoder will signal a ``V4L2_EVENT_EOS``
>>>> +      event when the last frame has been decoded and all frames are ready to be
>>>> +      dequeued. It is deprecated behavior and the client must not rely on it.
>>>> +      The ``V4L2_BUF_FLAG_LAST`` buffer flag should be used instead.
>>>> +
>>>> +3. Once all ``OUTPUT`` buffers queued before the ``V4L2_ENC_CMD_STOP`` call are
>>>> +   dequeued and the last ``CAPTURE`` buffer is dequeued, the encoder is stopped
>>>> +   and it will accept, but not process any newly queued ``OUTPUT`` buffers
>>>> +   until the client issues any of the following operations:
>>>> +
>>>> +   * ``V4L2_ENC_CMD_START`` - the encoder will not be reset and will resume
>>>> +     operation normally, with all the state from before the drain,
>>>> +
>>>> +   * a pair of :c:func:`VIDIOC_STREAMOFF` and :c:func:`VIDIOC_STREAMON` on the
>>>> +     ``CAPTURE`` queue - the encoder will be reset (see the `Reset` sequence)
>>>> +     and then resume encoding,
>>>> +
>>>> +   * a pair of :c:func:`VIDIOC_STREAMOFF` and :c:func:`VIDIOC_STREAMON` on the
>>>> +     ``OUTPUT`` queue - the encoder will resume operation normally, however any
>>>> +     source frames queued to the ``OUTPUT`` queue between ``V4L2_ENC_CMD_STOP``
>>>> +     and :c:func:`VIDIOC_STREAMOFF` will be discarded.
>>>> +
>>>> +.. note::
>>>> +
>>>> +   Once the drain sequence is initiated, the client needs to drive it to
>>>> +   completion, as described by the steps above, unless it aborts the process by
>>>> +   issuing :c:func:`VIDIOC_STREAMOFF` on any of the ``OUTPUT`` or ``CAPTURE``
>>>> +   queues.  The client is not allowed to issue ``V4L2_ENC_CMD_START`` or
>>>> +   ``V4L2_ENC_CMD_STOP`` again while the drain sequence is in progress and they
>>>> +   will fail with -EBUSY error code if attempted.
>>>> +
>>>> +   Although mandatory, the availability of encoder commands may be queried
>>>> +   using :c:func:`VIDIOC_TRY_ENCODER_CMD`.
>>>> +
>>>> +Reset
>>>> +=====
>>>> +
>>>> +The client may want to request the encoder to reinitialize the encoding, so
>>>> +that the following stream data becomes independent from the stream data
>>>> +generated before. Depending on the coded format, that may imply that:
>>>> +
>>>> +* encoded frames produced after the restart must not reference any frames
>>>> +  produced before the stop, e.g. no long term references for H.264,
>>>> +
>>>> +* any headers that must be included in a standalone stream must be produced
>>>> +  again, e.g. SPS and PPS for H.264.
>>>> +
>>>> +This can be achieved by performing the reset sequence.
>>>> +
>>>> +1. Perform the `Drain` sequence to ensure all the in-flight encoding finishes
>>>> +   and respective buffers are dequeued.
>>>> +
>>>> +2. Stop streaming on the ``CAPTURE`` queue via :c:func:`VIDIOC_STREAMOFF`. This
>>>> +   will return all currently queued ``CAPTURE`` buffers to the client, without
>>>> +   valid frame data.
>>>> +
>>>> +3. Start streaming on the ``CAPTURE`` queue via :c:func:`VIDIOC_STREAMON` and
>>>> +   continue with regular encoding sequence. The encoded frames produced into
>>>> +   ``CAPTURE`` buffers from now on will contain a standalone stream that can be
>>>> +   decoded without the need for frames encoded before the reset sequence,
>>>> +   starting at the first ``OUTPUT`` buffer queued after issuing the
>>>> +   `V4L2_ENC_CMD_STOP` of the `Drain` sequence.
>>>> +
>>>> +This sequence may be also used to change encoding parameters for encoders
>>>> +without the ability to change the parameters on the fly.
>>>> +
>>>> +Commit points
>>>> +=============
>>>> +
>>>> +Setting formats and allocating buffers triggers changes in the behavior of the
>>>> +encoder.
>>>> +
>>>> +1. Setting the format on the ``CAPTURE`` queue may change the set of formats
>>>> +   supported/advertised on the ``OUTPUT`` queue. In particular, it also means
>>>> +   that the ``OUTPUT`` format may be reset and the client must not rely on the
>>>> +   previously set format being preserved.
>>>> +
>>>> +2. Enumerating formats on the ``OUTPUT`` queue always returns only formats
>>>> +   supported for the current ``CAPTURE`` format.
>>>> +
>>>> +3. Setting the format on the ``OUTPUT`` queue does not change the list of
>>>> +   formats available on the ``CAPTURE`` queue. An attempt to set the ``OUTPUT``
>>>> +   format that is not supported for the currently selected ``CAPTURE`` format
>>>> +   will result in the encoder adjusting the requested ``OUTPUT`` format to a
>>>> +   supported one.
>>>> +
>>>> +4. Enumerating formats on the ``CAPTURE`` queue always returns the full set of
>>>> +   supported coded formats, irrespectively of the current ``OUTPUT`` format.
>>>
>>> irrespectively -> irrespective
>>>
>>>> +
>>>> +5. While buffers are allocated on the ``CAPTURE`` queue, the client must not
>>>> +   change the format on the queue. Drivers will return the -EBUSY error code
>>
>> Change the format on which queue? CAPTURE or OUTPUT?
> 
> CAPTURE was intended here. One should be able to change the format on
> OUTPUT freely.

Ack.

> 
>>
>> I think this should be more precise: changing the CAPTURE format will always
>> fail if CAPTURE buffers are already allocated, or if the OUTPUT is streaming,
>> or if changing the CAPTURE format will change the OUTPUT format and OUTPUT
>> buffers are already allocated.
> 
> Indeed. I believe we can generalize this to:
> 
> 5. While buffers are allocated on any of the ``OUTPUT`` or ``CAPTURE`` queues,
>    the client must not change the format on the ``CAPTURE`` queue. Drivers will
>    return the -EBUSY error code for any such format change attempt.

Sounds good.

> 
>>
>> Changing the OUTPUT format will always fail if OUTPUT buffers are already allocated,
>> or if changing the OUTPUT format would change the CAPTURE format (sizeimage in
>> particular) and CAPTURE buffers were already allocated and are too small.
> 
> The OUTPUT format must not change the CAPTURE format by definition.
> Otherwise we end up in a situation where we can't commit, because both
> queue formats can affect each other. Any change to the OUTPUT format
> that wouldn't work with the current CAPTURE format should be adjusted
> by the driver to match the current CAPTURE format.

But the CAPTURE format *does* depend on the OUTPUT format: if the output
resolution changes, then so does the CAPTURE resolution and esp. the
sizeimage value, since that is typically resolution dependent.

The coda driver does this as well: changing the output resolution
will update the capture resolution and sizeimage. The vicodec driver does the
same.

Setting the CAPTURE format basically just selects the codec to use, after
that you can set the OUTPUT format and read the updated CAPTURE format to
get the new sizeimage value. In fact, setting the CAPTURE format shouldn't
change the OUTPUT format, unless the OUTPUT format is incompatible with the
newly selected codec.

Regards,

	Hans
