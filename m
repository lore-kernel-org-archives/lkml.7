Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B239C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46237206F2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfKNAEV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:04:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726409AbfKNAEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:04:21 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xADNuR9p135080
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 19:04:20 -0500
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.82])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w8utg0ce1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 19:04:20 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-kernel@vger.kernel.org> from <miltonm@us.ibm.com>;
        Thu, 14 Nov 2019 00:04:19 -0000
Received: from us1a3-smtp06.a3.dal06.isc4sb.com (10.146.103.243)
        by smtp.notes.na.collabserv.com (10.106.227.105) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 14 Nov 2019 00:04:10 -0000
Received: from us1a3-mail228.a3.dal06.isc4sb.com ([10.146.103.71])
          by us1a3-smtp06.a3.dal06.isc4sb.com
          with ESMTP id 2019111400040938-1142723 ;
          Thu, 14 Nov 2019 00:04:09 +0000 
In-Reply-To: <20191113155237.30646-3-i.mikhaylov@yadro.com>
From:   "Milton Miller II" <miltonm@us.ibm.com>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
        openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 14 Nov 2019 00:04:09 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20191113155237.30646-3-i.mikhaylov@yadro.com>,<20191113155237.30646-1-i.mikhaylov@yadro.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP62 November 04, 2019 at 09:47
X-LLNOutbound: False
X-Disclaimed: 46159
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19111400-9463-0000-0000-00000173B243
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.002686
X-IBM-SpamModules-Versions: BY=3.00012103; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01289727; UDB=6.00684066; IPR=6.01071925;
 MB=3.00029520; MTD=3.00000008; XFM=3.00000015; UTC=2019-11-14 00:04:17
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-11-13 22:35:31 - 6.00010644
x-cbparentid: 19111400-9464-0000-0000-000049232CB6
Message-Id: <OF20F73C7F.F32D5A9E-ON002584B1.00836403-002584B2.0000614A@notes.na.collabserv.com>
Subject: Re:  [PATCH 2/2] mmc: sdhci-of-aspeed: add inversion signal presence
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-13_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/2019 around 09:57AM in some time zone, Ivan Mikhaylov wrote:
>Change the default .get_cd callback. Add inverted signal card
>detection
>check.
>
>Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
>
>diff --git a/drivers/mmc/host/sdhci-of-aspeed.c
>b/drivers/mmc/host/sdhci-of-aspeed.c
>index 8962f6664381..8eded8a6ed8d 100644
>--- a/drivers/mmc/host/sdhci-of-aspeed.c
>+++ b/drivers/mmc/host/sdhci-of-aspeed.c
>@@ -31,6 +31,7 @@ struct aspeed_sdc {
> struct aspeed_sdhci {
> 	struct aspeed_sdc *parent;
> 	u32 width_mask;
>+	u8 cd_inverted;

The mmc core/host.c checks the device tree and stores the
result as mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH

This appears to be accessale as sdhci_host->mmc->caps2.

Please reuse this bit like the other drivers.

> };
> 
> static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
>@@ -143,6 +144,21 @@ static inline int
>aspeed_sdhci_calculate_slot(struct aspeed_sdhci *dev,
> 	return (delta / 0x100) - 1;
> }
> 
>+static int aspeed_get_cd(struct mmc_host *mmc)
>+{
>+	struct aspeed_sdhci *aspeed_sdhci;
>+	struct sdhci_pltfm_host *pltfm_priv;
>+	struct sdhci_host *host = mmc_priv(mmc);
>+
>+	int presence = !!(sdhci_readl(host, SDHCI_PRESENT_STATE)
>+			 & SDHCI_CARD_PRESENT);
>+
>+	pltfm_priv = sdhci_priv(host);
>+	aspeed_sdhci = sdhci_pltfm_priv(pltfm_priv);
>+
>+	return presence ^ aspeed_sdhci->cd_inverted;
>+}
>+
> static int aspeed_sdhci_probe(struct platform_device *pdev)
> {
> 	struct sdhci_pltfm_host *pltfm_host;
>@@ -183,6 +199,13 @@ static int aspeed_sdhci_probe(struct
>platform_device *pdev)
> 		goto err_pltfm_free;
> 	}
> 
>+	dev->cd_inverted = 0;
>+	host->mmc_host_ops.get_cd = aspeed_get_cd;
>+	if (of_property_read_bool(pdev->dev.of_node, "cd-inverted")) {
>+		dev->cd_inverted = 1;
>+		dev_info(&pdev->dev, "aspeed: sdhci: presence signal inversion
>enabled\n");
>+	}
>+
> 	ret = mmc_of_parse(host->mmc);
> 	if (ret)
> 		goto err_sdhci_add;
>-- 
>2.20.1
>
>

