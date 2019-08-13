Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8627C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940A020665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfHMGyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 02:54:18 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:33909 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfHMGyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 02:54:16 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Ludovic.Desroches@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="Ludovic.Desroches@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Ludovic.Desroches@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: S50QYZScpAZMoH8zbv+WueYONP6hoGpU0ZY5iduS0funkDaq8LbBCBaq3g6xGLAlgaLK0rPbFD
 XGihs5BCXQNENv2UpXkKFEbhC+kvpjbSwtRrCbBrBjLLL5CLZsAdQyUPL2LNsOJ9v3pf4J6RqL
 7cTM/Vka8bhO+uMVEfFaEc3e8E7H7pwThJpgs+XViFAMhccbCau1lUd0pcAF2gbvt0fohEj5aH
 tBDDlAChrQIFzrL57gn7scHL8l+q7ScrlDUbNbuqBhsEP+wO0buWIOIWvnvVvDYJ3LRk2QAViC
 TBM=
X-IronPort-AV: E=Sophos;i="5.64,380,1559545200"; 
   d="scan'208";a="46314422"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Aug 2019 23:54:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 12 Aug 2019 23:54:15 -0700
Received: from localhost (10.10.85.251) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 12 Aug 2019 23:54:14 -0700
Date:   Tue, 13 Aug 2019 08:53:06 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <Eugen.Hristev@microchip.com>
CC:     <adrian.hunter@intel.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ulf.hansson@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 2/2] ARM: dts: at91: sama5d27_som1_ek: add mmc
 capabilities for SDMMC0
Message-ID: <20190813065306.tqz57hqeiofofbnz@M43218.corp.atmel.com>
Mail-Followup-To: Eugen.Hristev@microchip.com, adrian.hunter@intel.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <1565252928-28994-1-git-send-email-eugen.hristev@microchip.com>
 <1565252928-28994-2-git-send-email-eugen.hristev@microchip.com>
 <20190808124217.wrmcxohw5i6ju2qe@M43218.corp.atmel.com>
 <04fd74c3-a828-1064-b77b-f3de07a26190@intel.com>
 <20190809062322.syuieymdqjs4e7lh@M43218.corp.atmel.com>
 <fa0debbb-b84c-1f74-f8b8-8fdd7812aaee@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fa0debbb-b84c-1f74-f8b8-8fdd7812aaee@microchip.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 03:38:34PM +0000, Eugen.Hristev@microchip.com wrote:
> On 09.08.2019 09:23, Ludovic Desroches wrote:
> > On Thu, Aug 08, 2019 at 03:57:30PM +0300, Adrian Hunter wrote:
> >> On 8/08/19 3:42 PM, Ludovic Desroches wrote:
> >>> On Thu, Aug 08, 2019 at 10:35:43AM +0200, Eugen Hristev - M18282 wrote:
> >>>> From: Eugen Hristev <eugen.hristev@microchip.com>
> >>>>
> >>>> Add mmc capabilities for SDMMC0 for this board.
> >>>> With this enabled, eMMC connected card is detected as:
> >>>>
> >>>> mmc0: new DDR MMC card at address 0001
> >>>>
> >>>> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> >>> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> >>>
> >>> I am interested to have the some insights about the use of sd-uhs-*
> >>> properties.
> >>>
> >>> Our IP can't deal with 1V8 by itself. It has a 1V8SEL signal which can
> >>> be used as the logic control input of a mux. So even if the IP claims
> >>> to support UHS modes, it depends on the board.
> >>>
> >>> Are the sd-uhs-* properties a way to deal with this? I tend to think no
> >>> as sdhci_setup_host() will set the caps depending on the content of the
> >>> capabilities register. Do we have to use the SDHCI_QUIRK_MISSING_CAPS
> >>> quirk or sdhci-caps/sdhci-caps-mask?
> >>
> >> There is "no-1-8-v" which it looks like sdhci-of-at91.c already supports:
> >>
> >>    sdhci_at91_probe() -> sdhci_get_of_property() -> sdhci_get_property()
> >>
> >>      	if (device_property_present(dev, "no-1-8-v"))
> >> 		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> >>
> > 
> > Right, I forgot this property. Thanks.
> > 
> > Eugen, do you see cases we can't cover with this property?
> 
> Hi,
> 
> For current requirements and driver support, this should be enough.
> 
> I noticed one thing regarding SD-Cards, if I add property sd-uhs-sdr104 
> the class 10 uhs1 cards are detected as SDR104 . Without this property 
> they are detected as DDR50. Any idea why the difference ? The controller 
> does not claim to have SDR104 support ?  We should add it ?

With the mainline, our tree or both? In our tree, SDR104 is removed from
the capabilities.

Ludovic
