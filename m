Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58926C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 04:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309B4216F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 04:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfEQEkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 00:40:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:43334 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfEQEky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 00:40:54 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 May 2019 21:40:54 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 16 May 2019 21:40:53 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hRUfs-00020o-J6; Fri, 17 May 2019 12:40:52 +0800
Date:   Fri, 17 May 2019 12:40:30 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Patrick Venture <venture@google.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: drivers/soc/Kconfig:23: 'menu' in different file than 'menu'
Message-ID: <201905171226.xchw0NQ2%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0d74471924f2a01dcd32d154510c0500780b531a
commit: 524feb799408e5d45c6aa82763a9f52489d1e19f soc: add aspeed folder and misc drivers
date:   3 weeks ago
config: xtensa-allyesconfig
compiler: xtensa-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 524feb799408e5d45c6aa82763a9f52489d1e19f
        GCC_VERSION=8.1.0 make.cross ARCH=xtensa  allyesconfig
        GCC_VERSION=8.1.0 make.cross ARCH=xtensa 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/soc/Kconfig:23: 'menu' in different file than 'menu'
>> drivers/soc/aspeed/Kconfig:1: location of the 'menu'
>> drivers/Kconfig:233: 'menu' in different file than 'menu'
>> drivers/soc/aspeed/Kconfig:1: location of the 'menu'
   <none>:34: syntax error
>> drivers/Kconfig:2: missing end statement for this entry
   make[2]: *** [allyesconfig] Error 1
   make[1]: *** [allyesconfig] Error 2
   make: *** [sub-make] Error 2
--
>> drivers/soc/Kconfig:23: 'menu' in different file than 'menu'
>> drivers/soc/aspeed/Kconfig:1: location of the 'menu'
>> drivers/Kconfig:233: 'menu' in different file than 'menu'
>> drivers/soc/aspeed/Kconfig:1: location of the 'menu'
   <none>:34: syntax error
>> drivers/Kconfig:2: missing end statement for this entry
   make[2]: *** [oldconfig] Error 1
   make[1]: *** [oldconfig] Error 2
   make: *** [sub-make] Error 2
--
>> drivers/soc/Kconfig:23: 'menu' in different file than 'menu'
>> drivers/soc/aspeed/Kconfig:1: location of the 'menu'
>> drivers/Kconfig:233: 'menu' in different file than 'menu'
>> drivers/soc/aspeed/Kconfig:1: location of the 'menu'
   <none>:34: syntax error
>> drivers/Kconfig:2: missing end statement for this entry
   make[2]: *** [olddefconfig] Error 1
   make[1]: *** [olddefconfig] Error 2
   make: *** [sub-make] Error 2

vim +23 drivers/soc/Kconfig

5d144e36 Andy Gross        2014-04-24  22  
3a6e0821 Santosh Shilimkar 2014-04-23 @23  endmenu

:::::: The code at line 23 was first introduced by commit
:::::: 3a6e08218f36baa9c49282ad2fe0dfbf001d8f23 soc: Introduce drivers/soc place-holder for SOC specific drivers

:::::: TO: Santosh Shilimkar <santosh.shilimkar@ti.com>
:::::: CC: Kumar Gala <galak@codeaurora.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
