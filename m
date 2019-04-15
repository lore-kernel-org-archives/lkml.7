Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62228C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303042084B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfDOXkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 19:40:11 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:48850 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbfDOXkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 19:40:10 -0400
Received: from MUA
        by vps-vb.mhejs.net with esmtps (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1hGBCn-0006su-Mj; Tue, 16 Apr 2019 01:40:05 +0200
Subject: Re: [PATCH v9 3/4] [media] cxusb: add analog mode support for Medion
 MD95700
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Michael Krufky <mkrufky@linuxtv.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Walls <awalls@md.metrocast.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org
References: <cover.1553903063.git.mail@maciej.szmigiero.name>
 <0c30210a0d946cac6b17755e7d255541ff535023.1553903063.git.mail@maciej.szmigiero.name>
 <b33ebf2a-9507-9940-4474-6f37af4d8010@xs4all.nl>
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Openpgp: preference=signencrypt
Autocrypt: addr=mail@maciej.szmigiero.name; prefer-encrypt=mutual; keydata=
 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 PA==
Message-ID: <3927f261-9052-0b89-62c2-6fe8b4876ba1@maciej.szmigiero.name>
Date:   Tue, 16 Apr 2019 01:40:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b33ebf2a-9507-9940-4474-6f37af4d8010@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.2019 11:22, Hans Verkuil wrote:
> On 3/30/19 12:51 AM, Maciej S. Szmigiero wrote:
>> This patch adds support for analog part of Medion 95700 in the cxusb
>> driver.
>>
>> What works:
>> * Video capture at various sizes with sequential fields,
>> * Input switching (TV Tuner, Composite, S-Video),
>> * TV and radio tuning,
>> * Video standard switching and auto detection,
>> * Radio mode switching (stereo / mono),
>> * Unplugging while capturing,
>> * DVB / analog coexistence.
>>
>> What does not work yet:
>> * Audio,
>> * VBI,
>> * Picture controls.
>>
>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>> ---
(..)
>> +static int cxusb_medion_try_s_fmt_vid_cap(struct file *file,
>> +					  struct v4l2_format *f,
>> +					  bool isset)
>> +{
>> +	struct dvb_usb_device *dvbdev = video_drvdata(file);
>> +	struct cxusb_medion_dev *cxdev = dvbdev->priv;
>> +	struct v4l2_subdev_format subfmt;
>> +	int ret;
>> +
>> +	if (isset && (vb2_start_streaming_called(&cxdev->videoqueue) ||
>> +		      cxdev->stop_streaming))
> 
> This should be:
> 
> 	if (isset && vb2_is_busy(&cxdev->videoqueue))
> 
> As long as buffers are allocated you can no longer change the format.
> 
>> +		return -EBUSY;
>> +
>> +	memset(&subfmt, 0, sizeof(subfmt));
>> +	subfmt.which = isset ? V4L2_SUBDEV_FORMAT_ACTIVE :
>> +		V4L2_SUBDEV_FORMAT_TRY;
>> +	subfmt.format.width = f->fmt.pix.width & ~1;
>> +	subfmt.format.height = f->fmt.pix.height & ~1;
>> +	subfmt.format.code = MEDIA_BUS_FMT_FIXED;
>> +	subfmt.format.field = V4L2_FIELD_SEQ_TB;
> 
> Why FIELD_SEQ_TB? If memory serves the cx25840 always uses FIELD_INTERLACED.

It looks like all the existing cx25840 users use an intelligent bridge
chip (or a MPEG encoder), which normalize the video data received to
a nice V4L2_FIELD_INTERLACED.

However, this device uses a "dumb" USB bridge chip which does not do any
video processing (other than dropping parts of it if the host PC is not
receiving it fast enough), so the output data matches what the cx25840
chip produces - and it produces a sequential fields format.

>> +	subfmt.format.colorspace = V4L2_COLORSPACE_SMPTE170M;
>> +
>> +	ret = v4l2_subdev_call(cxdev->cx25840, pad, set_fmt, NULL, &subfmt);
>> +	if (ret != 0) {
>> +		if (ret != -ERANGE)
>> +			return ret;
>> +
>> +		/* try some common formats */
>> +		subfmt.format.width = 720;
>> +		subfmt.format.height = 576;
>> +		ret = v4l2_subdev_call(cxdev->cx25840, pad, set_fmt, NULL,
>> +				       &subfmt);
>> +		if (ret != 0) {
>> +			if (ret != -ERANGE)
>> +				return ret;
>> +
>> +			subfmt.format.width = 640;
>> +			subfmt.format.height = 480;
>> +			ret = v4l2_subdev_call(cxdev->cx25840, pad, set_fmt,
>> +					       NULL, &subfmt);
>> +			if (ret != 0)
>> +				return ret;
>> +		}
> 
> Why these fallbacks? Is this really needed?

V4L2 docs say that VIDIOC_{S,TRY}_FMT ioctls "should not return an error
code unless the type field is invalid", that is, they should not return
an error for invalid or unsupported image widths or heights.
They should instead return something sensible for these image parameters.

However, cx25840 driver set_fmt callback simply returns -ERANGE if it
does not like the provided width or height.
In this case the code above simply tries first the bigger PAL capture
resolution then the smaller NTSC one.
Which one will be accepted by the cx25840 depends on the currently set
broadcast standard and parameters of the last signal that was received,
at least one of these resolutions seem to work even without any
signal being received since the chip was powered up.

This way the API guarantees should be kept by the driver.

>> +int cxusb_medion_analog_init(struct dvb_usb_device *dvbdev)
>> +{
>> +	struct cxusb_medion_dev *cxdev = dvbdev->priv;
>> +	u8 tuner_analog_msg_data[] = { 0x9c, 0x60, 0x85, 0x54 };
>> +	struct i2c_msg tuner_analog_msg = { .addr = 0x61, .flags = 0,
>> +					    .buf = tuner_analog_msg_data,
>> +					    .len =
>> +					    sizeof(tuner_analog_msg_data) };
>> +	struct v4l2_subdev_format subfmt;
>> +	int ret;
>> +
>> +	/* switch tuner to analog mode so IF demod will become accessible */
>> +	ret = i2c_transfer(&dvbdev->i2c_adap, &tuner_analog_msg, 1);
>> +	if (ret != 1)
>> +		dev_warn(&dvbdev->udev->dev,
>> +			 "tuner analog switch failed (%d)\n", ret);
>> +
>> +	/*
>> +	 * cx25840 might have lost power during mode switching so we need
>> +	 * to set it again
>> +	 */
>> +	ret = v4l2_subdev_call(cxdev->cx25840, core, reset, 0);
>> +	if (ret != 0)
>> +		dev_warn(&dvbdev->udev->dev,
>> +			 "cx25840 reset failed (%d)\n", ret);
>> +
>> +	ret = v4l2_subdev_call(cxdev->cx25840, video, s_routing,
>> +			       CX25840_COMPOSITE1, 0, 0);
>> +	if (ret != 0)
>> +		dev_warn(&dvbdev->udev->dev,
>> +			 "cx25840 initial input setting failed (%d)\n", ret);
>> +
>> +	/* composite */
>> +	cxdev->input = 1;
>> +	cxdev->norm = 0;
>> +
>> +	/* TODO: setup audio samples insertion */
>> +
>> +	ret = v4l2_subdev_call(cxdev->cx25840, core, s_io_pin_config,
>> +			       sizeof(cxusub_medion_pin_config) /
>> +			       sizeof(cxusub_medion_pin_config[0]),
>> +			       cxusub_medion_pin_config);
>> +	if (ret != 0)
>> +		dev_warn(&dvbdev->udev->dev,
>> +			"cx25840 pin config failed (%d)\n", ret);
>> +
>> +	/* make sure that we aren't in radio mode */
>> +	v4l2_subdev_call(cxdev->tda9887, video, s_std, V4L2_STD_PAL);
>> +	v4l2_subdev_call(cxdev->tuner, video, s_std, V4L2_STD_PAL);
>> +	v4l2_subdev_call(cxdev->cx25840, video, s_std, cxdev->norm);
>> +
>> +	memset(&subfmt, 0, sizeof(subfmt));
>> +	subfmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
>> +	subfmt.format.width = cxdev->width;
>> +	subfmt.format.height = cxdev->height;
>> +	subfmt.format.code = MEDIA_BUS_FMT_FIXED;
>> +	subfmt.format.field = V4L2_FIELD_SEQ_TB;
>> +	subfmt.format.colorspace = V4L2_COLORSPACE_SMPTE170M;
>> +
>> +	ret = v4l2_subdev_call(cxdev->cx25840, pad, set_fmt, NULL, &subfmt);
>> +	if (ret != 0) {
>> +		subfmt.format.width = 640;
>> +		subfmt.format.height = 480;
> 
> Why the fallback to 640x480?

This resolution seems to work even without any signal being received,
and it is a sensible NTSC-like resolution so it makes a good fallback
if restoring the previously used resolution has failed.

>> +		ret = v4l2_subdev_call(cxdev->cx25840, pad, set_fmt, NULL,
>> +				       &subfmt);
>> +		if (ret != 0)
>> +			dev_warn(&dvbdev->udev->dev,
>> +				 "cx25840 format set failed (%d)\n", ret);
>> +	}
>> +
>> +	if (ret == 0) {
>> +		cxdev->width = subfmt.format.width;
>> +		cxdev->height = subfmt.format.height;
>> +	}
>> +
>> +	return 0;
>> +}
>> +

> 
> Regards,
> 
> 	Hans
> 

Thanks and best regards,
Maciej
