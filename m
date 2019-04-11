Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC59C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A4D21841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfDKHYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:24:05 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:47302 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726256AbfDKHYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:24:05 -0400
Received: from [IPv6:2001:983:e9a7:1:4cd3:53c0:7e2b:d8bc] ([IPv6:2001:983:e9a7:1:4cd3:53c0:7e2b:d8bc])
        by smtp-cloud8.xs4all.net with ESMTPA
        id EU42hwp8eUjKfEU43hkvhI; Thu, 11 Apr 2019 09:24:03 +0200
Subject: Re: [RFC PATCH 18/20] lib: image-formats: Add v4l2 formats support
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
References: <cover.92acdec88ee4c280cb74e08ea22f0075e5fa055c.1553032382.git-series.maxime.ripard@bootlin.com>
 <c97024b97d3261dcf41aad3c8bc1c5d9906f33c9.1553032382.git-series.maxime.ripard@bootlin.com>
 <3f5748a6422d2f7eb11601bad297df870ff5952b.camel@ndufresne.ca>
 <20190401144434.7n7lyiwan4eevgcn@flea>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <8193edcc-fb4b-34d7-fc7b-a37f2bf451a6@xs4all.nl>
Date:   Thu, 11 Apr 2019 09:24:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401144434.7n7lyiwan4eevgcn@flea>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPIHlLNzRHUODLIiCtKKFY+xH5uEtGT/4IwK70L91T//qlWzSlo11oqj+J9F5EkRWHjx28Iyi7TLkRm7p0aH4QrKrOYSj6E/qfJmF2ojFu6Z03NPRmqq
 FFUsjMWcXoZQB5Flrbp1Id7XpywkLivdtn4wEDVJl5O3hCyGABmT2epLyc+OUfOlED2FbuWxdp6s+3RZHhSar9yXSUpFX9gStZlziniN9WDtOVFhCfZvVE/i
 41W083ZCWUGgxAfnNAqKVvsEERb561FE/Tz+PrKe6ytN+OI3K21H00YJcnRRgFpsXyiZnuxP5Jx1WBw5QXDZip0QIRVafVxkM4DRJZ9reUxM6fbx8k4QpKg4
 VHeNASCJcj89HIUUUsAMPeS86i3gy91VvFqfamDp66JlAYvPsf9al1pEq8JMSE2pYwTRII9/SLzVGACd8Z9U/NY2XD1gXaCtRMT9gDNJz3PUXXdPjiLDdIAH
 w5uXCEEbxbzuEffQgB4wl/CVVzn+gBI8ZldSI6oX6T47jvNQ2vgFUg2AHAajvhVpee9BeVVn9AcKLgQ29kvMWyEDFXotnFZY85LPyKP+455Od89lDPQJxc/D
 UaVRw4IHm1On1yzduKC8yXWOYQapNPzUe6ame4nwwE+1bfTsyBOU4RYo0IUyQydlRocZesifywDK+h0cSW5NXE6dLgEm8X0MUVV0hlOpuDK/KUA1CFPI4UJ1
 T80kUBRynKweYIfYKO1L4zv/+RrMGZBqiIB9hWU9/UU8SLpxnYsn+EQWbgm0i0cJFDQcFY1MwkQhIMsWwp1HnopnEzBpLiBmBEFaQVeWBIvlIPgTy+ELJg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/19 4:44 PM, Maxime Ripard wrote:
> Hi Nicolas,
> 
> On Fri, Mar 22, 2019 at 03:55:19PM -0400, Nicolas Dufresne wrote:
>> Le mardi 19 mars 2019 à 22:57 +0100, Maxime Ripard a écrit :
>>> V4L2 uses different fourcc's than DRM, and has a different set of formats.
>>> For now, let's add the v4l2 fourcc's for the already existing formats.
>>
>> Hopefully I get the fixup right this time, see inline.
> 
> Thanks a lot for that extensive review.
> 
> About the single vs multi-planar issue, I'd be inclined with just
> supporting single-planar formats for now, and extend it later to deal
> with multiplanar formats.
> 
> Would that work for everyone?

I'd say that is the right approach.

Regards,

	Hans

> 
> Maxime
> 
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

