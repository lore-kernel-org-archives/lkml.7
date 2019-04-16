Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556E3C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2320420693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfDPM1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:27:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:40897 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbfDPM1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 08:27:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 05:26:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,357,1549958400"; 
   d="scan'208";a="141118816"
Received: from mylly.fi.intel.com (HELO [10.237.72.155]) ([10.237.72.155])
  by fmsmga008.fm.intel.com with ESMTP; 16 Apr 2019 05:26:56 -0700
Subject: Re: [PATCH] spi: pxa2xx: Add support for Intel Comet Lake
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Evan Green <evgreen@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rajat Jain <rajatja@chromium.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20190416032743.180517-1-evgreen@chromium.org>
 <CAHp75VcPYu1APhcqcu-Df5ucpW-q597OCKHwne1dgqQsMM9+Fg@mail.gmail.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <2898d0e2-1e91-552e-c053-e31f617c7732@linux.intel.com>
Date:   Tue, 16 Apr 2019 15:26:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VcPYu1APhcqcu-Df5ucpW-q597OCKHwne1dgqQsMM9+Fg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/19 11:00 AM, Andy Shevchenko wrote:
> On Tue, Apr 16, 2019 at 6:28 AM Evan Green <evgreen@chromium.org> wrote:
>>
>> Add PCI IDs for SPI on Comet Lake.
>>
> 
> I didn't check IDs, perhaps Jarkko can do it.
>  From other prospectives looks good.
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
Yes, those IDs and compatibility with Cannon Lake match with my 
understanding.

Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
