Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79178C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5012F2082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfDCJcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:32:33 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:45109 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725935AbfDCJcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:32:32 -0400
Received: from [IPv6:2001:420:44c1:2579:c83e:d0a5:cb24:b9a9] ([IPv6:2001:420:44c1:2579:c83e:d0a5:cb24:b9a9])
        by smtp-cloud8.xs4all.net with ESMTPA
        id BcFshxPEGUjKfBcFwhDvGg; Wed, 03 Apr 2019 11:32:29 +0200
Subject: Re: [PATCH v6 1/2] media: uapi: Add H264 low-level decoder API
 compound controls.
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     hans.verkuil@cisco.com, acourbot@chromium.org,
        sakari.ailus@linux.intel.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        tfiga@chromium.org, posciak@chromium.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        nicolas.dufresne@collabora.com, jenskuske@gmail.com,
        jernej.skrabec@gmail.com, jonas@kwiboo.se, ezequiel@collabora.com,
        linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Guenter Roeck <groeck@chromium.org>
References: <cover.3917a1471bfc8cbdfdde8026566b3857caff5762.1553009355.git-series.maxime.ripard@bootlin.com>
 <9d9fe5c2dc58f9398cb6b1e9bb208640d25ae816.1553009355.git-series.maxime.ripard@bootlin.com>
 <dbe5702e-f76d-9c92-cab6-bd88d243ae55@xs4all.nl>
 <4c70e58d-ce7b-c15d-4b1c-063cf9b67007@xs4all.nl>
 <20190403072948.ixugqb2t4z3dcyd4@flea>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <9e2c1764-a7c3-71d7-5058-cb40cce4d4d6@xs4all.nl>
Date:   Wed, 3 Apr 2019 11:32:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190403072948.ixugqb2t4z3dcyd4@flea>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGhmIka3vRcnzhkOjszXlXoq65engabdrAMmDlyXuLaBX3wlGrkUGi6e0A7epMclXei6iuO+07XLnfINE5s+Mqwp1B9767FC1dv0zDrvXYVUYb5KrA8G
 zXOJTREy6gvifRA7IU6xVFEszq7/4Jog3pOlj7M4F+DDPsCcZ6jmEWIqojmfaeD5SUilPvaIihC04J2TjBaAxGEh/H0Qhn8cLOg964XTUQwg5okwLZ4COWU0
 Xxi2XHoHLoQfeL9ABzr6vMyl11e6ZaxV7Bo8ccS7HWhlDzlOZhoHueY0G2YuAg4gLUo0fNePmnwHjJk4Pb+w7aibCtQ0VpT9Ia4gmKeOV5OdLwRgiUkx7dqn
 8zIjHGi+vGsheZ/lKdFgU3p7tuufocuREmnL3tFD1iMfxaVBw0Ai71YOdkG9KzVNHCqzHwtyG4Hu9wkeOwsJGKH0Zfd9+FBpQ+Nf/pOBGbhysRKP9slgoEXd
 omva50RBFtw6Cz0C2zST2Ps17de60UskyX267MAicziMTf3AEWn1WmmzfkI/7+1YOpyKS7iNZF+cJmn5QsytM1KhNau76xZXMrqMjmYjHGGjreqVsnM0qC5i
 tSsF1xa0j6zh5IaB32JIycMg6L3OUOtk2MUmnVYYfvC6+NboJzaouy43+RF9T/BHi36m5Tk/u4/vfOWNmvmJRvY3jY5l3Gm/gqV7CYsRJPZ/N0yt60T40Up9
 mg7RYGk2pDBqkMjUAYV+V4JbZEXITCIxaqRYp1mOThXKUhHJ/d/SHu/oYH6S+Zbe2YJsVXSxIw4Cv/51Zw30MtXXa11bn768gBN8CDgEUIirYOEdbgyJLsxj
 6tQLfE3bjyI2aIUJ3Ol8pop6B82Goarhb5TuNO/CX/3zgpjb2I/oCAo/cAhJfof7kuHaQoaqmJrroHeSj1QSryhF9AmyaG3DFy26SYwtgPtOGraEpj0DKY10
 q+sESinId+Wqn47eD5WKAafaaumo/y1Ut11HebBxgrLLwbk2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/19 9:29 AM, Maxime Ripard wrote:
> Hi Hans,
> 
> On Tue, Apr 02, 2019 at 01:39:21PM +0200, Hans Verkuil wrote:
>>>> +struct v4l2_h264_dpb_entry {
>>>> +	__u64 timestamp;
>>>
>>> As mentioned above, I suggest to rename this to 'reference_ts'.
>>>
>>> But see also the discussion below.
>>>
>>>> +	__u16 frame_num;
>>>> +	__u16 pic_num;
>>>> +	/* Note that field is indicated by v4l2_buffer.field */
>>>> +	__s32 top_field_order_cnt;
>>>> +	__s32 bottom_field_order_cnt;
>>>> +	__u32 flags; /* V4L2_H264_DPB_ENTRY_FLAG_* */
>>>> +};
>>>> +
>>>> +#define V4L2_H264_DECODE_PARAM_FLAG_IDR_PIC	0x01
>>>> +
>>>> +struct v4l2_ctrl_h264_decode_param {
>>>> +	__u32 num_slices;
>>>> +	__u32 nal_ref_idc;
>>>> +	__u8 ref_pic_list_p0[32];
>>>> +	__u8 ref_pic_list_b0[32];
>>>> +	__u8 ref_pic_list_b1[32];
>>>> +	__s32 top_field_order_cnt;
>>>> +	__s32 bottom_field_order_cnt;
>>>> +	__u32 flags; /* V4L2_H264_DECODE_PARAM_FLAG_* */
>>>> +	struct v4l2_h264_dpb_entry dpb[16];
>>>
>>> Should the reference timestamp be included in this control? Or be
>>> separated into its own control?
>>>
>>> Reference frames do not apply to stateless encoders (the driver will
>>> have to maintain the reference frames internally). Everything else
>>> is equally valid for both stateless encoders and decoders, but only
>>> stateless decoders need to provide the reference frames.
>>>
>>> So in this case we would need to create a new control:
>>>
>>> #define V4L2_CID_MPEG_VIDEO_H264_DECODE_REF_TS	(V4L2_CID_MPEG_BASE+1005)
>>>
>>> Which is a u64 array control (16 elements for H.264).
>>>
>>> You would need to do something similar for MPEG2.
>>
>> The question is if this is worth the extra effort. An alternative is
>> to just specify that these reference timestamps are always to be zeroed
>> by stateless encoders and are unused.
>>
>> I'm undecided on this.
> 
> I'll address your other comments, thanks!
> 
> For that part, I haven't really looked at the encoder parameters yet,
> but I guess we should have other controls to be passed there as well
> (like the target level of encoding). We can probably reuse the
> existing controls for that though.
> 
> From the way it looks, our encoder needs to put some parameters (the
> level and feature flags, mostly) and will output the entire
> bitstream. I'm not really sure if it qualifies as a stateless encoder,
> but that would require far less than what we have in those controls
> already.

This sounds like a stateful encoder. A stateless encoder would rely on
userspace to mux the metadata and the compressed video into a valid
bitstream, and it doesn't seem that that's the case here.

> 
> Either way, maybe the good way forward here would be to way for an
> H264 / MPEG2 stateless encoder to come up, either ours or some other,
> to see what should we do about this. How does that sound?

I think so too.

I think splitting off the reference timestamps into a separate control
is probably overkill.

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

