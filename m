Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7EAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3FB218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GxcJDci1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387421AbfB1RLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:11:53 -0500
Received: from mail-eopbgr140087.outbound.protection.outlook.com ([40.107.14.87]:55554
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726093AbfB1RLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:11:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTX1ImYfxpTMVx8K7Iz4uTOuzXhPtWWh9m+DPDlEbBM=;
 b=GxcJDci1fY7igHCl1qs2lCaoX9mRi21x+O1qhb8lIrXnyvkh8QF9lwHdToDPt7k2yuyb74ozQg2OgFKuIZ90G6UUtp7jbLBSURAQ+GuqxX7cC/yAM4SLYcwUdcLwwnDnATaPxBFoyl2NMnEdbQoH7tnWB/FiAUYXKCNJTwS81iY=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB4896.eurprd04.prod.outlook.com (20.177.49.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Thu, 28 Feb 2019 17:11:50 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::7437:2195:ffd3:a33a]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::7437:2195:ffd3:a33a%5]) with mapi id 15.20.1665.015; Thu, 28 Feb 2019
 17:11:50 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "linux-kernel-owner@vger.kernel.org" 
        <linux-kernel-owner@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "viresh.kumar@lina ro.org" <viresh.kumar@linaro.org>,
        Leo Li <leoyang.li@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH v1 0/4] arm64: dts: NXP: add basic dts file for LX2160A
 SoC
Thread-Topic: [PATCH v1 0/4] arm64: dts: NXP: add basic dts file for LX2160A
 SoC
Thread-Index: AQHUzbuK+PMriY4fR0+7hv0/i3vTSKX0VgoAgAD1WYA=
Date:   Thu, 28 Feb 2019 17:11:50 +0000
Message-ID: <VI1PR04MB480033C54751F04835C0EE5EF3750@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <1551132245-6089-1-git-send-email-vabhav.sharma@nxp.com>
 <155131208867.260864.6630901066653352400@swboyd.mtv.corp.google.com>
In-Reply-To: <155131208867.260864.6630901066653352400@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-originating-ip: [223.225.61.15]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc831e13-f043-4474-4178-08d69d9fd401
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4896;
x-ms-traffictypediagnostic: VI1PR04MB4896:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI0ODk2OzIzOitaNExPNXJpbjFzUEVWNkxYMUNwQ0Q0dWUw?=
 =?utf-8?B?azR4bHJYbFRSdGdiOVFWVkQxNEpiTEtnS2JmM0hKemxCQ1BIbEx6ZHlTMkhW?=
 =?utf-8?B?Tmg1SXlINHUxZzdWeklndjU1dTRRMk1wOHFjUFJOaFhZK2VsSG53OGpUNDVW?=
 =?utf-8?B?bU5yQkpHaWpsVHZaNEwvZUtnOEV4bklTT2QvQkNCK1o2UTk5djdqbzVOOWw0?=
 =?utf-8?B?WjBUZVdGVkFGR3dGV0JUdlNFUU1sUXpBbWlVZjJNRzMrLzllWmFjSE4yTWlH?=
 =?utf-8?B?NXFydEJqNDQ1T2IwbUFERUcwWStYN3BKV2RuNWVKTEprQUc3aldVdFpjOHFJ?=
 =?utf-8?B?WGZtZEppTzBHMWVxdHVoUnpDNzJsQi9oZGJoeGIxNEkzcTkzVXV3WGR2L2E4?=
 =?utf-8?B?THpHdHdoT0puQXFzcHFMbUtWSXJNTnV3K3c1amw5NlVEOFMrd3VaL2ZNaXNa?=
 =?utf-8?B?Uk1QSVdyL25mYitQWGpZU0ZGT3kzdzNMazNhTTc3L0VraG1LZE12YjZWcTdN?=
 =?utf-8?B?KzdJbU5ockx5L0F3ZFlEeFp6UjZHVE94ajRNb0xTWjhSU05BanhaUDFGb2g5?=
 =?utf-8?B?dEFGTDd3Z3p4RnV0K2lKcVJrQXlBdkFFalhoYjBnU2RDUDZ0dWlIeXVveVJK?=
 =?utf-8?B?THo1cHZLUkRnNkxkb1dTQXhBRkpGaW1rK2dOb2xBZnRxREZtV1ZrSTg4WS9m?=
 =?utf-8?B?ZlpOdG5LSnQyRFRHZXVuc3NrSTNjeXBzR0tuT1lGSGlvV1FTaW54aG01bVdL?=
 =?utf-8?B?MnJBTkVRZDdTdEZkQ01mRVZLdk9IbmkrVm9vcENKY3Q5NUtZb1F1RkZ3ci9U?=
 =?utf-8?B?RjE4K0ZNa3l6R2llNFBNR2dLbzRzQ3JnOEJsUnplR2ZuK2RIOGN3elYxZ2FC?=
 =?utf-8?B?QnY4b3FGdEdqTlpYNFhkZThXSWQ5aisydkYrODU0bEhoSHY2U3gxTm5uTG5m?=
 =?utf-8?B?RzBOZjhlR2RHVk91eVFmdmEzM0VQL2hMcUphNkJTRFkybndsZm9jNExjakdY?=
 =?utf-8?B?TFJ0QjlNdHVLSTlFSTAzUy8zOUZzQklzSWFRRG5DVU1DUDlxZXFrYmVwUVNI?=
 =?utf-8?B?dWRvdUZjM0NucTUyMjdhOEZla1RCVGJwd3ZXQlN5MWNpaTQ5Z3FTdHpnbnJy?=
 =?utf-8?B?TGpVR3JOQXNKMlYyOC8wdkl3Mkw5UHNpMDVZcDh3MSt1elBQd1dhS3BVMjZl?=
 =?utf-8?B?NWR2YThRdStzYVhJZzhxcVRJUHI5NmJXcGwxZ3N1TklHcFN4QnpzZytzM1FZ?=
 =?utf-8?B?b2l2YXJ2MlB4OGRoSzU3aVpSMFhaZ3ZEV2xsQ2RPWkRaNXNxUWF4RGJvdEJF?=
 =?utf-8?B?ZGlOQVFzYmZGQndDVXNSdUF2dGN4WlV4T0hsd3BxdDFFUjFGRzJldlA3ZXZk?=
 =?utf-8?B?TnBjcUxPV1plbzNDQlNtSHkxUVUzcnhnSmN4WE5lcWs2NkxWajRFMUFmcnZi?=
 =?utf-8?B?Tk1Wa2VFWXZpeEtHMDB0aG9IS1RNTGsyK1hOTUZDTmw2NlhyZGVQb0x1L09R?=
 =?utf-8?B?bG5FSFVlcTIzTlBib09tTTMrSEpXT0VyYTFSTE1tUXhIR1JlaTIvUU5HdVdL?=
 =?utf-8?B?UTVqSTV4NldlajVYYW9LdzZ2WXlpRW9WWXNtMFFHZXArS0pIaTROMDBPLzNl?=
 =?utf-8?B?b0g0dnZoV3dwK21udXN6V0dLL1BjSzJNWEdRSWY4ZXRmMGd4a2M1WElqR0pn?=
 =?utf-8?B?K2dVRDZ3WWJwd2E1SkpDeDQ0UHhVZS96OXJZNmNGUjVJUmszUGtQTVNpYTNq?=
 =?utf-8?B?M09ISmNSYlN4MUg0cDVJb3ZPZ1BPTDBlMjB5ZVp1Y0JWT2lKQVFTdlJtbTFC?=
 =?utf-8?B?ajkwVThyblQ2dUN0OStGaC9HeG9TNE5QUmtMK3JwQmM4TUdZbjdiU3FLSEN1?=
 =?utf-8?B?TGd4OThYVVphcDkyeVlrQkRJMkhWaWJCYnJ6M3lPbWphdm1kRWVHamtNWVJG?=
 =?utf-8?B?QnVmcDVvQzlnPT0=?=
x-microsoft-antispam-prvs: <VI1PR04MB4896EBA8FEF2AC3A4E19BFFBF3750@VI1PR04MB4896.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(366004)(346002)(189003)(199004)(13464003)(966005)(97736004)(2201001)(6116002)(3846002)(14444005)(110136005)(8936002)(66066001)(4326008)(256004)(45080400002)(68736007)(2501003)(5660300002)(71190400001)(102836004)(71200400001)(25786009)(14454004)(6246003)(2906002)(52536013)(86362001)(478600001)(6506007)(55236004)(53546011)(26005)(305945005)(186003)(106356001)(81166006)(81156014)(6436002)(7736002)(55016002)(6306002)(9686003)(53936002)(105586002)(99286004)(7696005)(446003)(486006)(8676002)(44832011)(74316002)(33656002)(316002)(11346002)(476003)(229853002)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4896;H:VI1PR04MB4800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6r4oFh+L9znyQCPKWDaVUh5oUtN6PEQsyTkp35mzWgzxtgPvhOZMmuMO6sRXy2yStOPcF7Bf0nl/mIZoJgFGs9BHF2KdLEmInGBvEWci1mK67byHHDleoydyqzFv+lRqdLMEYEuHm8aFA+0JBAQyS3TH975bC1aDToepUW6cSwpYSSTPzMOUZ/bIwyzUl5gOyLgEf22ky48qzXP9lrf5eal2E+dYxvj8bSxJozKkKMFwyvmmsDek74UV2giFEJW2Led12JCBgwg+VQBupJiipDsSuxcHBoRFBChvRZrlfQ18GmnEUu8hv0izTidtBDQ8ehD4Opeif0AnCqV4iApeBlkUOBrg7kSbeQ+QtlWkC+Ifx4hECgh5F1KSjSyECImy+9jblBEn7LvQcTiISCk6yDbIXlg5yIjvRCAZcMBxVmw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc831e13-f043-4474-4178-08d69d9fd401
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 17:11:50.0405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4896
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTWFpbnRhaW5lcnMsDQpQbGVhc2UgaGVscCB0byBtZXJnZSBwYXRjaC4NCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5l
bC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSAyOCwgMjAxOSA1OjMxIEFNDQo+IFRv
OiBhcm5kQGFybmRiLmRlOyBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBrc3Rld2FydEBsaW51
eGZvdW5kYXRpb24ub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWwtDQo+IG93bmVyQHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IHBtQHZn
ZXIua2VybmVsLm9yZzsgbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IG1hcmsucnV0bGFu
ZEBhcm0uY29tOw0KPiBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsgb3NzQGJ1c2Vycm9yLm5ldDsg
cmp3QHJqd3lzb2NraS5uZXQ7DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2VybmVs
Lm9yZzsgc3VkZWVwLmhvbGxhQGFybS5jb207DQo+IHZpcmVzaC5rdW1hckBsaW5hIHJvLm9yZyA8
dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+OyB3aWxsLmRlYWNvbkBhcm0uY29tOw0KPiB5YW1hZGEu
bWFzYWhpcm9Ac29jaW9uZXh0LmNvbTsgTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+OyBWYWJo
YXYNCj4gU2hhcm1hIDx2YWJoYXYuc2hhcm1hQG54cC5jb20+DQo+IENjOiBsaW51eEBhcm1saW51
eC5vcmcudWs7IGFkcmlhbi5odW50ZXJAaW50ZWwuY29tOw0KPiB1bGYuaGFuc3NvbkBsaW5hcm8u
b3JnOyBWYWJoYXYgU2hhcm1hIDx2YWJoYXYuc2hhcm1hQG54cC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjEgMC80XSBhcm02NDogZHRzOiBOWFA6IGFkZCBiYXNpYyBkdHMgZmlsZSBmb3Ig
TFgyMTYwQQ0KPiBTb0MNCj4gDQo+IFF1b3RpbmcgVmFiaGF2IFNoYXJtYSAoMjAxOS0wMi0yNiAw
MjoxMDo0NikNCj4gPiBUaGVzZSBwYXRjaGVzIHdlcmUgcmV2aWV3ZWQgYW5kIGFja2VkIGJ1dCBk
cm9wcGVkIGR1cmluZyBtZXJnZQ0KPiB3aW5kb3cuDQo+ID4gUGF0Y2h3b3JrIGxpbmsgd2FzDQo+
IGh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0
cHMlM0ElMkYlMkZsb3JlLg0KPiBrZXJuZWwub3JnJTJGcGF0Y2h3b3JrJTJGY292ZXIlMkYxMDA0
MTU1JTJGJmFtcDtkYXRhPTAyJTdDMDElN0N2DQo+IGFiaGF2LnNoYXJtYSU0MG54cC5jb20lN0M5
ZmI5NzhjYjg1ODM0ZjY4OGI1NzA4ZDY5ZDBmZTU1NiU3QzY4NmUNCj4gYTFkM2JjMmI0YzZmYTky
Y2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2ODY5MDg4OTMxMjkyMzIyJmFtcDtzDQo+IGRhdGE9
UUY2Nk9RZkpJckZJOXREVkJESTFTS0Z1YW01M2Zlak1mQzlwSm1KRVpNQSUzRCZhbXA7cmVzZXJ2
ZWQ9DQo+IDANCj4gPg0KPiA+IENoYW5nZXMgZm9yIHYxOg0KPiA+IC0gVXBkYXRlZCBseDIxNjBh
IGNsb2NrZ2VuIGluIGFscGhhYmV0aWNhbCBvcmRlcg0KPiA+DQo+ID4gVmFiaGF2IFNoYXJtYSAo
Mik6DQo+ID4gICBkdC1iaW5kaW5nczogYXJtNjQ6IGFkZCBjb21wYXRpYmxlIGZvciBMWDIxNjBB
DQpSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPiAsIE1hcmsgUnV0bGFuZCA8bWFyay5y
dXRsYW5kQGFybS5jb20+DQo+ID4gICBzb2MvZnNsL2d1dHM6IEFkZCBkZWZpbml0aW9uIGZvciBM
WDIxNjBBDQpMZW8NCj4gPg0KPiA+IFlvZ2VzaCBHYXVyICgyKToNCj4gPiAgIGNsazogcW9yaXE6
IGluY3JlYXNlIGFycmF5IHNpemUgb2YgY211eF90b19ncm91cA0KU3RlcGhlbiBCb3lkIDxzYm95
ZEBrZXJuZWwub3JnPiwgTWljaGFlbCBUdXJxdWV0dGUgPG10dXJxdWV0dGVAYmF5bGlicmUuY29t
PiAsDQogPiA+ICAgY2xrOiBxb3JpcTogQWRkIGNsb2NrZ2VuIHN1cHBvcnQgZm9yIGx4MjE2MGEN
ClN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4sIE1pY2hhZWwgVHVycXVldHRlIDxtdHVy
cXVldHRlQGJheWxpYnJlLmNvbT4gLCJSYWZhZWwgSi4gV3lzb2NraSIgPHJqd0Byand5c29ja2ku
bmV0PiAsIFZpcmVzaCBLdW1hciA8dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+DQo+IA0KPiBXaG8g
ZG8geW91IHdhbnQgdG8gYXBwbHkgdGhlc2UgcGF0Y2hlcz8NCkFzIHBlciBtYWludGFpbmVycyBz
Y3JpcHQgcmVzdWx0LCBJIGhhdmUgdXBkYXRlZCBlbWFpbA0KDQo=
