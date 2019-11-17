Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14C4C43215
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 11:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F19206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 11:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfKQLRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 06:17:43 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:40399
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725974AbfKQLRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 06:17:43 -0500
X-IronPort-AV: E=Sophos;i="5.68,316,1569276000"; 
   d="scan'208";a="327005876"
Received: from abo-228-123-68.mrs.modulonet.fr (HELO hadrien) ([85.68.123.228])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 12:17:20 +0100
Date:   Sun, 17 Nov 2019 12:17:19 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Eddie James <eajames@linux.ibm.com>
cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        andrew@aj.id.au, joel@jms.id.au, maz@kernel.org,
        jason@lakedaemon.net, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        kbuild-all@lists.01.org
Subject: Re: [PATCH 06/12] drivers/soc: Add Aspeed XDMA Engine Driver (fwd)
Message-ID: <alpine.DEB.2.21.1911171216090.2641@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please check on the missing iounmap issue.  Patches have beenf
forwarded for the other issues.

julia

---------- Forwarded message ----------
Date: Sun, 17 Nov 2019 16:34:53 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@lists.01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 06/12] drivers/soc: Add Aspeed XDMA Engine Driver

In-Reply-To: <1573244313-9190-7-git-send-email-eajames@linux.ibm.com>
References: <1573244313-9190-7-git-send-email-eajames@linux.ibm.com>

Hi Eddie,

I love your patch! Perhaps something to improve:

[auto build test WARNING on joel-aspeed/for-next]
[also build test WARNING on v5.4-rc7 next-20191115]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Eddie-James/Aspeed-Add-SCU-interrupt-controller-and-XDMA-engine-drivers/20191110-064846
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git for-next
:::::: branch date: 7 days ago
:::::: commit date: 7 days ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>

>> drivers/soc/aspeed/aspeed-xdma.c:614:2-8: ERROR: missing iounmap; ioremap on line 580 and execution via conditional on line 612
--
>> drivers/soc/aspeed/aspeed-xdma.c:756:2-9: line 756 is redundant because platform_get_irq() already prints an error
--
>> drivers/soc/aspeed/aspeed-xdma.c:610:2-3: Unneeded semicolon
   drivers/soc/aspeed/aspeed-xdma.c:738:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
