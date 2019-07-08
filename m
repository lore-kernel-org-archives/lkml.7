Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF6CC48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 04:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC70620848
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 04:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfGHEZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 00:25:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:58011 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbfGHEZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 00:25:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jul 2019 21:25:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,465,1557212400"; 
   d="scan'208";a="364110586"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jul 2019 21:25:50 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hkLDq-0004hF-Ek; Mon, 08 Jul 2019 12:25:50 +0800
Date:   Mon, 8 Jul 2019 12:25:47 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     kbuild-all@01.org, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [linux-next:master 9908/12641] drivers/mfd/rohm-bd70528.c:109:14:
 sparse: sparse: symbol 'bit0_offsets' was not declared. Should it be static?
Message-ID: <201907081224.B6QvwFVw%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git master
head:   22c45ec32b4a9fa8c48ef4f5bf9b189b307aae12
commit: 21b7c58fc1943f3aa8c18a994ab9bed4ae5aa72d [9908/12641] mfd: bd70528: Support ROHM bd70528 PMIC core
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        git checkout 21b7c58fc1943f3aa8c18a994ab9bed4ae5aa72d
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/mfd/rohm-bd70528.c:109:14: sparse: sparse: symbol 'bit0_offsets' was not declared. Should it be static?
>> drivers/mfd/rohm-bd70528.c:110:14: sparse: sparse: symbol 'bit1_offsets' was not declared. Should it be static?
>> drivers/mfd/rohm-bd70528.c:111:14: sparse: sparse: symbol 'bit2_offsets' was not declared. Should it be static?
>> drivers/mfd/rohm-bd70528.c:112:14: sparse: sparse: symbol 'bit3_offsets' was not declared. Should it be static?
>> drivers/mfd/rohm-bd70528.c:113:14: sparse: sparse: symbol 'bit4_offsets' was not declared. Should it be static?
>> drivers/mfd/rohm-bd70528.c:114:14: sparse: sparse: symbol 'bit5_offsets' was not declared. Should it be static?
>> drivers/mfd/rohm-bd70528.c:115:14: sparse: sparse: symbol 'bit6_offsets' was not declared. Should it be static?
>> drivers/mfd/rohm-bd70528.c:116:14: sparse: sparse: symbol 'bit7_offsets' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
