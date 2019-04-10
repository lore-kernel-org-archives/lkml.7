Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4DBC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97332133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732844AbfDJOjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:39:54 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:45575 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732824AbfDJOjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:39:53 -0400
Received: from [IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f] ([IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f])
        by smtp-cloud7.xs4all.net with ESMTPA
        id EEOBhlVEENG8zEEOCh1eY1; Wed, 10 Apr 2019 16:39:50 +0200
Subject: Re: [RFC PATCH] media/doc: Allow sizeimage to be set by v4l clients
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Malathi Gottam <mgottam@codeaurora.org>
References: <20190116123701.10344-1-stanimir.varbanov@linaro.org>
 <299e8aeb-6deb-b383-8f63-cf2cbf5d2e9f@xs4all.nl>
 <adecdc4e-1aed-fc33-b14b-083322797c70@linaro.org>
 <c103b0d8-0020-17e0-4584-e5c3ca6bbc51@xs4all.nl>
 <b6a231ea-c039-d276-313d-1b6dd19cab14@linaro.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <f374662e-64f8-d280-21f8-892c70b6b29e@xs4all.nl>
Date:   Wed, 10 Apr 2019 16:39:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <b6a231ea-c039-d276-313d-1b6dd19cab14@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPhIn2jdk7/TjaYtV/4WT/kp/s3oY7UeUYIGlZFCcR3+unp1ORVg4w+wmxikTQKBgQceE+zTJx2gLRcQ+AoxAnIi9MFgOWPcNtmi9eH3MA524uQYXnmU
 GvljoiFzjOb/AOUmg5Z8njdeQjD5IAXKN4KkDuxuxcBCj76o95HLh17QTxEMym08mGRn8mTNHuBJXG0PamaaIC05PjTjD4ryFmfR17pRRv82gY37dSDWshk3
 LTYHxDlyjl8GjE48Aei5N11wS7j6+4R5OYI3g8QHmAVRTxJRCcTV09bLoyFSa0zYcFSrT+RDzuNsrtvrDDxrAmXHULR0q9NMSQRe1Dm1hOq+rsVWUzmrmXjP
 Qpll2W0JRpDMOjRcB+Vq/GzlAD4MJx1OjZdl2nWKNbOgk7z/yaZV3kUGBXc91cRD/odbawMPUo4UvyuLcZN91iCYWZPeNhKAgjglQe6AUAO2a7oIbNvHjwuL
 +wiYxNxX3yRbebjJlp8CGH3sTcOKUd/7n+m6E9CYAq5rrYluvRAYLyfgZqGIzfyMM3SAcinJueJ32coRYjrR9Qpg0LJpAp9snp9e9w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 4:21 PM, Stanimir Varbanov wrote:
> Hi Hans,
> 
> On 3/14/19 3:11 PM, Hans Verkuil wrote:
>> On 1/21/19 11:48 AM, Stanimir Varbanov wrote:
>>> Hi Hans,
>>>
>>> On 1/18/19 11:13 AM, Hans Verkuil wrote:
>>>> On 1/16/19 1:37 PM, Stanimir Varbanov wrote:
>>>>> This changes v4l2_pix_format and v4l2_plane_pix_format sizeimage
>>>>> field description to allow v4l clients to set bigger image size
>>>>> in case of variable length compressed data.
>>>>>
>>>>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>>>>> ---
>>>>>  Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst | 5 ++++-
>>>>>  Documentation/media/uapi/v4l/pixfmt-v4l2.rst        | 3 ++-
>>>>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst b/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
>>>>> index 7f82dad9013a..dbe0b74e9ba4 100644
>>>>> --- a/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
>>>>> +++ b/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
>>>>> @@ -30,7 +30,10 @@ describing all planes of that format.
>>>>>  
>>>>>      * - __u32
>>>>>        - ``sizeimage``
>>>>> -      - Maximum size in bytes required for image data in this plane.
>>>>> +      - Maximum size in bytes required for image data in this plane,
>>>>> +        set by the driver. When the image consists of variable length
>>>>> +        compressed data this is the maximum number of bytes required
>>>>> +        to hold an image, and it is allowed to be set by the client.
>>>>>      * - __u32
>>>>>        - ``bytesperline``
>>>>>        - Distance in bytes between the leftmost pixels in two adjacent
>>>>> diff --git a/Documentation/media/uapi/v4l/pixfmt-v4l2.rst b/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
>>>>> index 71eebfc6d853..54b6d2b67bd7 100644
>>>>> --- a/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
>>>>> +++ b/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
>>>>> @@ -89,7 +89,8 @@ Single-planar format structure
>>>>>        - Size in bytes of the buffer to hold a complete image, set by the
>>>>>  	driver. Usually this is ``bytesperline`` times ``height``. When
>>>>>  	the image consists of variable length compressed data this is the
>>>>> -	maximum number of bytes required to hold an image.
>>>>> +	maximum number of bytes required to hold an image, and it is
>>>>> +	allowed to be set by the client.
>>>>>      * - __u32
>>>>>        - ``colorspace``
>>>>>        - Image colorspace, from enum :c:type:`v4l2_colorspace`.
>>>>>
>>>>
>>>> Hmm. "maximum number of bytes required to hold an image": that's not actually true
>>>> for bitstream formats like MPEG. It's just the size of the buffer used to store the
>>>> bitstream, i.e. one buffer may actually contain multiple compressed images, or a
>>>> compressed image is split over multiple buffers.
>>>>
>>>
>>> Do you want me to change something in the current documentation, i.e.
>>> the quoted above?
>>
>> Hmm, it looks like this discussion stalled (i.e. I forgot to reply).
>>
>> How about this:
>>
>> "When the image consists of variable length compressed data this is the
>> number of bytes required by the encoder to support the worst-case
> 
> I don't think 'encoder' is the right word here:
> 
> s/encoder/encoder or decoder

or perhaps just 'codec'? Either is fine by me.

> 
>> compression scenario. Clients are allowed to set this field. However,
>> drivers may ignore the value or modify it."
> 
> Can we rephrase to:
> 
> "Clients are allowed to set sizeimage field, but however drivers my
> ignore the value or modify it."
> 

How about this:

"Clients are allowed to set the sizeimage field, but drivers may
 modify it."

'ignore the value' isn't right, since that suggests that the sizeimage
value that is returned may not be in actual use. Since sizeimage can now
be set by userspace, this means that a sanity check is needed in drivers
as well (i.e. what if userspace sets sizeimage to ~0?)

This should be tested in v4l2-compliance as well.

Regards,

	Hans
