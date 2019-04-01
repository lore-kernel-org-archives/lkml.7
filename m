Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D196EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5932082C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfDANaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:30:09 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:50120 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726821AbfDANaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 09:30:08 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id Ax0jhtRcaiLOmAx0nhcKO4; Mon, 01 Apr 2019 15:30:06 +0200
Subject: Re: [PATCH 0/2] DCMI bridge support
To:     Hugues FRUCHET <hugues.fruchet@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Philippe CORNU <philippe.cornu@st.com>,
        Mickael GUENE <mickael.guene@st.com>
References: <1554111076-31471-1-git-send-email-hugues.fruchet@st.com>
 <158aa8b9-e607-3630-0e13-ad10759d3468@xs4all.nl>
 <2ff6b4cb-dd57-e982-a839-00c50037d2a4@st.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <80572a34-a79c-862b-6040-668e8a79568b@xs4all.nl>
Date:   Mon, 1 Apr 2019 15:30:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2ff6b4cb-dd57-e982-a839-00c50037d2a4@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDxE8dmK+vCBLLcKLSS8/Uk+sjdNtt/uv7QYz8Gtf4YBBiKCKpzbaou3h4T2KbEUsn2DM1G7KgurPzbPldSELal1f5QbzNnFFO5S3TbQmwld3U/0r30p
 p5uTUqQ6SE1lh1Md+DL8Y98TR6KLaS3bhWZcb0FhRqtF0fqSmjGVkCXRiugQF0qd9GFB+ioiFRtxz1cRweL9Qsi0YQMtlEveLc33IDsITVyUWrSNvJ68MJbo
 7MjwmVTXS0NnEKMsNf/ogZLDRtoucGXDX9RPPXw04JeWRzcg+8xrk+yBV0hfCBO/9h8MkssxEV7ggtAug4u67c1iZWXT3p1UrPdl2Z6tTmdNDaGDMbJY7+g4
 2eXJKmRNoileQtmQVgoYH9wi5zofwMDZmo0bGe/jIqTTu+t0rcdw2t1g6svWwYZCoe6OGC0osnGUiA1ZExt/xlIvHvf0dLj3RxylrrOabV4WZeQmjmUTDkMy
 /JVuzYewTxwN2USQaj7E/b7+mPlJObd6MbKwA+pD+UxJNzCle5FnjA2CQzbAM5SZrCCKTP4Z34fcLjyAe1gtULXIdJPDlRDtTAuXEQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/19 3:08 PM, Hugues FRUCHET wrote:
> Hi Hans,
> 
> Here it is.
> 
> SHA1 is aa371c995ec2ad70323db00c47b3132002b060b7:
> 
> Author: Hans Verkuil <hverkuil-cisco@xs4all.nl>  2019-02-08 16:21:23
> Committer: Hans Verkuil <hverkuil-cisco@xs4all.nl>  2019-02-08 16:21:23
> Parent: 98d5622551eb6b9a0397464fb52378949f33c364 (v4l2-compliance: 
> support m2m devices with -f)
> Child:  59f9840781aab464c1331dcdb82e63dd0544b5c6 (v4l2-compliance: 
> remove duplicate MEDIA_IOC_DEVICE_INFO ioctl call)
> Branches: master, master2, remotes/origin/master
> Follows: v4l-utils-1.16.0
> Precedes:
> 
>      v4l2-compliance: -f bug fixes
> 
> 
> Result is below:
> 
> root@stm32mp1:~# v4l2-compliance -m /dev/media0
> v4l2-compliance SHA: eb8e3b07c9249ff56091ae4bc3ae9b76779db4cd, 32 bits
> 
> Compliance test for stm32-dcmi device /dev/media0:
> 
> Media Driver Info:
>          Driver name      : stm32-dcmi
>          Model            : stm32-dcmi
>          Serial           :
>          Bus info         : platform:stm32-dcmi
>          Media version    : 5.0.0
>          Hardware revision: 0x00000000 (0)
>          Driver version   : 5.0.0
> 
> Required ioctls:
>          test MEDIA_IOC_DEVICE_INFO: OK
> 
> Allow for multiple opens:
>          test second /dev/media0 open: OK
>          test MEDIA_IOC_DEVICE_INFO: OK
>          test for unlimited opens: OK
> 
> Media Controller ioctls:
>          test MEDIA_IOC_G_TOPOLOGY: OK
>          Entities: 3 Interfaces: 2 Pads: 4 Links: 4
>          test MEDIA_IOC_ENUM_ENTITIES/LINKS: OK
>          test MEDIA_IOC_SETUP_LINK: OK
> 
> Total for stm32-dcmi device /dev/media0: 7, Succeeded: 7, Failed: 0, 
> Warnings: 0
> --------------------------------------------------------------------------------
> Compliance test for stm32-dcmi device /dev/video0:
> 
> Driver Info:
>          Driver name      : stm32-dcmi
>          Card type        : STM32 Camera Memory Interface
>          Bus info         : platform:dcmi
>          Driver version   : 5.0.0
>          Capabilities     : 0x85200001
>                  Video Capture
>                  Read/Write
>                  Streaming
>                  [ 2117.336477] stm32-dcmi 4c006000.dcmi: 
> =================  START STATUS  =================
> E[ 2117.344647] stm32-dcmi 4c006000.dcmi: White Balance, Automatic: true
> [ 2117.350990] stm32-dcmi 4c006000.dcmi: Blue Balance: 0 inactive
> x[ 2117.356853] stm32-dcmi 4c006000.dcmi: Red Balance: 0 inactive
> [ 2117.362645] stm32-dcmi 4c006000.dcmi: Auto Exposure: Auto Mode
> [ 2117.368438] stm32-dcmi 4c006000.dcmi: Exposure: 0 inactive volatile
> t[ 2117.374729] stm32-dcmi 4c006000.dcmi: Gain, Automatic: true
> [ 2117.380335] stm32-dcmi 4c006000.dcmi: Gain: 0 inactive volatile
> e[ 2117.386305] stm32-dcmi 4c006000.dcmi: Saturation: 64
> [ 2117.391275] stm32-dcmi 4c006000.dcmi: Hue: 0
> n[ 2117.395572] stm32-dcmi 4c006000.dcmi: Contrast: 0
> [ 2117.400305] stm32-dcmi 4c006000.dcmi: Test Pattern: Disabled
> d[ 2117.405988] stm32-dcmi 4c006000.dcmi: Horizontal Flip: false
> [ 2117.411721] stm32-dcmi 4c006000.dcmi: Vertical Flip: false
> [ 2117.417148] stm32-dcmi 4c006000.dcmi: Power Line Frequency: 50 Hz
> [ 2117.423265] stm32-dcmi 4c006000.dcmi: ==================  END STATUS 
> ==================
> ed Pix Format
>                  Device Capabilities
>          Device Caps      : 0x05200001
>                  Video Capture
>                  Read/Write
>                  Streaming
>                  Extended Pix Format
> Media Driver Info:
>          Driver name      : stm32-dcmi
>          Model            : stm32-dcmi
>          Serial           :
>          Bus info         : platform:stm32-dcmi
>          Media version    : 5.0.0
>          Hardware revision: 0x00000000 (0)
>          Driver version   : 5.0.0
> Interface Info:
>          ID               : 0x03000003
>          Type             : V4L Video
> Entity Info:
>          ID               : 0x00000001 (1)
>          Name             : stm32_dcmi
>          Function         : V4L2 I/O
>          Flags         : default
>          Pad 0x01000002   : 0: Sink
>            Link 0x02000008: from remote pad 0x1000007 of entity 'mipid02 
> 0-0014': Data, Enabled, Immutable
> 
> Required ioctls:
>          test MC information (see 'Media Driver Info' above): OK
>                  warn: 
> ../../../../../../../../../sources/v4l-utils/utils/v4l2-compliance/v4l2-compliance.cpp(621): 
> media bus_info 'platform:stm32-dcmi
> ' differs from V4L2 bus_info 'platform:dcmi'
>          test VIDIOC_QUERYCAP: OK
> 
> Allow for multiple opens:
>          test second /dev/video0 open: OK
>                  warn: 
> ../../../../../../../../../sources/v4l-utils/utils/v4l2-compliance/v4l2-compliance.cpp(621): 
> media bus_info 'platform:stm32-dcmi
> ' differs from V4L2 bus_info 'platform:dcmi'
>          test VIDIOC_QUERYCAP: OK
>          test VIDIOC_G/S_PRIORITY: OK
>          test for unlimited opens: OK
> 
> Debug ioctls:
>          test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
>          test VIDIOC_LOG_STATUS: OK
> 
> Input ioctls:
>          test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
>          test VIDIOC_G/S_FRE[ 2117.564770] mipid02 0-0014: 
> =================  START STATUS  =================
> Q[ 2117.572042] mipid02 0-0014: ==================  END STATUS 
> ==================
> UENCY: OK (Not Supported)
>          test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
>          test VIDIOC_ENUMAUDIO: OK (Not Supported)
>          test VIDIOC_G/S/ENUMINPUT: OK
>          test VIDIOC_G/S_AUDIO: OK (Not Supported)
>          Inputs: 1 Audio Inputs: 0 Tuners: 0
> 
> Output ioctls:
>          test VIDIOC_G/S_MODULATOR: OK (Not Supported)
>          test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>          test VIDIOC_ENUMAUDOUT: OK (Not Supported)
>          test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
>          test VIDIOC_G/S_AUDOUT: OK (Not Supported)
>          Outputs: 0 Audio Outputs: 0 Modulators: 0
> 
> Input/Output configuration ioctls:
>          test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
>          test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
>          test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
>          test VIDIOC_G/S_EDID: OK (Not Supported)
> 
> Control ioctls (Input 0):
>          test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
>          test VIDIOC_QUERYCTRL: OK
>          test VIDIOC_G/S_CTRL: OK
>          test VIDIOC_G/S/TRY_EXT_CTRLS: OK
>          test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
>          test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
>          Standard Controls: 17 Private Controls: 0
> 
> Format ioctls (Input 0):
>          test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
>          test VIDIOC_G/S_PARM: OK
>          test VIDIOC_G_FBUF: OK (Not Supported)
>          test VIDIOC_G_FMT: OK
>          test VIDIOC_TRY_FMT: OK
>          test VIDIOC_S_FMT: OK
>          test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
>                  fail: 
> ../../../../../../../../../sources/v4l-utils/utils/v4l2-compliance/v4l2-test-formats.cpp(1338): 
> node->frmsizes_count[pixfmt] > 1
>          test Cropping: FAIL
>          test Composing: OK (Not Supported)
>          test Scaling: OK (Not Supported)
> 
> Codec ioctls (Input 0):
>          test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
>          test VIDIOC_G_ENC_INDEX: OK (Not Supported)
>          test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> 
> Buffer ioctls (Input 0):
>          test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>          test VIDIOC_EXPBUF: OK
>          test Requests: OK (Not Supported)
> 
> Total for stm32-dcmi device /dev/video0: 45, Succeeded: 44, Failed: 1, 
> Warnings: 2
> --------------------------------------------------------------------------------
> Compliance test for device /dev/v4l-subdev0:
> 
> 
> Required ioctls:
> 
> Allow for multiple opens:
>          test second /dev/v4l-subdev0 open: OK
>          test for unlimited opens: OK
> 
> Debug ioctls:
>          test VIDIOC_LOG_STATUS: OK (Not Supported)
> 
> Input ioctls:
>          test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
>          test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>          test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
>          test VIDIOC_ENUMAUDIO: OK (Not Supported)
>          test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
>          test VIDIOC_G/S_AUDIO: OK (Not Supported)
>          Inputs: 0 Audio Inputs: 0 Tuners: 0
> 
> Output ioctls:
>          test VIDIOC_G/S_MODULATOR: OK (Not Supported)
>          test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>          test VIDIOC_ENUMAUDOUT: OK (Not Supported)
>          test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
>          test VIDIOC_G/S_AUDOUT: OK (Not Supported)
>          Outputs: 0 Audio Outputs: 0 Modulators: 0
> 
> Input/Output configuration ioctls:
>          test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
>          test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
>          test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
>          test VIDIOC_G/S_EDID: OK (Not Supported)
> 
> Control ioctls:
>          test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
>          test VIDIOC_QUERYCTRL: OK (Not Supported)
>          test VIDIOC_G/S_CTRL: OK (Not Supported)
>          test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
>          test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
>          test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
>          Standard Controls: 0 Private Controls: 0
> 
> Format ioctls:
>          test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK (Not Supported)
>          test VIDIOC_G/S_PARM: OK (Not Supported)
>          test VIDIOC_G_FBUF: OK (Not Supported)
>          test VIDIOC_G_FMT: OK (Not Supported)
>          test VIDIOC_TRY_FMT: OK (Not Supported)
>          test VIDIOC_S_FMT: OK (Not Supported)
>          test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
>          test Cropping: OK (Not Supported)
>          test Composing: OK (Not Supported)
>          test Scaling: OK (Not Supported)
> 
> Codec ioctls:
>          test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
>          test VIDIOC_G_ENC_INDEX: OK (Not Supported)
>          test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> 
> Buffer ioctls:
>          test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK (Not Supported)
>          test VIDIOC_EXPBUF: OK (Not Supported)
>          test Requests: OK (Not Supported)
> 
> Total for device /dev/v4l-subdev0: 40, Succeeded: 40, Failed: 0, Warnings: 0
> 
> Grand Total for stm32-dcmi device /dev/media0: 92, Succeeded: 91, 
> Failed: 1, Warnings: 2

The warnings should be fixed (both warnings refer to the same problem).

The fail was present before this patch series.

The core problem there is that if there are multiple possible framesizes,
then crop support is ambiguous: against which framesize do you crop?

I see that dcmi_try_fmt() has a heuristic for that. We really need to fix
this in the API, but this situation rarely occurs.

So for now I don't think there is a need to fix the fail.

Regards,

	Hans

> 
> 
> BR,
> Hugues.
> 
> On 4/1/19 1:10 PM, Hans Verkuil wrote:
>> Hi Hugues,
>>
>> On 4/1/19 11:31 AM, Hugues Fruchet wrote:
>>> This patch serie allows to connect non-parallel camera sensor to
>>> DCMI thanks to a bridge connected in between such as STMIPID02 [1].
>>>
>>> Media controller support is introduced first, then support of
>>> several sub-devices within pipeline with dynamic linking
>>> between them.
>>
>> Can you post the output of v4l2-compliance -m /dev/mediaX ?
>>
>> Thanks!
>>
>> 	Hans
>>
>>>
>>> [1] https://www.spinics.net/lists/devicetree/msg278002.html
>>>
>>> Hugues Fruchet (2):
>>>    media: stm32-dcmi: add media controller support
>>>    media: stm32-dcmi: add support of several sub-devices
>>>
>>>   drivers/media/platform/Kconfig            |   2 +-
>>>   drivers/media/platform/stm32/stm32-dcmi.c | 213 ++++++++++++++++++++++++------
>>>   2 files changed, 177 insertions(+), 38 deletions(-)
>>>

