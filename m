Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59121C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6A320880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfDHHnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:43:22 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:52266 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725871AbfDHHnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:43:22 -0400
Received: from [IPv6:2001:983:e9a7:1:1170:5c87:411e:5806] ([IPv6:2001:983:e9a7:1:1170:5c87:411e:5806])
        by smtp-cloud7.xs4all.net with ESMTPA
        id DOvxhRmkZNG8zDOvyhk304; Mon, 08 Apr 2019 09:43:17 +0200
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
 <7dc32e83-dec3-37d6-9bfe-e162c495dcf3@xs4all.nl>
 <CAAFQd5APTQNdH0wbAJpkBO+spXT=dK3e=egv3648bGNPw5-bJA@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <515c409c-dfe9-d5dc-33e2-f8dcf5eb9cef@xs4all.nl>
Date:   Mon, 8 Apr 2019 09:43:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5APTQNdH0wbAJpkBO+spXT=dK3e=egv3648bGNPw5-bJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEz3dJjyydRfQLDoAB2FLEnLyIcwJZbDSMJ5y+5yEcfFwco7jXRdl2aORiGET0eDlQKoVDqJudPmb0Ed06hDJopsaHLKYbCwGem3swSByHl++YIi8CDh
 dWea9/gDagVworyLBaPtXG6XSTgSfQHPu1S+HInW35cvZmykYgBveO5FWqwTDpO/N9s4+jo/dfzah1mRy3dkiz5KpfBR9QNqIPD+oYQQgLmNw04aXSRITfFy
 ibQU17GRRWf8HwtK5/6RCnjej9fpevyX/wZu5+Hjg4kCV0T1BD5KZu/au4JOJ1Dn+R/eL4GbUE6LYGmETNt3Qo29xKWowrexTRFMYkLpyRwMxKAM0enz3FLb
 7rLw29T8C1gu2Udes/u4GEu27AGSqlD7rUn5ZiFvEZ1ZJrZAdbm+sHkdmCD6ThRIfF+tBYTbmaC26bXeB8CEzuG38dtPBzoCvNAXps+iKv5bY0jyy2lp12fd
 mNjxHY1xCMA7E9Gj11DaebCHnhasxUFLwdt6eC4wDB2KJx2/bAxOS/5or6W1vwon93hevntyRkzCdeu4WieDGzZS2+2zYwX31GQllkc43KvOQKfzIPpxZ6YK
 5MAriX5bNOEbQjT9caSv980kivJxWIZfAKvYmK3jO4yywsd7pOWGIepZjEdnYlNyRs1cpbwycn+GZ3ommIf6uh+ujhNhNOxOEfkzWA8LTbycuuI4bEj2J3vM
 eC75cVvZGEgqj3dvKK3Ktc1Q8hsLv1W2fsXBLnq0P/U7h/5xStpl5/sMmoG/Id/JRDQSChqlmtJm0y2793IgFjzkJol5+nV/5mXBknrX4d3JUv/z562gJryx
 O37Wg2hY9VuPUxsQ9Hyiru7TCeTPnXGA5k600pMiZZJOxpkTGM+oQAtKY8EwZqwY3RuD3chfuOp6fDCFAeI8EgEkXWdC+jmmaY7acw0CFc8Mdk3r+7qyqrf5
 bqlhxEUtMW33KzJ2sORcX7gOUOO6tEYvlPh2QVEhCKAAYGPf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/19 8:59 AM, Tomasz Figa wrote:
> On Thu, Mar 21, 2019 at 7:11 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>
>> Hi Tomasz,
>>
>> A few more comments:
>>
>> On 1/24/19 11:04 AM, Tomasz Figa wrote:
>>> Due to complexity of the video encoding process, the V4L2 drivers of
>>> stateful encoder hardware require specific sequences of V4L2 API calls
>>> to be followed. These include capability enumeration, initialization,
>>> encoding, encode parameters change, drain and reset.
>>>
>>> Specifics of the above have been discussed during Media Workshops at
>>> LinuxCon Europe 2012 in Barcelona and then later Embedded Linux
>>> Conference Europe 2014 in Düsseldorf. The de facto Codec API that
>>> originated at those events was later implemented by the drivers we already
>>> have merged in mainline, such as s5p-mfc or coda.
>>>
>>> The only thing missing was the real specification included as a part of
>>> Linux Media documentation. Fix it now and document the encoder part of
>>> the Codec API.
>>>
>>> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
>>> ---
>>>  Documentation/media/uapi/v4l/dev-encoder.rst  | 586 ++++++++++++++++++
>>>  Documentation/media/uapi/v4l/dev-mem2mem.rst  |   1 +
>>>  Documentation/media/uapi/v4l/pixfmt-v4l2.rst  |   5 +
>>>  Documentation/media/uapi/v4l/v4l2.rst         |   2 +
>>>  .../media/uapi/v4l/vidioc-encoder-cmd.rst     |  38 +-
>>>  5 files changed, 617 insertions(+), 15 deletions(-)
>>>  create mode 100644 Documentation/media/uapi/v4l/dev-encoder.rst
>>>
>>> diff --git a/Documentation/media/uapi/v4l/dev-encoder.rst b/Documentation/media/uapi/v4l/dev-encoder.rst
>>> new file mode 100644
>>> index 000000000000..fb8b05a132ee
>>> --- /dev/null
>>> +++ b/Documentation/media/uapi/v4l/dev-encoder.rst
>>> @@ -0,0 +1,586 @@
>>> +.. -*- coding: utf-8; mode: rst -*-
>>> +
>>> +.. _encoder:
>>> +
>>> +*************************************************
>>> +Memory-to-memory Stateful Video Encoder Interface
>>> +*************************************************
>>> +
>>> +A stateful video encoder takes raw video frames in display order and encodes
>>> +them into a bitstream. It generates complete chunks of the bitstream, including
>>> +all metadata, headers, etc. The resulting bitstream does not require any
>>> +further post-processing by the client.
>>> +
>>> +Performing software stream processing, header generation etc. in the driver
>>> +in order to support this interface is strongly discouraged. In case such
>>> +operations are needed, use of the Stateless Video Encoder Interface (in
>>> +development) is strongly advised.
>>> +
>>> +Conventions and notation used in this document
>>> +==============================================
>>> +
>>> +1. The general V4L2 API rules apply if not specified in this document
>>> +   otherwise.
>>> +
>>> +2. The meaning of words "must", "may", "should", etc. is as per `RFC
>>> +   2119 <https://tools.ietf.org/html/rfc2119>`_.
>>> +
>>> +3. All steps not marked "optional" are required.
>>> +
>>> +4. :c:func:`VIDIOC_G_EXT_CTRLS` and :c:func:`VIDIOC_S_EXT_CTRLS` may be used
>>> +   interchangeably with :c:func:`VIDIOC_G_CTRL` and :c:func:`VIDIOC_S_CTRL`,
>>> +   unless specified otherwise.
>>> +
>>> +5. Single-planar API (see :ref:`planar-apis`) and applicable structures may be
>>> +   used interchangeably with multi-planar API, unless specified otherwise,
>>> +   depending on decoder capabilities and following the general V4L2 guidelines.
>>
>> decoder -> encoder
>>
> 
> Ack.
> 
>>> +
>>> +6. i = [a..b]: sequence of integers from a to b, inclusive, i.e. i =
>>> +   [0..2]: i = 0, 1, 2.
>>> +
>>> +7. Given an ``OUTPUT`` buffer A, then A’ represents a buffer on the ``CAPTURE``
>>> +   queue containing data that resulted from processing buffer A.
>>> +
>>> +Glossary
>>> +========
>>> +
>>> +Refer to :ref:`decoder-glossary`.
>>> +
>>> +State machine
>>> +=============
>>> +
>>> +.. kernel-render:: DOT
>>> +   :alt: DOT digraph of encoder state machine
>>> +   :caption: Encoder state machine
>>> +
>>> +   digraph encoder_state_machine {
>>> +       node [shape = doublecircle, label="Encoding"] Encoding;
>>> +
>>> +       node [shape = circle, label="Initialization"] Initialization;
>>> +       node [shape = circle, label="Stopped"] Stopped;
>>> +       node [shape = circle, label="Drain"] Drain;
>>> +       node [shape = circle, label="Reset"] Reset;
>>> +
>>> +       node [shape = point]; qi
>>> +       qi -> Initialization [ label = "open()" ];
>>> +
>>> +       Initialization -> Encoding [ label = "Both queues streaming" ];
>>> +
>>> +       Encoding -> Drain [ label = "V4L2_DEC_CMD_STOP" ];
>>> +       Encoding -> Reset [ label = "VIDIOC_STREAMOFF(CAPTURE)" ];
>>> +       Encoding -> Stopped [ label = "VIDIOC_STREAMOFF(OUTPUT)" ];
>>> +       Encoding -> Encoding;
>>> +
>>> +       Drain -> Stopped [ label = "All CAPTURE\nbuffers dequeued\nor\nVIDIOC_STREAMOFF(CAPTURE)" ];
>>> +       Drain -> Reset [ label = "VIDIOC_STREAMOFF(CAPTURE)" ];
>>> +
>>> +       Reset -> Encoding [ label = "VIDIOC_STREAMON(CAPTURE)" ];
>>> +       Reset -> Initialization [ label = "VIDIOC_REQBUFS(OUTPUT, 0)" ];
>>> +
>>> +       Stopped -> Encoding [ label = "V4L2_DEC_CMD_START\nor\nVIDIOC_STREAMON(OUTPUT)" ];
>>> +       Stopped -> Reset [ label = "VIDIOC_STREAMOFF(CAPTURE)" ];
>>> +   }
>>> +
>>> +Querying capabilities
>>> +=====================
>>> +
>>> +1. To enumerate the set of coded formats supported by the encoder, the
>>> +   client may call :c:func:`VIDIOC_ENUM_FMT` on ``CAPTURE``.
>>> +
>>> +   * The full set of supported formats will be returned, regardless of the
>>> +     format set on ``OUTPUT``.
>>> +
>>> +2. To enumerate the set of supported raw formats, the client may call
>>> +   :c:func:`VIDIOC_ENUM_FMT` on ``OUTPUT``.
>>> +
>>> +   * Only the formats supported for the format currently active on ``CAPTURE``
>>> +     will be returned.
>>> +
>>> +   * In order to enumerate raw formats supported by a given coded format,
>>> +     the client must first set that coded format on ``CAPTURE`` and then
>>> +     enumerate the formats on ``OUTPUT``.
>>> +
>>> +3. The client may use :c:func:`VIDIOC_ENUM_FRAMESIZES` to detect supported
>>> +   resolutions for a given format, passing desired pixel format in
>>> +   :c:type:`v4l2_frmsizeenum` ``pixel_format``.
>>> +
>>> +   * Values returned by :c:func:`VIDIOC_ENUM_FRAMESIZES` for a coded pixel
>>> +     format will include all possible coded resolutions supported by the
>>> +     encoder for given coded pixel format.
>>> +
>>> +   * Values returned by :c:func:`VIDIOC_ENUM_FRAMESIZES` for a raw pixel format
>>> +     will include all possible frame buffer resolutions supported by the
>>> +     encoder for given raw pixel format and coded format currently set on
>>> +     ``CAPTURE``.
>>> +
>>> +4. Supported profiles and levels for the coded format currently set on
>>> +   ``CAPTURE``, if applicable, may be queried using their respective controls
>>> +   via :c:func:`VIDIOC_QUERYCTRL`.
>>> +
>>> +5. Any additional encoder capabilities may be discovered by querying
>>> +   their respective controls.
>>> +
>>> +Initialization
>>> +==============
>>> +
>>> +1. Set the coded format on the ``CAPTURE`` queue via :c:func:`VIDIOC_S_FMT`
>>> +
>>> +   * **Required fields:**
>>> +
>>> +     ``type``
>>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``CAPTURE``
>>> +
>>> +     ``pixelformat``
>>> +         the coded format to be produced
>>> +
>>> +     ``sizeimage``
>>> +         desired size of ``CAPTURE`` buffers; the encoder may adjust it to
>>> +         match hardware requirements
>>> +
>>> +     ``width``, ``height``
>>> +         ignored (always zero)
>>> +
>>> +     other fields
>>> +         follow standard semantics
>>> +
>>> +   * **Return fields:**
>>> +
>>> +     ``sizeimage``
>>> +         adjusted size of ``CAPTURE`` buffers
>>> +
>>> +   .. important::
>>> +
>>> +      Changing the ``CAPTURE`` format may change the currently set ``OUTPUT``
>>> +      format. The encoder will derive a new ``OUTPUT`` format from the
>>> +      ``CAPTURE`` format being set, including resolution, colorimetry
>>> +      parameters, etc. If the client needs a specific ``OUTPUT`` format, it
>>> +      must adjust it afterwards.
>>> +
>>> +2. **Optional.** Enumerate supported ``OUTPUT`` formats (raw formats for
>>> +   source) for the selected coded format via :c:func:`VIDIOC_ENUM_FMT`.
>>> +
>>> +   * **Required fields:**
>>> +
>>> +     ``type``
>>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
>>> +
>>> +     other fields
>>> +         follow standard semantics
>>> +
>>> +   * **Return fields:**
>>> +
>>> +     ``pixelformat``
>>> +         raw format supported for the coded format currently selected on
>>> +         the ``CAPTURE`` queue.
>>> +
>>> +     other fields
>>> +         follow standard semantics
>>> +
>>> +3. Set the raw source format on the ``OUTPUT`` queue via
>>> +   :c:func:`VIDIOC_S_FMT`.
>>> +
>>> +   * **Required fields:**
>>> +
>>> +     ``type``
>>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
>>> +
>>> +     ``pixelformat``
>>> +         raw format of the source
>>> +
>>> +     ``width``, ``height``
>>> +         source resolution
>>> +
>>> +     other fields
>>> +         follow standard semantics
>>> +
>>> +   * **Return fields:**
>>> +
>>> +     ``width``, ``height``
>>> +         may be adjusted by encoder to match alignment requirements, as
>>> +         required by the currently selected formats
>>> +
>>> +     other fields
>>> +         follow standard semantics
>>> +
>>> +   * Setting the source resolution will reset the selection rectangles to their
>>> +     default values, based on the new resolution, as described in the step 5
>>> +     below.
>>> +
>>> +4. **Optional.** Set the visible resolution for the stream metadata via
>>> +   :c:func:`VIDIOC_S_SELECTION` on the ``OUTPUT`` queue.
>>> +
>>> +   * **Required fields:**
>>> +
>>> +     ``type``
>>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
>>> +
>>> +     ``target``
>>> +         set to ``V4L2_SEL_TGT_CROP``
>>> +
>>> +     ``r.left``, ``r.top``, ``r.width``, ``r.height``
>>> +         visible rectangle; this must fit within the `V4L2_SEL_TGT_CROP_BOUNDS`
>>> +         rectangle and may be subject to adjustment to match codec and
>>> +         hardware constraints
>>> +
>>> +   * **Return fields:**
>>> +
>>> +     ``r.left``, ``r.top``, ``r.width``, ``r.height``
>>> +         visible rectangle adjusted by the encoder
>>> +
>>> +   * The following selection targets are supported on ``OUTPUT``:
>>> +
>>> +     ``V4L2_SEL_TGT_CROP_BOUNDS``
>>> +         equal to the full source frame, matching the active ``OUTPUT``
>>> +         format
>>> +
>>> +     ``V4L2_SEL_TGT_CROP_DEFAULT``
>>> +         equal to ``V4L2_SEL_TGT_CROP_BOUNDS``
>>> +
>>> +     ``V4L2_SEL_TGT_CROP``
>>> +         rectangle within the source buffer to be encoded into the
>>> +         ``CAPTURE`` stream; defaults to ``V4L2_SEL_TGT_CROP_DEFAULT``
>>> +
>>> +         .. note::
>>> +
>>> +            A common use case for this selection target is encoding a source
>>> +            video with a resolution that is not a multiple of a macroblock,
>>> +            e.g.  the common 1920x1080 resolution may require the source
>>> +            buffers to be aligned to 1920x1088 for codecs with 16x16 macroblock
>>> +            size. To avoid encoding the padding, the client needs to explicitly
>>> +            configure this selection target to 1920x1080.
>>> +
>>> +     ``V4L2_SEL_TGT_COMPOSE_BOUNDS``
>>> +         maximum rectangle within the coded resolution, which the cropped
>>> +         source frame can be composed into; if the hardware does not support
>>> +         composition or scaling, then this is always equal to the rectangle of
>>> +         width and height matching ``V4L2_SEL_TGT_CROP`` and located at (0, 0)
>>> +
>>> +     ``V4L2_SEL_TGT_COMPOSE_DEFAULT``
>>> +         equal to a rectangle of width and height matching
>>> +         ``V4L2_SEL_TGT_CROP`` and located at (0, 0)
>>> +
>>> +     ``V4L2_SEL_TGT_COMPOSE``
>>> +         rectangle within the coded frame, which the cropped source frame
>>> +         is to be composed into; defaults to
>>> +         ``V4L2_SEL_TGT_COMPOSE_DEFAULT``; read-only on hardware without
>>> +         additional compose/scaling capabilities; resulting stream will
>>> +         have this rectangle encoded as the visible rectangle in its
>>> +         metadata
>>
>> I would only support the COMPOSE targets if the hardware can actually do
>> scaling and/or composing. That is conform standard V4L2 behavior where
>> cropping/composing is only implemented if the hardware can actually do
>> this.
>>
> 
> Please see my other reply to your earlier similar comment in this thread.
> 
>>> +
>>> +   .. warning::
>>> +
>>> +      The encoder may adjust the crop/compose rectangles to the nearest
>>> +      supported ones to meet codec and hardware requirements. The client needs
>>> +      to check the adjusted rectangle returned by :c:func:`VIDIOC_S_SELECTION`.
>>> +
>>> +5. Allocate buffers for both ``OUTPUT`` and ``CAPTURE`` via
>>> +   :c:func:`VIDIOC_REQBUFS`. This may be performed in any order.
>>> +
>>> +   * **Required fields:**
>>> +
>>> +     ``count``
>>> +         requested number of buffers to allocate; greater than zero
>>> +
>>> +     ``type``
>>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT`` or
>>> +         ``CAPTURE``
>>> +
>>> +     other fields
>>> +         follow standard semantics
>>> +
>>> +   * **Return fields:**
>>> +
>>> +     ``count``
>>> +          actual number of buffers allocated
>>> +
>>> +   .. warning::
>>> +
>>> +      The actual number of allocated buffers may differ from the ``count``
>>> +      given. The client must check the updated value of ``count`` after the
>>> +      call returns.
>>> +
>>> +   .. note::
>>> +
>>> +      To allocate more than the minimum number of OUTPUT buffers (for pipeline
>>> +      depth), the client may query the ``V4L2_CID_MIN_BUFFERS_FOR_OUTPUT``
>>> +      control to get the minimum number of buffers required, and pass the
>>> +      obtained value plus the number of additional buffers needed in the
>>> +      ``count`` field to :c:func:`VIDIOC_REQBUFS`.
>>> +
>>> +   Alternatively, :c:func:`VIDIOC_CREATE_BUFS` can be used to have more
>>> +   control over buffer allocation.
>>> +
>>> +   * **Required fields:**
>>> +
>>> +     ``count``
>>> +         requested number of buffers to allocate; greater than zero
>>> +
>>> +     ``type``
>>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
>>> +
>>> +     other fields
>>> +         follow standard semantics
>>> +
>>> +   * **Return fields:**
>>> +
>>> +     ``count``
>>> +         adjusted to the number of allocated buffers
>>> +
>>> +6. Begin streaming on both ``OUTPUT`` and ``CAPTURE`` queues via
>>> +   :c:func:`VIDIOC_STREAMON`. This may be performed in any order. The actual
>>> +   encoding process starts when both queues start streaming.
>>> +
>>> +.. note::
>>> +
>>> +   If the client stops the ``CAPTURE`` queue during the encode process and then
>>> +   restarts it again, the encoder will begin generating a stream independent
>>> +   from the stream generated before the stop. The exact constraints depend
>>> +   on the coded format, but may include the following implications:
>>> +
>>> +   * encoded frames produced after the restart must not reference any
>>> +     frames produced before the stop, e.g. no long term references for
>>> +     H.264,
>>> +
>>> +   * any headers that must be included in a standalone stream must be
>>> +     produced again, e.g. SPS and PPS for H.264.
>>> +
>>> +Encoding
>>> +========
>>> +
>>> +This state is reached after the `Initialization` sequence finishes
>>> +successfully.  In this state, the client queues and dequeues buffers to both
>>> +queues via :c:func:`VIDIOC_QBUF` and :c:func:`VIDIOC_DQBUF`, following the
>>> +standard semantics.
>>> +
>>> +The contents of encoded ``CAPTURE`` buffers depend on the active coded pixel
>>> +format and may be affected by codec-specific extended controls, as stated
>>> +in the documentation of each format.
>>> +
>>> +Both queues operate independently, following standard behavior of V4L2 buffer
>>> +queues and memory-to-memory devices. In addition, the order of encoded frames
>>> +dequeued from the ``CAPTURE`` queue may differ from the order of queuing raw
>>> +frames to the ``OUTPUT`` queue, due to properties of the selected coded format,
>>> +e.g. frame reordering.
>>> +
>>> +The client must not assume any direct relationship between ``CAPTURE`` and
>>> +``OUTPUT`` buffers and any specific timing of buffers becoming
>>> +available to dequeue. Specifically:
>>> +
>>> +* a buffer queued to ``OUTPUT`` may result in more than 1 buffer produced on
>>> +  ``CAPTURE`` (if returning an encoded frame allowed the encoder to return a
>>> +  frame that preceded it in display, but succeeded it in the decode order),
>>> +
>>> +* a buffer queued to ``OUTPUT`` may result in a buffer being produced on
>>> +  ``CAPTURE`` later into encode process, and/or after processing further
>>> +  ``OUTPUT`` buffers, or be returned out of order, e.g. if display
>>> +  reordering is used,
>>> +
>>> +* buffers may become available on the ``CAPTURE`` queue without additional
>>> +  buffers queued to ``OUTPUT`` (e.g. during drain or ``EOS``), because of the
>>> +  ``OUTPUT`` buffers queued in the past whose decoding results are only
>>> +  available at later time, due to specifics of the decoding process,
>>> +
>>> +* buffers queued to ``OUTPUT`` may not become available to dequeue instantly
>>> +  after being encoded into a corresponding ``CATPURE`` buffer, e.g. if the
>>> +  encoder needs to use the frame as a reference for encoding further frames.
>>> +
>>> +.. note::
>>> +
>>> +   To allow matching encoded ``CAPTURE`` buffers with ``OUTPUT`` buffers they
>>> +   originated from, the client can set the ``timestamp`` field of the
>>> +   :c:type:`v4l2_buffer` struct when queuing an ``OUTPUT`` buffer. The
>>> +   ``CAPTURE`` buffer(s), which resulted from encoding that ``OUTPUT`` buffer
>>> +   will have their ``timestamp`` field set to the same value when dequeued.
>>> +
>>> +   In addition to the straightforward case of one ``OUTPUT`` buffer producing
>>> +   one ``CAPTURE`` buffer, the following cases are defined:
>>> +
>>> +   * one ``OUTPUT`` buffer generates multiple ``CAPTURE`` buffers: the same
>>> +     ``OUTPUT`` timestamp will be copied to multiple ``CAPTURE`` buffers,
>>> +
>>> +   * the encoding order differs from the presentation order (i.e. the
>>> +     ``CAPTURE`` buffers are out-of-order compared to the ``OUTPUT`` buffers):
>>> +     ``CAPTURE`` timestamps will not retain the order of ``OUTPUT`` timestamps
>>> +     and thus monotonicity of the timestamps cannot be guaranteed.
>>> +
>>> +.. note::
>>> +
>>> +   To let the client distinguish between frame types (keyframes, intermediate
>>> +   frames; the exact list of types depends on the coded format), the
>>> +   ``CAPTURE`` buffers will have corresponding flag bits set in their
>>> +   :c:type:`v4l2_buffer` struct when dequeued. See the documentation of
>>> +   :c:type:`v4l2_buffer` and each coded pixel format for exact list of flags
>>> +   and their meanings.
>>
>> I don't think we can require this since a capture buffer may contain multiple
>> encoded frames.
>>
> 
> I thought we required that only one encoded frame was in one CAPTURE
> buffer. Real time use cases rely heavily on this frame type
> information, so I can't imagine not requiring this.

That the CAPTURE buffer contains only one encoded frame is never stated
explicitly. I am not so sure I want that to be a hard requirement anyway
since the old ivtv MPEG encoder just produces a bitstream.

Perhaps this should be signaled with a flag in ENUM_FMT?

> 
>> It would actually make more sense to return it in the output buffer, but I don't
>> know if a hardware encoder can actually provide that information.
>>
> 
> I believe all the already existing drivers provide the information
> about the encoded frame type, but I don't think they provide the
> information about what source frame it came from.
> 
>> Another use of these flags for an output buffer is to force a keyframe if for
>> example a scene change was detected.
>>
>> My feeling is that we should drop this note. Forcing a keyframe by setting that
>> flag for the output buffer might actually be a useful thing to do for a stateful
>> encoder.
>>
> 
> However, to force keyframe, one sets it in the OUTPUT buffer. Then, to
> actually get the right CAPTURE buffer, one has to look for one with
> this flag set.

So *if* the driver stores only one encoded frame in a CAPTURE buffer, then we
can require that these flags have to be set for that CAPTURE buffer. Otherwise
they should be cleared since they cannot be associated with a specific buffer.

And I think it should be documented that you can set the KEYFRAME flag in the
OUTPUT buffer to force a keyframe (the driver may ignore this if it can't do
this for some reason).

Regards,

	Hans

> 
>>> +
>>> +Encoding parameter changes
>>> +==========================
>>> +
>>> +The client is allowed to use :c:func:`VIDIOC_S_CTRL` to change encoder
>>> +parameters at any time. The availability of parameters is encoder-specific
>>> +and the client must query the encoder to find the set of available controls.
>>> +
>>> +The ability to change each parameter during encoding is encoder-specific, as
>>> +per the standard semantics of the V4L2 control interface. The client may
>>> +attempt to set a control during encoding and if the operation fails with the
>>> +-EBUSY error code, the ``CAPTURE`` queue needs to be stopped for the
>>> +configuration change to be allowed. To do this, it may follow the `Drain`
>>> +sequence to avoid losing the already queued/encoded frames.
>>> +
>>> +The timing of parameter updates is encoder-specific, as per the standard
>>> +semantics of the V4L2 control interface. If the client needs to apply the
>>> +parameters exactly at specific frame, using the Request API
>>> +(:ref:`media-request-api`) should be considered, if supported by the encoder.
>>> +
>>> +Drain
>>> +=====
>>> +
>>> +To ensure that all the queued ``OUTPUT`` buffers have been processed and the
>>> +related ``CAPTURE`` buffers are given to the client, the client must follow the
>>> +drain sequence described below. After the drain sequence ends, the client has
>>> +received all encoded frames for all ``OUTPUT`` buffers queued before the
>>> +sequence was started.
>>> +
>>> +1. Begin the drain sequence by issuing :c:func:`VIDIOC_ENCODER_CMD`.
>>> +
>>> +   * **Required fields:**
>>> +
>>> +     ``cmd``
>>> +         set to ``V4L2_ENC_CMD_STOP``
>>> +
>>> +     ``flags``
>>> +         set to 0
>>> +
>>> +     ``pts``
>>> +         set to 0
>>> +
>>> +   .. warning::
>>> +
>>> +      The sequence can be only initiated if both ``OUTPUT`` and ``CAPTURE``
>>> +      queues are streaming. For compatibility reasons, the call to
>>> +      :c:func:`VIDIOC_ENCODER_CMD` will not fail even if any of the queues is
>>> +      not streaming, but at the same time it will not initiate the `Drain`
>>> +      sequence and so the steps described below would not be applicable.
>>> +
>>> +2. Any ``OUTPUT`` buffers queued by the client before the
>>> +   :c:func:`VIDIOC_ENCODER_CMD` was issued will be processed and encoded as
>>> +   normal. The client must continue to handle both queues independently,
>>> +   similarly to normal encode operation. This includes:
>>> +
>>> +   * queuing and dequeuing ``CAPTURE`` buffers, until a buffer marked with the
>>> +     ``V4L2_BUF_FLAG_LAST`` flag is dequeued,
>>> +
>>> +     .. warning::
>>> +
>>> +        The last buffer may be empty (with :c:type:`v4l2_buffer`
>>> +        ``bytesused`` = 0) and in that case it must be ignored by the client,
>>> +        as it does not contain an encoded frame.
>>> +
>>> +     .. note::
>>> +
>>> +        Any attempt to dequeue more buffers beyond the buffer marked with
>>> +        ``V4L2_BUF_FLAG_LAST`` will result in a -EPIPE error from
>>> +        :c:func:`VIDIOC_DQBUF`.
>>> +
>>> +   * dequeuing processed ``OUTPUT`` buffers, until all the buffers queued
>>> +     before the ``V4L2_ENC_CMD_STOP`` command are dequeued,
>>> +
>>> +   * dequeuing the ``V4L2_EVENT_EOS`` event, if the client subscribes to it.
>>> +
>>> +   .. note::
>>> +
>>> +      For backwards compatibility, the encoder will signal a ``V4L2_EVENT_EOS``
>>> +      event when the last frame has been decoded and all frames are ready to be
>>
>> decoded -> encoded
>>
> 
> Ack.
> 
> Best regards,
> Tomasz
> 

