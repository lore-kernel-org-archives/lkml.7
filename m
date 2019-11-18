Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA4BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48793206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfKRN1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 08:27:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:34640 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfKRN1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 08:27:43 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 05:27:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,320,1569308400"; 
   d="scan'208";a="196125970"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.13.128])
  by orsmga007.jf.intel.com with ESMTP; 18 Nov 2019 05:27:38 -0800
Date:   Mon, 18 Nov 2019 21:34:30 +0800
From:   Philip Li <philip.li@intel.com>
To:     vishnu <vravulap@amd.com>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>, Alexander.Deucher@amd.com,
        djkurtz@google.com, Akshu.Agrawal@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        Sanju R Mehta <sanju.mehta@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        kbuild-all@lists.01.org
Subject: Re: [kbuild-all] Re: [PATCH v5 1/6] ASoC: amd:Create multiple I2S
 platform device Endpoint (fwd)
Message-ID: <20191118133430.GB3979@intel.com>
References: <alpine.DEB.2.21.1911171159570.2641@hadrien>
 <ff992812-3bf1-4cc0-1e07-e11392cf5dca@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff992812-3bf1-4cc0-1e07-e11392cf5dca@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 02:29:01PM +0530, vishnu wrote:
> Hi Julia,
> 
> This is not latest version.I have already send V6 version.
> The comment which you gave is for v5 old version.
sorry Vishnu, this is kbuild side problem. We will check
why we didn't block the report when there's new version.

> 
> 
> Thanks,
> Vishnu
> 
> On 17/11/19 4:31 PM, Julia Lawall wrote:
> > On line 70, adata->res is allocated with a devm function, so it shouldn't
> > be passed to kfree later; that will lead to a double free.
> > 
> > julia
> > 
> > ---------- Forwarded message ----------
> > Date: Sun, 17 Nov 2019 11:44:07 +0800
> > From: kbuild test robot <lkp@intel.com>
> > To: kbuild@lists.01.org
> > Cc: Julia Lawall <julia.lawall@lip6.fr>
> > Subject: Re: [PATCH v5 1/6] ASoC: amd:Create multiple I2S platform device
> >      Endpoint
> > 
> > In-Reply-To: <1573629249-13272-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
> > References: <1573629249-13272-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
> > 
> > Hi Ravulapati,
> > 
> > Thank you for the patch! Perhaps something to improve:
> > 
> > [auto build test WARNING on asoc/for-next]
> > [cannot apply to v5.4-rc7 next-20191115]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system. BTW, we also suggest to use '--base' option to specify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Ravulapati-Vishnu-vardhan-rao/ASoC-amd-Create-multiple-I2S-platform-device-Endpoint/20191113-230604
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> > :::::: branch date: 4 days ago
> > :::::: commit date: 4 days ago
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> > 
> > > > sound/soc/amd/raven/pci-acp3x.c:142:1-6: WARNING: invalid free of devm_ allocated data
> > 
> > # https://github.com/0day-ci/linux/commit/79701559637a30a0708febfd5119ad05128b2ba5
> > git remote add linux-review https://github.com/0day-ci/linux
> > git remote update linux-review
> > git checkout 79701559637a30a0708febfd5119ad05128b2ba5
> > vim +142 sound/soc/amd/raven/pci-acp3x.c
> > 
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   21
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   22  static int snd_acp3x_probe(struct pci_dev *pci,
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   23  			   const struct pci_device_id *pci_id)
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   24  {
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   25  	int ret;
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   26  	u32 addr, val, i;
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   27  	struct acp3x_dev_data *adata;
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   28  	struct platform_device_info pdevinfo[ACP3x_DEVS];
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   29  	unsigned int irqflags;
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   30
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   31  	if (pci_enable_device(pci)) {
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   32  		dev_err(&pci->dev, "pci_enable_device failed\n");
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   33  		return -ENODEV;
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   34  	}
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   35
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   36  	ret = pci_request_regions(pci, "AMD ACP3x audio");
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   37  	if (ret < 0) {
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   38  		dev_err(&pci->dev, "pci_request_regions failed\n");
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   39  		goto disable_pci;
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   40  	}
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   41
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   42  	adata = devm_kzalloc(&pci->dev, sizeof(struct acp3x_dev_data),
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   43  			     GFP_KERNEL);
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   44  	if (!adata) {
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   45  		ret = -ENOMEM;
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   46  		goto release_regions;
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   47  	}
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   48
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   49  	/* check for msi interrupt support */
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   50  	ret = pci_enable_msi(pci);
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   51  	if (ret)
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   52  		/* msi is not enabled */
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   53  		irqflags = IRQF_SHARED;
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   54  	else
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   55  		/* msi is enabled */
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   56  		irqflags = 0;
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   57
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   58  	addr = pci_resource_start(pci, 0);
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   59  	adata->acp3x_base = ioremap(addr, pci_resource_len(pci, 0));
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   60  	if (!adata->acp3x_base) {
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   61  		ret = -ENOMEM;
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   62  		goto release_regions;
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   63  	}
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   64  	pci_set_master(pci);
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   65  	pci_set_drvdata(pci, adata);
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   66
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   67  	val = rv_readl(adata->acp3x_base + mmACP_I2S_PIN_CONFIG);
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   68  	switch (val) {
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   69  	case I2S_MODE:
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   70  		adata->res = devm_kzalloc(&pci->dev,
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   71  					  sizeof(struct resource) * 4,
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   72  					  GFP_KERNEL);
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   73  		if (!adata->res) {
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   74  			ret = -ENOMEM;
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   75  			goto unmap_mmio;
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   76  		}
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   77
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   78  		adata->res[0].name = "acp3x_i2s_iomem";
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   79  		adata->res[0].flags = IORESOURCE_MEM;
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   80  		adata->res[0].start = addr;
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   81  		adata->res[0].end = addr + (ACP3x_REG_END - ACP3x_REG_START);
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   82
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   83  		adata->res[1].name = "acp3x_i2s_sp";
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   84  		adata->res[1].flags = IORESOURCE_MEM;
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   85  		adata->res[1].start = addr + ACP3x_I2STDM_REG_START;
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   86  		adata->res[1].end = addr + ACP3x_I2STDM_REG_END;
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   87
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   88  		adata->res[2].name = "acp3x_i2s_bt";
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   89  		adata->res[2].flags = IORESOURCE_MEM;
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   90  		adata->res[2].start = addr + ACP3x_BT_TDM_REG_START;
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   91  		adata->res[2].end = addr + ACP3x_BT_TDM_REG_END;
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   92
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   93  		adata->res[3].name = "acp3x_i2s_irq";
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   94  		adata->res[3].flags = IORESOURCE_IRQ;
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   95  		adata->res[3].start = pci->irq;
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   96  		adata->res[3].end = adata->res[3].start;
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   97
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   98  		adata->acp3x_audio_mode = ACP3x_I2S_MODE;
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   99
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12  100  		memset(&pdevinfo, 0, sizeof(pdevinfo));
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  101  		pdevinfo[0].name = "acp3x_rv_i2s_dma";
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  102  		pdevinfo[0].id = 0;
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  103  		pdevinfo[0].parent = &pci->dev;
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  104  		pdevinfo[0].num_res = 4;
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  105  		pdevinfo[0].res = &adata->res[0];
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  106  		pdevinfo[0].data = &irqflags;
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  107  		pdevinfo[0].size_data = sizeof(irqflags);
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  108
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  109  		pdevinfo[1].name = "acp3x_i2s_playcap";
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  110  		pdevinfo[1].id = 0;
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  111  		pdevinfo[1].parent = &pci->dev;
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  112  		pdevinfo[1].num_res = 1;
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  113  		pdevinfo[1].res = &adata->res[1];
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  114
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  115  		pdevinfo[2].name = "acp3x_i2s_playcap";
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  116  		pdevinfo[2].id = 1;
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  117  		pdevinfo[2].parent = &pci->dev;
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  118  		pdevinfo[2].num_res = 1;
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  119  		pdevinfo[2].res = &adata->res[2];
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  120  		for (i = 0; i < ACP3x_DEVS ; i++) {
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  121  			adata->pdev[i] =
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  122  				platform_device_register_full(&pdevinfo[i]);
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  123  			if (IS_ERR(adata->pdev[i])) {
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12  124  				dev_err(&pci->dev, "cannot register %s device\n",
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  125  					pdevinfo[i].name);
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  126  				ret = PTR_ERR(adata->pdev[i]);
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12  127  				goto unmap_mmio;
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12  128  			}
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  129  		}
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12  130  		break;
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12  131  	default:
> > 00347e4ea8ca4c Colin Ian King                2018-11-16  132  		dev_err(&pci->dev, "Invalid ACP audio mode : %d\n", val);
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12  133  		ret = -ENODEV;
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12  134  		goto unmap_mmio;
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12  135  	}
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12  136  	return 0;
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12  137
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12  138  unmap_mmio:
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12  139  	pci_disable_msi(pci);
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  140  	for (i = 0 ; i < ACP3x_DEVS ; i++)
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  141  		platform_device_unregister(adata->pdev[i]);
> > 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13 @142  	kfree(adata->res);
> > 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12  143  	iounmap(adata->acp3x_base);
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12  144  release_regions:
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12  145  	pci_release_regions(pci);
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12  146  disable_pci:
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12  147  	pci_disable_device(pci);
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12  148
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12  149  	return ret;
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12  150  }
> > e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12  151
> > 
> > ---
> > 0-DAY kernel test infrastructure                 Open Source Technology Center
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
> > 
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
