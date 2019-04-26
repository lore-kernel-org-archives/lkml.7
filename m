Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D5DC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC12E20578
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfDZGim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:38:42 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34574 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDZGil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:38:41 -0400
Received: by mail-qt1-f194.google.com with SMTP id j6so2991710qtq.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 23:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=esgVSxyJEQJ3AKRIRb2wbVsQDVn3sWq4z5aYGFQZ51Q=;
        b=skqFIXwGzkq2X8B2UmXhNfaLI7k2ivVzm3cJSVkKZdtePu4MNjZGDF8a34Ww7YoKrQ
         b6CfWQ7OYxiPQJ5P6DFsvpTsoiQrnfD14m3fu7JC4uJEdtA5SF2NiWgCrYXl0EySVXDK
         241akz1ZxYoxhTr1dRWYlLUv13cuPkVKtNb/T6e5bL3l5Uek2N6C+yLDM2vQp8ADlJp8
         FWOxXz16KKHzkdOa0vrJe938xusbsqdyOUA2NYbS5H4MZqbNgGe0je/b2nFZvkQj4T/L
         zmUnRIWnLwMFYHBcsG7iHWyHcEkmaOfbC2sB+kZ1ajH6STbWwqarjRAzB5gzxKodU92d
         X9NQ==
X-Gm-Message-State: APjAAAWl/jBFdiPDhf1xEqskv2I8XmKa6J9yQ7aXoWE8+pv4Zh7Jnrp8
        WHhyU3Db6at6n+jB4eP4eEBsu1W8YtSDyKhJxhRURw==
X-Google-Smtp-Source: APXvYqx/mXPyh+LeeLejg8FzZQzg9oClnO0oTon65oqoa6XDy1NqSRpyOPhogdReSluhElyQy7kw8WV3iKNU/mQT7t8=
X-Received: by 2002:a0c:8881:: with SMTP id 1mr7549347qvn.231.1556260720871;
 Thu, 25 Apr 2019 23:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190425163846.51730-1-dmitry.torokhov@gmail.com> <20190425163846.51730-2-dmitry.torokhov@gmail.com>
In-Reply-To: <20190425163846.51730-2-dmitry.torokhov@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 26 Apr 2019 08:38:29 +0200
Message-ID: <CAO-hwJ+=n0Nh7XbcWRLeO5ay43YVwWK6vmMB=A5H23JKCWCUtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] HID: input: add mapping for KEY_KBD_LAYOUT_NEXT
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, gwink@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 6:38 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> HUTRR56 defined a new usage code on consumer page to cycle through
> set of keyboard layouts, let's add this mapping.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

I don't think this will collide with the HID tree, so IMO, you can
take this through yours if you want.

Cheers,
Benjamin

>  drivers/hid/hid-input.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index b607286a0bc8..0579b8d3f912 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1051,6 +1051,8 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>                 case 0x28b: map_key_clear(KEY_FORWARDMAIL);     break;
>                 case 0x28c: map_key_clear(KEY_SEND);            break;
>
> +               case 0x29d: map_key_clear(KEY_KBD_LAYOUT_NEXT); break;
> +
>                 case 0x2c7: map_key_clear(KEY_KBDINPUTASSIST_PREV);             break;
>                 case 0x2c8: map_key_clear(KEY_KBDINPUTASSIST_NEXT);             break;
>                 case 0x2c9: map_key_clear(KEY_KBDINPUTASSIST_PREVGROUP);                break;
> --
> 2.21.0.593.g511ec345e18-goog
>
