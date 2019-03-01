Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72550C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C73E2083E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387755AbfCALtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 06:49:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:26220 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfCALtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 06:49:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2019 03:32:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,427,1544515200"; 
   d="gz'50?scan'50,208,50";a="147639768"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 01 Mar 2019 03:32:08 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gzgOf-000F69-1n; Fri, 01 Mar 2019 19:32:09 +0800
Date:   Fri, 1 Mar 2019 19:31:53 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     kbuild-all@01.org, Mark Brown <broonie@kernel.org>,
        Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH] regulator: lp87565: Convert to use
 regulator_set/get_current_limit_regmap
Message-ID: <201903011929.WkN8JU5R%fengguang.wu@intel.com>
References: <20190301062432.2322-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20190301062432.2322-1-axel.lin@ingics.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Axel,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on regulator/for-next]
[also build test ERROR on next-20190228]
[cannot apply to v5.0-rc8]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Axel-Lin/regulator-lp87565-Convert-to-use-regulator_set-get_current_limit_regmap/20190301-190141
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
config: i386-randconfig-x013-201908 (attached as .config)
compiler: gcc-8 (Debian 8.2.0-21) 8.2.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> drivers//regulator/lp87565-regulator.c:120:23: error: 'regulator_set_current_limit_regmap' undeclared here (not in a function); did you mean 'regulator_set_current_limit'?
     .set_current_limit = regulator_set_current_limit_regmap,
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                          regulator_set_current_limit
>> drivers//regulator/lp87565-regulator.c:121:23: error: 'regulator_get_current_limit_regmap' undeclared here (not in a function); did you mean 'regulator_get_current_limit'?
     .get_current_limit = regulator_get_current_limit_regmap,
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                          regulator_get_current_limit
>> drivers//regulator/lp87565-regulator.c:37:5: error: 'struct regulator_desc' has no member named 'curr_table'; did you mean 'volt_table'?
       .curr_table = lp87565_buck_uA,   \
        ^~~~~~~~~~
   drivers//regulator/lp87565-regulator.c:125:2: note: in expansion of macro 'LP87565_REGULATOR'
     LP87565_REGULATOR("BUCK0", LP87565_BUCK_0, "buck0", lp87565_buck_ops,
     ^~~~~~~~~~~~~~~~~
>> drivers//regulator/lp87565-regulator.c:38:5: error: 'struct regulator_desc' has no member named 'n_current_limits'
       .n_current_limits = ARRAY_SIZE(lp87565_buck_uA),\
        ^~~~~~~~~~~~~~~~
   drivers//regulator/lp87565-regulator.c:125:2: note: in expansion of macro 'LP87565_REGULATOR'
     LP87565_REGULATOR("BUCK0", LP87565_BUCK_0, "buck0", lp87565_buck_ops,
     ^~~~~~~~~~~~~~~~~
>> drivers//regulator/lp87565-regulator.c:37:5: error: 'struct regulator_desc' has no member named 'curr_table'; did you mean 'volt_table'?
       .curr_table = lp87565_buck_uA,   \
        ^~~~~~~~~~
   drivers//regulator/lp87565-regulator.c:130:2: note: in expansion of macro 'LP87565_REGULATOR'
     LP87565_REGULATOR("BUCK1", LP87565_BUCK_1, "buck1", lp87565_buck_ops,
     ^~~~~~~~~~~~~~~~~
>> drivers//regulator/lp87565-regulator.c:38:5: error: 'struct regulator_desc' has no member named 'n_current_limits'
       .n_current_limits = ARRAY_SIZE(lp87565_buck_uA),\
        ^~~~~~~~~~~~~~~~
   drivers//regulator/lp87565-regulator.c:130:2: note: in expansion of macro 'LP87565_REGULATOR'
     LP87565_REGULATOR("BUCK1", LP87565_BUCK_1, "buck1", lp87565_buck_ops,
     ^~~~~~~~~~~~~~~~~
>> drivers//regulator/lp87565-regulator.c:37:5: error: 'struct regulator_desc' has no member named 'curr_table'; did you mean 'volt_table'?
       .curr_table = lp87565_buck_uA,   \
        ^~~~~~~~~~
   drivers//regulator/lp87565-regulator.c:135:2: note: in expansion of macro 'LP87565_REGULATOR'
     LP87565_REGULATOR("BUCK2", LP87565_BUCK_2, "buck2", lp87565_buck_ops,
     ^~~~~~~~~~~~~~~~~
>> drivers//regulator/lp87565-regulator.c:38:5: error: 'struct regulator_desc' has no member named 'n_current_limits'
       .n_current_limits = ARRAY_SIZE(lp87565_buck_uA),\
        ^~~~~~~~~~~~~~~~
   drivers//regulator/lp87565-regulator.c:135:2: note: in expansion of macro 'LP87565_REGULATOR'
     LP87565_REGULATOR("BUCK2", LP87565_BUCK_2, "buck2", lp87565_buck_ops,
     ^~~~~~~~~~~~~~~~~
>> drivers//regulator/lp87565-regulator.c:37:5: error: 'struct regulator_desc' has no member named 'curr_table'; did you mean 'volt_table'?
       .curr_table = lp87565_buck_uA,   \
        ^~~~~~~~~~
   drivers//regulator/lp87565-regulator.c:140:2: note: in expansion of macro 'LP87565_REGULATOR'
     LP87565_REGULATOR("BUCK3", LP87565_BUCK_3, "buck3", lp87565_buck_ops,
     ^~~~~~~~~~~~~~~~~
>> drivers//regulator/lp87565-regulator.c:38:5: error: 'struct regulator_desc' has no member named 'n_current_limits'
       .n_current_limits = ARRAY_SIZE(lp87565_buck_uA),\
        ^~~~~~~~~~~~~~~~
   drivers//regulator/lp87565-regulator.c:140:2: note: in expansion of macro 'LP87565_REGULATOR'
     LP87565_REGULATOR("BUCK3", LP87565_BUCK_3, "buck3", lp87565_buck_ops,
     ^~~~~~~~~~~~~~~~~
>> drivers//regulator/lp87565-regulator.c:37:5: error: 'struct regulator_desc' has no member named 'curr_table'; did you mean 'volt_table'?
       .curr_table = lp87565_buck_uA,   \
        ^~~~~~~~~~
   drivers//regulator/lp87565-regulator.c:145:2: note: in expansion of macro 'LP87565_REGULATOR'
     LP87565_REGULATOR("BUCK10", LP87565_BUCK_10, "buck10", lp87565_buck_ops,
     ^~~~~~~~~~~~~~~~~
>> drivers//regulator/lp87565-regulator.c:38:5: error: 'struct regulator_desc' has no member named 'n_current_limits'
       .n_current_limits = ARRAY_SIZE(lp87565_buck_uA),\
        ^~~~~~~~~~~~~~~~
   drivers//regulator/lp87565-regulator.c:145:2: note: in expansion of macro 'LP87565_REGULATOR'
     LP87565_REGULATOR("BUCK10", LP87565_BUCK_10, "buck10", lp87565_buck_ops,
     ^~~~~~~~~~~~~~~~~
>> drivers//regulator/lp87565-regulator.c:37:5: error: 'struct regulator_desc' has no member named 'curr_table'; did you mean 'volt_table'?
       .curr_table = lp87565_buck_uA,   \
        ^~~~~~~~~~
   drivers//regulator/lp87565-regulator.c:151:2: note: in expansion of macro 'LP87565_REGULATOR'
     LP87565_REGULATOR("BUCK23", LP87565_BUCK_23, "buck23", lp87565_buck_ops,
     ^~~~~~~~~~~~~~~~~
>> drivers//regulator/lp87565-regulator.c:38:5: error: 'struct regulator_desc' has no member named 'n_current_limits'
       .n_current_limits = ARRAY_SIZE(lp87565_buck_uA),\
        ^~~~~~~~~~~~~~~~
   drivers//regulator/lp87565-regulator.c:151:2: note: in expansion of macro 'LP87565_REGULATOR'
     LP87565_REGULATOR("BUCK23", LP87565_BUCK_23, "buck23", lp87565_buck_ops,
     ^~~~~~~~~~~~~~~~~

vim +120 drivers//regulator/lp87565-regulator.c

    16	
    17	#define LP87565_REGULATOR(_name, _id, _of, _ops, _n, _vr, _vm, _er, _em, \
    18				 _delay, _lr, _cr)				\
    19		[_id] = {							\
    20			.desc = {						\
    21				.name			= _name,		\
    22				.supply_name		= _of "-in",		\
    23				.id			= _id,			\
    24				.of_match		= of_match_ptr(_of),	\
    25				.regulators_node	= of_match_ptr("regulators"),\
    26				.ops			= &_ops,		\
    27				.n_voltages		= _n,			\
    28				.type			= REGULATOR_VOLTAGE,	\
    29				.owner			= THIS_MODULE,		\
    30				.vsel_reg		= _vr,			\
    31				.vsel_mask		= _vm,			\
    32				.enable_reg		= _er,			\
    33				.enable_mask		= _em,			\
    34				.ramp_delay		= _delay,		\
    35				.linear_ranges		= _lr,			\
    36				.n_linear_ranges	= ARRAY_SIZE(_lr),	\
  > 37				.curr_table = lp87565_buck_uA,			\
  > 38				.n_current_limits = ARRAY_SIZE(lp87565_buck_uA),\
    39				.csel_reg = (_cr),				\
    40				.csel_mask = LP87565_BUCK_CTRL_2_ILIM,		\
    41			},							\
    42			.ctrl2_reg = _cr,					\
    43		}
    44	
    45	struct lp87565_regulator {
    46		struct regulator_desc desc;
    47		unsigned int ctrl2_reg;
    48	};
    49	
    50	static const struct lp87565_regulator regulators[];
    51	
    52	static const struct regulator_linear_range buck0_1_2_3_ranges[] = {
    53		REGULATOR_LINEAR_RANGE(600000, 0xA, 0x17, 10000),
    54		REGULATOR_LINEAR_RANGE(735000, 0x18, 0x9d, 5000),
    55		REGULATOR_LINEAR_RANGE(1420000, 0x9e, 0xff, 20000),
    56	};
    57	
    58	static const unsigned int lp87565_buck_ramp_delay[] = {
    59		30000, 15000, 10000, 7500, 3800, 1900, 940, 470
    60	};
    61	
    62	/* LP87565 BUCK current limit */
    63	static const unsigned int lp87565_buck_uA[] = {
    64		1500000, 2000000, 2500000, 3000000, 3500000, 4000000, 4500000, 5000000,
    65	};
    66	
    67	static int lp87565_buck_set_ramp_delay(struct regulator_dev *rdev,
    68					       int ramp_delay)
    69	{
    70		int id = rdev_get_id(rdev);
    71		struct lp87565 *lp87565 = rdev_get_drvdata(rdev);
    72		unsigned int reg;
    73		int ret;
    74	
    75		if (ramp_delay <= 470)
    76			reg = 7;
    77		else if (ramp_delay <= 940)
    78			reg = 6;
    79		else if (ramp_delay <= 1900)
    80			reg = 5;
    81		else if (ramp_delay <= 3800)
    82			reg = 4;
    83		else if (ramp_delay <= 7500)
    84			reg = 3;
    85		else if (ramp_delay <= 10000)
    86			reg = 2;
    87		else if (ramp_delay <= 15000)
    88			reg = 1;
    89		else
    90			reg = 0;
    91	
    92		ret = regmap_update_bits(lp87565->regmap, regulators[id].ctrl2_reg,
    93					 LP87565_BUCK_CTRL_2_SLEW_RATE,
    94					 reg << __ffs(LP87565_BUCK_CTRL_2_SLEW_RATE));
    95		if (ret) {
    96			dev_err(lp87565->dev, "SLEW RATE write failed: %d\n", ret);
    97			return ret;
    98		}
    99	
   100		rdev->constraints->ramp_delay = lp87565_buck_ramp_delay[reg];
   101	
   102		/* Conservatively give a 15% margin */
   103		rdev->constraints->ramp_delay =
   104					rdev->constraints->ramp_delay * 85 / 100;
   105	
   106		return 0;
   107	}
   108	
   109	/* Operations permitted on BUCKs */
   110	static const struct regulator_ops lp87565_buck_ops = {
   111		.is_enabled		= regulator_is_enabled_regmap,
   112		.enable			= regulator_enable_regmap,
   113		.disable		= regulator_disable_regmap,
   114		.get_voltage_sel	= regulator_get_voltage_sel_regmap,
   115		.set_voltage_sel	= regulator_set_voltage_sel_regmap,
   116		.list_voltage		= regulator_list_voltage_linear_range,
   117		.map_voltage		= regulator_map_voltage_linear_range,
   118		.set_voltage_time_sel	= regulator_set_voltage_time_sel,
   119		.set_ramp_delay		= lp87565_buck_set_ramp_delay,
 > 120		.set_current_limit	= regulator_set_current_limit_regmap,
 > 121		.get_current_limit	= regulator_get_current_limit_regmap,
   122	};
   123	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--opJtzjQTFsWo+cga
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AQA=

--opJtzjQTFsWo+cga--
