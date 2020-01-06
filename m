Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9EAC32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1922072E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgAFKjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 05:39:41 -0500
Received: from foss.arm.com ([217.140.110.172]:42666 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgAFKjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 05:39:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8C22328;
        Mon,  6 Jan 2020 02:39:39 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E28F63F534;
        Mon,  6 Jan 2020 02:39:38 -0800 (PST)
Date:   Mon, 6 Jan 2020 10:39:33 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-hwmon@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 10/11] hwmon: (scmi-hwmon) Match scmi device by both
 name and protocol id
Message-ID: <20200106103933.GA54418@bogus>
References: <20191218111742.29731-1-sudeep.holla@arm.com>
 <20191218111742.29731-11-sudeep.holla@arm.com>
 <20200104161946.GA2974@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104161946.GA2974@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2020 at 08:19:46AM -0800, Guenter Roeck wrote:
> On Wed, Dec 18, 2019 at 11:17:41AM +0000, Sudeep Holla wrote:
> > The scmi bus now has support to match the driver with devices not only
> > based on their protocol id but also based on their device name if one is
> > available. This was added to cater the need to support multiple devices
> > and drivers for the same protocol.
> >
> > Let us add the name "hwmon" to scmi_device_id table in the driver so
> > that in matches only with device with the same name and protocol id
> > SCMI_PROTOCOL_SENSOR. This is just for sake of completion and must
> > not be used to add IIO support in parallel. Instead, if IIO support is
> > added ever in future, we need to drop this hwmon driver entirely and
> > use the iio->hwmon bridge to access the sensors as hwmon devices if
> > needed.
> >
>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
>

Thanks

> [ assuming the series will be pushed into the kernel together ]
>

Indeed.

--
Regards,
Sudeep
