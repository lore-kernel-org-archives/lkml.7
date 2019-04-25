Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224E4C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE94217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389167AbfDYHIn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:08:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:57064 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729948AbfDYHIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:08:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 00:08:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,392,1549958400"; 
   d="scan'208";a="138665178"
Received: from pgsmsx106.gar.corp.intel.com ([10.221.44.98])
  by orsmga006.jf.intel.com with ESMTP; 25 Apr 2019 00:08:40 -0700
Received: from pgsmsx103.gar.corp.intel.com ([169.254.2.111]) by
 PGSMSX106.gar.corp.intel.com ([169.254.9.45]) with mapi id 14.03.0415.000;
 Thu, 25 Apr 2019 15:08:40 +0800
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
Subject: RE: [PATCH 6/7] net: stmmac: add xPCS platform data for EHL
Thread-Topic: [PATCH 6/7] net: stmmac: add xPCS platform data for EHL
Thread-Index: AQHU+n52aY9EtFmX3Uqb+pfZ3Ck+x6ZMdhtg
Date:   Thu, 25 Apr 2019 07:08:39 +0000
Message-ID: <D6759987A7968C4889FDA6FA91D5CBC8146EF0C9@PGSMSX103.gar.corp.intel.com>
References: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
 <1556126241-2774-7-git-send-email-weifeng.voon@intel.com>
In-Reply-To: <1556126241-2774-7-git-send-email-weifeng.voon@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWMxZDQ1MTYtMGI5MS00ZjdiLThhZmUtMTY0ZjdhZmM5MmNmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQjZqWm0yQ3JDYURVZ1ljSU5OcGJEQno5U3lwazU3QjZNNmFoMGRjcFNLMkR2ZitRMXBnUWVrZ1wvZFE4eW8wd0wifQ==
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

> Enable xPCS capability inside EHL platform data.
> 
> Signed-off-by: Weifeng Voon <weifeng.voon@intel.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> index b454a97..daac2eb 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> @@ -23,6 +23,7 @@
>  #include <linux/dmi.h>
> 
>  #include "stmmac.h"
> +#include "dw_xpcs.h"
> 
>  /*
>   * This struct is used to associate PCI Function of MAC controller on a board,
> @@ -128,6 +129,8 @@ static int ehl_common_data(struct pci_dev *pdev,
>  	plat->clk_csr = 5;
>  	plat->has_gmac = 0;
>  	plat->has_gmac4 = 1;
> +	plat->xpcs_phy_addr = 0x16;
> +	plat->pcs_mode = AN_CTRL_PCS_MD_C37_SGMII;
>  	plat->force_sf_dma_mode = 0;
>  	plat->tso_en = 1;
> 
> @@ -211,6 +214,7 @@ static int ehl_sgmii1g_data(struct pci_dev *pdev,
>  		return ret;
> 
>  	plat->interface = PHY_INTERFACE_MODE_SGMII;
> +	plat->has_xpcs = 1;
> 
>  	return 0;
>  }
> @@ -387,6 +391,7 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
>  	res.addr = pcim_iomap_table(pdev)[i];
>  	res.wol_irq = pdev->irq;
>  	res.irq = pdev->irq;
> +	res.xpcs_irq = 0;
> 
>  	return stmmac_dvr_probe(&pdev->dev, plat, &res);  }
> --
> 1.9.1

++ stmmac maintainers and c45 experts
