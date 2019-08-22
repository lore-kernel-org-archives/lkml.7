Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D48BC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9ED22CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732968AbfHVJJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:09:53 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:38131 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbfHVJJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:09:53 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id AAC63FF80D;
        Thu, 22 Aug 2019 09:09:48 +0000 (UTC)
Date:   Thu, 22 Aug 2019 11:09:48 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Rahul Tanwar <rahul.tanwar@linux.intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tony.luck@intel.com,
        x86@kernel.org, a.zummo@towertech.it, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, alan@linux.intel.com,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com
Subject: Re: [PATCH v1 2/2] dt-bindings: rtc: Add optional status property
Message-ID: <20190822090948.GQ27031@piout.net>
References: <cover.1566458029.git.rahul.tanwar@linux.intel.com>
 <1b01287241d49638c43222d32f3ece5a38c95ddf.1566458029.git.rahul.tanwar@linux.intel.com>
 <20190822085659.GI30120@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822085659.GI30120@smile.fi.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2019 11:56:59+0300, Andy Shevchenko wrote:
> On Thu, Aug 22, 2019 at 03:44:04PM +0800, Rahul Tanwar wrote:
> > Some products may not support MC146818 RTC CMOS device. Introduce a optional
> > 'status' standard property for RTC-CMOS to indicate if the MC146818 RTC device
> > is available (status="okay") or not (status="disabled")
> 
> This needs to be converted to YAML
> 

Well, I think the status property doesn't even need to be documented
because it is simply the generic behaviour.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
