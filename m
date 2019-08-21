Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7EEC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBF622CE3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfHUMLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:11:47 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.209]:59783 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbfHUMLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:11:47 -0400
Received: from [67.219.251.53] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-c.us-west-2.aws.symcld.net id F6/2C-30481-FF43D5D5; Wed, 21 Aug 2019 12:11:43 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRWlGSWpSXmKPExsXi5LtOQPefSWy
  sQe8ac4uHV/0tVk3dyWKx6fE1VouuXyuZLS7vmsNm8Xf7JhaLF1vELdqOHWN14PDYOesuu8em
  VZ1sHneu7WHz2Lyk3mPjux1MHv1/DTw+b5ILYI9izcxLyq9IYM042LiTrWAec8XVCwfZGhhnM
  HcxcnEICaxilJi+6SY7hLOXUeLMimUsXYycHGwC5hLTDh8Es0UELCT+TZgL1sEs8ItJ4tOOA0
  wgCWGBMInXc1ayQhSFS7xe8psNwraSuHVsGyOIzSKgKjH35HtmEJtXwFfixuxPYDVCAjUSkyf
  9ZAexOQXsJE6fmgQ2h1FAVmLl+dNgvcwC4hK3nswH2yUhICCxZM95ZghbVOLl43+sELaCxIIL
  X4EO5QCq15RYv0sfolVRYkr3Q3aItYISJ2c+YYFYqybRNmcC8wRG0VlINsxC6J6FpHsWku4Fj
  CyrGM2TijLTM0pyEzNzdA0NDHQNDY10DY3Ndc0s9RKrdJP1Sot1y1OLS3SN9BLLi/WKK3OTc1
  L08lJLNjECoziloNN1B+P+WW/0DjFKcjApifKeUYmNFeJLyk+pzEgszogvKs1JLT7EKMPBoST
  Ba2IMlBMsSk1PrUjLzAEmFJi0BAePkgjvXSOgNG9xQWJucWY6ROoUozHHhJdzFzFzHJm7dBGz
  EEtefl6qlDjvH5BSAZDSjNI8uEGwRHeJUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjDvHZB7e
  DLzSuD2vQI6hQnolN2HI0FOKUlESEk1MNV1bzmx+TDj7m9vk86tefZYfvaaV281E4S98pdbm3
  P8MhHnaLnnte98xJmfE81v8mjcmLXOnaXEyervw/kfvLtiiyIk5VdNfP2zLG1P9beX39m/b/Z
  +vqNFbYdFzbR150KtvC6eZ8x19ftRGWiy4tCNgFVPWBS4uFZbtT1mcDr6THCRTu/8leEsv47v
  2b2MoWB59C2NiOXSyn4HXP9dXZgb3/BOL93bcIXN+6qF3jOSeib1+ficFsx/sbbw0213D6Egk
  RNKbnc3TXya816Kv/Ds67z7akwvDr7W3rq4JtF8inWgtMjq22bcFVMTTXcxfKj3TD6grFEsaR
  z6IH8W66/FlWzSDA2nZgRvn2h/Y7kSS3FGoqEWc1FxIgB4MB1D7wMAAA==
X-Env-Sender: Jose.DiazdeGrenu@digi.com
X-Msg-Ref: server-19.tower-365.messagelabs.com!1566389501!14255!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22255 invoked from network); 21 Aug 2019 12:11:42 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-19.tower-365.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 21 Aug 2019 12:11:42 -0000
Received: from DOR-VMS-XCH01.digi.com (10.49.8.98) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 21 Aug 2019
 07:11:41 -0500
Received: from DOR-SMS-XCH01.digi.com ([fe80::894b:3bdc:74ae:6efc]) by
 DOR-VMS-XCH01.digi.com ([fe80::c47f:be41:1dc7:5ab8%11]) with mapi id
 14.03.0468.000; Wed, 21 Aug 2019 14:11:39 +0200
From:   "Diaz de Grenu, Jose" <Jose.DiazdeGrenu@digi.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] nvmem: imx-ocotp: allow reads with arbitrary size
 and offset
Thread-Topic: [PATCH 0/2] nvmem: imx-ocotp: allow reads with arbitrary size
 and offset
Thread-Index: AQHVQWvhEud7zccX5U+rMC/CtlWS8Kbt2KgAgBfWu0A=
Date:   Wed, 21 Aug 2019 12:11:38 +0000
Message-ID: <0B2EBCD48D33654381E736352034C70C025D80A9@dor-sms-xch01.digi.com>
References: <1563895963-19526-1-git-send-email-Jose.DiazdeGrenu@digi.com>
 <771a6f0a-3cc2-da20-2439-9a91dd2bf9d2@linaro.org>
In-Reply-To: <771a6f0a-3cc2-da20-2439-9a91dd2bf9d2@linaro.org>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.101.2.178]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYvMDgvMjAxOSAxMjowNiBTcmluaXZhcyBLYW5kYWdhdGxhIHdyb3RlOg0KPiBBbnlvbmUg
Zm9ybSBJTVggY2FuIHRlc3QgdGhpcyBwYXRjaHNldCBiZWZvcmUgSSBwdXNoIHRoaXMgb3V0Pw0K
Pg0KPiBUaGFua3MsDQo+IHNyaW5pDQoNCkp1c3QgZm9yIHRoZSByZWNvcmQsIEkgdGVzdGVkIHRo
aXMgb24gYW4gaS5NWDZVTCBiYXNlZCBib2FyZC4NCg0KTGV0IG1lIGtub3cgaWYgdGhlcmUgaXMg
c29tZXRoaW5nIEkgY2FuIGRvIHRvIGZhY2lsaXRhdGUgdGhlIHRlc3RpbmcgdG8gYW55b25lIGZy
b20gSU1YLg0KDQpUaGFua3MuDQo=
