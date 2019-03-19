Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382C6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C24206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfCSKfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:35:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:26066 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbfCSKfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:35:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 03:35:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,497,1544515200"; 
   d="scan'208";a="141929703"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Mar 2019 03:35:05 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1h6C5L-0004Kb-9z; Tue, 19 Mar 2019 18:35:07 +0800
Date:   Tue, 19 Mar 2019 18:34:34 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Shawn Landden <shawn@git.icu>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        Shawn Landden <shawn@git.icu>
Subject: Re: [PATCH] Use fall-through attribute rather than magic comments
Message-ID: <201903191849.kFLSqS7A%lkp@intel.com>
References: <20190316033841.7659-1-shawn@git.icu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316033841.7659-1-shawn@git.icu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.1-rc1]
[cannot apply to next-20190319]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Shawn-Landden/Use-fall-through-attribute-rather-than-magic-comments/20190318-194548


coccinelle warnings: (new ones prefixed by >>)

>> drivers/media/dvb-frontends/drx39xyj/drxj.c:11123:48-49: Unneeded semicolon
   drivers/media/dvb-frontends/drx39xyj/drxj.c:11124:48-49: Unneeded semicolon
   drivers/media/dvb-frontends/drx39xyj/drxj.c:11125:47-48: Unneeded semicolon
   drivers/media/dvb-frontends/drx39xyj/drxj.c:11126:47-48: Unneeded semicolon
   drivers/media/dvb-frontends/drx39xyj/drxj.c:11127:48-49: Unneeded semicolon
   drivers/media/dvb-frontends/drx39xyj/drxj.c:11128:40-41: Unneeded semicolon
   drivers/media/dvb-frontends/drx39xyj/drxj.c:11139:40-41: Unneeded semicolon
   drivers/media/dvb-frontends/drx39xyj/drxj.c:11276:39-40: Unneeded semicolon
   drivers/media/dvb-frontends/drx39xyj/drxj.c:11278:40-41: Unneeded semicolon
   drivers/media/dvb-frontends/drx39xyj/drxj.c:11279:40-41: Unneeded semicolon
   drivers/media/dvb-frontends/drx39xyj/drxj.c:11313:40-41: Unneeded semicolon
   drivers/media/dvb-frontends/drx39xyj/drxj.c:11314:40-41: Unneeded semicolon
   drivers/media/dvb-frontends/drx39xyj/drxj.c:11232:40-41: Unneeded semicolon
   drivers/media/dvb-frontends/drx39xyj/drxj.c:11233:40-41: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
