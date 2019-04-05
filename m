Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE0AC10F14
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B8C218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbfDEHQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:16:43 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:42998 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726694AbfDEHQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 03:16:43 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id CIyNhbLEJiLOmCIyQhqQqZ; Fri, 05 Apr 2019 09:09:17 +0200
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
 <CAAFQd5Dd9s-+XmA-KhokarCGUH6qCbdY3qcYq3oSfW7oRmMtMg@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <9c06c93d-a5f1-2998-a031-d483a6b51c13@xs4all.nl>
Date:   Fri, 5 Apr 2019 09:09:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAAFQd5Dd9s-+XmA-KhokarCGUH6qCbdY3qcYq3oSfW7oRmMtMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfESrEGWV9ZjhhnfSt/p9JDPiffeWrm9zK50kvxO5gBON0yCHnfLYVBtGoDlwtfCikzbaxg0TmbKrpQhWd6OApdTDu4PzNmJE9mvo9JVIOHmzlAa1UVZ0
 7WR/GOiXuK/8dLnwwDh6DB5RJxoeG2Ym2zoC0WzImrh/k8kK+MJHsu/BAiCEpdCgkuyC4jZFhERPsRU1dlng1eR6YfpjqTuQ4arqpBPrnhBobYAzz9ixHnlR
 wAPA4tE9QHloLuS0jm1OEJg8I+lTHsdIl5mU7poFjp9PaK+/xmnRsuDQld/UE1/oVV7x5kwlBnGQKSIgdYJ1i2c0s7mdWv9/tjnw0c6hjH+eGeL960b5fwBJ
 /xmUrCkU7uzVnJVxqY1aoh3tSb2G0MXHuMAHyKVbSKhr7C0eqDHeMhxq4d1d8e3VHutCggbR0OxGZs7Vq8T4GZnBWnoS7mWLuszG1er1g0eUIqE/Hsa6gzuZ
 mazYrWGZ5yBbf3Zkq9QJ4LjhCJZn9abKaphg9aD+awIrOvJAyxUbG5M/r6puBrY/DfU2fsgjhVvgSQWamztaPCVciZ73Wo56J5d1Kutb/6f2A7XoMxO+5TXG
 0RaQrqao1RH4pBIWChyGrZIxXusn9PK01aXuqZ+m/2/k83U46P4ytgDR74q0XCzTtwHxGM5B55dHT8+HNyzEtPP7rMdz3rzZbOCOonkrnKl705BiEhddY5g/
 Vd5ETwoyzkhe6IPKVy5oXQIHoFpJFAhFZaFoaZmxgTOLgfpQDMgwzrLTjjmTMG+CefYyC1jyDbfug1/tdrIT3UTwN5vn0jpDKJyftWS6puSOObG7XDy5n6zd
 6p/4BlIv4bGBGjXpf6D0zWUPot7oBc8NoYgUX0ar/+WbnL9gkmLUOwU0JbRFhlw7mLGD/Kz+uukD/8cbi9s=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/19 7:53 AM, Tomasz Figa wrote:
> On Tue, Jan 29, 2019 at 10:53 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>
>> Hi Tomasz,
>>
>> Some comments below. Nothing major, so I think a v4 should be ready to be
>> merged.
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

<snip>

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
>>
>> Hmm, "including resolution": if width and height are set to 0, what should the
>> OUTPUT resolution be? Up to the driver? I think this should be clarified since
>> at a first reading of this paragraph it appears to be contradictory.
>>
> 
> Indeed, it's hard to derive some sensible resolution from 0...
> 
> The intention here is to prevent the application from making any
> assumptions about the OUTPUT format, if it changes the CAPTURE format.
> Then, it shouldn't actually matter what's the new OUTPUT format, since
> the application needs to set it anyway.
> 
> Maybe let's just remove the mention of deriving and say something
> along these lines?
> 
> "How the new ``OUTPUT`` format is determined is unspecified and the client must
>  ensure it matches its needs afterwards."

I would replace "unspecified" with "driver specific" or possibly "up to the driver".

Regards,

	Hans
