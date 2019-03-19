Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3871DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B2E20828
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfCSKXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:23:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:30300 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbfCSKXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:23:05 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 03:23:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,497,1544515200"; 
   d="scan'208";a="143247980"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga002.jf.intel.com with ESMTP; 19 Mar 2019 03:23:00 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h6BtM-0003i8-Qs; Tue, 19 Mar 2019 12:22:44 +0200
Date:   Tue, 19 Mar 2019 12:22:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "wanghai (M)" <wanghai26@huawei.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        davem@davemloft.net, idosch@mellanox.com,
        alexander.h.duyck@intel.com, tyhicks@canonical.com,
        f.fainelli@gmail.com, amritha.nambiar@intel.com, joe@perches.com,
        dmitry.torokhov@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net-sysfs: Fix memory leak in netdev_register_kobject
Message-ID: <20190319102244.GC9224@smile.fi.intel.com>
References: <20190319050657.61327-1-wanghai26@huawei.com>
 <20190318085724.1e0c017b@shemminger-XPS-13-9360>
 <cfc4b528-8bda-6823-cdf8-f4d12eb95c85@huawei.com>
 <20190318201546.7675e5ec@shemminger-XPS-13-9360>
 <bff1b8d2-ee8a-ca5b-abab-06c3a876b170@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bff1b8d2-ee8a-ca5b-abab-06c3a876b170@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 11:39:54AM +0800, wanghai (M) wrote:
> 在 2019/3/19 11:15, Stephen Hemminger 写道:

> Device_del just delete device from system, but do not clean up
> dev->kobj.name.

May I ask how you get this conclusion?

>	In normal case,     the name is freed  in free_netdev(dev)->put_device(&dev->dev)->kobject_put(&dev->kobj)->kobject_cleanup()
> ,not in device_del()

-- 
With Best Regards,
Andy Shevchenko


