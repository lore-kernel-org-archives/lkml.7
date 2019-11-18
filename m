Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF237C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8883020692
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfKRNBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 08:01:33 -0500
Received: from gecko.sbs.de ([194.138.37.40]:58080 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfKRNBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 08:01:33 -0500
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id xAID1Ib2019169
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 14:01:18 +0100
Received: from [167.87.4.156] ([167.87.4.156])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id xAID1GHM008139;
        Mon, 18 Nov 2019 14:01:17 +0100
Subject: Re: [PATCH v2] gpio: sch: Add interrupt support
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J., Wysocki" <rafael.j.wysocki@intel.com>
References: <046793ee-ba51-6a1b-1aa5-14560d849df7@siemens.com>
 <20190429131900.GD9224@smile.fi.intel.com>
 <20191118115019.GW32742@smile.fi.intel.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3254f095-3c0d-c96f-df96-cb30e1c97947@siemens.com>
Date:   Mon, 18 Nov 2019 14:01:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191118115019.GW32742@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.11.19 12:50, Andy Shevchenko wrote:
> On Mon, Apr 29, 2019 at 04:19:00PM +0300, Andy Shevchenko wrote:
>> On Mon, Apr 29, 2019 at 07:55:52AM +0200, Jan Kiszka wrote:
>>> Validated on the Quark platform, this adds interrupt support on rising
>>> and/or falling edges.
>>
>> Can we split it to two:
>> - Add IRQ support on edge
>> - Add ACPI handler (with explanation in the commit message why we do like this,
>>    based on the thread from v1)
>>
>> ?
> 
> Jan, anything you would like to do with this or is it abandoned?
> 

Thanks for the reminder - forgotten. Will try to do that split-up and 
resubmit.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
