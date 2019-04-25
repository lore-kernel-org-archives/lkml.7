Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C49C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31477217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbfDYHJ0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:09:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:33016 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbfDYHJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:09:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 00:09:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,392,1549958400"; 
   d="scan'208";a="164908352"
Received: from pgsmsx112-dag.png.intel.com (HELO PGSMSX112.gar.corp.intel.com) ([10.108.55.234])
  by fmsmga004.fm.intel.com with ESMTP; 25 Apr 2019 00:09:23 -0700
Received: from pgsmsx103.gar.corp.intel.com ([169.254.2.111]) by
 PGSMSX112.gar.corp.intel.com ([169.254.3.40]) with mapi id 14.03.0415.000;
 Thu, 25 Apr 2019 15:09:22 +0800
From:   "Voon, Weifeng" <weifeng.voon@intel.com>
To:     "David S. Miller" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ong, Boon Leong" <boon.leong.ong@intel.com>,
        "Kweh, Hock Leong" <hock.leong.kweh@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "Andrew Lunn" <andrew@lunn.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Giuseppe Cavallaro" <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "Voon, Weifeng" <weifeng.voon@intel.com>
Subject: RE: [PATCH 7/7] net: stmmac: add xPCS functions for device with
 DWMACv5.1
Thread-Topic: [PATCH 7/7] net: stmmac: add xPCS functions for device with
 DWMACv5.1
Thread-Index: AQHU+n54FtbEdBiVAUioUTWSokEIU6ZMdneg
Date:   Thu, 25 Apr 2019 07:09:21 +0000
Message-ID: <D6759987A7968C4889FDA6FA91D5CBC8146EF0DD@PGSMSX103.gar.corp.intel.com>
References: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
 <1556126241-2774-8-git-send-email-weifeng.voon@intel.com>
In-Reply-To: <1556126241-2774-8-git-send-email-weifeng.voon@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGE4ZTU5ZmEtMTkyNy00NGM5LWExYzgtYTZiOTIyNGY3OGJkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRWJRTjM0OWtmMEU4Zkt6ZUJ0KzdHMVBkRVRxRGtxQksyaFRxcnV4OGRoMDFac2syQUI1R213VG52Z0k0cFZYVyJ9
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [172.30.20.205]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ong Boon Leong <boon.leong.ong@intel.com>
> 
> We introduce support for driver that has v5.10 IP and is also using xPCS as
> MMD. This can be easily enabled for other product that integrates xPCS that
> is not using v5.00 IP.
> 
> Reviewed-by: Chuah Kim Tatt <kim.tatt.chuah@intel.com>
> Reviewed-by: Voon Weifeng <weifeng.voon@intel.com>
> Reviewed-by: Kweh Hock Leong <hock.leong.kweh@intel.com>
> Reviewed-by: Baoli Zhang <baoli.zhang@intel.com>
> Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 67
> +++++++++++++++++++++++
>  drivers/net/ethernet/stmicro/stmmac/hwif.c        | 31 ++++++++++-
>  drivers/net/ethernet/stmicro/stmmac/hwif.h        |  1 +
>  3 files changed, 98 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> index 7e5d5db..f36aa67 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> @@ -20,6 +20,7 @@
>  #include <net/dsa.h>
>  #include "stmmac.h"
>  #include "stmmac_pcs.h"
> +#include "dw_xpcs.h"
>  #include "dwmac4.h"
>  #include "dwmac5.h"
> 
> @@ -505,6 +506,34 @@ static void dwmac4_get_adv_lp(void __iomem
> *ioaddr, struct rgmii_adv *adv)
>  	dwmac_get_adv_lp(ioaddr, GMAC_PCS_BASE, adv);  }
> 
> +static void dwmac_xpcs_init(struct net_device *ndev, int pcs_mode) {
> +	dw_xpcs_init(ndev, pcs_mode);
> +}
> +
> +static void dwmac_xpcs_ctrl_ane(struct net_device *ndev, bool ane,
> +				bool loopback)
> +{
> +	dw_xpcs_ctrl_ane(ndev, ane, loopback); }
> +
> +static void dwmac_xpcs_rane(struct net_device *ndev, bool restart) {
> +	dw_xpcs_rane(ndev, restart);
> +}
> +
> +static void dwmac_xpcs_get_adv_lp(struct net_device *ndev,
> +				  struct rgmii_adv *adv)
> +{
> +	dw_xpcs_get_adv_lp(ndev, adv);
> +}
> +
> +static int dwmac_xpcs_irq_status(struct net_device *ndev,
> +				 struct stmmac_extra_stats *x)
> +{
> +	return dw_xpcs_irq_status(ndev, x);
> +}
> +
>  /* RGMII or SMII interface */
>  static void dwmac4_phystatus(void __iomem *ioaddr, struct
> stmmac_extra_stats *x)  { @@ -799,6 +828,44 @@ static void
> dwmac4_debug(void __iomem *ioaddr, struct stmmac_extra_stats *x,
>  	.flex_pps_config = dwmac5_flex_pps_config,  };
> 
> +const struct stmmac_ops dwmac510_xpcs_ops = {
> +	.core_init = dwmac4_core_init,
> +	.set_mac = stmmac_dwmac4_set_mac,
> +	.rx_ipc = dwmac4_rx_ipc_enable,
> +	.rx_queue_enable = dwmac4_rx_queue_enable,
> +	.rx_queue_prio = dwmac4_rx_queue_priority,
> +	.tx_queue_prio = dwmac4_tx_queue_priority,
> +	.rx_queue_routing = dwmac4_rx_queue_routing,
> +	.prog_mtl_rx_algorithms = dwmac4_prog_mtl_rx_algorithms,
> +	.prog_mtl_tx_algorithms = dwmac4_prog_mtl_tx_algorithms,
> +	.set_mtl_tx_queue_weight = dwmac4_set_mtl_tx_queue_weight,
> +	.map_mtl_to_dma = dwmac4_map_mtl_dma,
> +	.config_cbs = dwmac4_config_cbs,
> +	.dump_regs = dwmac4_dump_regs,
> +	.host_irq_status = dwmac4_irq_status,
> +	.host_mtl_irq_status = dwmac4_irq_mtl_status,
> +	.flow_ctrl = dwmac4_flow_ctrl,
> +	.pmt = dwmac4_pmt,
> +	.set_umac_addr = dwmac4_set_umac_addr,
> +	.get_umac_addr = dwmac4_get_umac_addr,
> +	.set_eee_mode = dwmac4_set_eee_mode,
> +	.reset_eee_mode = dwmac4_reset_eee_mode,
> +	.set_eee_timer = dwmac4_set_eee_timer,
> +	.set_eee_pls = dwmac4_set_eee_pls,
> +	.xpcs_init = dwmac_xpcs_init,
> +	.xpcs_ctrl_ane = dwmac_xpcs_ctrl_ane,
> +	.xpcs_rane = dwmac_xpcs_rane,
> +	.xpcs_get_adv_lp = dwmac_xpcs_get_adv_lp,
> +	.xpcs_irq_status = dwmac_xpcs_irq_status,
> +	.debug = dwmac4_debug,
> +	.set_filter = dwmac4_set_filter,
> +	.safety_feat_config = dwmac5_safety_feat_config,
> +	.safety_feat_irq_status = dwmac5_safety_feat_irq_status,
> +	.safety_feat_dump = dwmac5_safety_feat_dump,
> +	.rxp_config = dwmac5_rxp_config,
> +	.flex_pps_config = dwmac5_flex_pps_config, };
> +
>  int dwmac4_setup(struct stmmac_priv *priv)  {
>  	struct mac_device_info *mac = priv->hw; diff --git
> a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> index 81b966a..3725baa 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> @@ -73,6 +73,7 @@ static int stmmac_dwmac4_quirks(struct stmmac_priv
> *priv)
>  	bool gmac;
>  	bool gmac4;
>  	bool xgmac;
> +	bool xpcs;
>  	u32 min_id;
>  	const struct stmmac_regs_off regs;
>  	const void *desc;
> @@ -89,6 +90,7 @@ static int stmmac_dwmac4_quirks(struct stmmac_priv
> *priv)
>  		.gmac = false,
>  		.gmac4 = false,
>  		.xgmac = false,
> +		.xpcs = false,
>  		.min_id = 0,
>  		.regs = {
>  			.ptp_off = PTP_GMAC3_X_OFFSET,
> @@ -106,6 +108,7 @@ static int stmmac_dwmac4_quirks(struct stmmac_priv
> *priv)
>  		.gmac = true,
>  		.gmac4 = false,
>  		.xgmac = false,
> +		.xpcs = false,
>  		.min_id = 0,
>  		.regs = {
>  			.ptp_off = PTP_GMAC3_X_OFFSET,
> @@ -123,6 +126,7 @@ static int stmmac_dwmac4_quirks(struct stmmac_priv
> *priv)
>  		.gmac = false,
>  		.gmac4 = true,
>  		.xgmac = false,
> +		.xpcs = false,
>  		.min_id = 0,
>  		.regs = {
>  			.ptp_off = PTP_GMAC4_OFFSET,
> @@ -140,6 +144,7 @@ static int stmmac_dwmac4_quirks(struct stmmac_priv
> *priv)
>  		.gmac = false,
>  		.gmac4 = true,
>  		.xgmac = false,
> +		.xpcs = false,
>  		.min_id = DWMAC_CORE_4_00,
>  		.regs = {
>  			.ptp_off = PTP_GMAC4_OFFSET,
> @@ -157,6 +162,7 @@ static int stmmac_dwmac4_quirks(struct stmmac_priv
> *priv)
>  		.gmac = false,
>  		.gmac4 = true,
>  		.xgmac = false,
> +		.xpcs = false,
>  		.min_id = DWMAC_CORE_4_10,
>  		.regs = {
>  			.ptp_off = PTP_GMAC4_OFFSET,
> @@ -174,6 +180,7 @@ static int stmmac_dwmac4_quirks(struct stmmac_priv
> *priv)
>  		.gmac = false,
>  		.gmac4 = true,
>  		.xgmac = false,
> +		.xpcs = false,
>  		.min_id = DWMAC_CORE_5_10,
>  		.regs = {
>  			.ptp_off = PTP_GMAC4_OFFSET,
> @@ -191,6 +198,7 @@ static int stmmac_dwmac4_quirks(struct stmmac_priv
> *priv)
>  		.gmac = false,
>  		.gmac4 = false,
>  		.xgmac = true,
> +		.xpcs = false,
>  		.min_id = DWXGMAC_CORE_2_10,
>  		.regs = {
>  			.ptp_off = PTP_XGMAC_OFFSET,
> @@ -204,7 +212,25 @@ static int stmmac_dwmac4_quirks(struct
> stmmac_priv *priv)
>  		.tc = &dwmac510_tc_ops,
>  		.setup = dwxgmac2_setup,
>  		.quirks = NULL,
> -	},
> +	}, {
> +		.gmac = false,
> +		.gmac4 = true,
> +		.xgmac = false,
> +		.xpcs = true,
> +		.min_id = DWMAC_CORE_5_10,
> +		.regs = {
> +			.ptp_off = PTP_GMAC4_OFFSET,
> +			.mmc_off = MMC_GMAC4_OFFSET,
> +		},
> +		.desc = &dwmac4_desc_ops,
> +		.dma = &dwmac410_dma_ops,
> +		.mac = &dwmac510_xpcs_ops,
> +		.hwtimestamp = &stmmac_ptp,
> +		.mode = &dwmac4_ring_mode_ops,
> +		.tc = &dwmac510_tc_ops,
> +		.setup = dwmac4_setup,
> +		.quirks = NULL,
> +	}
>  };
> 
>  int stmmac_hwif_init(struct stmmac_priv *priv) @@ -212,6 +238,7 @@ int
> stmmac_hwif_init(struct stmmac_priv *priv)
>  	bool needs_xgmac = priv->plat->has_xgmac;
>  	bool needs_gmac4 = priv->plat->has_gmac4;
>  	bool needs_gmac = priv->plat->has_gmac;
> +	bool needs_xpcs = priv->plat->has_xpcs;
>  	const struct stmmac_hwif_entry *entry;
>  	struct mac_device_info *mac;
>  	bool needs_setup = true;
> @@ -256,6 +283,8 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
>  			continue;
>  		if (needs_xgmac ^ entry->xgmac)
>  			continue;
> +		if (needs_xpcs ^ entry->xpcs)
> +			continue;
>  		/* Use synopsys_id var because some setups can override
> this */
>  		if (priv->synopsys_id < entry->min_id)
>  			continue;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index cb7eb48..485be41 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -495,6 +495,7 @@ struct stmmac_regs_off {  extern const struct
> stmmac_ops dwmac410_ops;  extern const struct stmmac_dma_ops
> dwmac410_dma_ops;  extern const struct stmmac_ops dwmac510_ops;
> +extern const struct stmmac_ops dwmac510_xpcs_ops;
>  extern const struct stmmac_tc_ops dwmac510_tc_ops;  extern const struct
> stmmac_ops dwxgmac210_ops;  extern const struct stmmac_dma_ops
> dwxgmac210_dma_ops;
> --
> 1.9.1

++ stmmac maintainers and c45 experts
