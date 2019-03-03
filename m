Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86661C10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E114206DD
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfCCQLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 11:11:20 -0500
Received: from mga03.intel.com ([134.134.136.65]:36623 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbfCCQLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 11:11:19 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2019 08:11:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,436,1544515200"; 
   d="scan'208";a="138731368"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 03 Mar 2019 08:11:15 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1h0Thq-0009BM-PO; Mon, 04 Mar 2019 00:11:14 +0800
Date:   Mon, 4 Mar 2019 00:10:16 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     kbuild-all@01.org, lars@metafoo.de, Michael.Hennerich@analog.com,
        jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 4/4] staging: iio: ad5933: move out of staging
Message-ID: <201903040037.6l3rI2yh%fengguang.wu@intel.com>
References: <20190301025331.ucqd7unbgaqfcuaf@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301025331.ucqd7unbgaqfcuaf@smtp.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on iio/togreg]
[cannot apply to v5.0-rc8]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Marcelo-Schmitt/staging-iio-ad5933-move-out-of-staging/20190303-232039
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: xtensa-allyesconfig
compiler: xtensa-linux-gcc (GCC) 8.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        GCC_VERSION=8.2.0 make.cross ARCH=xtensa  allyesconfig
        GCC_VERSION=8.2.0 make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

>> drivers/staging/iio/Kconfig:12: can't open file "drivers/staging/iio/impedance-analyzer/Kconfig"
   make[2]: *** [allyesconfig] Error 1
   make[1]: *** [allyesconfig] Error 2
   make: *** [sub-make] Error 2
--
>> drivers/staging/iio/Kconfig:12: can't open file "drivers/staging/iio/impedance-analyzer/Kconfig"
   make[2]: *** [oldconfig] Error 1
   make[1]: *** [oldconfig] Error 2
   make: *** [sub-make] Error 2
--
>> drivers/staging/iio/Kconfig:12: can't open file "drivers/staging/iio/impedance-analyzer/Kconfig"
   make[2]: *** [olddefconfig] Error 1
   make[1]: *** [olddefconfig] Error 2
   make: *** [sub-make] Error 2

vim +12 drivers/staging/iio/Kconfig

f94aa354d6 Michael Hennerich 2011-08-02 @12  source "drivers/staging/iio/impedance-analyzer/Kconfig"
09434ef7c2 Barry Song        2010-10-27  13  source "drivers/staging/iio/meter/Kconfig"
f46d9f154a Graf Yang         2010-10-27  14  source "drivers/staging/iio/resolver/Kconfig"
7f3a1fb998 Jonathan Cameron  2009-08-18  15  

:::::: The code at line 12 was first introduced by commit
:::::: f94aa354d676532448e8e222e737fdd0755fc786 iio: impedance-analyzer: New driver for AD5933/4 Impedance Converter, Network Analyzer

:::::: TO: Michael Hennerich <michael.hennerich@analog.com>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
