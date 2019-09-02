Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762ECC41514
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457F62173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbfIBHqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 03:46:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:23402 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfIBHqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:46:50 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 00:46:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="gz'50?scan'50,208,50";a="357419495"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 Sep 2019 00:46:45 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1i4h2y-000Fiv-JY; Mon, 02 Sep 2019 15:46:44 +0800
Date:   Mon, 2 Sep 2019 15:46:40 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     kbuild-all@01.org, Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 1/4] regulator: provide regulator_bulk_set_supply_names()
Message-ID: <201909021509.oIWdElAg%lkp@intel.com>
References: <20190830071740.4267-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u4zsaicwuqjs7dsr"
Content-Disposition: inline
In-Reply-To: <20190830071740.4267-2-brgl@bgdev.pl>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u4zsaicwuqjs7dsr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bartosz,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[cannot apply to v5.3-rc6 next-20190830]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bartosz-Golaszewski/regulator-add-and-use-a-helper-for-setting-supply-names/20190901-140224
config: c6x-evmc6678_defconfig (attached as .config)
compiler: c6x-elf-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=c6x 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/of/platform.o: In function `regulator_bulk_set_supply_names':
>> platform.c:(.text+0xc80): multiple definition of `regulator_bulk_set_supply_names'
   drivers/usb/phy/of.o:of.c:(.text+0xa8): first defined here

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--u4zsaicwuqjs7dsr
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--u4zsaicwuqjs7dsr--
