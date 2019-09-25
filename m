Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F79C4320D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E44E20673
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634056AbfIYIRw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 04:17:52 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:45795 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634045AbfIYIRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 04:17:51 -0400
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 9D02D100016;
        Wed, 25 Sep 2019 08:17:41 +0000 (UTC)
Date:   Wed, 25 Sep 2019 10:17:40 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Piotr Sroka <piotrs@cadence.com>, kbuild-all@01.org,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [v7 1/2] mtd: rawnand: Add new Cadence NAND driver to MTD
 subsystem (fwd)
Message-ID: <20190925101740.725e2cb6@xps13>
In-Reply-To: <alpine.DEB.2.21.1909182103550.2753@hadrien>
References: <alpine.DEB.2.21.1909182103550.2753@hadrien>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Piotr,

Can you fix the below issue reported by Julia? Either convert the
structure parameter to a signed parameter or use an intermediate
variable.

Thanks,
Miquèl

Julia Lawall <julia.lawall@lip6.fr> wrote on Wed, 18 Sep 2019 21:04:37
+0200 (CEST):

> ---------- Forwarded message ----------
> Date: Wed, 18 Sep 2019 23:17:29 +0800
> From: kbuild test robot <lkp@intel.com>
> To: kbuild@01.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: Re: [v7 1/2] mtd: rawnand: Add new Cadence NAND driver to MTD subsystem
> 
> CC: kbuild-all@01.org
> In-Reply-To: <20190918123115.30510-1-piotrs@cadence.com>
> References: <20190918123115.30510-1-piotrs@cadence.com>
> TO: Piotr Sroka <piotrs@cadence.com>
> CC: Kazuhiro Kasai <kasai.kazuhiro@socionext.com>, Piotr Sroka <piotrs@cadence.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Boris Brezillon <boris.brezillon@collabora.com>, Thomas Gleixner <tglx@linutronix.de>, Paul Cercueil <paul@crapouillou.net>, Arnd Bergmann <arnd@arndb.de>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Liang Yang <liang.yang@amlogic.com>, Anders Roxell <anders.roxell@linaro.org>, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
> 
> Hi Piotr,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on linus/master]
> [cannot apply to v5.3 next-20190917]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Piotr-Sroka/mtd-rawnand-Add-new-Cadence-NAND-driver-to-MTD-subsystem/20190918-204505
> :::::: branch date: 3 hours ago
> :::::: commit date: 3 hours ago
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> 
> >> drivers/mtd/nand/raw/cadence-nand-controller.c:2644:5-28: WARNING: Unsigned expression compared with zero: cdns_chip -> corr_str_idx < 0  
> 
> # https://github.com/0day-ci/linux/commit/3235ae79d58b8d95b44d5d3773f59065f04d4f00
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 3235ae79d58b8d95b44d5d3773f59065f04d4f00
> vim +2644 drivers/mtd/nand/raw/cadence-nand-controller.c
> 
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2584
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2585  int cadence_nand_attach_chip(struct nand_chip *chip)
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2586  {
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2587  	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2588  	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2589  	u32 ecc_size = cdns_chip->sector_count * chip->ecc.bytes;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2590  	struct mtd_info *mtd = nand_to_mtd(chip);
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2591  	u32 max_oob_data_size;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2592  	int ret;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2593
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2594  	if (chip->options & NAND_BUSWIDTH_16) {
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2595  		ret = cadence_nand_set_access_width16(cdns_ctrl, true);
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2596  		if (ret)
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2597  			goto free_buf;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2598  	}
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2599
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2600  	chip->bbt_options |= NAND_BBT_USE_FLASH;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2601  	chip->bbt_options |= NAND_BBT_NO_OOB;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2602  	chip->ecc.mode = NAND_ECC_HW;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2603
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2604  	chip->options |= NAND_NO_SUBPAGE_WRITE;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2605
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2606  	cdns_chip->bbm_offs = chip->badblockpos;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2607  	if (chip->options & NAND_BUSWIDTH_16) {
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2608  		cdns_chip->bbm_offs &= ~0x01;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2609  		cdns_chip->bbm_len = 2;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2610  	} else {
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2611  		cdns_chip->bbm_len = 1;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2612  	}
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2613
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2614  	ret = nand_ecc_choose_conf(chip,
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2615  				   &cdns_ctrl->ecc_caps,
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2616  				   mtd->oobsize - cdns_chip->bbm_len);
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2617  	if (ret) {
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2618  		dev_err(cdns_ctrl->dev, "ECC configuration failed\n");
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2619  		goto free_buf;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2620  	}
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2621
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2622  	dev_dbg(cdns_ctrl->dev,
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2623  		"chosen ECC settings: step=%d, strength=%d, bytes=%d\n",
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2624  		chip->ecc.size, chip->ecc.strength, chip->ecc.bytes);
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2625
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2626  	/* Error correction configuration. */
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2627  	cdns_chip->sector_size = chip->ecc.size;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2628  	cdns_chip->sector_count = mtd->writesize / cdns_chip->sector_size;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2629
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2630  	cdns_chip->avail_oob_size = mtd->oobsize - ecc_size;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2631
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2632  	max_oob_data_size = MAX_OOB_SIZE_PER_SECTOR;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2633
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2634  	if (cdns_chip->avail_oob_size > max_oob_data_size)
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2635  		cdns_chip->avail_oob_size = max_oob_data_size;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2636
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2637  	if ((cdns_chip->avail_oob_size + cdns_chip->bbm_len + ecc_size)
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2638  	    > mtd->oobsize)
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2639  		cdns_chip->avail_oob_size -= 4;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2640
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2641  	cdns_chip->corr_str_idx =
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2642  		cadence_nand_get_ecc_strength_idx(cdns_ctrl,
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2643  						  chip->ecc.strength);
> 3235ae79d58b8d Piotr Sroka 2019-09-18 @2644  	if (cdns_chip->corr_str_idx < 0)
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2645  		return -EINVAL;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2646
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2647  	if (cadence_nand_wait_for_value(cdns_ctrl, CTRL_STATUS,
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2648  					1000000,
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2649  					CTRL_STATUS_CTRL_BUSY, true))
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2650  		return -ETIMEDOUT;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2651
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2652  	cadence_nand_set_ecc_strength(cdns_ctrl,
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2653  				      cdns_chip->corr_str_idx);
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2654
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2655  	cadence_nand_set_erase_detection(cdns_ctrl, true,
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2656  					 chip->ecc.strength);
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2657
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2658  	/* Override the default read operations. */
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2659  	chip->ecc.read_page = cadence_nand_read_page;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2660  	chip->ecc.read_page_raw = cadence_nand_read_page_raw;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2661  	chip->ecc.write_page = cadence_nand_write_page;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2662  	chip->ecc.write_page_raw = cadence_nand_write_page_raw;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2663  	chip->ecc.read_oob = cadence_nand_read_oob;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2664  	chip->ecc.write_oob = cadence_nand_write_oob;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2665  	chip->ecc.read_oob_raw = cadence_nand_read_oob_raw;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2666  	chip->ecc.write_oob_raw = cadence_nand_write_oob_raw;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2667
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2668  	if ((mtd->writesize + mtd->oobsize) > cdns_ctrl->buf_size) {
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2669  		cdns_ctrl->buf_size = mtd->writesize + mtd->oobsize;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2670  		kfree(cdns_ctrl->buf);
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2671  		cdns_ctrl->buf = kzalloc(cdns_ctrl->buf_size, GFP_KERNEL);
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2672  		if (!cdns_ctrl->buf) {
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2673  			ret = -ENOMEM;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2674  			goto free_buf;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2675  		}
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2676  	}
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2677
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2678  	/* Is 32-bit DMA supported? */
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2679  	ret = dma_set_mask(cdns_ctrl->dev, DMA_BIT_MASK(32));
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2680  	if (ret) {
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2681  		dev_err(cdns_ctrl->dev, "no usable DMA configuration\n");
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2682  		goto free_buf;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2683  	}
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2684
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2685  	mtd_set_ooblayout(mtd, &cadence_nand_ooblayout_ops);
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2686
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2687  	return 0;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2688
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2689  free_buf:
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2690  	kfree(cdns_ctrl->buf);
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2691
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2692  	return ret;
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2693  }
> 3235ae79d58b8d Piotr Sroka 2019-09-18  2694
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

