Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D90C282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 09:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3D52087F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 09:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfDTJim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 05:38:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:5108 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfDTJil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 05:38:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Apr 2019 02:38:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,373,1549958400"; 
   d="scan'208";a="163501398"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Apr 2019 02:38:38 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hHmSD-000HC2-VJ; Sat, 20 Apr 2019 17:38:38 +0800
Date:   Sat, 20 Apr 2019 17:37:54 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Nick Crews <ncrews@chromium.org>
Cc:     kbuild-all@01.org, bleung@chromium.org, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlaurie@chromium.org, lamzin@google.com, bartfab@google.com,
        derat@google.com, dtor@google.com, sjg@chromium.org,
        jchwong@chromium.org, Nick Crews <ncrews@chromium.org>
Subject: Re: [PATCH v5] power_supply: platform/chrome: wilco_ec: Add charging
 config driver
Message-ID: <201904201756.6pNuTXy5%lkp@intel.com>
References: <20190418233838.149545-1-ncrews@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418233838.149545-1-ncrews@chromium.org>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.1-rc5 next-20190418]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nick-Crews/power_supply-platform-chrome-wilco_ec-Add-charging-config-driver/20190420-041913
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>



sparse warnings: (new ones prefixed by >>)

   drivers/power/supply/wilco-charger.c:46:14: sparse: undefined identifier 'POWER_SUPPLY_CHARGE_TYPE_STANDARD'
   drivers/power/supply/wilco-charger.c:48:14: sparse: undefined identifier 'POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE'
   drivers/power/supply/wilco-charger.c:50:14: sparse: undefined identifier 'POWER_SUPPLY_CHARGE_TYPE_CUSTOM'
>> drivers/power/supply/wilco-charger.c:46:14: sparse: incompatible types for 'case' statement
   drivers/power/supply/wilco-charger.c:48:14: sparse: incompatible types for 'case' statement
   drivers/power/supply/wilco-charger.c:50:14: sparse: incompatible types for 'case' statement
   drivers/power/supply/wilco-charger.c:66:24: sparse: undefined identifier 'POWER_SUPPLY_CHARGE_TYPE_STANDARD'
   drivers/power/supply/wilco-charger.c:68:24: sparse: undefined identifier 'POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE'
   drivers/power/supply/wilco-charger.c:70:24: sparse: undefined identifier 'POWER_SUPPLY_CHARGE_TYPE_CUSTOM'
   drivers/power/supply/wilco-charger.c:78:9: sparse: undefined identifier 'POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD'
   drivers/power/supply/wilco-charger.c:79:9: sparse: undefined identifier 'POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD'
   drivers/power/supply/wilco-charger.c:95:14: sparse: undefined identifier 'POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD'
   drivers/power/supply/wilco-charger.c:98:14: sparse: undefined identifier 'POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD'
   drivers/power/supply/wilco-charger.c:95:14: sparse: incompatible types for 'case' statement
   drivers/power/supply/wilco-charger.c:98:14: sparse: incompatible types for 'case' statement
   drivers/power/supply/wilco-charger.c:132:14: sparse: undefined identifier 'POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD'
   drivers/power/supply/wilco-charger.c:138:14: sparse: undefined identifier 'POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD'
   drivers/power/supply/wilco-charger.c:132:14: sparse: incompatible types for 'case' statement
   drivers/power/supply/wilco-charger.c:138:14: sparse: incompatible types for 'case' statement
   drivers/power/supply/wilco-charger.c:46:14: sparse: Expected constant expression in case statement
   drivers/power/supply/wilco-charger.c:48:14: sparse: Expected constant expression in case statement
   drivers/power/supply/wilco-charger.c:50:14: sparse: Expected constant expression in case statement
   drivers/power/supply/wilco-charger.c:95:14: sparse: Expected constant expression in case statement
   drivers/power/supply/wilco-charger.c:98:14: sparse: Expected constant expression in case statement
   drivers/power/supply/wilco-charger.c:132:14: sparse: Expected constant expression in case statement
   drivers/power/supply/wilco-charger.c:138:14: sparse: Expected constant expression in case statement

vim +/case +46 drivers/power/supply/wilco-charger.c

    37	
    38	/* Convert from POWER_SUPPLY_PROP_CHARGE_TYPE value to the EC's charge mode */
    39	static enum charge_mode psp_val_to_charge_mode(int psp_val)
    40	{
    41		switch (psp_val) {
    42		case POWER_SUPPLY_CHARGE_TYPE_TRICKLE:
    43			return CHARGE_MODE_AC;
    44		case POWER_SUPPLY_CHARGE_TYPE_FAST:
    45			return CHARGE_MODE_EXP;
  > 46		case POWER_SUPPLY_CHARGE_TYPE_STANDARD:
    47			return CHARGE_MODE_STD;
    48		case POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE:
    49			return CHARGE_MODE_AUTO;
    50		case POWER_SUPPLY_CHARGE_TYPE_CUSTOM:
    51			return CHARGE_MODE_CUSTOM;
    52		default:
    53			return CHARGE_MODE_ILLEGAL;
    54		}
    55	}
    56	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
