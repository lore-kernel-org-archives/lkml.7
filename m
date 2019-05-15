Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9E6C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEB92082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfEONA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 09:00:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59434 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfEONA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:00:27 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id EC2FE27BA8D
Subject: Re: [PATCH v3 1/2] platform/chrome: wilco_ec: Add Boot on AC support
To:     Nick Crews <ncrews@chromium.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Daniel Erat <derat@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Simon Glass <sjg@chromium.org>, bartfab@chromium.org,
        Oleh Lamzin <lamzin@google.com>,
        Jason Wong <jchwong@google.com>
References: <20190417012048.87977-1-ncrews@chromium.org>
 <CAFqH_53L-rq3pGny90eAS1ho__vAxnLt5i_F1pvo+=PA1fO-HQ@mail.gmail.com>
 <CAHX4x8506kfxeuk4n5Q=HjceT5zV-gifGXYNYfge_wV825ki4Q@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <7c672532-e1f4-0e10-94a0-728a7fe575cb@collabora.com>
Date:   Wed, 15 May 2019 15:00:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHX4x8506kfxeuk4n5Q=HjceT5zV-gifGXYNYfge_wV825ki4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/5/19 18:09, Nick Crews wrote:
> Thanks for the review Enric!
> 
> I can resend the patch with the fixes, or if you think the fixes are
> simple enough, you could tweak them as you apply them. Let
> me know if you want me to resend a clean version.
> 

No need to resend, I tweaked them.

The patch is queued to the for-next branch for the autobuilders to play with, if
all goes well I'll add the patch for 5.3 when current merge window closes.

Thanks,
 Enric


>>> +
>>> +static DEVICE_ATTR_WO(boot_on_ac);
>>
>> Is not possible to read the flag? From the API description seems that it is.
> 
> It is not possible to read the flag. The API description is wrong,
> I'll fix remove
> the line about reading from the documentation.
> 
>>> +void wilco_ec_remove_sysfs(struct wilco_ec_device *ec)
>>> +{
>>> +       sysfs_create_group(&ec->dev->kobj, &wilco_dev_attr_group);
>>
>> As Guenter pointed:  sysfs_remove_group()
> 
> Yes, exactly.
> 
