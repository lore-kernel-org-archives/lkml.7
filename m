Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779D5C04AAD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5382121479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfEHLf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:35:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59002 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbfEHLf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:35:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B549341;
        Wed,  8 May 2019 04:35:27 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10CC43FBF8;
        Wed,  8 May 2019 04:35:25 -0700 (PDT)
Date:   Wed, 8 May 2019 12:35:19 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 0/2] hwmon: scmi: Scale values to target desired HWMON
 units
Message-ID: <20190508113452.GA27209@e107155-lin>
References: <20190507230917.21659-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507230917.21659-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 04:09:15PM -0700, Florian Fainelli wrote:
> Hi Sudeep, Guenter,
> 
> This patch series adds support for scaling SCMI sensor values read from
> firmware. Sudeep, let me know if you think we should be treating scale
> == 0 as a special value to preserve some firmware compatibility (not
> that this would be desired).

So are we providing raw values from sensors.c and handling conversion
in hwmon layer ? I was thinking of just providing converted values
to hwmon just in case if the scaling thing change in future with
newer versions of SCMI. I am fine either way, just trying to keep
hwmon-scmi simpler. I will check if scale = 0 needs to be treated as
special(I don't think so, but will read the spec)

--
Regards,
Sudeep
