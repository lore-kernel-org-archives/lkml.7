Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBBCC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8232720685
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389226AbfDYHNn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:13:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:45746 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387456AbfDYHNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:13:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 00:13:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,392,1549958400"; 
   d="scan'208";a="340638898"
Received: from pgsmsx105.gar.corp.intel.com ([10.221.44.96])
  by fmsmga006.fm.intel.com with ESMTP; 25 Apr 2019 00:13:40 -0700
Received: from pgsmsx103.gar.corp.intel.com ([169.254.2.111]) by
 PGSMSX105.gar.corp.intel.com ([169.254.4.8]) with mapi id 14.03.0415.000;
 Thu, 25 Apr 2019 15:12:14 +0800
From:   "Voon, Weifeng" <weifeng.voon@intel.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ong, Boon Leong" <boon.leong.ong@intel.com>,
        "Kweh, Hock Leong" <hock.leong.kweh@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "Voon, Weifeng" <weifeng.voon@intel.com>
Subject: RE: [PATCH 2/7] net: stmmac: enable clause 45 mdio support
Thread-Topic: [PATCH 2/7] net: stmmac: enable clause 45 mdio support
Thread-Index: AQHU+n5xnAb9AV3JVEqJGUskzYy9caZKxXSAgAGxPyA=
Date:   Thu, 25 Apr 2019 07:12:13 +0000
Message-ID: <D6759987A7968C4889FDA6FA91D5CBC8146EF0F7@PGSMSX103.gar.corp.intel.com>
References: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
 <1556126241-2774-3-git-send-email-weifeng.voon@intel.com>
 <20190424131859.GN28405@lunn.ch>
In-Reply-To: <20190424131859.GN28405@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjI3OGQ3NGItZTYwNC00ZDEzLWFiODktMDAxMDkxOTBkMjUxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTVMxalFlWW5BNTlnXC9rK2xoUnVEK0VzUUgzS3hYRjd0V3h3Nnp4S1RzcUVBOHZlMDdDU1VDSUI3NVlrVTFFQ1MifQ==
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

> > From: Kweh Hock Leong <hock.leong.kweh@intel.com>
> >
> > DWMAC4 is capable to support clause 45 mdio communication.
> 
> Hi Weifeng
> 
> Is C45 a synthesis time option, or do all DWMAC4 have it?

All DWMAC4 with MDIO enabled will have C45. It is not a
Synthesis time option. 

Regards,
Weifeng

> 
> Thanks
> 	Andrew
