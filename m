Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FE4C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 00:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6949F2177E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 00:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QahgpFMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388718AbfEXAmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 20:42:12 -0400
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:36068
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388657AbfEXAmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 20:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhjDNhvoRr14+1mLYoZOHPZ7bSjV+K2aH1MsXi8WRNo=;
 b=QahgpFMUI8/aYVEbHJtkTZMfk7znTaRKvHcVLt/QCLRQ2z3dl/rfDWqTikaA8VSPKYhntwuz2fHaB9ceW8LqkNoJNGSoStF76ussrI9thTp+5EzD0a5o9n/JnIStBqBEApeF64DKWmTP15X2eVR80uTq43rYllB+IQc1qV/yRPE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3850.eurprd04.prod.outlook.com (52.134.65.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.19; Fri, 24 May 2019 00:42:08 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1922.017; Fri, 24 May 2019
 00:42:08 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawn.guo@linaro.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "agross@kernel.org" <agross@kernel.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] arm64: defconfig: Enable CONFIG_QORIQ_THERMAL
Thread-Topic: [PATCH] arm64: defconfig: Enable CONFIG_QORIQ_THERMAL
Thread-Index: AQHVD6rI9PtGaZwUh0KVobDDBMOB9qZ4tAgAgAC/R7A=
Date:   Fri, 24 May 2019 00:42:07 +0000
Message-ID: <DB3PR0402MB3916617FD2047D91BFFE4EAEF5020@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1558425114-10625-1-git-send-email-Anson.Huang@nxp.com>
 <20190523131606.GA21933@dragon>
In-Reply-To: <20190523131606.GA21933@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f361de0e-0a6a-4f54-1cad-08d6dfe0a6b5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3850;
x-ms-traffictypediagnostic: DB3PR0402MB3850:
x-microsoft-antispam-prvs: <DB3PR0402MB38504AA456D63988A27C2DB5F5020@DB3PR0402MB3850.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0047BC5ADE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(396003)(376002)(13464003)(199004)(189003)(8936002)(478600001)(81166006)(81156014)(86362001)(6916009)(6116002)(8676002)(3846002)(44832011)(6436002)(2906002)(68736007)(7416002)(316002)(476003)(486006)(9686003)(55016002)(11346002)(446003)(66066001)(54906003)(26005)(53936002)(229853002)(6246003)(25786009)(99286004)(186003)(4326008)(71200400001)(71190400001)(102836004)(5660300002)(6506007)(53546011)(76176011)(76116006)(73956011)(66476007)(66556008)(66446008)(64756008)(66946007)(256004)(7696005)(7736002)(74316002)(305945005)(14454004)(52536014)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3850;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H16ZGaZCFdcFnpuFqewfKuQ34EgumVSqL247IKTMvnlP1DY/y9F1VsCw+zWFoyv4SgJLvPh755YRTAa4pFLGy1I5LJVZzdDgnj3270DBmylgehPepcvLvJe9GVec7X7RMvn+b9dXssrnM1OQ4DYVPVNXyJVMh1Ep5qlarQWaMbrVHi9tKmPFSmsoJyb/MZm2HNa8QXARwNRKnDxTIGLe2oEy5LfNPn2woNFHD+CFHOWx7qxaVWLC6hNi4co5B82HuBtqhEGBljc+paAODoWNp5QlsA8YVKd2a3MlXEFenwT0gci1FpUCKAkYHR/50nKp54+uKAMy6yd4cnoqNZ006K5HGi1IJf2ckpdgdZo1o2Lx1wsj+BJFY5zm41qYDdgtYRp3Mhvt4xWaATcwO+XwT71UaTCjSx3C3Dd7nubbhf8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f361de0e-0a6a-4f54-1cad-08d6dfe0a6b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2019 00:42:08.0780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3850
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24g
R3VvIFttYWlsdG86c2hhd24uZ3VvQGxpbmFyby5vcmddDQo+IFNlbnQ6IFRodXJzZGF5LCBNYXkg
MjMsIDIwMTkgOToxNiBQTQ0KPiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+
DQo+IENjOiBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsNCj4g
bWF4aW1lLnJpcGFyZEBib290bGluLmNvbTsgb2xvZkBsaXhvbS5uZXQ7IGFncm9zc0BrZXJuZWwu
b3JnOw0KPiBob3JtcytyZW5lc2FzQHZlcmdlLm5ldC5hdTsgamFnYW5AYW1hcnVsYXNvbHV0aW9u
cy5jb207DQo+IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBMZW9uYXJkIENyZXN0ZXogPGxl
b25hcmQuY3Jlc3RlekBueHAuY29tPjsNCj4gZGluZ3V5ZW5Aa2VybmVsLm9yZzsgZW5yaWMuYmFs
bGV0Ym9AY29sbGFib3JhLmNvbTsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14DQo+IDxsaW51
eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gYXJtNjQ6IGRlZmNvbmZpZzog
RW5hYmxlIENPTkZJR19RT1JJUV9USEVSTUFMDQo+IA0KPiBPbiBUdWUsIE1heSAyMSwgMjAxOSBh
dCAwNzo1NzowNUFNICswMDAwLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPiBpLk1YOE1RIG5lZWRz
IENPTkZJR19RT1JJUV9USEVSTUFMIGZvciB0aGVybWFsIHN1cHBvcnQuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gDQo+IFBsZWFz
ZSBzZW5kIHRvIG15IGtlcm5lbC5vcmcgZW1haWwgYWRkcmVzcy4NCg0KSSBqdXN0IHJlc2VuZCB0
aGUgcGF0Y2ggdG8geW91ciBrZXJuZWwub3JnIGVtYWlsIGFkZHJlc3MsIGxvb2tzIGxpa2UgdGhl
DQpnZXRfbWFpbnRhaW5lciBzY3JpcHQgc3RpbGwgbGlzdCB5b3VyIGxpbmFyby5vcmcgZW1haWwg
YWRkcmVzcyBmb3Igc29tZQ0KcGF0Y2hlcy4NCg0KVGhhbmtzLA0KQW5zb24uDQoNCj4gDQo+IFNo
YXduDQo+IA0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnIHwgMSAr
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcNCj4gPiBiL2FyY2gvYXJtNjQvY29uZmln
cy9kZWZjb25maWcgaW5kZXggZGE4NTgwOC4uNjFiZTM5YiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNo
L2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQo+ID4gKysrIGIvYXJjaC9hcm02NC9jb25maWdzL2Rl
ZmNvbmZpZw0KPiA+IEBAIC00MjAsNiArNDIwLDcgQEAgQ09ORklHX1NFTlNPUlNfSU5BMlhYPW0N
Cj4gPiBDT05GSUdfVEhFUk1BTF9HT1ZfUE9XRVJfQUxMT0NBVE9SPXkNCj4gPiAgQ09ORklHX0NQ
VV9USEVSTUFMPXkNCj4gPiAgQ09ORklHX1RIRVJNQUxfRU1VTEFUSU9OPXkNCj4gPiArQ09ORklH
X1FPUklRX1RIRVJNQUw9bQ0KPiA+ICBDT05GSUdfUk9DS0NISVBfVEhFUk1BTD1tDQo+ID4gIENP
TkZJR19SQ0FSX1RIRVJNQUw9eQ0KPiA+ICBDT05GSUdfUkNBUl9HRU4zX1RIRVJNQUw9eQ0KPiA+
IC0tDQo+ID4gMi43LjQNCj4gPg0K
