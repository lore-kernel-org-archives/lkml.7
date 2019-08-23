Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53875C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311E421726
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392079AbfHWKHM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:07:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392021AbfHWKHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:07:04 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9D12756
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 10:07:03 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id r10so9392022qte.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 03:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1qTrupegLo3u3nuR5XIE3rXtDob+SQqNerz4BULqfAk=;
        b=Ew7r3o/CfYfz4fYWXrSDgtHv6wkEdf0zhGiwwEHBYkDpUWYpICcqd/xCrwoMte+wut
         PbJvvSckRxeaMUJcBahWZGH8ciJg7VXPiCzLBNimXndjlF6QFXANrzXhKpchz34EoF6z
         pPwHf+v/KHDWTX4L11poxbvrKVBWn/xbCFMevJUS2YQ/je2TR7gw/hiuiv+DD3UfTU+1
         7UAHqhAcc18B+3Upu6JlWOaURujCOVztA8tbAPjM5WfHuOwlzW1Hwi+50A97WskBfteB
         dMV03SDgYxH95sQRNafTYMP/dj+DxquAuDQs2+0zEANbHXAaedPujY2GGJ6b3Tkp12FE
         IQTQ==
X-Gm-Message-State: APjAAAVOgRfIKh7CGCz/YqwjJZp4WjtDVe9hCLZbECEHvFFrKujOIk7H
        mX06poWkI+f7/SxwlBHH85kL5waosCdZv1qsBeX0+2FEjRQ/ISmzTnPLcw8C1WlKhLym01FL/Pt
        /s0ZxPIQXPAiBF/WsPCyUl8a+Vv6c0zMTao/kP/AK
X-Received: by 2002:ad4:4974:: with SMTP id p20mr3008444qvy.29.1566554822994;
        Fri, 23 Aug 2019 03:07:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxNwW5Vj+CElg3egvLGrz0tB/3keOZ4CzgCNyFMXCyW2lgOmeoRIPAm0sFQuM0jFiHntpZDy1KFOILCqvhXN5s=
X-Received: by 2002:ad4:4974:: with SMTP id p20mr3008436qvy.29.1566554822772;
 Fri, 23 Aug 2019 03:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190730122458.5275-1-lains@archlinux.org>
In-Reply-To: <20190730122458.5275-1-lains@archlinux.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 23 Aug 2019 12:06:51 +0200
Message-ID: <CAO-hwJJ2kFoAp8at_a+KRfjivZ2VnbNDXsx=BBQbiEDLZ==3Sg@mail.gmail.com>
Subject: Re: [PATCH v2] hid-logitech-dj: add the new Lightspeed receiver
To:     =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
Cc:     Nestor Lopez Casado <nlopezcasad@logitech.com>,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 2:26 PM Filipe Laíns <lains@archlinux.org> wrote:
>
> This patchs adds the new Lightspeed receiver. Currently it seems to only
> be used in the G305.
>
> Signed-off-by: Filipe Laíns <lains@archlinux.org>

Applied to for-5.4/logitech

Cheers,
Benjamin

> ---
>  drivers/hid/hid-ids.h         |  3 ++-
>  drivers/hid/hid-logitech-dj.c | 13 +++++++++++--
>  2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index fb19eefbc0b3..61b954fcfc2e 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -768,7 +768,8 @@
>  #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER           0xc52f
>  #define USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVER_2     0xc532
>  #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_2         0xc534
> -#define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED        0xc539
> +#define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1      0xc539
> +#define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_1    0xc53f
>  #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_POWERPLAY 0xc53a
>  #define USB_DEVICE_ID_SPACETRAVELLER   0xc623
>  #define USB_DEVICE_ID_SPACENAVIGATOR   0xc626
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index 4a68960b131f..d718f01f56d3 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -968,7 +968,12 @@ static void logi_hidpp_recv_queue_notif(struct hid_device *hdev,
>                 logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
>                 break;
>         case 0x0c:
> -               device_type = "eQUAD Lightspeed";
> +               device_type = "eQUAD Lightspeed 1";
> +               logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
> +               workitem.reports_supported |= STD_KEYBOARD;
> +               break;
> +       case 0x0d:
> +               device_type = "eQUAD Lightspeed 1_1";
>                 logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
>                 workitem.reports_supported |= STD_KEYBOARD;
>                 break;
> @@ -1832,7 +1837,11 @@ static const struct hid_device_id logi_dj_receivers[] = {
>          .driver_data = recvr_type_hidpp},
>         { /* Logitech lightspeed receiver (0xc539) */
>           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> -               USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED),
> +               USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1),
> +        .driver_data = recvr_type_gaming_hidpp},
> +       { /* Logitech lightspeed receiver (0xc53f) */
> +         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> +               USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_1),
>          .driver_data = recvr_type_gaming_hidpp},
>         { /* Logitech 27 MHz HID++ 1.0 receiver (0xc513) */
>           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_MX3000_RECEIVER),
> --
> 2.22.0
