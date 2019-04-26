Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48394C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE1B20675
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfDZG0h convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:26:37 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35986 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfDZG0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:26:37 -0400
Received: by mail-qt1-f196.google.com with SMTP id c35so2955989qtk.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 23:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZQNZ4iQSzC6GpABMj1ZNXDeC9DcJXeVOK1d6t7edZK8=;
        b=QIVy8LUcXE4N6w4v2k1/wLxZw3e72PBw0vXv+lhVBQij7+P6ghwiiMuMzYVWCxfmQK
         dUH0fNQKgunGLFuURAP/2bC+QhuSR3KVyGtPEmucLlqT7QV0Y8wPbzrueAULOda13Pt8
         koPzJwUl2eDBmmHYgiVQhtbXIICx+bFZqLQgmz9mtxDYgqq32Bm3ysh8hEI0IqKQ+rVb
         AiYMUFB2NC09lYjDfgaYKjYgW/E2Enc/mTfo1E91Yh2kEnuK+pvL6pcMHZ2aekUJJp/Z
         xhSee2B7nQ/+HwjxpSbcg7gksh4pTmDKc6+1l4zmSl27vDdWgwz2XjiD1WxcQoYiXmK7
         zaOw==
X-Gm-Message-State: APjAAAXlc6iyr0th4Dj8jjZLhP4EK0px8oJS5qvJULpS9dBhfiCNC1FF
        BtKKpdNxY842C9rj9HPJ6Itpd1LDJkZiYK98AW2FNQ==
X-Google-Smtp-Source: APXvYqyPVeU0AHwG29b7Yj0e1JEn1v2cd23QCRIRtuZHJl0L6bCECDv3GMshTZioAd/XsnXd9d311YAaBHpKkd8Y/XE=
X-Received: by 2002:ac8:247c:: with SMTP id d57mr35401821qtd.308.1556259996338;
 Thu, 25 Apr 2019 23:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190422031251.11968-1-ronald@innovation.ch> <20190422031251.11968-2-ronald@innovation.ch>
 <CAO-hwJLMZvBGheEtH_iU+mBtE4T3OsT6W+=1x-ewzGGP5Fxp4Q@mail.gmail.com>
 <20190425081948.GB31301@innovation.ch> <CAO-hwJKcuptG6X7Y0jrQzyLUzZfsXoyWxMmk=v_aPxJh9iv4Gg@mail.gmail.com>
 <20190426055632.GC31266@innovation.ch>
In-Reply-To: <20190426055632.GC31266@innovation.ch>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 26 Apr 2019 08:26:25 +0200
Message-ID: <CAO-hwJJOixkp9i9RYOhDZrw4_R0_5u52yvdui3NwEWHRyvNFow@mail.gmail.com>
Subject: Re: [PATCH 1/3] mfd: apple-ibridge: Add Apple iBridge MFD driver.
To:     "Life is hard, and then you die" <ronald@innovation.ch>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-iio@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 7:56 AM Life is hard, and then you die
<ronald@innovation.ch> wrote:
>
>
>   Hi Benjamin,
>
> On Thu, Apr 25, 2019 at 11:39:12AM +0200, Benjamin Tissoires wrote:
> > On Thu, Apr 25, 2019 at 10:19 AM Life is hard, and then you die
> > <ronald@innovation.ch> wrote:
> > >
> > >   Hi Benjamin,
> > >
> > > Thank you for looking at this.
> > >
> > > On Wed, Apr 24, 2019 at 04:18:23PM +0200, Benjamin Tissoires wrote:
> > > > On Mon, Apr 22, 2019 at 5:13 AM Ronald Tschalär <ronald@innovation.ch> wrote:
> > > > >
> > > > > The iBridge device provides access to several devices, including:
> > > > > - the Touch Bar
> > > > > - the iSight webcam
> > > > > - the light sensor
> > > > > - the fingerprint sensor
> > > > >
> > > > > This driver provides the core support for managing the iBridge device
> > > > > and the access to the underlying devices. In particular, since the
> > > > > functionality for the touch bar and light sensor is exposed via USB HID
> > > > > interfaces, and the same HID device is used for multiple functions, this
> > > > > driver provides a multiplexing layer that allows multiple HID drivers to
> > > > > be registered for a given HID device. This allows the touch bar and ALS
> > > > > driver to be separated out into their own modules.
> > > >
> > > > Sorry for coming late to the party, but IMO this series is far too
> > > > complex for what you need.
> > > >
> > > > As I read this and the first comment of drivers/mfd/apple-ibridge.c,
> > > > you need to have a HID driver that multiplex 2 other sub drivers
> > > > through one USB communication.
> > > > For that, you are using MFD, platform driver and you own sauce instead
> > > > of creating a bus.
> > >
> > > Basically correct. To be a bit more precise, there are currently two
> > > hid-devices and two drivers (touchbar and als) involved, with
> > > connections as follows (pardon the ugly ascii art):
> > >
> > >   hdev1  ---  tb-drv
> > >            /
> > >           /
> > >          /
> > >   hdev2  ---  als-drv
> > >
> > > i.e. the touchbar driver talks to both hdev's, and hdev2's events
> > > (reports) are processed by both drivers (though each handles different
> > > reports).
> > >
> > > > So, how about we reuse entirely the HID subsystem which already
> > > > provides the capability you need (assuming I am correct above).
> > > > hid-logitech-dj already does the same kind of stuff and you could:
> > > > - create drivers/hid/hid-ibridge.c that handles USB_ID_PRODUCT_IBRIDGE
> > > > - hid-ibridge will then register itself to the hid subsystem with a
> > > > call to hid_hw_start(hdev, HID_CONNECT_HIDRAW) and
> > > > hid_device_io_start(hdev) to enable the events (so you don't create
> > > > useless input nodes for it)
> > > > - then you add your 2 new devices by calling hid_allocate_device() and
> > > > then hid_add_device(). You can even create a new HID group
> > > > APPLE_IBRIDGE and allocate 2 new PIDs for them to distinguish them
> > > > from the actual USB device.
> > > > - then you have 2 brand new HID devices you can create their driver as
> > > > a regular ones.
> > > >
> > > > hid-ibridge.c would just need to behave like any other hid transport
> > > > driver (see logi_dj_ll_driver in drivers/hid/hid-logitech-dj.c) and
> > > > you can get rid of at least the MFD and the platform part of your
> > > > drivers.
> > > >
> > > > Does it makes sense or am I missing something obvious in the middle?
> > >
> > > Yes, I think I understand, and I think this can work. Basically,
> > > instead of demux'ing at the hid-driver level as I am doing now (i.e.
> > > the iBridge hid-driver forwarding calls to the sub-hid-drivers), we
> > > demux at the hid-device level (events forwarded from iBridge hdev to
> > > all "virtual" sub-hdev's, and requests from sub-hdev's forwarded to
> > > the original hdev via an iBridge ll_driver attached to the
> > > sub-hdev's).
> > >
> > > So I would need to create 3 new "virtual" hid-devices (instances) as
> > > follows:
> > >
> > >   hdev1  ---  vhdev1  ---  tb-drv
> > >                         /
> > >           --  vhdev2  --
> > >          /
> > >   hdev2  ---  vhdev3  ---  als-drv
> > >
> > > (vhdev1 is probably not strictly necessary, but makes things more
> > > consistent).
> >
> > Oh, ok.
> >
> > How about the following:
> >
> > hdev1 and hdev2 are merged together in hid-apple-ibridge.c, and then
> > this driver creates 2 virtual hid drivers that are consistent
> >
> > like
> >
> > hdev1---ibridge-drv---vhdev1---tb-drv
> > hdev2--/           \--vhdev2---als-drv
>
> I don't think this will work. The problem is when the sub-drivers need
> to send a report or usb-command: how to they specify which hdev the
> report/command is destined for? While we could store the original hdev
> in each report (the hid_report's device field), that only works for
> hid_hw_request(), but not for things like hid_hw_raw_request() or
> hid_hw_output_report(). Now, currently I don't use the latter two; but
> I do need to send raw usb control messages in the touchbar driver
> (some commands are not proper hid reports), so it definitely breaks
> down there.
>
> Or am I missing something?
>

I'd need to have a deeper look at the protocol, but you can emulate
pure HID devices by having your ibridge handling a translation from
set/get features/input to the usb control messages. Likewise, nothing
prevents you to slightly rewrite the report descriptors you present to
the als and touchbar to have a clear separation with the report ID.

For example, if both hdev1 and hdev2 use a report ID of 0x01, you
could rewrite the report descriptor so that when you receive a report
with an id of 0x01 you send this to hdev1, but you can also translate
0x11 to a report ID 0x01 to hdev2.
Likewise, report ID 0x42 could be a raw USB control message to the USB
under hdev2.

Note that you will have to write 2 report descriptors for your new
devices, but you can take what makes sense from the original ones, and
just add a new collection with a vendor application with with an
opaque meaning (for the USB control messages).

Cheers,
Benjamin
