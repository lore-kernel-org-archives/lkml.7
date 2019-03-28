Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E52C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEB42075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xzpgiuog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfC1O4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:56:19 -0400
Received: from mail-eopbgr50086.outbound.protection.outlook.com ([40.107.5.86]:4985
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726059AbfC1O4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujoUqIkFs6ai5CHF046raKkkh2wLukfEkUQHufMAD5U=;
 b=xzpgiuoghOhejAuB9+6r5xUzBMlywL4koAf3Gw68fb2oxxLQgOyx8MTCo26h8yCsjvNevUQx6nbAqtfeyfwSeEgggjjU5b/IkGqK2WxEoVRaTVgfgoYha07lsd2cnteAW1EbKKHuSDCC/ddorVLmVVEWKzUxVfASLn+aN0o/OII=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3342.eurprd04.prod.outlook.com (52.134.8.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Thu, 28 Mar 2019 14:56:15 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::7cee:3159:6414:9cc5]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::7cee:3159:6414:9cc5%4]) with mapi id 15.20.1750.014; Thu, 28 Mar 2019
 14:56:15 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "angus@akkea.ca" <angus@akkea.ca>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/4] arm64: dts: imx8mq: Fix the fsl,imx8mq-sdma
 compatible string
Thread-Topic: [PATCH 1/4] arm64: dts: imx8mq: Fix the fsl,imx8mq-sdma
 compatible string
Thread-Index: AQHU5Wuc4mLaUDVRWEC+hJSKGZVF3aYhIe8A
Date:   Thu, 28 Mar 2019 14:56:15 +0000
Message-ID: <9ecf7b0936618844e8b48b765f2b8f1a66cfdf0f.camel@nxp.com>
References: <20190328133828.20999-1-angus@akkea.ca>
         <20190328133828.20999-2-angus@akkea.ca>
In-Reply-To: <20190328133828.20999-2-angus@akkea.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 209f460b-7122-4bc7-b8c8-08d6b38d86d2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3342;
x-ms-traffictypediagnostic: VI1PR0402MB3342:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-microsoft-antispam-prvs: <VI1PR0402MB33420AA064C84B9E8F6891CEF9590@VI1PR0402MB3342.eurprd04.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(39860400002)(396003)(199004)(189003)(68736007)(6116002)(71190400001)(36756003)(71200400001)(1730700003)(81166006)(106356001)(66066001)(186003)(7736002)(44832011)(26005)(3846002)(76176011)(6916009)(8676002)(8936002)(86362001)(6246003)(6506007)(99286004)(102836004)(305945005)(7416002)(6512007)(14454004)(11346002)(446003)(25786009)(316002)(4326008)(81156014)(5660300002)(97736004)(6486002)(54906003)(229853002)(118296001)(558084003)(2501003)(256004)(53936002)(2351001)(2906002)(2616005)(476003)(6436002)(5640700003)(486006)(105586002)(478600001)(32563001)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3342;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 54DQbmZg3ijvC0YkCrnh6IxPo9N8nQuE5giAzxhlhtGD86Rb0ZgDJ9HjhC17cQ1/5NbLePUVxyk33pu7xujP6RFsDLbcq075U8D7NIoNV39hJeObnWMk9DjjR+KNQFFM2QbZcGZI5ZcreafqBpgKAR/3IZcwpyaHAZRudoLxHkNsnKTBuQ+Pw13Q91IBamMxi4/PRk+BBQsay6glPsaf7tJEe8mShviIr/HOR1CeGQc2tF4lqMa8NSXI70c91+5TnWukS6coL+tO/rUaLUFsyqAaG8SumjQZOjX5iugNFYRGSbKGsjbgGrdokRqbrS/ez01UVcNMFLTVUn15oU4WidY/4s4iP3XBUi3ErPcYRx+6rv1ZCjiDXTRqZHzqDL1HjXHrl6knDuqr7v4lPaPXejxmwLPxvLYWelrjXNmA4uU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C53B1635E338F42A8FFC77B5417B23B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209f460b-7122-4bc7-b8c8-08d6b38d86d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 14:56:15.1610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3342
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTAzLTI4IGF0IDA2OjM4IC0wNzAwLCBBbmd1cyBBaW5zbGllIChQdXJpc20p
IHdyb3RlOg0KPiBGaXggYSB0eXBvIGluIHRoZSBjb21wYXRpYmxlIHN0cmluZw0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQW5ndXMgQWluc2xpZSAoUHVyaXNtKSA8YW5ndXNAYWtrZWEuY2E+DQoNCg0K
UmV2aXdlZC1ieTogRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPg0K
