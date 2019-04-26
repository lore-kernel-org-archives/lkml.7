Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B47CC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490CB206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfDZOSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:18:46 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:60681 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726060AbfDZOSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:18:45 -0400
Received: from [IPv6:2001:420:44c1:2579:108d:59b8:4aa1:d99c] ([IPv6:2001:420:44c1:2579:108d:59b8:4aa1:d99c])
        by smtp-cloud8.xs4all.net with ESMTPA
        id K1gUhcizbb8gSK1gYhsNEF; Fri, 26 Apr 2019 16:18:43 +0200
Subject: Re: [PATCH v4] media: docs-rst: Document m2m stateless video decoder
 interface
To:     Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Dafna Hirschfeld <dafna3@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190306080019.159676-1-acourbot@chromium.org>
 <371df0e4ec9e38d83d11171cbd98f19954cbf787.camel@ndufresne.ca>
 <da5aa9ab957923a72e30b169a3c242c4fe6260f1.camel@bootlin.com>
 <c07703459c7e48904bd7fd83be1e675c70eee83c.camel@ndufresne.ca>
 <d81d0112b99feba0a1899f3722077a4aeec9860c.camel@bootlin.com>
 <439b7f57aa3ba2b2ed5b043f961ef87cb83912af.camel@ndufresne.ca>
 <59e23c5ca5bfbadf9441ea06da2e9b9b5898c6d7.camel@bootlin.com>
 <0b495143bb260cf9f8927ee541e7f001842ac5c3.camel@ndufresne.ca>
 <CAPBb6MVG+3jQcw3AuhYDYCZ0YJ0aX=TmEuM5izh12GLw9V6B8Q@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <793af82c-6b37-6f69-648e-2cd2a2e87645@xs4all.nl>
Date:   Fri, 26 Apr 2019 16:18:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAPBb6MVG+3jQcw3AuhYDYCZ0YJ0aX=TmEuM5izh12GLw9V6B8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFL8Ja44FZFIsmjQo2LHxrQGhfa6RjonS9rLymDquLpVkq7T+XX0hne0yVz60Kj8L8tnCtbjnpxbQrB1zRsp7jyr4bMDUilgjnfPU/UzyJYO5Pi4upe7
 z8fV0C47wE7jR5wi1GoJ80A49QSpfrMxdlJmS/z+BFIGJ0huGbSIUMgDlGeyygk4wGSd7xk3sbY7IE2X0KcU5akYOCOVa83y6S7vOZmN42gMBOJ6xnZCvI4f
 X21EN1hjuZ2zWULzwsY70z590jqGXq6zKuzneS3zONHdvreAN+URkDLyLgBPY8eUbP8+6NkU5gRZ0AsyAZZSHuJRtYPBcHSIPuP13CF0eYtlrIL6/eU5cP7j
 sxce+1kApepkcSXj2SCUT/Pw3um2F3z28rtELMCPbikohTFj+KhmVRUw0FMVGpIWgrjuKeokhrplJtOzWdpZndx6/doyeq6BaEffnMMPAzctslYdz6WKUx4O
 Ul2IzrWwkv9sQgsycTCiQSR8eMiENF6wvj8m84vnGFSWEy1qPDqkIQnwLsIrE08azp4jGTxmlt+RVNoKiETMjK4FRBwasQQGUzOEsQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/19 9:22 AM, Alexandre Courbot wrote:

<snip>

> Thanks for this great discussion. Let me try to summarize the status
> of this thread + the IRC discussion and add my own thoughts:
> 
> Proper support for multiple decoding units (e.g. H.264 slices) per
> frame should not be an afterthought ; compliance to encoded formats
> depend on it, and the benefit of lower latency is a significant
> consideration for vendors.
> 
> m2m, which we use for all stateless codecs, has a strong assumption
> that one OUTPUT buffer consumed results in one CAPTURE buffer being
> produced. This assumption can however be overruled: at least the venus
> driver does it to implement the stateful specification.
> 
> So we need a way to specify frame boundaries when submitting encoded
> content to the driver. One request should contain a single OUTPUT
> buffer, containing a single decoding unit, but we need a way to
> specify whether the driver should directly produce a CAPTURE buffer
> from this request, or keep using the same CAPTURE buffer with
> subsequent requests.
> 
> I can think of 2 ways this can be expressed:
> 1) We keep the current m2m behavior as the default (a CAPTURE buffer
> is produced), and add a flag to ask the driver to change that behavior
> and hold on the CAPTURE buffer and reuse it with the next request(s) ;
> 2) We specify that no CAPTURE buffer is produced by default, unless a
> flag asking so is specified.
> 
> The flag could be specified in one of two ways:
> a) As a new v4l2_buffer.flag for the OUTPUT buffer ;
> b) As a dedicated control, either format-specific or more common to all codecs.
> 
> I tend to favor 2) and b) for this, for the reason that with H.264 at
> least, user-space does not know whether a slice is the last slice of a
> frame until it starts parsing the next one, and we don't know when we
> will receive it. If we use a control to ask that a CAPTURE buffer be
> produced, we can always submit another request with only that control
> set once it is clear that the frame is complete (and not delay
> decoding meanwhile). In practice I am not that familiar with
> latency-sensitive streaming ; maybe a smart streamer would just append
> an AUD NAL unit at the end of every frame and we can thus submit the
> flag it with the last slice without further delay?
> 
> An extra constraint to enforce would be that each decoding unit
> belonging to the same frame must be submitted with the same timestamp,
> otherwise the request submission would fail. We really need a
> framework to enforce all this at a higher level than individual
> drivers, once we reach an agreement I will start working on this.
> 
> Formats that do not support multiple decoding units per frame would
> reject any request that does not carry the end-of-frame information.
> 
> Anything missing / any further comment?
> 

After reading through this thread and a further irc discussion I now
understand the problem. I think there are several ways this can be
solved, but I think this is the easiest:

Introduce a new V4L2_BUF_FLAG_HOLD_CAPTURE_BUFFER flag.

If set in the OUTPUT buffer, then don't mark the CAPTURE buffer as
done after processing the OUTPUT buffer.

If an OUTPUT buffer was queued with a different timestamp than was
used for the currently held CAPTURE buffer, then mark that CAPTURE
buffer as done before starting processing this OUTPUT buffer.

In other words, for slicing you can just always set this flag and
group the slices by the OUTPUT timestamp. If you know that you
reached the last slice of a frame, then you can optionally clear the
flag to ensure the CAPTURE buffer is marked done without having to wait
for the first slice of the next frame to arrive.

Potential disadvantage of this approach is that this relies on the
OUTPUT timestamp to be the same for all slices of the same frame.

Which sounds reasonable to me.

In addition add a V4L2_BUF_CAP_SUPPORTS_HOLD_CAPTURE_BUFFER
capability to signal support for this flag.

I think this can be fairly easily implemented in v4l2-mem2mem.c.

In addition, this approach is not specific to codecs, it can be
used elsewhere as well (composing multiple output buffers into one
capture buffer is one use-case that comes to mind).

Comments? Other ideas?

Regards,

	Hans
