Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8AEC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0EC22CF7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfIBHFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 03:05:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:48801 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbfIBHFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:05:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 00:05:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="scan'208";a="265950380"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by orsmga001.jf.intel.com with ESMTP; 02 Sep 2019 00:05:49 -0700
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: h6: Introduce Tanix TX6 board
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@siol.net>,
        kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mripard@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190816205342.29552-3-jernej.skrabec@siol.net>
 <201908190222.ZdIp2gT1%lkp@intel.com> <7640522.c0V0aH5rf2@jernej-laptop>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <4494861c-defe-6783-6718-a201f77ec65a@intel.com>
Date:   Mon, 2 Sep 2019 15:05:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7640522.c0V0aH5rf2@jernej-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/19/19 2:59 AM, Jernej Škrabec wrote:
> Dne nedelja, 18. avgust 2019 ob 20:42:49 CEST je kbuild test robot napisal(a):
>> Hi Jernej,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on linus/master]
>> [cannot apply to v5.3-rc4 next-20190816]
>> [if your patch is applied to the wrong git tree, please drop us a note to
>> help improve the system]
>>
>> url:
>> https://github.com/0day-ci/linux/commits/Jernej-Skrabec/dt-bindings-arm-sun
>> xi-Add-compatible-for-Tanix-TX6-board/20190819-002034 config:
>> arm64-defconfig (attached as .config)
>> compiler: aarch64-linux-gcc (GCC) 7.4.0
>> reproduce:
>>          wget
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O
>> ~/bin/make.cross chmod +x ~/bin/make.cross
>>          # save the attached .config to linux build tree
>>          GCC_VERSION=7.4.0 make.cross ARCH=arm64
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>>> Error: arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts:83.1-6 Label
>>>> or path r_ir not found FATAL ERROR: Syntax error parsing input tree
> Strange, Allwinner tree has commit, which introduces r_ir node:
> https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git/commit/?
> h=sunxi/dt-for-5.4&id=9267811aad3524c857cf2e16bbadd8c569e15ab9
>
> Maybe kbuild test robot tree doesn't have it?

The tree is in our list. 
https://github.com/intel/lkp-tests/blob/master/repo/linux/sunxi
Robot also tries to apply patches to a git tree to test. Maybe your 
patch was applied to a wrong git tree.

Best Regards,
Rong Chen

