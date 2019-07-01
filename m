Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E518C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 17:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42642206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 17:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbfGARlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 13:41:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:11112 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727130AbfGARlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:41:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2019 10:41:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,440,1557212400"; 
   d="scan'208";a="246988339"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 Jul 2019 10:41:37 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hi0J6-0009f4-Fc; Tue, 02 Jul 2019 01:41:36 +0800
Date:   Tue, 2 Jul 2019 01:40:50 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Gabriel Beauchamp <beauchampgabriel@gmail.com>
Cc:     kbuild-all@01.org, gregkh@linuxfoundation.org,
        christian.gromm@microchip.com, colin.king@canonical.com,
        gustavo@embeddedor.com, joe@perches.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Gabriel Beauchamp <beauchampgabriel@gmail.com>
Subject: Re: [PATCH v3] Staging: most: fix coding style issues
Message-ID: <201907020151.4hvM1eTo%lkp@intel.com>
References: <20190630165604.2452-1-beauchampgabriel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190630165604.2452-1-beauchampgabriel@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]
[also build test WARNING on v5.2-rc6 next-20190625]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Gabriel-Beauchamp/Staging-most-fix-coding-style-issues/20190701-203804
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)


vim +308 drivers/staging/most/core.c

   296	
   297	static ssize_t set_datatype_show(struct device *dev,
   298					 struct device_attribute *attr,
   299					 char *buf)
   300	{
   301		int i;
   302		char *type = "unconfigured\n";
   303	
   304		struct most_channel *c = to_channel(dev);
   305	
   306		for (i = 0; i < ARRAY_SIZE(ch_data_type); i++) {
   307			if (c->cfg.data_type & ch_data_type[i].most_ch_data_type) {
 > 308				type = ch_data_type[i].name;
   309				break;
   310			}
   311		}
   312		return snprintf(buf, PAGE_SIZE, "%s", type);
   313	}
   314	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
