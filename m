Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E399BC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F784206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfFVKlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:41:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:32731 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfFVKlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 06:41:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2019 03:41:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,404,1557212400"; 
   d="scan'208";a="165902019"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2019 03:41:19 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hedSQ-000CZ2-Rv; Sat, 22 Jun 2019 18:41:18 +0800
Date:   Sat, 22 Jun 2019 18:40:35 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     kbuild-all@01.org, shuah@kernel.org, stern@rowland.harvard.edu,
        valentina.manea.m@gmail.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suwan Kim <suwan.kim027@gmail.com>
Subject: Re: [PATCH 2/2] usbip: Implement SG support to vhci
Message-ID: <201906221828.RndHkR8Y%lkp@intel.com>
References: <20190621174553.28862-3-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621174553.28862-3-suwan.kim027@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suwan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on v5.2-rc5 next-20190621]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Suwan-Kim/usbip-Skip-DMA-mapping-and-unmapping-for-urb-at-vhci/20190622-130016
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/usb/usbip/usbip_common.c:419:33: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] command @@    got restrunsigned int [usertype] command @@
   drivers/usb/usbip/usbip_common.c:419:33: sparse:    expected unsigned int [usertype] command
   drivers/usb/usbip/usbip_common.c:419:33: sparse:    got restricted __be32 [usertype]
   drivers/usb/usbip/usbip_common.c:420:33: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] seqnum @@    got restrunsigned int [usertype] seqnum @@
   drivers/usb/usbip/usbip_common.c:420:33: sparse:    expected unsigned int [usertype] seqnum
   drivers/usb/usbip/usbip_common.c:420:33: sparse:    got restricted __be32 [usertype]
   drivers/usb/usbip/usbip_common.c:421:33: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] devid @@    got restrunsigned int [usertype] devid @@
   drivers/usb/usbip/usbip_common.c:421:33: sparse:    expected unsigned int [usertype] devid
   drivers/usb/usbip/usbip_common.c:421:33: sparse:    got restricted __be32 [usertype]
   drivers/usb/usbip/usbip_common.c:422:33: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] direction @@    got restrunsigned int [usertype] direction @@
   drivers/usb/usbip/usbip_common.c:422:33: sparse:    expected unsigned int [usertype] direction
   drivers/usb/usbip/usbip_common.c:422:33: sparse:    got restricted __be32 [usertype]
   drivers/usb/usbip/usbip_common.c:423:33: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] ep @@    got restrunsigned int [usertype] ep @@
   drivers/usb/usbip/usbip_common.c:423:33: sparse:    expected unsigned int [usertype] ep
   drivers/usb/usbip/usbip_common.c:423:33: sparse:    got restricted __be32 [usertype]
   drivers/usb/usbip/usbip_common.c:425:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:425:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:425:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:425:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:425:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:425:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:426:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:426:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:426:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:426:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:426:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:426:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:427:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:427:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:427:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:427:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:427:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:427:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:428:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:428:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:428:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:428:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:428:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:428:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:429:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:429:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:429:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:429:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:429:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:429:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:437:37: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] transfer_flags @@    got restrunsigned int [usertype] transfer_flags @@
   drivers/usb/usbip/usbip_common.c:437:37: sparse:    expected unsigned int [usertype] transfer_flags
   drivers/usb/usbip/usbip_common.c:437:37: sparse:    got restricted __be32 [usertype]
>> drivers/usb/usbip/usbip_common.c:438:30: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] num_sgs @@    got restrunsigned int [usertype] num_sgs @@
>> drivers/usb/usbip/usbip_common.c:438:30: sparse:    expected unsigned int [usertype] num_sgs
   drivers/usb/usbip/usbip_common.c:438:30: sparse:    got restricted __be32 [usertype]
   drivers/usb/usbip/usbip_common.c:445:39: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:445:39: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:445:39: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:445:39: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:445:39: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:445:39: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:446:32: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:446:32: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:446:32: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:446:32: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:446:32: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:446:32: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:477:29: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] seqnum @@    got restrunsigned int [usertype] seqnum @@
   drivers/usb/usbip/usbip_common.c:477:29: sparse:    expected unsigned int [usertype] seqnum
   drivers/usb/usbip/usbip_common.c:477:29: sparse:    got restricted __be32 [usertype]
   drivers/usb/usbip/usbip_common.c:479:31: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:479:31: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:479:31: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:479:31: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:479:31: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:479:31: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:529:33: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] offset @@    got restrunsigned int [usertype] offset @@
   drivers/usb/usbip/usbip_common.c:529:33: sparse:    expected unsigned int [usertype] offset
   drivers/usb/usbip/usbip_common.c:529:33: sparse:    got restricted __be32 [usertype]
   drivers/usb/usbip/usbip_common.c:530:33: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] length @@    got restrunsigned int [usertype] length @@
   drivers/usb/usbip/usbip_common.c:530:33: sparse:    expected unsigned int [usertype] length
   drivers/usb/usbip/usbip_common.c:530:33: sparse:    got restricted __be32 [usertype]
   drivers/usb/usbip/usbip_common.c:531:33: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] status @@    got restrunsigned int [usertype] status @@
   drivers/usb/usbip/usbip_common.c:531:33: sparse:    expected unsigned int [usertype] status
   drivers/usb/usbip/usbip_common.c:531:33: sparse:    got restricted __be32 [usertype]
   drivers/usb/usbip/usbip_common.c:532:36: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] actual_length @@    got restrunsigned int [usertype] actual_length @@
   drivers/usb/usbip/usbip_common.c:532:36: sparse:    expected unsigned int [usertype] actual_length
   drivers/usb/usbip/usbip_common.c:532:36: sparse:    got restricted __be32 [usertype]
   drivers/usb/usbip/usbip_common.c:534:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:534:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:534:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:534:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:534:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:534:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:535:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:535:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:535:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:535:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:535:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:535:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:536:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:536:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:536:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:536:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:536:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:536:35: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:537:38: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:537:38: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:537:38: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:537:38: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:537:38: sparse: sparse: cast to restricted __be32
   drivers/usb/usbip/usbip_common.c:537:38: sparse: sparse: cast to restricted __be32

vim +438 drivers/usb/usbip/usbip_common.c

   415	
   416	static void correct_endian_basic(struct usbip_header_basic *base, int send)
   417	{
   418		if (send) {
   419			base->command	= cpu_to_be32(base->command);
   420			base->seqnum	= cpu_to_be32(base->seqnum);
   421			base->devid	= cpu_to_be32(base->devid);
   422			base->direction	= cpu_to_be32(base->direction);
   423			base->ep	= cpu_to_be32(base->ep);
   424		} else {
   425			base->command	= be32_to_cpu(base->command);
   426			base->seqnum	= be32_to_cpu(base->seqnum);
   427			base->devid	= be32_to_cpu(base->devid);
   428			base->direction	= be32_to_cpu(base->direction);
 > 429			base->ep	= be32_to_cpu(base->ep);
   430		}
   431	}
   432	
   433	static void correct_endian_cmd_submit(struct usbip_header_cmd_submit *pdu,
   434					      int send)
   435	{
   436		if (send) {
   437			pdu->transfer_flags = cpu_to_be32(pdu->transfer_flags);
 > 438			pdu->num_sgs = cpu_to_be32(pdu->num_sgs);
   439	
   440			cpu_to_be32s(&pdu->transfer_buffer_length);
   441			cpu_to_be32s(&pdu->start_frame);
   442			cpu_to_be32s(&pdu->number_of_packets);
   443			cpu_to_be32s(&pdu->interval);
   444		} else {
   445			pdu->transfer_flags = be32_to_cpu(pdu->transfer_flags);
   446			pdu->num_sgs = be32_to_cpu(pdu->num_sgs);
   447	
   448			be32_to_cpus(&pdu->transfer_buffer_length);
   449			be32_to_cpus(&pdu->start_frame);
   450			be32_to_cpus(&pdu->number_of_packets);
   451			be32_to_cpus(&pdu->interval);
   452		}
   453	}
   454	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
