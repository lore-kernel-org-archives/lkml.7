Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B8EC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D316C214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfIQOfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:35:04 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39013 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbfIQOfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 10:35:03 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAEZG-0004lH-B7; Tue, 17 Sep 2019 16:34:58 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAEZF-0003p7-Kp; Tue, 17 Sep 2019 16:34:57 +0200
Date:   Tue, 17 Sep 2019 16:34:57 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     support.opensource@diasemi.com
Cc:     support.opensource@diasemi.com, lee.jones@linaro.org,
        robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        stwiss.opensource@diasemi.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] regulator: da9062: add voltage selection gpio support
Message-ID: <20190917143457.cmnko5wmdozjtoe5@pengutronix.de>
References: <20190917124246.11732-4-m.felsch@pengutronix.de>
 <201909172223.Jhc0dAmS%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909172223.Jhc0dAmS%lkp@intel.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 16:33:09 up 122 days, 20:51, 70 users,  load average: 0.12, 0.06,
 0.04
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please ignore this error because the kbuild don't apply the dependency I
noted in the cover-letter.

Regards,
  Marco

On 19-09-17 22:22, kbuild test robot wrote:
> Hi Marco,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3 next-20190916]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Marco-Felsch/DA9062-PMIC-fixes-and-features/20190917-205911
> config: x86_64-randconfig-e004-201937 (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-11) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/regulator/da9062-regulator.c:19:10: fatal error: linux/mfd/da9062/gpio.h: No such file or directory
>     #include <linux/mfd/da9062/gpio.h>
>              ^~~~~~~~~~~~~~~~~~~~~~~~~
>    compilation terminated.
> 
> vim +19 drivers/regulator/da9062-regulator.c
> 
>      5	
>      6	#include <linux/kernel.h>
>      7	#include <linux/module.h>
>      8	#include <linux/init.h>
>      9	#include <linux/err.h>
>     10	#include <linux/gpio/consumer.h>
>     11	#include <linux/slab.h>
>     12	#include <linux/of.h>
>     13	#include <linux/platform_device.h>
>     14	#include <linux/regmap.h>
>     15	#include <linux/regulator/driver.h>
>     16	#include <linux/regulator/machine.h>
>     17	#include <linux/regulator/of_regulator.h>
>     18	#include <linux/mfd/da9062/core.h>
>   > 19	#include <linux/mfd/da9062/gpio.h>
>     20	#include <linux/mfd/da9062/registers.h>
>     21	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
