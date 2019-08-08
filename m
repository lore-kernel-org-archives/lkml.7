Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508D4C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BA52166E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390451AbfHHWCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 18:02:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:63010 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730768AbfHHWCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 18:02:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 15:02:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,363,1559545200"; 
   d="scan'208";a="326447683"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 Aug 2019 15:02:12 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hvqU7-0001o2-N7; Fri, 09 Aug 2019 06:02:11 +0800
Date:   Fri, 9 Aug 2019 06:01:20 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Zeng Tao <prime.zeng@hisilicon.com>
Cc:     kbuild-all@01.org, prime.zeng@hisilicon.com, kishon@ti.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] phy: Change the configuration interface param to void*
 to make it more general
Message-ID: <201908090527.lvf3vFhJ%lkp@intel.com>
References: <1562868255-31467-1-git-send-email-prime.zeng@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562868255-31467-1-git-send-email-prime.zeng@hisilicon.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zeng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[cannot apply to v5.3-rc3 next-20190808]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Zeng-Tao/phy-Change-the-configuration-interface-param-to-void-to-make-it-more-general/20190713-213420
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   include/linux/sched.h:609:43: sparse: sparse: bad integer constant expression
   include/linux/sched.h:609:73: sparse: sparse: invalid named zero-width bitfield `value'
   include/linux/sched.h:610:43: sparse: sparse: bad integer constant expression
   include/linux/sched.h:610:67: sparse: sparse: invalid named zero-width bitfield `bucket_id'
>> drivers/gpu/drm/bridge/cdns-dsi.c:609:73: sparse: sparse: using member 'mipi_dphy' in incomplete union phy_configure_opts
   drivers/gpu/drm/bridge/cdns-dsi.c:784:73: sparse: sparse: using member 'mipi_dphy' in incomplete union phy_configure_opts
--
   include/linux/sched.h:609:43: sparse: sparse: bad integer constant expression
   include/linux/sched.h:609:73: sparse: sparse: invalid named zero-width bitfield `value'
   include/linux/sched.h:610:43: sparse: sparse: bad integer constant expression
   include/linux/sched.h:610:67: sparse: sparse: invalid named zero-width bitfield `bucket_id'
   drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:165:22: sparse: sparse: using member 'hs_clk_rate' in incomplete struct phy_configure_opts_mipi_dphy
   drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:169:30: sparse: sparse: using member 'hs_clk_rate' in incomplete struct phy_configure_opts_mipi_dphy
   drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:173:17: sparse: sparse: using member 'hs_clk_rate' in incomplete struct phy_configure_opts_mipi_dphy
   drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:200:17: sparse: sparse: using member 'hs_clk_rate' in incomplete struct phy_configure_opts_mipi_dphy
   drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:206:9: sparse: sparse: using member 'hs_clk_rate' in incomplete struct phy_configure_opts_mipi_dphy
   drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:211:9: sparse: sparse: using member 'lp_clk_rate' in incomplete struct phy_configure_opts_mipi_dphy
   drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:216:9: sparse: sparse: using member 'lp_clk_rate' in incomplete struct phy_configure_opts_mipi_dphy
   drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:220:26: sparse: sparse: using member 'hs_prepare' in incomplete struct phy_configure_opts_mipi_dphy
   drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:221:17: sparse: sparse: using member 'hs_prepare' in incomplete struct phy_configure_opts_mipi_dphy
   drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:227:22: sparse: sparse: using member 'hs_prepare' in incomplete struct phy_configure_opts_mipi_dphy
   drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:230:37: sparse: sparse: using member 'hs_prepare' in incomplete struct phy_configure_opts_mipi_dphy
   drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:237:26: sparse: sparse: using member 'clk_prepare' in incomplete struct phy_configure_opts_mipi_dphy
   drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:238:17: sparse: sparse: using member 'clk_prepare' in incomplete struct phy_configure_opts_mipi_dphy
   drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:244:43: sparse: sparse: using member 'clk_prepare' in incomplete struct phy_configure_opts_mipi_dphy
   drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:247:30: sparse: sparse: using member 'hs_clk_rate' in incomplete struct phy_configure_opts_mipi_dphy
   drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:251:29: sparse: sparse: using member 'hs_clk_rate' in incomplete struct phy_configure_opts_mipi_dphy
   drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:255:30: sparse: sparse: using member 'hs_clk_rate' in incomplete struct phy_configure_opts_mipi_dphy
   drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:264:22: sparse: sparse: using member 'hs_clk_rate' in incomplete struct phy_configure_opts_mipi_dphy
   drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:266:27: sparse: sparse: using member 'hs_clk_rate' in incomplete struct phy_configure_opts_mipi_dphy
   drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:268:27: sparse: sparse: using member 'hs_clk_rate' in incomplete struct phy_configure_opts_mipi_dphy
   drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:270:27: sparse: sparse: using member 'hs_clk_rate' in incomplete struct phy_configure_opts_mipi_dphy
   drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:272:27: sparse: sparse: using member 'hs_clk_rate' in incomplete struct phy_configure_opts_mipi_dphy
   drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:274:27: sparse: sparse: using member 'hs_clk_rate' in incomplete struct phy_configure_opts_mipi_dphy
>> drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:326:53: sparse: sparse: using member 'mipi_dphy' in incomplete union phy_configure_opts
   drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:356:54: sparse: sparse: using member 'mipi_dphy' in incomplete union phy_configure_opts

vim +/mipi_dphy +609 drivers/gpu/drm/bridge/cdns-dsi.c

4dad3e7f12f702 Maxime Ripard   2019-01-21  602  
4dad3e7f12f702 Maxime Ripard   2019-01-21  603  static int cdns_dsi_check_conf(struct cdns_dsi *dsi,
4dad3e7f12f702 Maxime Ripard   2019-01-21  604  			       const struct drm_display_mode *mode,
4dad3e7f12f702 Maxime Ripard   2019-01-21  605  			       struct cdns_dsi_cfg *dsi_cfg,
4dad3e7f12f702 Maxime Ripard   2019-01-21  606  			       bool mode_valid_check)
4dad3e7f12f702 Maxime Ripard   2019-01-21  607  {
4dad3e7f12f702 Maxime Ripard   2019-01-21  608  	struct cdns_dsi_output *output = &dsi->output;
fced5a364dee9d Maxime Ripard   2019-01-21 @609  	struct phy_configure_opts_mipi_dphy *phy_cfg = &output->phy_opts.mipi_dphy;
4dad3e7f12f702 Maxime Ripard   2019-01-21  610  	unsigned long dsi_hss_hsa_hse_hbp;
4dad3e7f12f702 Maxime Ripard   2019-01-21  611  	unsigned int nlanes = output->dev->lanes;
4dad3e7f12f702 Maxime Ripard   2019-01-21  612  	int ret;
4dad3e7f12f702 Maxime Ripard   2019-01-21  613  
4dad3e7f12f702 Maxime Ripard   2019-01-21  614  	ret = cdns_dsi_mode2cfg(dsi, mode, dsi_cfg, mode_valid_check);
4dad3e7f12f702 Maxime Ripard   2019-01-21  615  	if (ret)
4dad3e7f12f702 Maxime Ripard   2019-01-21  616  		return ret;
4dad3e7f12f702 Maxime Ripard   2019-01-21  617  
fced5a364dee9d Maxime Ripard   2019-01-21  618  	phy_mipi_dphy_get_default_config(mode->crtc_clock * 1000,
fced5a364dee9d Maxime Ripard   2019-01-21  619  					 mipi_dsi_pixel_format_to_bpp(output->dev->format),
fced5a364dee9d Maxime Ripard   2019-01-21  620  					 nlanes, phy_cfg);
fced5a364dee9d Maxime Ripard   2019-01-21  621  
fced5a364dee9d Maxime Ripard   2019-01-21  622  	ret = cdns_dsi_adjust_phy_config(dsi, dsi_cfg, phy_cfg, mode, mode_valid_check);
fced5a364dee9d Maxime Ripard   2019-01-21  623  	if (ret)
fced5a364dee9d Maxime Ripard   2019-01-21  624  		return ret;
fced5a364dee9d Maxime Ripard   2019-01-21  625  
fced5a364dee9d Maxime Ripard   2019-01-21  626  	ret = phy_validate(dsi->dphy, PHY_MODE_MIPI_DPHY, 0, &output->phy_opts);
4dad3e7f12f702 Maxime Ripard   2019-01-21  627  	if (ret)
4dad3e7f12f702 Maxime Ripard   2019-01-21  628  		return ret;
4dad3e7f12f702 Maxime Ripard   2019-01-21  629  
4dad3e7f12f702 Maxime Ripard   2019-01-21  630  	dsi_hss_hsa_hse_hbp = dsi_cfg->hbp + DSI_HBP_FRAME_OVERHEAD;
4dad3e7f12f702 Maxime Ripard   2019-01-21  631  	if (output->dev->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
4dad3e7f12f702 Maxime Ripard   2019-01-21  632  		dsi_hss_hsa_hse_hbp += dsi_cfg->hsa + DSI_HSA_FRAME_OVERHEAD;
e19233955d9e9a Boris Brezillon 2018-04-21  633  
e19233955d9e9a Boris Brezillon 2018-04-21  634  	/*
e19233955d9e9a Boris Brezillon 2018-04-21  635  	 * Make sure DPI(HFP) > DSI(HSS+HSA+HSE+HBP) to guarantee that the FIFO
e19233955d9e9a Boris Brezillon 2018-04-21  636  	 * is empty before we start a receiving a new line on the DPI
e19233955d9e9a Boris Brezillon 2018-04-21  637  	 * interface.
e19233955d9e9a Boris Brezillon 2018-04-21  638  	 */
fced5a364dee9d Maxime Ripard   2019-01-21  639  	if ((u64)phy_cfg->hs_clk_rate *
4dad3e7f12f702 Maxime Ripard   2019-01-21  640  	    mode_to_dpi_hfp(mode, mode_valid_check) * nlanes <
e19233955d9e9a Boris Brezillon 2018-04-21  641  	    (u64)dsi_hss_hsa_hse_hbp *
e19233955d9e9a Boris Brezillon 2018-04-21  642  	    (mode_valid_check ? mode->clock : mode->crtc_clock) * 1000)
e19233955d9e9a Boris Brezillon 2018-04-21  643  		return -EINVAL;
e19233955d9e9a Boris Brezillon 2018-04-21  644  
e19233955d9e9a Boris Brezillon 2018-04-21  645  	return 0;
e19233955d9e9a Boris Brezillon 2018-04-21  646  }
e19233955d9e9a Boris Brezillon 2018-04-21  647  

:::::: The code at line 609 was first introduced by commit
:::::: fced5a364dee9d3a3ed1e3290ea3b83984b78007 drm/bridge: cdns: Convert to phy framework

:::::: TO: Maxime Ripard <maxime.ripard@bootlin.com>
:::::: CC: Maxime Ripard <maxime.ripard@bootlin.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
