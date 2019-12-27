Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7384DC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 12:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A4020882
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 12:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfL0MTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 07:19:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:41142 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfL0MTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 07:19:12 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 04:19:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,363,1571727600"; 
   d="scan'208";a="368017078"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Dec 2019 04:19:10 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ikoaD-00007g-NT; Fri, 27 Dec 2019 20:19:09 +0800
Date:   Fri, 27 Dec 2019 20:18:47 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Michal Simek <monstr@monstr.eu>
Subject: drivers/pci/controller/pci-tegra.c:1365:1-3: WARNING:
 PTR_ERR_OR_ZERO can be used
Message-ID: <201912272041.iVxC623g%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   46cf053efec6a3a5f343fead837777efe8252a46
commit: 191d6f91f283dfb007499bb8529d54c3ac434bd7 PCI: Remove PCI_MSI_IRQ_DOMAIN architecture whitelist
date:   4 weeks ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


coccinelle warnings: (new ones prefixed by >>)

>> drivers/pci/controller/pci-tegra.c:1365:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
