Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84100C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39744218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HkdTaBEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbfC3Qzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:55:31 -0400
Received: from mail-eopbgr40065.outbound.protection.outlook.com ([40.107.4.65]:54753
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730395AbfC3Qzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 12:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qj6gAyOyDQyDXC7vpjIsEYcBRQl1A6m8bSRT9AvikaM=;
 b=HkdTaBEoi8BBxTJgJK0JokSJ7BexCqmoARYu8sUrQzafecumUjzIUbOTXXZSij9IE7t2PO2cP10IEe4b+aVTXTehk5PB6/UV2GtbKz+j+H1LJit60hHLFOufuobJ1BVX5+3ZIdElf+HT5KsCIfYQT50pZyS+kMJfUEXOaRHMe9s=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3711.eurprd04.prod.outlook.com (52.134.15.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Sat, 30 Mar 2019 16:55:27 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::7cee:3159:6414:9cc5]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::7cee:3159:6414:9cc5%4]) with mapi id 15.20.1750.014; Sat, 30 Mar 2019
 16:55:27 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
CC:     Angus Ainslie <angus.ainslie@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Carlo Caione <ccaione@baylibre.com>,
        =?utf-8?B?R3VpZG8gR8O8bnRoZXI=?= <agx@sigxcpu.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] arm64: dts: imx8mq: Fix the fsl,imx8mq-sdma
 compatible string
Thread-Topic: [PATCH v2 1/3] arm64: dts: imx8mq: Fix the fsl,imx8mq-sdma
 compatible string
Thread-Index: AQHU5kMe/Lt705t4YE6bXeCkX1isAKYkZiSA
Date:   Sat, 30 Mar 2019 16:55:23 +0000
Message-ID: <CAEnQRZCRP2C9Zczx5qNOHYbQsVxOD96th9um2wwMNiB2cEqt9Q@mail.gmail.com>
References: <20190328133828.20999-1-angus@akkea.ca>
 <20190329152130.18411-1-angus@akkea.ca>
 <20190329152130.18411-2-angus@akkea.ca>
In-Reply-To: <20190329152130.18411-2-angus@akkea.ca>
Reply-To: Daniel Baluta <daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0601CA0042.eurprd06.prod.outlook.com
 (2603:10a6:203:68::28) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-gm-message-state: APjAAAXA++9G4h2u1w+7xV85eF9Bb33uYhzk28jrc1he+c5fTBmJIEVz
        grY4ozyzKUCWmcF0psk6r/OVqOkPJs7LQ9ZIE9E=
x-google-smtp-source: APXvYqwl6ADVO2DkmG4inur1G6HU3XvwJB+v8AICIap0/4y7fiXIQY1ugkF2Dr4aXvd3ASptz2l/bf4PpAFOxcJw7uo=
x-received: by 2002:a50:8561:: with SMTP id 88mr21236486edr.101.1553964920784;
 Sat, 30 Mar 2019 09:55:20 -0700 (PDT)
x-gmail-original-message-id: <CAEnQRZCRP2C9Zczx5qNOHYbQsVxOD96th9um2wwMNiB2cEqt9Q@mail.gmail.com>
x-originating-ip: [209.85.208.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9f12998-2607-414f-5814-08d6b530804a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3711;
x-ms-traffictypediagnostic: VI1PR0402MB3711:
x-microsoft-antispam-prvs: <VI1PR0402MB3711FC997E97B55321E5A37FF95B0@VI1PR0402MB3711.eurprd04.prod.outlook.com>
x-forefront-prvs: 09928BEC91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(396003)(376002)(199004)(189003)(3846002)(99286004)(386003)(14444005)(105586002)(6506007)(97736004)(9686003)(53936002)(14454004)(498394004)(6512007)(55446002)(53546011)(76176011)(478600001)(54206008)(86362001)(102836004)(6862004)(6246003)(450100002)(52116002)(68736007)(256004)(4326008)(81166006)(4744005)(8936002)(81156014)(44832011)(476003)(8676002)(2906002)(11346002)(446003)(61266001)(54906003)(5660300002)(106356001)(7736002)(305945005)(66066001)(229853002)(316002)(6486002)(6436002)(95326003)(3450700001)(25786009)(486006)(186003)(43066004)(6666004)(61726006)(71200400001)(71190400001)(6116002)(26005)(32563001)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3711;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QPKsuOsG3TXuUSAXodhlgFBcIjtuygX6PsqMnZKt2vi05qlr0F0Xch22FQgDlJfrPfHi/lV9al06cmeYHmtkgJ4bZNae+UcGkQrPppxlVBkjIZk9fpm/S3EXetUfp/4z/1HI8kvNwa3mrdLa6mz5ZTmLssiBs8JWfaefKQZcLlskzqcT7qpxqmFvMiP/sLdYKtGRgp2KHjLHWcXpJa6OuA026+DpiiMR3bc+sHGGxWTrv8iW2KVHF04SN/KlxCivAmjb10JMjAcArQlLOSnWhC00b6NaULGgWY7KMtEkRWTyJ5SLXIzKwvWUw8yyobx8oSCOALkMgQhQnAjSkAsUNGshalRSmzkKwz+QQQxbLUh54Ouj72Qq6H27PDUxEjk2T19ceZ0KhtP3UsiShQfMQqAQtKcDyb4zDEK8XSLpvB0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <416F0AE0A9C6614FA937B9CB94AD66F0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f12998-2607-414f-5814-08d6b530804a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2019 16:55:23.7359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBNYXIgMjksIDIwMTkgYXQgNToyMiBQTSBBbmd1cyBBaW5zbGllIChQdXJpc20pIDxh
bmd1c0Bha2tlYS5jYT4gd3JvdGU6DQo+DQo+IEZpeCBhIHR5cG8gaW4gdGhlIGNvbXBhdGlibGUg
c3RyaW5nDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEFuZ3VzIEFpbnNsaWUgKFB1cmlzbSkgPGFuZ3Vz
QGFra2VhLmNhPg0KDQpSZXZpZXdlZC1ieTogRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBu
eHAuY29tPg0KDQo+IC0tLQ0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1x
LmR0c2kgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lt
eDhtcS5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kNCj4g
aW5kZXggODFkNWNlMWIxZWMxLi4wNjE1ODYyNWYyNGYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpDQo+IEBAIC03MjAsNyArNzIwLDcgQEANCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgfTsNCj4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgc2Rt
YTE6IHNkbWFAMzBiZDAwMDAgew0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNv
bXBhdGlibGUgPSAiZnNsLCBpbXg4bXEtc2RtYSIsImZzbCxpbXg3ZC1zZG1hIjsNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImZzbCxpbXg4bXEtc2RtYSIs
ImZzbCxpbXg3ZC1zZG1hIjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWcg
PSA8MHgzMGJkMDAwMCAweDEwMDAwPjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8JmNsayBJTVg4TVFfQ0xLX1NETUEx
X1JPT1Q+LA0KPiAtLQ0KPiAyLjE3LjENCj4NCg==
