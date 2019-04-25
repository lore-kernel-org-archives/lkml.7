Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEAEC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550DA217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388432AbfDYHEG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:04:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:53862 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387421AbfDYHEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:04:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 00:04:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,392,1549958400"; 
   d="scan'208";a="164681084"
Received: from kmsmsx153.gar.corp.intel.com ([172.21.73.88])
  by fmsmga002.fm.intel.com with ESMTP; 25 Apr 2019 00:04:03 -0700
Received: from pgsmsx110.gar.corp.intel.com (10.221.44.111) by
 KMSMSX153.gar.corp.intel.com (172.21.73.88) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 25 Apr 2019 15:04:02 +0800
Received: from pgsmsx103.gar.corp.intel.com ([169.254.2.111]) by
 PGSMSX110.gar.corp.intel.com ([169.254.13.159]) with mapi id 14.03.0415.000;
 Thu, 25 Apr 2019 15:04:02 +0800
From:   "Voon, Weifeng" <weifeng.voon@intel.com>
To:     "David S. Miller" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ong, Boon Leong" <boon.leong.ong@intel.com>,
        "Kweh, Hock Leong" <hock.leong.kweh@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>
Subject: RE: [PATCH 1/7] net: stmmac: add EHL SGMII 1Gbps platform data and
 PCI ID
Thread-Topic: [PATCH 1/7] net: stmmac: add EHL SGMII 1Gbps platform data and
 PCI ID
Thread-Index: AQHU+n5vPaFVAFSnsUe6Vu/7mB5bRaZMdA6Q
Date:   Thu, 25 Apr 2019 07:04:01 +0000
Message-ID: <D6759987A7968C4889FDA6FA91D5CBC8146EF07B@PGSMSX103.gar.corp.intel.com>
References: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
 <1556126241-2774-2-git-send-email-weifeng.voon@intel.com>
In-Reply-To: <1556126241-2774-2-git-send-email-weifeng.voon@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTliMzk5ZmUtOGUyNS00MGQzLTlmYjYtYTgxYTJjNTAxNzFkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoid0drOG1yblBMMzlZOGgxeEc4dzN1SlRKNWZlazhvcEJScGVoWXRcL3YzcHBSdWJ0bG9ENjlCckJoUFZUXC9POTNUIn0=
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

> Added EHL SGMII 1Gbps PCI ID. Different MII and speed will have different
> PCI ID.
> For EHL, default TX and RX FIFO size is set to 32KB. This is because the FIFO
> size advertised in the HW features is not the same as the HW
> implementation. The TX FIFO is shared among all all the TX queues and the
> RX FIFO is also shared among all the RX queues.
> 
> Signed-off-by: Weifeng Voon <weifeng.voon@intel.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c | 103
> +++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> index d819e8e..b454a97 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> @@ -118,6 +118,107 @@ static int stmmac_default_data(struct pci_dev
> *pdev,
>  	.setup = stmmac_default_data,
>  };
> 
> +static int ehl_common_data(struct pci_dev *pdev,
> +			   struct plat_stmmacenet_data *plat) {
> +	int i;
> +
> +	plat->bus_id = 1;
> +	plat->phy_addr = 0;
> +	plat->clk_csr = 5;
> +	plat->has_gmac = 0;
> +	plat->has_gmac4 = 1;
> +	plat->force_sf_dma_mode = 0;
> +	plat->tso_en = 1;
> +
> +	plat->rx_queues_to_use = 8;
> +	plat->tx_queues_to_use = 8;
> +	plat->rx_sched_algorithm = MTL_RX_ALGORITHM_SP;
> +
> +	for (i = 0; i < plat->rx_queues_to_use; i++) {
> +		plat->rx_queues_cfg[i].mode_to_use = MTL_QUEUE_DCB;
> +		plat->rx_queues_cfg[i].chan = i;
> +
> +		/* Disable Priority config by default */
> +		plat->tx_queues_cfg[i].use_prio = false;
> +
> +		/* Disable RX queues routing by default */
> +		plat->rx_queues_cfg[i].pkt_route = 0x0;
> +	}
> +
> +	for (i = 0; i < plat->tx_queues_to_use; i++) {
> +		plat->tx_queues_cfg[i].mode_to_use = MTL_QUEUE_DCB;
> +
> +		/* Disable Priority config by default */
> +		plat->tx_queues_cfg[i].use_prio = false;
> +	}
> +
> +	plat->tx_sched_algorithm = MTL_TX_ALGORITHM_WRR;
> +	plat->tx_queues_cfg[0].weight = 0x09;
> +	plat->tx_queues_cfg[1].weight = 0x0A;
> +	plat->tx_queues_cfg[2].weight = 0x0B;
> +	plat->tx_queues_cfg[3].weight = 0x0C;
> +	plat->tx_queues_cfg[4].weight = 0x0D;
> +	plat->tx_queues_cfg[5].weight = 0x0E;
> +	plat->tx_queues_cfg[6].weight = 0x0F;
> +	plat->tx_queues_cfg[7].weight = 0x10;
> +
> +	plat->mdio_bus_data->phy_reset = NULL;
> +	plat->mdio_bus_data->phy_mask = 0;
> +
> +	plat->dma_cfg->pbl = 32;
> +	plat->dma_cfg->pblx8 = true;
> +	plat->dma_cfg->fixed_burst = 0;
> +	plat->dma_cfg->mixed_burst = 0;
> +	plat->dma_cfg->aal = 0;
> +
> +	plat->axi = devm_kzalloc(&pdev->dev, sizeof(*plat->axi),
> +				 GFP_KERNEL);
> +	if (!plat->axi)
> +		return -ENOMEM;
> +	plat->axi->axi_lpi_en = 0;
> +	plat->axi->axi_xit_frm = 0;
> +	plat->axi->axi_wr_osr_lmt = 0;
> +	plat->axi->axi_rd_osr_lmt = 2;
> +	plat->axi->axi_blen[0] = 4;
> +	plat->axi->axi_blen[1] = 8;
> +	plat->axi->axi_blen[2] = 16;
> +
> +	/* Set default value for multicast hash bins */
> +	plat->multicast_filter_bins = HASH_TABLE_SIZE;
> +
> +	/* Set default value for unicast filter entries */
> +	plat->unicast_filter_entries = 1;
> +
> +	/* Set the maxmtu to a default of JUMBO_LEN */
> +	plat->maxmtu = JUMBO_LEN;
> +
> +	plat->tx_fifo_size = 32768;
> +	plat->rx_fifo_size = 32768;
> +
> +	return 0;
> +}
> +
> +static int ehl_sgmii1g_data(struct pci_dev *pdev,
> +			    struct plat_stmmacenet_data *plat) {
> +	int ret;
> +
> +	/* Set common default data first */
> +	ret = ehl_common_data(pdev, plat);
> +
> +	if (ret)
> +		return ret;
> +
> +	plat->interface = PHY_INTERFACE_MODE_SGMII;
> +
> +	return 0;
> +}
> +
> +static struct stmmac_pci_info ehl_sgmii1g_pci_info = {
> +	.setup = ehl_sgmii1g_data,
> +};
> +
>  static const struct stmmac_pci_func_data galileo_stmmac_func_data[] = {
>  	{
>  		.func = 6,
> @@ -355,6 +456,7 @@ static int __maybe_unused
> stmmac_pci_resume(struct device *dev)
> 
>  #define STMMAC_QUARK_ID  0x0937
>  #define STMMAC_DEVICE_ID 0x1108
> +#define STMMAC_EHL_SGMII1G_ID   0x4b31
> 
>  #define STMMAC_DEVICE(vendor_id, dev_id, info)	{	\
>  	PCI_VDEVICE(vendor_id, dev_id),			\
> @@ -365,6 +467,7 @@ static int __maybe_unused
> stmmac_pci_resume(struct device *dev)
>  	STMMAC_DEVICE(STMMAC, STMMAC_DEVICE_ID,
> stmmac_pci_info),
>  	STMMAC_DEVICE(STMICRO, PCI_DEVICE_ID_STMICRO_MAC,
> stmmac_pci_info),
>  	STMMAC_DEVICE(INTEL, STMMAC_QUARK_ID, quark_pci_info),
> +	STMMAC_DEVICE(INTEL, STMMAC_EHL_SGMII1G_ID,
> ehl_sgmii1g_pci_info),
>  	{}
>  };
> 
> --
> 1.9.1

++ stmmac maintainers and c45 experts
