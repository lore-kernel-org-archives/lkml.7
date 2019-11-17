Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3964C432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 11:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842FD206D6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 11:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfKQLFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 06:05:16 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:39589
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725974AbfKQLFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 06:05:16 -0500
X-IronPort-AV: E=Sophos;i="5.68,316,1569276000"; 
   d="scan'208";a="327005211"
Received: from abo-228-123-68.mrs.modulonet.fr (HELO hadrien) ([85.68.123.228])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 12:05:12 +0100
Date:   Sun, 17 Nov 2019 12:05:12 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Akshu.Agrawal@amd.com,
        Sanju R Mehta <sanju.mehta@amd.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Mark Brown <broonie@kernel.org>, djkurtz@google.com,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        kbuild-all@lists.01.org
Subject: Re: [alsa-devel] [RESEND PATCH v5 2/6] ASoC: amd: Refactoring of
 DAI from DMA driver (fwd)
Message-ID: <alpine.DEB.2.21.1911171203580.2641@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code needs some work.  You can't just kfree every pointer.  YOu have
to consider how the pointer was initialized.

julia

---------- Forwarded message ----------
Date: Sun, 17 Nov 2019 12:48:14 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@lists.01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [alsa-devel] [RESEND PATCH v5 2/6] ASoC: amd: Refactoring of DAI
    from DMA driver

CC: kbuild-all@lists.01.org
In-Reply-To: <1573629249-13272-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1573629249-13272-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
CC:

Hi Ravulapati,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on asoc/for-next]
[cannot apply to v5.4-rc7 next-20191115]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Ravulapati-Vishnu-vardhan-rao/ASoC-amd-Create-multiple-I2S-platform-device-Endpoint/20191113-230604
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
:::::: branch date: 4 days ago
:::::: commit date: 4 days ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>

>> sound/soc/amd/raven/acp3x-i2s.c:245:1-6: WARNING: invalid free of devm_ allocated data
   sound/soc/amd/raven/acp3x-i2s.c:248:1-6: WARNING: invalid free of devm_ allocated data
   sound/soc/amd/raven/acp3x-i2s.c:249:1-6: WARNING: invalid free of devm_ allocated data

# https://github.com/0day-ci/linux/commit/74480eceed0f95f0b8d383d0882b918a335ce0d4
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 74480eceed0f95f0b8d383d0882b918a335ce0d4
vim +245 sound/soc/amd/raven/acp3x-i2s.c

74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  207
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  208
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  209  static int acp3x_dai_probe(struct platform_device *pdev)
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  210  {
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  211  	int status;
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  212  	struct resource *res;
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  213  	struct i2s_dev_data *adata;
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  214
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  215  	adata = devm_kzalloc(&pdev->dev, sizeof(struct i2s_dev_data),
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  216  			GFP_KERNEL);
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  217  	if (!adata)
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  218  		return -ENOMEM;
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  219
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  220  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  221  	if (!res) {
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  222  		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  223  		goto err;
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  224  	}
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  225
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  226  	adata->acp3x_base = devm_ioremap(&pdev->dev, res->start,
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  227  			resource_size(res));
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  228  	if (IS_ERR(adata->acp3x_base))
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  229  		return PTR_ERR(adata->acp3x_base);
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  230
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  231  	adata->i2s_irq = res->start;
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  232  	dev_set_drvdata(&pdev->dev, adata);
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  233  	status = devm_snd_soc_register_component(&pdev->dev,
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  234  			&acp3x_dai_component,
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  235  			&acp3x_i2s_dai, 1);
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  236  	if (status) {
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  237  		dev_err(&pdev->dev, "Fail to register acp i2s dai\n");
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  238  		goto dev_err;
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  239  	}
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  240  	pm_runtime_set_autosuspend_delay(&pdev->dev, 10000);
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  241  	pm_runtime_use_autosuspend(&pdev->dev);
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  242  	pm_runtime_enable(&pdev->dev);
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  243  	return 0;
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  244  err:
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13 @245  	kfree(adata);
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  246  	return -ENOMEM;
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  247  dev_err:
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  248  	kfree(adata->acp3x_base);
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  249  	kfree(adata);
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  250  	kfree(res);
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  251  	return -ENODEV;
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  252  }
74480eceed0f95 Ravulapati Vishnu vardhan rao 2019-11-13  253

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
