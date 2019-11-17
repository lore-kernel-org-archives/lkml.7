Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F02C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 01:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4972075C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 01:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKQBT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 20:19:27 -0500
Received: from mga11.intel.com ([192.55.52.93]:34838 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbfKQBT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 20:19:26 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2019 17:19:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,314,1569308400"; 
   d="scan'208";a="380302666"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Nov 2019 17:19:23 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iW9Dm-000E0F-T3; Sun, 17 Nov 2019 09:19:22 +0800
Date:   Sun, 17 Nov 2019 09:18:33 +0800
From:   kbuild test robot <lkp@intel.com>
To:     patrick.rudolph@9elements.com
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        coreboot@coreboot.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 1/2] firmware: google: Expose CBMEM over sysfs
Message-ID: <201911170909.p3H1NF75%lkp@intel.com>
References: <20191115161524.23738-2-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115161524.23738-2-patrick.rudolph@9elements.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.4-rc7 next-20191115]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/patrick-rudolph-9elements-com/firmware-google-Expose-coreboot-tables-and-CBMEM/20191116-033417
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 96b95eff4a591dbac582c2590d067e356a18aacb
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-32-g233d4e1-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/firmware/google/cbmem-coreboot.c:79:44: sparse: sparse: incorrect type in argument 4 (different address spaces) @@    expected void const *from @@    got void [noderef] <asvoid const *from @@
>> drivers/firmware/google/cbmem-coreboot.c:79:44: sparse:    expected void const *from
>> drivers/firmware/google/cbmem-coreboot.c:79:44: sparse:    got void [noderef] <asn:2> *const remap
>> drivers/firmware/google/cbmem-coreboot.c:110:21: sparse: sparse: incorrect type in assignment (different address spaces) @@    expected void [noderef] <asn:2> *remap @@    got n:2> *remap @@
>> drivers/firmware/google/cbmem-coreboot.c:110:21: sparse:    expected void [noderef] <asn:2> *remap
>> drivers/firmware/google/cbmem-coreboot.c:110:21: sparse:    got void *
>> drivers/firmware/google/cbmem-coreboot.c:120:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void *addr @@    got void [noderef] <asvoid *addr @@
>> drivers/firmware/google/cbmem-coreboot.c:120:30: sparse:    expected void *addr
>> drivers/firmware/google/cbmem-coreboot.c:120:30: sparse:    got void [noderef] <asn:2> *remap
>> drivers/firmware/google/cbmem-coreboot.c:142:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void *addr @@    got void [noderef] <asn:2> *void *addr @@
   drivers/firmware/google/cbmem-coreboot.c:142:30: sparse:    expected void *addr
   drivers/firmware/google/cbmem-coreboot.c:142:30: sparse:    got void [noderef] <asn:2> *const remap

vim +79 drivers/firmware/google/cbmem-coreboot.c

    68	
    69	static ssize_t cbmem_data_read(struct file *filp, struct kobject *kobj,
    70				       struct bin_attribute *bin_attr,
    71				       char *buffer, loff_t offset, size_t count)
    72	{
    73		struct device *dev = kobj_to_dev(kobj);
    74		const struct cb_priv *priv;
    75	
    76		priv = (const struct cb_priv *)dev_get_platdata(dev);
    77	
    78		return memory_read_from_buffer(buffer, count, &offset,
  > 79					       priv->remap, priv->entry.size);
    80	}
    81	
    82	static struct bin_attribute coreboot_attr_data = {
    83		.attr = { .name = "data", .mode = 0444 },
    84		.read = cbmem_data_read,
    85	};
    86	
    87	static struct bin_attribute *cb_mem_bin_attrs[] = {
    88		&coreboot_attr_data,
    89		NULL
    90	};
    91	
    92	static struct attribute_group cb_mem_attr_group = {
    93		.name = "cbmem_attributes",
    94		.attrs = cb_mem_attrs,
    95		.bin_attrs = cb_mem_bin_attrs,
    96	};
    97	
    98	static int cbmem_probe(struct coreboot_device *cdev)
    99	{
   100		struct device *dev = &cdev->dev;
   101		struct cb_priv *priv;
   102		int err;
   103	
   104		priv = kzalloc(sizeof(*priv), GFP_KERNEL);
   105		if (!priv)
   106			return -ENOMEM;
   107	
   108		memcpy(&priv->entry, &cdev->cbmem_entry, sizeof(priv->entry));
   109	
 > 110		priv->remap = memremap(priv->entry.address,
   111				       priv->entry.entry_size, MEMREMAP_WB);
   112		if (!priv->remap) {
   113			err = -ENOMEM;
   114			goto failure;
   115		}
   116	
   117		err = sysfs_create_group(&dev->kobj, &cb_mem_attr_group);
   118		if (err) {
   119			dev_err(dev, "failed to create sysfs attributes: %d\n", err);
 > 120			memunmap(priv->remap);
   121			goto failure;
   122		}
   123	
   124		dev->platform_data = priv;
   125	
   126		return 0;
   127	failure:
   128		kfree(priv);
   129		return err;
   130	}
   131	
   132	static int cbmem_remove(struct coreboot_device *cdev)
   133	{
   134		struct device *dev = &cdev->dev;
   135		const struct cb_priv *priv;
   136	
   137		priv = (const struct cb_priv *)dev_get_platdata(dev);
   138	
   139		sysfs_remove_group(&dev->kobj, &cb_mem_attr_group);
   140	
   141		if (priv)
 > 142			memunmap(priv->remap);
   143		kfree(priv);
   144	
   145		dev->platform_data = NULL;
   146	
   147		return 0;
   148	}
   149	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
