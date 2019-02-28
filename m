Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE11C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1339E214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pw4XPdjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbfB1BZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 20:25:20 -0500
Received: from mail-eopbgr130053.outbound.protection.outlook.com ([40.107.13.53]:23940
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730234AbfB1BZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 20:25:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Xs0N2Ai/kezVS/se5mlyFa9t68/hn6sus48YlbHe9s=;
 b=pw4XPdjL8E3d6L/IiJ1mULfg/d1iXY1vzjAlkl5Y/jU9KbvXEFAH/lJHAZ92kjkpsYqTsEpNq+LshBtEMkKoltI5KXC4W9klO47lIikiaoRS81GkiIPBJgQSCRhJNkq50V08tpGAyYq3xULnXjBi06PZ/20U5AO3Bw2Gn62R+ro=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3898.eurprd04.prod.outlook.com (52.134.65.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 28 Feb 2019 01:24:34 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Thu, 28 Feb 2019
 01:24:34 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] ARM: dts: imx7ulp: add mmdc support
Thread-Topic: [PATCH 2/2] ARM: dts: imx7ulp: add mmdc support
Thread-Index: AQHUzoRwpxAD4szv5EOGWpqqmiUsgaX0DjYAgABdSoA=
Date:   Thu, 28 Feb 2019 01:24:34 +0000
Message-ID: <DB3PR0402MB3916BE64FA76F4145C368504F5750@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1551261844-23983-1-git-send-email-Anson.Huang@nxp.com>
 <1551261844-23983-2-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5Css2TvbbQ8cy6EA=2goHHDfDRzP1kVSe_vNaT0DtknLQ@mail.gmail.com>
In-Reply-To: <CAOMZO5Css2TvbbQ8cy6EA=2goHHDfDRzP1kVSe_vNaT0DtknLQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efe533ee-6c22-4c26-d248-08d69d1b7f37
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3898;
x-ms-traffictypediagnostic: DB3PR0402MB3898:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjNQUjA0MDJNQjM4OTg7MjM6OTZQYXBwWlVsWVh4Q3dORk9qaWVSYmNY?=
 =?utf-8?B?clVRQWw4dUpkRFZpdUpMQmZPR0VoUUdsZ2lUbXhVYzE3OTNvMGpqVDZmT1BY?=
 =?utf-8?B?T0t0UUprSUlnYU56a0dLZnB1WGl0dWRrVHNJemY3MDZzeEt2TW9UVXZ5UmZU?=
 =?utf-8?B?VWd5enZ0TVFqVWRLejBKYlF3ZTljM3ZHYVFYUXpDMkQ1QTlmazV1SmdoZ2N3?=
 =?utf-8?B?Q1hYSlROZXdqQ0dYcUgxdGZ3YlhodHBKb2s3d2pwQmowMXZISHBOVndYazRG?=
 =?utf-8?B?dG1tQjBsWExTTVVDZkUyclJiNWxBczQ3Y1RlRGpDTFZ5TmZZSVRWQlAzazh0?=
 =?utf-8?B?a2lsWXFUZExyd2UvZUtlVzRDaDlwVXgxT1FEZ2Rub0pSSjhHdkY0OS9wUnlI?=
 =?utf-8?B?NU1ZSmdJWDl6WWFLdWxlYXMxUmRnSnJYenpobE5mSGNYM2JpNkF2MU04cnhk?=
 =?utf-8?B?Mm9PUTlqNTZoUUZyaDJYTFJzNW1Xb3Q3Nk1yZE9QNFN6T2NDV3g1WDRjNkpL?=
 =?utf-8?B?ODhnZVBNUWRnOVhLT1ZHd0kyTW8zbzBxR3RZVDkyOW9nVjZuWWRrNitBSXNJ?=
 =?utf-8?B?UFJrODlxb01LNmxzTnE1UzNTeWdyNDV3Y3pPb0k3S1d2UXA3N2NHZ2didE9Y?=
 =?utf-8?B?aXNLK2Z4QW5kK1BXcXkvR3g5UCtrOXVDSGFUOG9ZVUZhK0dlcHVhV3kyaFMr?=
 =?utf-8?B?ZnRSd1daOHlUZTFpTVBjL0hZeXdNazExTUF2dGU3Z0JMVjZmVWtJUnBMeThp?=
 =?utf-8?B?QjlZSGdBS0hMQlRFdXY5NFlvTnNKa0hwdjh5bTBBZ1NwU2xvMy9WUkpLRzBm?=
 =?utf-8?B?bjdwM0xEVjJibXo1QmpZZlNvekNTZk1KWklmVEtmUW4xeUtqRE9tVHc0YnZh?=
 =?utf-8?B?OWtUazZKWitLVyt0WDFudEU2WkJVS3dkdXIwaVQ3emMxM1MrSXB2TU1IMnBT?=
 =?utf-8?B?RU9xZGEyMVRqcjVUQmtjd1k4UGhXN3NrN1Zpc0RPU1I3Qy8wRnVma2RDTU0r?=
 =?utf-8?B?UDdEcGhNSjJSaEpxOWg0WE9IWkx1aTV5alA0NVpCdllubWh1U09vbXBBR1R1?=
 =?utf-8?B?VnpmMHFMbjgvWkZGTjNjMEo3cHZIUCs2YTk5ZVlrV2tTYU83MmJCcUVFVEF1?=
 =?utf-8?B?Q0hsbUhaOGFvbUFmVjUvZytjT2wrRk9NbWpwK1R6a0NpR1dtdkMvQVhqbDM2?=
 =?utf-8?B?SnhXWGlYdy9uTTMvNEJEc1ZWeDYvRWcydGs0ZWJWdnpkUFJaaW1YRFlyWmlL?=
 =?utf-8?B?Vit6WWxlK2VwaFRjbjBZdUkvcGcrejl1Sno5bVY0VWd3V0xQbjZkUEJtNngr?=
 =?utf-8?B?SzlZdVZGZlVlaitJdWwvTC9ZeDhubUJFdFJkL2ZjbmRET2FucVpDdmpTOGNT?=
 =?utf-8?B?V1d5L3REVzZQZTNJY1doVEgyaWRMWW1JNEJSQTFZTWxocUk2TTdTYTFGV2JE?=
 =?utf-8?B?ZUF5YUJ5cGpCSmtqVytSZGU5RkNUT0FzWTNOZVR0TnNncXVzYUd6aEdmclRY?=
 =?utf-8?B?YkVPVy9SSzlUbTVxZkl0RVowdlppcHdUUmpXdzZPVXJBaGwwVDdyQldGcDhN?=
 =?utf-8?B?bDdwT216YU16UnpqRjRxYytxS2oydjRNblVsVUFjdzJzOEUzU3ErMUFnSVpr?=
 =?utf-8?B?bVFvdXgyb3NsTURGVUYxc0hQVFJZWHJrS2VFREk4UHI5ZGdrZVZiUC9mMFJB?=
 =?utf-8?B?aFR1ZzhPakw2ZVlWVjJUc0pqVWR2MFF4bGVCQjNzNU1jK213Q3RWazYyaFYz?=
 =?utf-8?B?QkYrSlliclZWamdOanBWbURaSWZ1amU4V1NDdTFQN1AvejNsV042Qm9VRm85?=
 =?utf-8?Q?2LNfT3QJkmfC1/J?=
x-microsoft-antispam-prvs: <DB3PR0402MB389832123C385A4775BECAD9F5750@DB3PR0402MB3898.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(366004)(346002)(39860400002)(13464003)(199004)(189003)(71200400001)(4326008)(71190400001)(4744005)(478600001)(81156014)(81166006)(8676002)(66066001)(7736002)(14454004)(316002)(256004)(446003)(2906002)(68736007)(26005)(476003)(44832011)(97736004)(25786009)(33656002)(229853002)(305945005)(5660300002)(11346002)(52536013)(486006)(14444005)(99286004)(53936002)(86362001)(6116002)(3846002)(76176011)(9686003)(6246003)(105586002)(7696005)(186003)(102836004)(54906003)(1411001)(8936002)(6916009)(6506007)(106356001)(74316002)(53546011)(6436002)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3898;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OEhG7ef08yST/ZyMLyrYsLhMWWfvXbqR6iWAY42Uu0M6BEfECUV//LrpVRt8cWSqBPIqckSW+yKYyO+kIt1K6R21E1N9qYtnC2iKkHy5hiF+TFRU7Egfb7pplerNubbknG2RXekIjAlYc5x1dkNmP5G7jpeBkQ01bdy2ETG7BZX8H88LNKadjz7g8yRUe5Y3Ue8RBlYZK6IB4LV6Bzciu8lPMd9FxVOPm/QZ6Rz/TQDw5NM9gAiBLMIiwD9RSIItH6s3Rdn/zxbFBohUlYLHBjSAKmrMeB03UB3x8K6J1LyCib51p4uDjZOu/JV5SHLhofnm1pdxnDHRgexdJ2tA5IxbLQYVceBo0MnMMD2sLQXIn7FiT24obM8ILUeBEG6oDPWFTRWJNIL+rDiqIH2o82fz7J2WUUWmzbrLedlAh1U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe533ee-6c22-4c26-d248-08d69d1b7f37
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 01:24:34.1715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3898
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZhYmlvDQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8gRXN0ZXZhbSBbbWFpbHRvOmZlc3RldmFtQGdt
YWlsLmNvbV0NCj4gU2VudDogMjAxOeW5tDLmnIgyOOaXpSAzOjUwDQo+IFRvOiBBbnNvbiBIdWFu
ZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5y
dXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9u
aXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBBUk06IGR0czogaW14N3VscDogYWRkIG1tZGMgc3VwcG9y
dA0KPiANCj4gT24gV2VkLCBGZWIgMjcsIDIwMTkgYXQgNzowOCBBTSBBbnNvbiBIdWFuZyA8YW5z
b24uaHVhbmdAbnhwLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9ib290L2R0cy9pbXg3dWxwLmR0c2kNCj4gPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDd1bHAu
ZHRzaSBpbmRleCBmY2E2ZTUwLi5mY2E0YTAxIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL2Jv
b3QvZHRzL2lteDd1bHAuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDd1bHAu
ZHRzaQ0KPiA+IEBAIC0yODYsNiArMjg2LDEyIEBADQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiAgICAgICAgICAgICAgICAgfTsNCj4gPg0KPiA+
ICsgICAgICAgICAgICAgICBtbWRjOiBtbWRjQDQwYWIwMDAwIHsNCj4gDQo+IE5vZGUgbmFtZXMg
c2hvdWxkIGJlIGdlbmVyaWMsIHNvOg0KPiANCj4gbWVtb3J5LWNvbnRyb2xsZXJANDBhYjAwMDAN
Cg0KVGhhbmtzLCBJIGFsc28gdXBkYXRlIG90aGVyIGkuTVggU29DJ3MgTU1EQyBub2RlIG5hbWUg
aW4gVjIgcGF0Y2ggc2VyaWVzLg0KDQpBbnNvbi4NCg0K
