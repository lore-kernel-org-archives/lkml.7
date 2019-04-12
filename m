Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746C9C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5C0206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfDLJXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:23:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33730 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbfDLJXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 05:23:24 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 26CBC282267
Subject: Re: [PATCH v3] platform/chrome: cros_ec_spi: Transfer messages at
 high priority
To:     Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Simon Glass <sjg@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Ryan Case <ryandcase@chromium.org>,
        Randall Spangler <rspangler@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <20190403203137.203582-1-dianders@chromium.org>
 <CA+ASDXNmxspD_3p-BftgySn5mPSYvSTeEXkzNS9B+ReZho-Uyw@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <9fce8b1c-e277-2eeb-4b0d-e6b0e1851419@collabora.com>
Date:   Fri, 12 Apr 2019 11:23:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CA+ASDXNmxspD_3p-BftgySn5mPSYvSTeEXkzNS9B+ReZho-Uyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/4/19 3:27, Brian Norris wrote:
> On Wed, Apr 3, 2019 at 1:32 PM Douglas Anderson <dianders@chromium.org> wrote:
>> +static int cros_ec_xfer_high_pri(struct cros_ec_device *ec_dev,
>> +                                struct cros_ec_command *ec_msg,
>> +                                cros_ec_xfer_fn_t fn)
>> +{
>> +       struct cros_ec_xfer_work_params params;
>> +
>> +       INIT_WORK(&params.work, cros_ec_xfer_high_pri_work);
> 
> Sorry for the late review, but this should have been
> INIT_WORK_ONSTACK(). Should it be a new patch, or is this in a
> non-rebasing tree yet?
> 

No need to resend, I'll do the modification myself and push again.

Thanks,
 Enric

> Otherwise, looks fine to me:
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> 
