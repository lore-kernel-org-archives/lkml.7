Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D725FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14BE206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfCSKbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:31:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:25453 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfCSKbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:31:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 03:31:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,497,1544515200"; 
   d="scan'208";a="283925110"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 19 Mar 2019 03:31:34 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h6C1t-0003mA-14; Tue, 19 Mar 2019 12:31:33 +0200
Date:   Tue, 19 Mar 2019 12:31:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wang Hai <wanghai26@huawei.com>
Cc:     davem@davemloft.net, idosch@mellanox.com,
        alexander.h.duyck@intel.com, tyhicks@canonical.com,
        f.fainelli@gmail.com, amritha.nambiar@intel.com, joe@perches.com,
        dmitry.torokhov@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net-sysfs: Fix memory leak in netdev_register_kobject
Message-ID: <20190319103133.GE9224@smile.fi.intel.com>
References: <20190319213613.48888-1-wanghai26@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319213613.48888-1-wanghai26@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 05:36:13PM -0400, Wang Hai wrote:
> When registering struct net_device, it will call
> 	register_netdevice ->
> 		netdev_register_kobject ->
> 			dev_set_name(dev, "%s", ndev->name)
> 			device_add(dev)
> 			register_queue_kobjects(ndev)
> 

>  - Improve the description of the cause of the bug, no code changes.

See my previous message.
NAK for this.

-- 
With Best Regards,
Andy Shevchenko


