Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2606FC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA45C2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfDIJh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:37:58 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:47828 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726387AbfDIJh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:37:58 -0400
Received: from [IPv6:2001:983:e9a7:1:21c4:edff:e18c:6e5e] ([IPv6:2001:983:e9a7:1:21c4:edff:e18c:6e5e])
        by smtp-cloud8.xs4all.net with ESMTPA
        id DnCRhgmvKUjKfDnCShbx4r; Tue, 09 Apr 2019 11:37:54 +0200
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
 <cb3c73e0-9481-54d1-8730-69e51655d7d8@xs4all.nl>
 <CAAFQd5AqRzGehW6fN4P=_oVdPdH+bJQqKhxgP6zsu80p-74bXA@mail.gmail.com>
 <fded491f-8a25-3283-76c4-dee3dd56045e@xs4all.nl>
 <CAAFQd5CYT=eA_eFyHLTePBQatOBVwsoDjAfMoybJeWrO7V-raA@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <2376896b-0087-5eee-a4b9-6ad03b0fef9c@xs4all.nl>
Date:   Tue, 9 Apr 2019 11:37:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5CYT=eA_eFyHLTePBQatOBVwsoDjAfMoybJeWrO7V-raA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJZZc4O1W+Xo6hsVnZgrrHojoZcHLyE3sjbmJ5sjOwiZcsghdk3h8binM4mv11wQT0c08n0Ed5XnYxs+yn9wFbgdv/j2zoHEblp53kGzE/of1nckUAed
 kI8Ry6Wb32WlPbZ4l80bILvk6KxvFN2U3SH2TX6hgv+XddSQ5TYCOC/XMdaU4gDrSuELfIanNvvYkr539wuzOvIWVcpTmHubxnY/2kGnviU7CjBVJIEftpGA
 OnTLMx4MausrWsqA40z1WgxzHU5nhDIpHCpePjn7ZW5elNM+eLJpw1A6LUq0jCdPvQUlsAS2qo7h535uNGaKajweJABiC63v+0Tht1uMPH7KU4Q23J94v7U4
 EDTzrSDZKjS4pizjl6yw7Bcz8tXB3NzhM65D33xMCShkfLohrYLyDKG1ly0qTBoCtwvEXfrXIPKvslPcuA3mi9Ni4vkh7FwCuOKjUS9I0qWVKWChXs56eEmt
 UPyRYzQja+NHXYbLsJQ1Yhg04mhgvOrprruSHfrGeawDlgUEGBcr514l0pQMKNzqr/RkQpEpNo+nzze3dezkZlYVnRvWvS9o4iUfS/nrbP1SfJVfdeJ1cCbW
 dExklwBGvDg0arGRJmltPnQdfG7Ku8mHxhtj5R3eUuALgazZTUx/QiY1mZ6RT+xRd5NGFWbzZmBIlD1Tn87VHTciPtIMAW7Ux/iu5+7UtCSTDw6xE8PA5ohw
 uxRhGP0Lm6s2sVIibT5Wib2o0AEvi8LdH2iz5CQXmOUmOXCAaV5c9tTdNG2+QoMO2F7RsKSCrcPtF74u7280qUDbRyW143PKoJvEHJEpIm6Z2E4j/6BFUxDk
 6iWDelXTA33ek7y11uVNXpTzRzJcKBWhXzJ5gA8lJlAsPv18csCnIVTybffd1d6EROMa870ugxxFWTdbfhlFSKoJDPkBzbsv8ZhdZGKBC5s7ByR4YvZ7kdDN
 +U4Pk7eD/Me9u/f3Bj+xy+mC7EA0D2pNfjioXtAfQXFWMn9Y
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/19 9:11 AM, Tomasz Figa wrote:
> On Mon, Apr 8, 2019 at 5:43 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>
>> On 4/8/19 10:36 AM, Tomasz Figa wrote:
>>> On Mon, Mar 25, 2019 at 10:12 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>>>
>>>> Another comment found while creating compliance tests:
>>>>
>>>> On 1/24/19 11:04 AM, Tomasz Figa wrote:
>>>>> +Drain
>>>>> +=====
>>>>> +
>>>>> +To ensure that all the queued ``OUTPUT`` buffers have been processed and the
>>>>> +related ``CAPTURE`` buffers are given to the client, the client must follow the
>>>>> +drain sequence described below. After the drain sequence ends, the client has
>>>>> +received all encoded frames for all ``OUTPUT`` buffers queued before the
>>>>> +sequence was started.
>>>>> +
>>>>> +1. Begin the drain sequence by issuing :c:func:`VIDIOC_ENCODER_CMD`.
>>>>> +
>>>>> +   * **Required fields:**
>>>>> +
>>>>> +     ``cmd``
>>>>> +         set to ``V4L2_ENC_CMD_STOP``
>>>>> +
>>>>> +     ``flags``
>>>>> +         set to 0
>>>>> +
>>>>> +     ``pts``
>>>>> +         set to 0
>>>>> +
>>>>> +   .. warning::
>>>>> +
>>>>> +      The sequence can be only initiated if both ``OUTPUT`` and ``CAPTURE``
>>>>> +      queues are streaming. For compatibility reasons, the call to
>>>>> +      :c:func:`VIDIOC_ENCODER_CMD` will not fail even if any of the queues is
>>>>> +      not streaming, but at the same time it will not initiate the `Drain`
>>>>> +      sequence and so the steps described below would not be applicable.
>>>>> +
>>>>> +2. Any ``OUTPUT`` buffers queued by the client before the
>>>>> +   :c:func:`VIDIOC_ENCODER_CMD` was issued will be processed and encoded as
>>>>> +   normal. The client must continue to handle both queues independently,
>>>>> +   similarly to normal encode operation. This includes:
>>>>> +
>>>>> +   * queuing and dequeuing ``CAPTURE`` buffers, until a buffer marked with the
>>>>> +     ``V4L2_BUF_FLAG_LAST`` flag is dequeued,
>>>>> +
>>>>> +     .. warning::
>>>>> +
>>>>> +        The last buffer may be empty (with :c:type:`v4l2_buffer`
>>>>> +        ``bytesused`` = 0) and in that case it must be ignored by the client,
>>>>> +        as it does not contain an encoded frame.
>>>>> +
>>>>> +     .. note::
>>>>> +
>>>>> +        Any attempt to dequeue more buffers beyond the buffer marked with
>>>>> +        ``V4L2_BUF_FLAG_LAST`` will result in a -EPIPE error from
>>>>> +        :c:func:`VIDIOC_DQBUF`.
>>>>> +
>>>>> +   * dequeuing processed ``OUTPUT`` buffers, until all the buffers queued
>>>>> +     before the ``V4L2_ENC_CMD_STOP`` command are dequeued,
>>>>> +
>>>>> +   * dequeuing the ``V4L2_EVENT_EOS`` event, if the client subscribes to it.
>>>>> +
>>>>> +   .. note::
>>>>> +
>>>>> +      For backwards compatibility, the encoder will signal a ``V4L2_EVENT_EOS``
>>>>> +      event when the last frame has been decoded and all frames are ready to be
>>>>> +      dequeued. It is deprecated behavior and the client must not rely on it.
>>>>> +      The ``V4L2_BUF_FLAG_LAST`` buffer flag should be used instead.
>>>>> +
>>>>> +3. Once all ``OUTPUT`` buffers queued before the ``V4L2_ENC_CMD_STOP`` call are
>>>>> +   dequeued and the last ``CAPTURE`` buffer is dequeued, the encoder is stopped
>>>>> +   and it will accept, but not process any newly queued ``OUTPUT`` buffers
>>>>> +   until the client issues any of the following operations:
>>>>> +
>>>>> +   * ``V4L2_ENC_CMD_START`` - the encoder will not be reset and will resume
>>>>> +     operation normally, with all the state from before the drain,
>>>>
>>>> I assume that calling CMD_START when *not* draining will succeed but does nothing.
>>>>
>>>> In other words: while draining is in progress START will return EBUSY. When draining
>>>> was finished, then START will resume the encoder. In all other cases it just returns
>>>> 0 since the encoder is really already started.
>>>>
>>>
>>> Yes, that was the intention and seems to be the closest to the
>>> behavior described in the existing documentation.
>>>
>>>>> +
>>>>> +   * a pair of :c:func:`VIDIOC_STREAMOFF` and :c:func:`VIDIOC_STREAMON` on the
>>>>> +     ``CAPTURE`` queue - the encoder will be reset (see the `Reset` sequence)
>>>>> +     and then resume encoding,
>>>>> +
>>>>> +   * a pair of :c:func:`VIDIOC_STREAMOFF` and :c:func:`VIDIOC_STREAMON` on the
>>>>> +     ``OUTPUT`` queue - the encoder will resume operation normally, however any
>>>>> +     source frames queued to the ``OUTPUT`` queue between ``V4L2_ENC_CMD_STOP``
>>>>> +     and :c:func:`VIDIOC_STREAMOFF` will be discarded.
>>>>> +
>>>>> +.. note::
>>>>> +
>>>>> +   Once the drain sequence is initiated, the client needs to drive it to
>>>>> +   completion, as described by the steps above, unless it aborts the process by
>>>>> +   issuing :c:func:`VIDIOC_STREAMOFF` on any of the ``OUTPUT`` or ``CAPTURE``
>>>>> +   queues.  The client is not allowed to issue ``V4L2_ENC_CMD_START`` or
>>>>> +   ``V4L2_ENC_CMD_STOP`` again while the drain sequence is in progress and they
>>>>> +   will fail with -EBUSY error code if attempted.
>>>>
>>>> I assume calling STOP again once the drain sequence completed just returns 0 and
>>>> doesn't do anything else (since we're already stopped).
>>>>
>>>
>>> Right.
>>>
>>>>> +
>>>>> +   Although mandatory, the availability of encoder commands may be queried
>>>>> +   using :c:func:`VIDIOC_TRY_ENCODER_CMD`.
>>>>
>>>> Some corner cases:
>>>>
>>>> 1) No buffers are queued on either vb2_queue, but STREAMON is called for both queues.
>>>>    Now ENC_CMD_STOP is issued. What should happen?
>>>>
>>>>    Proposal: the next time the applications queues a CAPTURE buffer it is returned
>>>>    at once as an empty buffer with FLAG_LAST set.
>>>>
>>>
>>> SGTM. It's actually similar to a relatively common case where all
>>> CAPTURE buffers have been dequeued and the application has to refill
>>> the CAPTURE queue, but in the meantime a drain request needs to be
>>> issued.
>>>
>>>> 2) Both queues are streaming and buffers have been encoded, but currently no buffers
>>>>    are queued on either vb2_queue. Now ENC_CMD_STOP is issued. What should happen?
>>>>
>>>>    Proposal: the next time the applications queues a CAPTURE buffer it is returned
>>>>    at once as an empty buffer with FLAG_LAST set. This is consistent with the
>>>>    previous corner case.
>>>
>>> Agreed.
>>>
>>>>
>>>> 3) The CAPTURE queue contains buffers, the OUTPUT queue does not. Now ENC_CMD_STOP
>>>>    is issued. What should happen?
>>>>
>>>>    Proposal: the oldest CAPTURE buffer in the ready queue is returned as an empty
>>>>    buffer with FLAG_LAST set.
>>>
>>> Generally agreed, but not sure if there is a reason to specifically
>>> refer to the oldest buffer. (I'm personally for keeping the queues
>>> ordered, though...)
>>
>> Feel free to rephrase. Perhaps: "an empty CAPTURE buffer with FLAG_LAST set should be
>> queued up for userspace to signal that the encoder has stopped." Or something along
>> those lines.
> 
> I've added a note:
> 
>    For reference, handling of various corner cases is described below:
> 
>    * In case of no buffer in the ``OUTPUT`` queue at the time the
>      ``V4L2_ENC_CMD_STOP`` command was issued, the drain sequence completes
>      immediately and the encoder returns an empty ``CAPTURE`` buffer with the
>      ``V4L2_BUF_FLAG_LAST`` flag set.
> 
>    * In case of no buffer in the ``CAPTURE`` queue at the time the drain
>      sequence completes, the next time the client queues a ``CAPTURE`` buffer
>      it is returned at once as an empty buffer with the ``V4L2_BUF_FLAG_LAST``
>      flag set.
> 
>    * If :c:func:`VIDIOC_STREAMOFF` is called on the ``CAPTURE`` queue in the
>      middle of the drain sequence, the drain sequence is cancelled and all

cancelled -> canceled

>      ``CAPTURE`` buffers are implicitly returned to the userpace.

userpace -> userspace

> 
>    * If :c:func:`VIDIOC_STREAMOFF` is called on the ``OUTPUT`` queue in the
>      middle of the drain sequence, the drain sequence completes immediately and
>      next ``CAPTURE`` buffer will be returned empty with the
>      ``V4L2_BUF_FLAG_LAST`` flag set.
> 
> Slightly changed the split into cases to cover behaviors rather than
> conditions. WDYT?

Looks good (with those two typos fixed).

	Hans

> 
> Best regards,
> Tomasz
> 
>>
>> Regards,
>>
>>         Hans
>>
>>>
>>>>
>>>> 4) Both queues have queued buffers. ENC_CMD_STOP is issued to start the drain process.
>>>>    Before the drain process completes STREAMOFF is called for either CAPTURE or
>>>>    OUTPUT queue. What should happen?
>>>>
>>>>    Proposal for STREAMOFF(CAPTURE): aborts the drain process and all CAPTURE buffers are
>>>>    returned to userspace. If encoding is restarted, then any remaining OUTPUT buffers
>>>>    will be used as input to the encoder.
>>>>
>>>
>>> Agreed.
>>>
>>>>    Proposal for STREAMOFF(OUTPUT): the next capture buffer will be empty and have
>>>>    FLAG_LAST set.
>>>
>>> Agreed.
>>>
>>>>
>>>> Some of this might have to be documented, but these corner cases should certainly be
>>>> tested by v4l2-compliance. Before I write those tests I'd like to know if you agree
>>>> with this.
>>>
>>> Agreed with just one minor comment. Thanks for checking with me!
>>>
>>> Best regards,
>>> Tomasz
>>>
>>

