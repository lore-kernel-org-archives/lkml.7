Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0134C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BA820657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tOTywPp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfCKGG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:06:59 -0400
Received: from mail-eopbgr40045.outbound.protection.outlook.com ([40.107.4.45]:53699
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725808AbfCKGG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHSwBxm1Nc9VItT2MBzTrZMNEO9wGlvls1S0xZqciJ0=;
 b=tOTywPp7pEYM17HIuUeyBikzqBSn3jwXxK+V0oAKeU7ZbHDcuRwtEZkLP8nqqVPK6fgNDBu+SYGmr1+jBTScE/Bm9dVeVVuliH3lRq8pRCEqPHwn/eoNwxlebpEc80s1rtqL9FJFARdFlpHPVInh2QIsLIdFsKG1OrD3qOsJo30=
Received: from VI1PR04MB4558.eurprd04.prod.outlook.com (20.177.55.216) by
 VI1PR04MB4942.eurprd04.prod.outlook.com (20.177.49.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 06:06:52 +0000
Received: from VI1PR04MB4558.eurprd04.prod.outlook.com
 ([fe80::952d:34ed:3402:da3]) by VI1PR04MB4558.eurprd04.prod.outlook.com
 ([fe80::952d:34ed:3402:da3%6]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 06:06:52 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Hans de Goede <hdegoede@redhat.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH 1/5] dt-bindings: connector: add optional properties for
 Type-B
Thread-Topic: [PATCH 1/5] dt-bindings: connector: add optional properties for
 Type-B
Thread-Index: AQHU1XYwO6elZIow2kmmljRaCV6BPKYBpB8AgARIv4CAAAftsA==
Date:   Mon, 11 Mar 2019 06:06:52 +0000
Message-ID: <VI1PR04MB45586752BAEEDBB3F979E0BB89480@VI1PR04MB4558.eurprd04.prod.outlook.com>
References: <1552025622-15582-1-git-send-email-chunfeng.yun@mediatek.com>
         <1552025622-15582-2-git-send-email-chunfeng.yun@mediatek.com>
         <693b11e7-fa9e-ab1f-561a-beb758b1872f@redhat.com>
 <1552282383.10179.21.camel@mhfsdcap03>
In-Reply-To: <1552282383.10179.21.camel@mhfsdcap03>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=jun.li@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8c264d4-c10e-4039-ee5c-08d6a5e7c173
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4942;
x-ms-traffictypediagnostic: VI1PR04MB4942:
x-ms-exchange-purlcount: 2
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI0OTQyOzIzOnRuc3hWZU9BNitFWktOQkxIOUo3YXZ1MFR5?=
 =?utf-8?B?TTVGZW9ldmpOZU1SaUxRbHZQcTgyWnpMaVZJQldkSFNsc1ByZEs5WDl0ZzNj?=
 =?utf-8?B?OTAvOFlieTNNTnd2OU9KWjVORmpGcmYzMG00RVlEY0I5SWFqZDdZbTlRb2wy?=
 =?utf-8?B?enI5aUNFczJFKys4ZWZ4d3lkMUcvV1NrVGVaOWZPc1pad1V3MlNZT0VqaXNH?=
 =?utf-8?B?Um5xZDR1WU5FYUFiT1ZZV3duWDdUOWFndFhPaU9hdk9Hajd6NVdJQ3JiTlR1?=
 =?utf-8?B?UWxmckxnNG5KdWsvN2ZaZFp4dG9WNGw5di9RVW9hNUNZWU94SnR3dWJUUm1Z?=
 =?utf-8?B?cy9ISjdERTBRMXFuOXR4b1FkdTdKYmlibHZPKzhEUnVPbm9WVGJxaVZ3QkY0?=
 =?utf-8?B?RGsvRjZRTlc1L09WNCs2TDJpY1NuWE9nMzNaNmQrSTRVSEhhTFY4S3hKcDFp?=
 =?utf-8?B?NVNyc1BFZmxGeGJ2V3l5TWJUd0Z2NnB1N0FsaVVJRU44MUs2SW9YMFVJUmtI?=
 =?utf-8?B?M0p5WExaenBLOXVuTlpXV05EckxieGgzMmM3c2kwN25ZNjFMM3o1eG1kWHA2?=
 =?utf-8?B?SFlYcDdWZ1BXdDFLVjJpejR4cEdLY1JEc0xFMUJacTg2SWw5SGROd1N6c09K?=
 =?utf-8?B?U1lxU3d1aENlcmpseGdkM3ZRQXdGVWpUdHNFcmsreE5jZ3AvZ0tVWVAzcW4y?=
 =?utf-8?B?UmprbHpOazNIbk5md3pmUHhlaG1WSzVsZVJ6NjJUTzAwcDFBbEc2d1ZpUzdK?=
 =?utf-8?B?RUloL2J4bDg2ZHE0Z2QzclJvazhITmFBcFFEd2lwaFVORkFLZmVDK3hRcDdP?=
 =?utf-8?B?Rk12K1lIWVFaZG9iMzViTXhIUzlLUzBLTXg3TGdxMDQ2N25TWkt1bHNQQlpK?=
 =?utf-8?B?MUkxWUtaK2g3anVpQzFhNm5IaFcwUHZuWnF5Ry9DRUFNNTZDVkdOUlNIalRo?=
 =?utf-8?B?RHUxbUxtTFI5QW1zWFpQSXdnbEphcDNaV2RibU4wdGZ6dk5ITUFISEdUbmNW?=
 =?utf-8?B?R2xlOHU5bVNsY1NBUjNaSEdqVmxNT0JuUUlmMUxIeWJxdHFWbm5iOFZKWkN2?=
 =?utf-8?B?dnovOXVFVk1VOUZLdlY2czlvNGFxaW9LRTdNWHRTK0wrZEJVNmRhQmUxSHA0?=
 =?utf-8?B?OFFlOWt6MTYxdTd1aVRaWXBVM2dCYUduVTJ0RmZmNkxWRVoyc2ZpUlVUMTgw?=
 =?utf-8?B?UWZCeG5hMkxXQ1UwcmVwamhsaGw1U1NSRVUrSWZmUGs5VzhIUk4ydnJlQkpW?=
 =?utf-8?B?K3BmSGd0V0hxeSsvVksyTmJPV1l4MmVDbHlTTVhJcWlOK1RFanpCUE5OREdw?=
 =?utf-8?B?ME80QzRPZ3VTenlIRDNoSmZXVnkwcEtRekV0dE5rUm9mSkRYcVVXM1lCelRy?=
 =?utf-8?B?eUc4eXVjMlVxNzRWaTI1YXdWalZGY2ZJWnhKUng5RUEyaUZXWDdCMFY1S2dm?=
 =?utf-8?B?UjBSNFJGOGVreEp6WmpUcHg4aHlJUko0c201a1RVWW1Qc29yRFkreTFqbSt6?=
 =?utf-8?B?TzIrTVZzcEVGMmhFN21HR09URGRvYnJBMXZGblhoY2hrdENZSUhPS3dUS1NR?=
 =?utf-8?B?N1JWSTAycCs5bHR0LzNNc2Zub3ZHVTVLZk42aXBKV0dhV2tMaUcrV1IwSmtX?=
 =?utf-8?B?b3N1Qk8rbGFiR2J5Qnh1L29xMXhZbUF5b21MZmpBYm5SWE5BdFRFTnJxWU9E?=
 =?utf-8?B?U3JUeUR5b3VJbFpaRTdHTHk5bVI5eThLdWR5MFY4UmRmM3kyREROdWlWUklL?=
 =?utf-8?B?cjRkZWhDb2dTekZnOTJUbEx4VmdtanZtajNsL0J0cXNhZFp2VlFhMU5VWkJo?=
 =?utf-8?B?K1ZvYUE4U21kM1B1MHp3aUJ2dEZaMFVoQTV3NGIwYVVUa0xXRFlGZjc4dTNx?=
 =?utf-8?Q?RwRNhPWems2a1r4fLBMCoyahG92UpuUH?=
x-microsoft-antispam-prvs: <VI1PR04MB4942CB36FDE8BE1734F986A489480@VI1PR04MB4942.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(376002)(346002)(136003)(13464003)(199004)(189003)(110136005)(8936002)(45080400002)(81166006)(99286004)(81156014)(102836004)(7416002)(8676002)(186003)(2906002)(33656002)(316002)(6506007)(53546011)(14454004)(14444005)(256004)(54906003)(229853002)(7696005)(3846002)(6116002)(93886005)(76176011)(74316002)(478600001)(66066001)(71190400001)(4326008)(966005)(71200400001)(6436002)(446003)(9686003)(53936002)(106356001)(105586002)(7736002)(52536013)(305945005)(25786009)(97736004)(68736007)(44832011)(476003)(11346002)(6246003)(486006)(26005)(86362001)(6306002)(55016002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4942;H:VI1PR04MB4558.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3eMJrUug/Lykf9xKYHlAckQwFBrrHpfFzlqt3MKlYawZjxqjsgI4L+31jApqJb52iIiSKrRmC8JUg3yFDbeizA7k4RS6upWJ4nDaL6KjipaeIlLhyV3SjYU4yP9lfuqeoG/cAUWtiqbVk5AK/KPej14icn85eTZM3JufL033CpHT1VgaYcrr6lu3GpuLpd/q3gXHhb82kqgzDtiQIPW4jK2TbCRaXSkCdIULrNeBe+yRHfxPho0U/YYpARofZ/nK3kabPmOvcEu9WbhzcLnbOQQryY5lg+5XznJ0nkZ3V8lc0T1I9J6Bs3yjsxZ2u9uFsCgFzAVkGZ2rb20t8cjqgQAXsYgBmKvgGNBhYEGHzE51GJlG7+r6f9UYGAsjX2q1NdVahmfiF+tbTv8xy4XBqzxjZyMBZBuGsCSp2B4a8yM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c264d4-c10e-4039-ee5c-08d6a5e7c173
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 06:06:52.0602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2h1bmZlbmcgWXVuIDxj
aHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiBTZW50OiAyMDE55bm0M+aciDEx5pelIDEzOjMz
DQo+IFRvOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPg0KPiBDYzogUm9iIEhl
cnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IEdyZWcgS3JvYWgtSGFydG1hbg0KPiA8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBIZWlra2kgS3JvZ2VydXMNCj4gPGhlaWtraS5rcm9nZXJ1
c0BsaW51eC5pbnRlbC5jb20+OyBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsN
Cj4gTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT47IEFkYW0gVGhvbXNv
bg0KPiA8QWRhbS5UaG9tc29uLk9wZW5zb3VyY2VAZGlhc2VtaS5jb20+OyBKdW4gTGkgPGp1bi5s
aUBueHAuY29tPjsgQmFkaHJpDQo+IEphZ2FuIFNyaWRoYXJhbiA8YmFkaHJpQGdvb2dsZS5jb20+
OyBBbmR5IFNoZXZjaGVua28NCj4gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+OyBNaW4gR3Vv
IDxtaW4uZ3VvQG1lZGlhdGVrLmNvbT47DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC11c2JAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LW1lZGlhdGVr
QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzVdIGR0LWJpbmRp
bmdzOiBjb25uZWN0b3I6IGFkZCBvcHRpb25hbCBwcm9wZXJ0aWVzIGZvcg0KPiBUeXBlLUINCj4g
DQo+IEhpLA0KPiANCj4gT24gRnJpLCAyMDE5LTAzLTA4IGF0IDEzOjA3ICswMTAwLCBIYW5zIGRl
IEdvZWRlIHdyb3RlOg0KPiA+IEhpLA0KPiA+DQo+ID4gT24gMDgtMDMtMTkgMDc6MTMsIENodW5m
ZW5nIFl1biB3cm90ZToNCj4gPiA+IEFkZCBpZC1ncGlvcywgdmJ1cy1ncGlvcywgdmJ1cy1zdXBw
bHkgYW5kIHBpbmN0cmwgcHJvcGVydGllcyBmb3INCj4gPiA+IHVzYi1iLWNvbm5lY3Rvcg0KPiA+
ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlh
dGVrLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9jb25u
ZWN0b3IvdXNiLWNvbm5lY3Rvci50eHQgICAgfCAxMCArKysrKysrKysrDQo+ID4gPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdA0KPiA+
ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY29ubmVjdG9yL3VzYi1jb25u
ZWN0b3IudHh0DQo+ID4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jb25u
ZWN0b3IvdXNiLWNvbm5lY3Rvci50eHQNCj4gPiA+IGluZGV4IGE5YTJmMmZjNDRmMi4uN2EwN2Iw
ZjRmOTczIDEwMDY0NA0KPiA+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2Nvbm5lY3Rvci91c2ItY29ubmVjdG9yLnR4dA0KPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nvbm5lY3Rvci91c2ItY29ubmVjdG9yLnR4dA0KPiA+ID4g
QEAgLTE3LDYgKzE3LDE2IEBAIE9wdGlvbmFsIHByb3BlcnRpZXM6DQo+ID4gPiAgIC0gc2VsZi1w
b3dlcmVkOiBTZXQgdGhpcyBwcm9wZXJ0eSBpZiB0aGUgdXNiIGRldmljZSB0aGF0IGhhcyBpdHMg
b3duIHBvd2VyDQo+ID4gPiAgICAgc291cmNlLg0KPiA+ID4NCj4gPiA+ICtPcHRpb25hbCBwcm9w
ZXJ0aWVzIGZvciB1c2ItYi1jb25uZWN0b3I6DQo+ID4gPiArLSBpZC1ncGlvczogZ3BpbyBmb3Ig
VVNCIElEIHBpbi4NCj4gPg0KPiA+IFdoYXQgYWJvdXQgYm9hcmRzIHdoZXJlIHRoZSBJRCBwaW4g
aXMgKm5vdCogY29ubmVjdGVkIHRvIGEgR1BJTywgYnV0DQo+ID4gZS5nLiB0byBhIHNwZWNpYWwg
cGluIG9uIHRoZSBQTUlDIHdoaWNoIGNhbiBhbHNvIGRldGVjdCBhbiBBQ0EgYWRhcHRlcg0KPiA+
ID8gQ3VycmVudGx5IHRoaXMgY2FzZSBpcyBoYW5kbGVkIGJ5IGV4dGNvbiBkcml2ZXJzLCBidXQg
d2UgaGF2ZSBubyB3YXkNCj4gPiB0byBzZXQgZS5nLiB2YnVzLXN1cHBseSBmb3IgdGhlIGNvbm5l
Y3Rvci4gTWF5YmUgaW4gdGhpcyBjYXNlIHRoZQ0KPiA+IHVzYi1jb25uZWN0b3Igbm9kZSBzaG91
bGQgYmUgYSBjaGlsZCBvZiB0aGUgUE1JQyBub2RlID8NCj4gWWVzLCBpdCB3b3VsZCBiZSwgUE1J
QyBpcyBpbiBjaGFyZ2VyIG9mIGRldGVjdGluZyB0aGUgc3RhdHVzIG9mIElEIHBpbg0KPiA+DQo+
ID4gQW5kIGluIG1hbnkgY2FzZXMgdGhlcmUgYWxzbyBpcyBhIG11eCB0byBzd2l0Y2ggdGhlIGRh
dGFsaW5lcyBiZXR3ZWVuDQo+ID4gdGhlIGhvc3QgYW5kIGRldmljZShnYWRnZXQpIGNvbnRyb2xs
ZXJzLCBob3cgc2hvdWxkIHRoYXQgYmUgZGVzY3JpYmVkDQo+ID4gaW4gdGhpcyBtb2RlbD8gIFNl
ZSB0aGUgbmV3IHVzYi1yb2xlLXN3aXRjaCBjb2RlIHVuZGVyDQo+ID4gZHJpdmVycy91c2Ivcm9s
ZXMNCj4gPg0KPiA+IEluIHNvbWUgY2FzZXMgdGhlIG11eCBpcyBjb250cm9sbGVkIHRocm91Z2gg
YSBncGlvLCBzbyB3ZSBtYXkgd2FudCB0bw0KPiA+IGFkZCBhICJtdXgtZ3Bpb3MiIGhlcmUgaW4g
d2hpY2ggY2FzZSB3ZSBhbHNvIG5lZWQgdG8gZGVmaW5lIHdoYXQgMC8xDQo+ID4gbWVhbnMuDQo+
IEknbSBub3Qgc3VyZSwgdGhlIG11eCBzZWVtcyBub3QgYmVsb25nIHRvIHRoaXMgY29ubmVjdG9y
LCBhbmQgbWF5IG5lZWQgYW5vdGhlcg0KPiBkcml2ZXIgdG8gcmVnaXN0ZXIgdXNiLXJvbGUtc3dp
dGNoLCBzaW1pbGFyIHRvOg0KPiANCj4gW3YyLDIvMl0gdXNiOiB0eXBlYzogYWRkIHR5cGVjIHN3
aXRjaCB2aWEgR1BJTyBjb250cm9sDQo+IGh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0
aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZwYXRjaHdvcmsNCj4gLmtlcm5lbC5v
cmclMkZwYXRjaCUyRjEwODM0MzI3JTJGJmFtcDtkYXRhPTAyJTdDMDElN0NqdW4ubGklNDBueHAu
Y28NCj4gbSU3Qzk2M2RmNjJlMTVlZDRiZWRiMTRkMDhkNmE1ZTMwZGUyJTdDNjg2ZWExZDNiYzJi
NGM2ZmE5MmNkOTljNQ0KPiBjMzAxNjM1JTdDMCU3QzAlN0M2MzY4Nzg3OTE5NTMxMjI3NjAmYW1w
O3NkYXRhPWdyUElzMk1iZGFhclRhMTdkcg0KPiBwQVNWa0dweVc3VEFleEIyNGlnT0pvcEdVJTNE
JmFtcDtyZXNlcnZlZD0wDQo+IA0KDQpObywgdGhpcyBpcyBub3QgZm9yIHVzYiByb2xlIHN3aXRj
aCwgdGhpcyBpcyBhIHR5cGVjIHN3aXRjaCBkcml2ZXIgdG8gc2VsZWN0IHRoZSBzdXBlciBzcGVl
ZA0KYWN0aXZlIGNoYW5uZWwgYnkgb3JpZW50YXRpb24oQ0MxL0NDMikuDQoNCkxpIEp1bg0KPiAN
Cj4gPg0KPiA+ID4gKy0gdmJ1cy1ncGlvczogZ3BpbyBmb3IgVVNCIFZCVVMgcGluLg0KPiA+ID4g
KyAgc2VlIGdwaW8vZ3Bpby50eHQuDQo+ID4gPiArLSB2YnVzLXN1cHBseTogcmVmZXJlbmNlIHRv
IHRoZSBWQlVTIHJlZ3VsYXRvciwgbmVlZGVkIHdoZW4NCj4gPiA+ICtzdXBwb3J0cw0KPiA+ID4g
KyAgZHVhbC1yb2xlIG1vZGUuDQo+ID4NCj4gPiBJIHRoaW5rIHRoaXMgbmVlZHMgc29tZSB0ZXh0
IHRoYXQgdGhlcmUgY2FuIGJlIGVpdGhlciBhIHZidXMtZ3BpbyBvciBhDQo+ID4gdmJ1cy1zdXBw
bHkuIE9oIHdhaXQgcmVhZGluZzoNCj4gPg0KPiA+IGh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5w
cm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZwYXQNCj4gPg0KPiBjaHdv
cmsua2VybmVsLm9yZyUyRnBhdGNoJTJGMTA4MTkzNzclMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q2p1
bi5saSU0DQo+IDBueA0KPiA+DQo+IHAuY29tJTdDOTYzZGY2MmUxNWVkNGJlZGIxNGQwOGQ2YTVl
MzBkZTIlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5DQo+IDljNWMzDQo+ID4NCj4gMDE2MzUlN0Mw
JTdDMCU3QzYzNjg3ODc5MTk1MzEyMjc2MCZhbXA7c2RhdGE9SnVkejdnZHdRVE9DN0poODQNCj4g
NTdONHgyMWENCj4gPiBmV2NpJTJGRUg3OUFScVdaemJYOCUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+
DQo+ID4gSSBzZWUgdGhhdCB0aGlzIEdQSU8gaXMgZm9yIGRldGVjdGluZyB2YnVzIHByZXNlbmNl
LCBub3QgZm9yDQo+ID4gZHJpdmluZy9lbmFibGluZyA1diB0byBWYnVzIGZyb20gdGhlIGJvYXJk
LCB0aGF0IG5lZWRzIHRvIGJlIGRlc2NyaWJlZCBtb3JlDQo+IGNsZWFybHkuDQo+IE9rDQo+IA0K
PiBUaGFua3MgYSBsb3QNCj4gPg0KPiA+ID4gKy0gcGluY3RybC1uYW1lcyA6IGEgcGluY3RybCBz
dGF0ZSBuYW1lZCAiZGVmYXVsdCIgaXMgb3B0aW9uYWwNCj4gPiA+ICstIHBpbmN0cmwtMCA6IHBp
biBjb250cm9sIGdyb3VwDQo+ID4gPiArICBzZWUgcGluY3RybC9waW5jdHJsLWJpbmRpbmdzLnR4
dA0KPiA+ID4gKw0KPiA+ID4gICBPcHRpb25hbCBwcm9wZXJ0aWVzIGZvciB1c2ItYy1jb25uZWN0
b3I6DQo+ID4gPiAgIC0gcG93ZXItcm9sZTogc2hvdWxkIGJlIG9uZSBvZiAic291cmNlIiwgInNp
bmsiIG9yICJkdWFsIihEUlApIGlmIHR5cGVjDQo+ID4gPiAgICAgY29ubmVjdG9yIGhhcyBwb3dl
ciBzdXBwb3J0Lg0KPiA+ID4NCj4gPg0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPg0KPiA+IEhhbnMN
Cj4gDQoNCg==
