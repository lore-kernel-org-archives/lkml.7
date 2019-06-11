Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FDFC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C46521721
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfFKKsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:48:21 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42835 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfFKKsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:48:21 -0400
Received: by mail-qk1-f193.google.com with SMTP id b18so7288157qkc.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 03:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DRCwbC43b8I/kW8dfdjp5o7aL26cGS0PPjZPEn74b+o=;
        b=kJgS3WccPNx8fpoGAyKzKW/Z4qbUbx404t+Bgr8VUpU6tTJXp6tIfUWNgcwDcIYVAZ
         vUpOq4egRrK1NgEu1FjFz1SkKHclUGvpSKg+T6z9NdDxfn6zoC+cA6yEx7TVQBAtin8M
         7DdK6+aFFTOuiytnpPOXrPvytJJtu4/iiUfaRRGno9y7hkO35zIG+HRtYVWDM0ahxz3D
         1Va5EH/u2CpVJ3JVFP+hje8PVaNzlakhTtLJrdS+XMR5g+g3hYsyIII5Sej6tnYx0jfQ
         dSqNP7uQVGQREsxGSV2oEJ778arEAOHs/fVTw4OYh1vQ62K7VxMqBLGCOYM61x+KdpXB
         w+rg==
X-Gm-Message-State: APjAAAU1A3fRC7NXla6TCQNDApaiKBL8SfGkkCvXGevml1pAY4bzzW+y
        PePdUwg4P3sH41PU53e0VtgjtqhUFS/gL9SRog+yZg==
X-Google-Smtp-Source: APXvYqy/IzAdxwn2OQKKaBdRM9ltVhzXM8al+4wQK97WeEXh27E1i5y+HzDhxM5f6rsIk6EKPCWgqFec84r4T3B1PJU=
X-Received: by 2002:a37:8847:: with SMTP id k68mr59858881qkd.278.1560250100550;
 Tue, 11 Jun 2019 03:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190525140908.2804-1-yuehaibing@huawei.com> <50800f5e-867d-ded9-235c-b9c2db1c41ef@huawei.com>
In-Reply-To: <50800f5e-867d-ded9-235c-b9c2db1c41ef@huawei.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 11 Jun 2019 12:48:09 +0200
Message-ID: <CAO-hwJJYWGjp=gNs7X5fsg0tf18hpVA0cn63LxAme+LQnp+wrQ@mail.gmail.com>
Subject: Re: [PATCH -next] HID: logitech-dj: fix return value of logi_dj_recv_query_hidpp_devices
To:     Yuehaibing <yuehaibing@huawei.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>, jkosina@suse.cz,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 5:01 AM Yuehaibing <yuehaibing@huawei.com> wrote:
>
> Hi all,
>
> Friendly ping...

Applied to for-5.3/logitech

Thanks!

Cheers,
Benjamin

>
> On 2019/5/25 22:09, YueHaibing wrote:
> > We should return 'retval' as the correct return value
> > instead of always zero.
> >
> > Fixes: 74808f9115ce ("HID: logitech-dj: add support for non unifying receivers")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/hid/hid-logitech-dj.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> > index 41baa4dbbfcc..7f8db602eec0 100644
> > --- a/drivers/hid/hid-logitech-dj.c
> > +++ b/drivers/hid/hid-logitech-dj.c
> > @@ -1133,7 +1133,7 @@ static int logi_dj_recv_query_hidpp_devices(struct dj_receiver_dev *djrcv_dev)
> >                                   HID_REQ_SET_REPORT);
> >
> >       kfree(hidpp_report);
> > -     return 0;
> > +     return retval;
> >  }
> >
> >  static int logi_dj_recv_query_paired_devices(struct dj_receiver_dev *djrcv_dev)
> >
>
