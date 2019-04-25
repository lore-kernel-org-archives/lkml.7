Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEABBC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32282084F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfDYOjM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:39:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:51582 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfDYOjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:39:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 07:39:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,394,1549958400"; 
   d="scan'208";a="167870966"
Received: from kmsmsx155.gar.corp.intel.com ([172.21.73.106])
  by fmsmga001.fm.intel.com with ESMTP; 25 Apr 2019 07:39:08 -0700
Received: from pgsmsx114.gar.corp.intel.com ([169.254.4.194]) by
 KMSMSX155.gar.corp.intel.com ([169.254.15.135]) with mapi id 14.03.0415.000;
 Thu, 25 Apr 2019 22:39:07 +0800
From:   "Ong, Boon Leong" <boon.leong.ong@intel.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        "Voon, Weifeng" <weifeng.voon@intel.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kweh, Hock Leong" <hock.leong.kweh@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>
Subject: RE: [PATCH 0/7] net: stmmac: enable EHL SGMII
Thread-Topic: [PATCH 0/7] net: stmmac: enable EHL SGMII
Thread-Index: AQHU+n5wKUIUU2n+WEWdYYhqXR355qZKzdAAgAEn3oCAAFapgIAApFcw
Date:   Thu, 25 Apr 2019 14:39:06 +0000
Message-ID: <AF233D1473C1364ABD51D28909A1B1B75C0B205D@pgsmsx114.gar.corp.intel.com>
References: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
 <20190424134854.GP28405@lunn.ch>
 <D6759987A7968C4889FDA6FA91D5CBC8146EF128@PGSMSX103.gar.corp.intel.com>
 <20190425123801.GD8117@lunn.ch>
In-Reply-To: <20190425123801.GD8117@lunn.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDI1MTFlYTQtZTMwZC00MWMzLWE0ODgtZTBmZTgwNjQzODQyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOVJvSzR6Zk5PWmdDT3F0RW11a0UycDV1d3c0UDVjaWVZcyttZ2xyY3F1QjlSUzY2RGVMMEZUNjJcL05ldVJsWDEifQ==
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

>-----Original Message-----
>From: Andrew Lunn [mailto:andrew@lunn.ch]
>Sent: Thursday, April 25, 2019 8:38 PM
>To: Voon, Weifeng <weifeng.voon@intel.com>
>Cc: David S. Miller <davem@davemloft.net>; netdev@vger.kernel.org; linux-
>kernel@vger.kernel.org; Ong, Boon Leong <boon.leong.ong@intel.com>;
>Kweh, Hock Leong <hock.leong.kweh@intel.com>; Florian Fainelli
><f.fainelli@gmail.com>; Maxime Coquelin <mcoquelin.stm32@gmail.com>;
>Giuseppe Cavallaro <peppe.cavallaro@st.com>; Jose Abreu
><joabreu@synopsys.com>
>Subject: Re: [PATCH 0/7] net: stmmac: enable EHL SGMII
>
>On Thu, Apr 25, 2019 at 07:27:51AM +0000, Voon, Weifeng wrote:
>> > > This patch-set is to enable Ethernet controller (DW Ethernet QoS and
>> > > DW Ethernet PCS) with SGMII interface in Elkhart Lake.
>> >
>> > Can the hardware also do 1000BaseX?
>>
>> Yes, it is able to do 1000BaseX.
>
>I Voon
>
>That means you should not really hard code it to SGMII. Somebody is
>going to connect an SFP or an Ethernet switch and want to use
>1000BaseX.

Hi Andrew,

The Ethernet controller consists of two ways to connect to external PHY,
RGMII and SGMII. The selection is done through soft strap.
The patch-series is to enable SGMII interface. The DW xPCS IP is
configured to operate in 1000BASE-X mode. The xPCS IP is external
connected through internal PHY interface which presents externally
as SGMII interface. To help illustrate the connection:-

      <-----------------GBE Controller----------------->|<--External PHY chip-->

      +----------+                    +----+          +---+                          +-----------------+
      |   EQoS   | <-GMII->|xPCS|<--> | L1 | <-- SGMII --> | External GbE |
      |   MAC    |                 |         |       |PHY|                         | PHY Chip        |
      +----------+                    +----+          +---+                          +-----------------+
            
In future, we will submit the changes for the RGMII connection that
bypasses DW xPCS.  

Hope this help clarifies matter. 

>At minimum, please add support for phy-mode in the device tree.
>
>Also, when the adjust_link callback passed to phy_connect() is called,
>you can look at the interface type to know if you need to configure it
>to SGMII or 1000BaseX. A copper PHY in an SFP module generally wants
>SGMII, but an optical module wants 1000BaseX. But to properly support
>SPFs the driver needs to swap to phylink, rather than phylib.
>
>     Andrew
