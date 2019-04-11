Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A47C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610A7217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfDKHyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:54:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47018 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfDKHym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:54:42 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hEUXg-0006GE-PP
        for linux-kernel@vger.kernel.org; Thu, 11 Apr 2019 07:54:40 +0000
Received: by mail-pf1-f197.google.com with SMTP id g83so3774223pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 00:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HkNXh+4xiympXYqqWJcQIb61EJ3dAcyW6hTTwwpfCmc=;
        b=Dwi3eocI4X2D4IhVuOQhFAHuQycMwMN2x0kwhXScfA8vnJzlJmIKdNuuxsacTx1Gm7
         bQmV46zp4dzxuZMlWaA/tmvz72ik4R/+k/CzVo7XCjS5g2dEqHdaSKfbOOsjIDq4qZEw
         eAgvc1+MKpwBULFnclpa/4sClOj2llyyUcvFg3efmnhwnTXWdg098krCgqEYH9teNyO8
         vk0xgckBKxD+Mb6zBEy+GUwbiKZZSWqZ+fIyzMHeroHPofkVeinJcB1GWiSijrApE3Mn
         xrSFroQvoTWc1tHmMYFjlhoN+HLov0GrrZ20Y/Ia6LoEefcT7fPf75RimiXxklWU6tof
         Pe0w==
X-Gm-Message-State: APjAAAV93DU+JaUJa+esdoSE2ZgxhQJ6lNWR7ctRwyktb4QrskmOyLlU
        3aLQYZ7WPtpQQ05Hp3SY8KEAjyEUSX2KwEKZ3SjYGGHwjF7xV4YOMvU3V3ljuKEYeG0euBOugC8
        Nwzkl3CkMKC+ThyD4cOiAyNKONXDmpgCWbi0tZbHjYQ==
X-Received: by 2002:a17:902:d24:: with SMTP id 33mr49857987plu.246.1554969279396;
        Thu, 11 Apr 2019 00:54:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwIlla7xJii1YsohMxgPLk3ZuNeeOxkguOFBDyqBnU1+l1QzY5DvtjVARZhOJAD2gJwQc/IMg==
X-Received: by 2002:a17:902:d24:: with SMTP id 33mr49857962plu.246.1554969279033;
        Thu, 11 Apr 2019 00:54:39 -0700 (PDT)
Received: from 2001-b011-380f-14b9-9cff-45f9-ad8b-c268.dynamic-ip6.hinet.net (2001-b011-380f-14b9-9cff-45f9-ad8b-c268.dynamic-ip6.hinet.net. [2001:b011:380f:14b9:9cff:45f9:ad8b:c268])
        by smtp.gmail.com with ESMTPSA id l2sm42048820pgl.2.2019.04.11.00.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 00:54:38 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH v2] Input: elantech: Enable SMBus on new (2018+) systems
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAO-hwJLPFzwkY+tkgeas8066CNygfyTY2EoVrximURx4dwQ0TQ@mail.gmail.com>
Date:   Thu, 11 Apr 2019 15:54:35 +0800
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?utf-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <F7D6560C-789E-48E4-B2B9-BC2EBED16E7F@canonical.com>
References: <20190121070258.1844-1-kai.heng.feng@canonical.com>
 <CAO-hwJLPFzwkY+tkgeas8066CNygfyTY2EoVrximURx4dwQ0TQ@mail.gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


at 16:33, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:

> On Mon, Jan 21, 2019 at 8:03 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> There are some new HP laptops with Elantech touchpad don't support
>> multitouch.
>>
>> Currently we use ETP_NEW_IC_SMBUS_HOST_NOTIFY() to check if SMBus is
>> supported, but in addition to firmware version, the bus type also
>> informs us if the IC can support SMBus, so also check that.
>>
>> In case of breaking old ICs, only enables SMBus on systems manufactured
>> after 2018, alongsides aforementioned checks.
>>
>> Lastly, consolidats all check into elantech_use_host_notify() and use it
>> to determine whether to use PS/2 or SMBus.
>>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> v2:
>> - Wording.
>> - Further restrain on older systems (< 2018).
>>
>>  drivers/input/mouse/elantech.c | 63 ++++++++++++++++++----------------
>>  1 file changed, 34 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/input/mouse/elantech.c  
>> b/drivers/input/mouse/elantech.c
>> index 9fe075c137dc..2594130b0079 100644
>> --- a/drivers/input/mouse/elantech.c
>> +++ b/drivers/input/mouse/elantech.c
>> @@ -1799,6 +1799,39 @@ static int elantech_create_smbus(struct psmouse  
>> *psmouse,
>>                                   leave_breadcrumbs);
>>  }
>>
>> +static bool elantech_use_host_notify(struct psmouse *psmouse,
>> +                                    struct elantech_device_info *info)
>> +{
>> +       bool host_notify = false;
>> +
>> +       if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
>> +               host_notify = true;
>> +       else {
>> +               switch (info->bus) {
>> +               case ETP_BUS_PS2_ONLY:
>> +                       /* expected case */
>> +                       break;
>> +               case ETP_BUS_SMB_ALERT_ONLY:
>> +                       /* fall-through  */
>> +               case ETP_BUS_PS2_SMB_ALERT:
>> +                       psmouse_dbg(psmouse, "Ignoring SMBus provider  
>> through alert protocol.\n");
>> +                       break;
>> +               case ETP_BUS_SMB_HST_NTFY_ONLY:
>> +                       /* fall-through  */
>> +               case ETP_BUS_PS2_SMB_HST_NTFY:
>> +                       host_notify = true;
>> +                       break;
>> +               default:
>> +                       psmouse_dbg(psmouse,
>> +                                   "Ignoring SMBus bus provider %d.\n",
>> +                                   info->bus);
>> +               }
>> +       }
>> +
>> +       /* SMbus implementation is stable after 2018 */
>> +       return host_notify && (dmi_get_bios_year() >= 2018);
>
> Strictly speaking, the check for the year should be in the `switch
> (info->bus)`, but OTOH, laptops with ETP_NEW_IC_SMBUS_HOST_NOTIFY
> should be manufactured after 2018 too, so we should be good.
>
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Hi Dmitry,

Would it be possible to include this patch?

Kai-Heng

>
> Cheers,
> Benjamin
>
>> +}
>> +
>>  /**
>>   * elantech_setup_smbus - called once the PS/2 devices are enumerated
>>   * and decides to instantiate a SMBus InterTouch device.
>> @@ -1818,7 +1851,7 @@ static int elantech_setup_smbus(struct psmouse  
>> *psmouse,
>>                  * i2c_blacklist_pnp_ids.
>>                  * Old ICs are up to the user to decide.
>>                  */
>> -               if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version) ||
>> +               if (!elantech_use_host_notify(psmouse, info) ||
>>                     psmouse_matches_pnp_id(psmouse, i2c_blacklist_pnp_ids))
>>                         return -ENXIO;
>>         }
>> @@ -1838,34 +1871,6 @@ static int elantech_setup_smbus(struct psmouse  
>> *psmouse,
>>         return 0;
>>  }
>>
>> -static bool elantech_use_host_notify(struct psmouse *psmouse,
>> -                                    struct elantech_device_info *info)
>> -{
>> -       if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
>> -               return true;
>> -
>> -       switch (info->bus) {
>> -       case ETP_BUS_PS2_ONLY:
>> -               /* expected case */
>> -               break;
>> -       case ETP_BUS_SMB_ALERT_ONLY:
>> -               /* fall-through  */
>> -       case ETP_BUS_PS2_SMB_ALERT:
>> -               psmouse_dbg(psmouse, "Ignoring SMBus provider through  
>> alert protocol.\n");
>> -               break;
>> -       case ETP_BUS_SMB_HST_NTFY_ONLY:
>> -               /* fall-through  */
>> -       case ETP_BUS_PS2_SMB_HST_NTFY:
>> -               return true;
>> -       default:
>> -               psmouse_dbg(psmouse,
>> -                           "Ignoring SMBus bus provider %d.\n",
>> -                           info->bus);
>> -       }
>> -
>> -       return false;
>> -}
>> -
>>  int elantech_init_smbus(struct psmouse *psmouse)
>>  {
>>         struct elantech_device_info info;
>> —

>> 2.17.1

