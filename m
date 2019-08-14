Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA86C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27D8206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfHNNmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:42:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33557 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfHNNmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:42:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id s15so5016196edx.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 06:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0HsquNrNKiMbr5FDDummx4kovw9WYQfo6fm7gr2n+lo=;
        b=Ks4AlHmTVfuW6kF28h/jVPAioKs/QXmP2ii/1Vd4JrDphvN7jsPdcSjFPsgDdtkpYB
         7lZIrTOKiGNO/uqFgH++dGxeTOnUboTW5T0LfvSGa68eBPKesWmjB5Ix2jACnZacELyo
         CJ47PQs6q1UU+OjVEz/XH3bIY+9HACzwSufDE7MUhGMm//VoOvSXnuU0Kskx6+p235rl
         w1xjFNum7DtrVrfnbbKwqAQRYccBu6Gc8TGWCopUz3TmtK4+1uT1oI2UWAzIThhv7RHP
         rsLTJVB362OQ1ZWnwBLCOu5l6mx8Vuw5FriNPNjWORaQJibjXMg8D6TiSI8mXhi9b1CF
         2wDQ==
X-Gm-Message-State: APjAAAXlIGffJMvjikGtxZiElL4qVhPj3wY/4hNab90pmGdHC8t5r6P0
        woLsKzScXqc6jZdkkiYe1rRU4tpsuf8=
X-Google-Smtp-Source: APXvYqzgD7tzSUMCupou4DFUUVf0PmPBWuMVp7BchUmB9yHfjojZwOpuIr/o4daHA3x/qYTDpeyDuw==
X-Received: by 2002:a50:b3cb:: with SMTP id t11mr27650559edd.203.1565790168489;
        Wed, 14 Aug 2019 06:42:48 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id b40sm4231311edc.53.2019.08.14.06.42.47
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 06:42:47 -0700 (PDT)
Subject: Re: [PATCH 0/3] usb: typec: fusb302: Small changes
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190814132419.39759-1-heikki.krogerus@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a826c351-4e9d-8a33-ad0f-764d13aeb1ed@redhat.com>
Date:   Wed, 14 Aug 2019 15:42:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814132419.39759-1-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14-08-19 15:24, Heikki Krogerus wrote:
> Hi,
> 
> This series removes the deprecated fusb302 specific properties, and
> stops using struct tcpc_config in the driver.

Series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

This has a small conflict with my
"[PATCH] usb: typec: fusb302: Call fusb302_debugfs_init earlier"
patch.

Since we've agreed to do the rootdir leak fix as a separate patch
(which I will write when I find some time probably tomorrow), I
was wondering if we can merge my patch first. I would like to see
a "Cc: stable@vger.kernel.org" added to my patch and then it would
be good to have it merged first.

Regardless we should probable prepare one series with all patches
for Greg to make this easy to merge for him.

Shall I combine this series + my fix + my to be written fix into
1 series, test that on actual hardware and then post that?

Regards,

Hans
