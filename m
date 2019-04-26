Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF0EC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56221206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfDZCLl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 22:11:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:21873 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfDZCLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 22:11:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 19:11:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,395,1549958400"; 
   d="scan'208";a="145827425"
Received: from pgsmsx104.gar.corp.intel.com ([10.221.44.91])
  by orsmga003.jf.intel.com with ESMTP; 25 Apr 2019 19:11:37 -0700
Received: from pgsmsx103.gar.corp.intel.com ([169.254.2.111]) by
 PGSMSX104.gar.corp.intel.com ([169.254.3.129]) with mapi id 14.03.0415.000;
 Fri, 26 Apr 2019 10:10:32 +0800
From:   "Voon, Weifeng" <weifeng.voon@intel.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ong, Boon Leong" <boon.leong.ong@intel.com>,
        "Kweh, Hock Leong" <hock.leong.kweh@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>
Subject: RE: [PATCH 1/7] net: stmmac: add EHL SGMII 1Gbps platform data and
 PCI ID
Thread-Topic: [PATCH 1/7] net: stmmac: add EHL SGMII 1Gbps platform data and
 PCI ID
Thread-Index: AQHU+n5vPaFVAFSnsUe6Vu/7mB5bRaZMdA6Q///UjYCAAWvOgA==
Date:   Fri, 26 Apr 2019 02:10:31 +0000
Message-ID: <D6759987A7968C4889FDA6FA91D5CBC8146EF563@PGSMSX103.gar.corp.intel.com>
References: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
 <1556126241-2774-2-git-send-email-weifeng.voon@intel.com>
 <D6759987A7968C4889FDA6FA91D5CBC8146EF07B@PGSMSX103.gar.corp.intel.com>
 <20190425122439.GC8117@lunn.ch>
In-Reply-To: <20190425122439.GC8117@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWQ4NmEyYjUtMzAwYS00ZmFiLWE5ZGYtM2M4ZDk0MDdlZmIzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiektUcldIYUJXanhcL1h6OHdyNmVhWkxyalVLTmhZVFZDSnJ6Y0JPSVFocVFKMEFVdnBsV0NHVWtEenllYUpuSUkifQ==
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

> > ++ stmmac maintainers and c45 experts
> 
> Normally you would repost the series as a v2, rather the additional
> maintainers added. Please try to remember that for next time.

Noted and I will remember that. The reason I did not repost the series
as v2 is because v1 is still in discussion and I am not changing any code
besides adding additional maintainers. Thanks. 

Weifeng
> 
> 	   Andrew
