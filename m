Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0CAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346D02083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbfDJJ0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:26:55 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:44597 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728057AbfDJJ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:26:54 -0400
Received: from [IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f] ([IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f])
        by smtp-cloud8.xs4all.net with ESMTPA
        id E9VKhpJTfUjKfE9VLhgvVa; Wed, 10 Apr 2019 11:26:51 +0200
Subject: Re: [PATCH v2 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
To:     Tomasz Figa <tfiga@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
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
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>
References: <20181022144901.113852-1-tfiga@chromium.org>
 <20181022144901.113852-2-tfiga@chromium.org>
 <cf0fc2fc-72c6-dbca-68f7-a349879a3a14@xs4all.nl>
 <CAAFQd5AORjMjHdavdr3zM13BnyFnKnEb-0aKNjvwbB_xJEnxgQ@mail.gmail.com>
 <9b7c1385-d482-6e92-2222-2daa835dbc91@xs4all.nl>
 <CAAFQd5DwjLt8UeDohzrMausaLGnOStvrmp5p7frYbG1hbGjx3Q@mail.gmail.com>
 <CAAFQd5BPJv3cbJOWrziEjz_yE32DhfZv9vb-pG1Ltx-KS2=PQg@mail.gmail.com>
 <3ea3bf5bf9904ce877142c41f595207752172d27.camel@ndufresne.ca>
 <CAAFQd5C_OD=bvAxG0B_G+T6bnWddPHuiVZApj_8_+4xpMjH9+g@mail.gmail.com>
 <c145fbf21301d03bdfdd8bf6613f0f68576e66be.camel@ndufresne.ca>
 <CAAFQd5D4AP+xj_EkcsB84UqxCLBBEGComqGaMCm2zHSMnpqOKw@mail.gmail.com>
 <CAAFQd5AfmoUNbd5qwNmj+X80T-B49M-kUCLzGSOirg3o5WPPzA@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <d5e1a68d-c4e7-2645-1cd4-e55d87839f6f@xs4all.nl>
Date:   Wed, 10 Apr 2019 11:26:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5AfmoUNbd5qwNmj+X80T-B49M-kUCLzGSOirg3o5WPPzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfDeU0zDfkemf/qdbHKs4iu3pROOjV6w0nWqG+Khuu2DfKffEeNTqWWhUitXefAfbtQBu4yk9iQjDne+yPI+UdJGrk7N3uGq0zONmzZ5x3aHSqUjAION4
 DZqSIpYcBGB/a8AFiVwZu2PT+AUZk3uk15/Fh2rLQKmnmP2rzq7QViuf8iruvth8rRldj8KWBC7uDCCSMZf2xxxV2EDFilH+mzVPp8Z/eMDqaJXVlXMv8hW/
 yy6Dwzx/5x/5/nNAczgjA47qpjSn431HIsYfhUOI7bWoGKz3nBeVq3prqi53XW6RuAa4g49ZzDv7LU3lY8jRNUqIV9deyHa3nkkMc7iBdfUapY84thFdolpI
 Yse2x1hYb9ieWBfDd1p83Q5YFJZ69ohFxecaQ0BKS6IvyRxNKavi0K2xY/BmVu1jryjNlknNjHAZpMweMrlkA9WprTiR/CtrZCtf0DcTlS5SQx9nEhKcjVJ+
 CfDP0hZ0KumgFsZkVdQZFnH0su90Yx22pqw9/QoYcGo84JJzd6jpqmUTu0VGUf2rItcdVu/YXeDKu/Q7gcfFSDXZs/1LYVAtic58b7huA8JagNCVF58EoG0Q
 NmqilnS4QoCHpScE1JtyjRuwa5BKT2L1O/ZclVdcScdu3eHOtH+6emCIe9+1jyQvO5ISI4k9eiqoudya47u3AGLw+Yd7cvMDfDkuQIw2VH9uosxl3kK1K8u/
 yHlJXMt8khqxq07W6tpykMeiDkv2psdErdwYq3Vpb+IwV4sfVSTFIHxQjHVBKhBZnJBWsEIQcyPqS/7CVHz92N3ukxa+j+ARsd4N0PCsltdKDQW4xcw6pI80
 hC40NL0kbY12aSTWyUropaJdDFvD3HiEs2NMPE/iWfvfc+BgPyCj58WFvg8bi0EyD25nNr5Ls/027FqnbF5tlhc+KUyb3S7XSh8iGywk6IZnPVbIVLYrC1+l
 U/LEchwtokYCfK2BIi1gU66D71/76ocD3YAPxuPHmzKjJevB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/19 11:47 AM, Tomasz Figa wrote:
> On Wed, Feb 6, 2019 at 2:35 PM Tomasz Figa <tfiga@chromium.org> wrote:
>>
>> On Wed, Jan 30, 2019 at 1:02 PM Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
>>>
>>> Le vendredi 25 janvier 2019 à 12:27 +0900, Tomasz Figa a écrit :
>>>> On Fri, Jan 25, 2019 at 4:55 AM Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
>>>>> Le jeudi 24 janvier 2019 à 18:06 +0900, Tomasz Figa a écrit :
>>>>>>> Actually I just realized the last point might not even be achievable
>>>>>>> for some of the decoders (s5p-mfc, mtk-vcodec), as they don't report
>>>>>>> which frame originates from which bitstream buffer and the driver just
>>>>>>> picks the most recently consumed OUTPUT buffer to copy the timestamp
>>>>>>> from. (s5p-mfc actually "forgets" to set the timestamp in some cases
>>>>>>> too...)
>>>>>>>
>>>>>>> I need to think a bit more about this.
>>>>>>
>>>>>> Actually I misread the code. Both s5p-mfc and mtk-vcodec seem to
>>>>>> correctly match the buffers.
>>>>>
>>>>> Ok good, since otherwise it would have been a regression in MFC driver.
>>>>> This timestamp passing thing could in theory be made optional though,
>>>>> it lives under some COPY_TIMESTAMP kind of flag. What that means though
>>>>> is that a driver without such a capability would need to signal dropped
>>>>> frames using some other mean.
>>>>>
>>>>> In userspace, the main use is to match the produced frame against a
>>>>> userspace specific list of frames. At least this seems to be the case
>>>>> in Gst and Chromium, since the userspace list contains a superset of
>>>>> the metadata found in the v4l2_buffer.
>>>>>
>>>>> Now, using the produced timestamp, userspace can deduce frame that the
>>>>> driver should have produced but didn't (could be a deadline case codec,
>>>>> or simply the frames where corrupted). It's quite normal for a codec to
>>>>> just keep parsing until it finally find something it can decode.
>>>>>
>>>>> That's at least one way to do it, but there is other possible
>>>>> mechanism. The sequence number could be used, or even producing buffers
>>>>> with the ERROR flag set. What matters is just to give userspace a way
>>>>> to clear these frames, which would simply grow userspace memory usage
>>>>> over time.
>>>>
>>>> Is it just me or we were missing some consistent error handling then?
>>>>
>>>> I feel like the drivers should definitely return the bitstream buffers
>>>> with the ERROR flag, if there is a decode failure of data in the
>>>> buffer. Still, that could become more complicated if there is more
>>>> than 1 frame in that piece of bitstream, but only 1 frame is corrupted
>>>> (or whatever).
>>>
>>> I agree, but it might be more difficult then it looks (even FFMPEG does
>>> not do that). I believe the code that is processing the bitstream in
>>> stateful codecs is mostly unrelated from the code actually doing the
>>> decoding. So what might happen is that the decoding part will never
>>> actually allocate a buffer for the skipped / corrupted part of the
>>> bitstream. Also, the notion of a skipped frame is not always evident in
>>> when parsing H264 or HEVC NALs. There is still a full page of text just
>>> to explain how to detect that start of a new frame.
>>
>> Right. I don't think we can guarantee that we can always correlate the
>> errors with exact buffers and so I phrased the paragraph about errors
>> in v3 in a bit more conservative way:
>>
>> See the snapshot hosted by Hans (thanks!):
>> https://hverkuil.home.xs4all.nl/codec-api/uapi/v4l/dev-decoder.html#decoding
>>
>>>
>>> Yet, it would be interesting to study the firmwares we have and see
>>> what they provide that would help making decode errors more explicit.
>>>
>>
>> Agreed.
>>
>>>>
>>>> Another case is when the bitstream, even if corrupted, is still enough
>>>> to produce some output. My intuition tells me that such CAPTURE buffer
>>>> should be then returned with the ERROR flag. That wouldn't still be
>>>> enough for any more sophisticated userspace error concealment, but
>>>> could still let the userspace know to perhaps drop the frame.
>>>
>>> You mean if a frame was concealed (typically the frame was decoded from
>>> a closed by reference instead of the expected reference). That is
>>> something signalled by FFPEG. We should document this possibility. I
>>> actually have something implemented in GStreamer. Basically if we have
>>> the ERROR flag with a payload size smaller then expected, I drop the
>>> frame and produce a drop event message, while if I have a frame with
>>> ERROR flag but of the right payload size, I assume it is corrupted, and
>>> simply flag it as corrupted, leaving to the application the decision to
>>> display it or not. This is a case that used to happen with some UVC
>>> cameras (though some have been fixed, and the UVC camera should drop
>>> smaller payload size buffers now).
>>
>> I think it's a behavior that makes the most sense indeed.
>>
>> Technically one could also consider the case of 0 < bytesused <
>> sizeimage, which could mean that only a part of the frame is in the
>> buffer. An application could try to blend it with previous frame using
>> some concealing algorithms. I haven't seen an app that could do such
>> thing, though.
> 
> Actually some interesting thought on this. I don't think the existing
> drivers would return any CAPTURE buffers on errors right now, but just
> return the OUTPUT buffer that failed to be decoded. Should we change
> this so that always one CAPTURE buffer with the ERROR flag is
> returned, to signal the application that a frame was potentially
> dropped?

It's what vicodec does. Since device_run is called with both an OUTPUT
and a CAPTURE buffer it would make sense to return both buffers with the
ERROR flag if decoding (or encoding for that matter) fails.

But I would also be fine if this is seen as driver specific. Since an
OUTPUT buffer can decode to multiple CAPTURE buffers it may not be
all that useful in practice.

Regards,

	Hans
