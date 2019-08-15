Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0695C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A524E20644
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732690AbfHOODR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:03:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38608 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732300AbfHOODQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:03:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so2329025wrr.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 07:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4sFRcD1ANoWWQjD+WhW2uig+aUbXyWs74RzRVjo7E7o=;
        b=RYyXNCdG9S3+p2B9CBHPtQo8qJBkvcwoB1MX0yf2euRRDYkPBUMNBkMqxi+RaK7B1Y
         HOTHXeAgH2B+TMgVzI2/lXpWDdoX1Z9eWQ9xR+nx4eF/Rfb0bvsbn+QLQMvDF34Rbifa
         iW3BMrJdrKi01hkCS04dq3MQ08KQO7UPTRuPHcWIsQ5BT/VUMKzFJUZw+6+sbhrWxZqZ
         J5JsK1t1jKMdA6jI7gPFViN6C6gSxEKIfsqKbmxwrxaiVxDBqWLQmnjXUSp3/F/fiVU5
         R3sLXEJU1iCaFXCFh183YohS2A7R+uq57ThnZPKg7Gmgjd73ZXcEoznVCtQ13QgZiV0H
         itHw==
X-Gm-Message-State: APjAAAVLs/v3Xp4gFclF4O5pFehMGLHcYze7y8UoVyxV3fsBXjwkgvnn
        NZxvH5ZS26qu+6GpBosKLyh3Pcl+wyY=
X-Google-Smtp-Source: APXvYqwOA1TUL5mIA6h1Tmg6qNpWnTKtEDEY963alOerUO+bTFmeEckdF/0ltUvBOOFFdQ5wGxXd6g==
X-Received: by 2002:adf:f0ce:: with SMTP id x14mr5695032wro.31.1565877793938;
        Thu, 15 Aug 2019 07:03:13 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id t63sm1590627wmt.6.2019.08.15.07.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 07:03:13 -0700 (PDT)
Subject: Re: [PATCH 0/3] usb: typec: fusb302: Small changes
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190814132419.39759-1-heikki.krogerus@linux.intel.com>
 <a826c351-4e9d-8a33-ad0f-764d13aeb1ed@redhat.com>
 <20190815125544.GC24270@kroah.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3f44f67a-9f13-3851-e218-7f9c14d8f996@redhat.com>
Date:   Thu, 15 Aug 2019 16:03:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815125544.GC24270@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15-08-19 14:55, Greg Kroah-Hartman wrote:
> On Wed, Aug 14, 2019 at 03:42:46PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 14-08-19 15:24, Heikki Krogerus wrote:
>>> Hi,
>>>
>>> This series removes the deprecated fusb302 specific properties, and
>>> stops using struct tcpc_config in the driver.
>>
>> Series looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> This has a small conflict with my
>> "[PATCH] usb: typec: fusb302: Call fusb302_debugfs_init earlier"
>> patch.
>>
>> Since we've agreed to do the rootdir leak fix as a separate patch
>> (which I will write when I find some time probably tomorrow), I
>> was wondering if we can merge my patch first. I would like to see
>> a "Cc: stable@vger.kernel.org" added to my patch and then it would
>> be good to have it merged first.
>>
>> Regardless we should probable prepare one series with all patches
>> for Greg to make this easy to merge for him.
> 
> I'll take this series now, and you can redo your patch based on my
> usb-next branch with them in it.

Ok.

Regards,

Hans
