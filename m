Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20FDC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 00:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE4120851
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 00:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="fkjzOf0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfCIA2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 19:28:17 -0500
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:13664
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726307AbfCIA2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 19:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXi7r8u2odRDaPR+5WO/vLCyfrXbGlALdmLPUFbIkSg=;
 b=fkjzOf0YnJHsacaJ9XK7fMMRn7QLCCZEwQicGq8i4HbsDqg8mVWL0Lq4owz8YYk2GVvf5UqEFx0IonIwd41d4avpqOa5Z2z/vaqLz/B/gtTBMRSqKiD0UHCAvP1o+igek/YTWEgaACZJMzPQLWJvYRZfxTVL92pQs8YBniPZ7ng=
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com (20.179.9.32) by
 DB8PR05MB6058.eurprd05.prod.outlook.com (20.179.11.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.17; Sat, 9 Mar 2019 00:27:31 +0000
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::28ed:92cd:4075:b660]) by DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::28ed:92cd:4075:b660%2]) with mapi id 15.20.1686.018; Sat, 9 Mar 2019
 00:27:31 +0000
From:   Saeed Mahameed <saeedm@mellanox.com>
To:     "davem@davemloft.net" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        Roi Dayan <roid@mellanox.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Eli Britstein <elibr@mellanox.com>
Subject: Re: [PATCH][next] net/mlx5e: Remove redundant assignment
Thread-Topic: [PATCH][next] net/mlx5e: Remove redundant assignment
Thread-Index: AQHU0S+tjWF8L6Ijf0eajSu7+CzZyqX6BweAgAD9E4CAAp0gAIAATriAgASLcIA=
Date:   Sat, 9 Mar 2019 00:27:31 +0000
Message-ID: <7315f2cf88be6af599d5adb46e3768178e9b581b.camel@mellanox.com>
References: <da1f1300-20f4-2929-078b-71ac1772a933@mellanox.com>
         <20190304062645.GZ15253@mtr-leonro.mtl.com>
         <176546c027a13f39c0dd8d5915b2d16b98637782.camel@mellanox.com>
         <20190305.190323.1175144356168830240.davem@davemloft.net>
In-Reply-To: <20190305.190323.1175144356168830240.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com; 
x-originating-ip: [209.116.155.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46cee5bc-4d9d-4e09-cc05-08d6a4260490
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB8PR05MB6058;
x-ms-traffictypediagnostic: DB8PR05MB6058:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjhQUjA1TUI2MDU4OzIzOlpzVXZZUGVqNUllL0l2UWJvZC9OVE9idjM1?=
 =?utf-8?B?bnVMRm51U2FrMThvSlZxdkxObEpOQlRhZGpJeVF5Mk9QQjhYK1ArK1c3SzF0?=
 =?utf-8?B?QzA2NURSQkRUUmY3Y1hWNXRUR0xzMmZ1dzdzUXpaazFCbHd1U0FXVGp5cFZv?=
 =?utf-8?B?a3dXVzdiRkQ4K2F3TVBPU3NhS0NFMDZjZkc4RGdnZXY2UmNKZ1RJNkRjMnVm?=
 =?utf-8?B?R3N0YXBpLzY2alIzZlRrT3BzTlZaNWFPaE9WZ2dXWUdLdXJrWWhxWS9FYTBr?=
 =?utf-8?B?cU11RmVFeGgycVEyM2FIUy9BaWwrdkJwdjAwYWd1TmExSHZINGNJZUNuU1BV?=
 =?utf-8?B?UlFyYlVNdG5JNHMzdUovcFA5aEtVTk1vVURudG83d0hLcGhDSkEzOHVXTUNp?=
 =?utf-8?B?dWdhbjVCT0NJUDdsVEdLZW1aZkJOeDUvY0dFRGFYUW1LT0VLcXNST2pHYWww?=
 =?utf-8?B?V2Voa2xZZnBRUjU0MmV3Z3l3WSs1eGpVeHl0VTRQSzNLOW5vbHZXTEpHUlFw?=
 =?utf-8?B?RXJ3SFI4T1hEM01NOWV6aFRwaGw3YjVmdURMUFdRWCs3TFlpc1B2d3hXaEpB?=
 =?utf-8?B?VTFsemVUZlMrdGlzZFpYVWJTUEZnRVpIMTAyemM5OXBVTWxlUE5INEFQS2tJ?=
 =?utf-8?B?QWhOejBRRFhRcy9XYmgzaSt5RzZWL1pab1M0azV1UnpuUWxZMnlXUFJjcVdo?=
 =?utf-8?B?eklVZFdnSGpMM1p5bG50YWFDQjNaZTJyYUptamV3V2wrM1J5VThpazhPdU9R?=
 =?utf-8?B?WDFqODVWTGEybHBrRjNQZnZITW5jMG4rVXFsa2RsR0NMLytlejN1T01zVUJO?=
 =?utf-8?B?bndiUzJXMDBocjE4dkpsd0tucm5IYkdabkJobU12T3RkSDVjN1k4eXpXeUgr?=
 =?utf-8?B?cTYva3BqRGNtMi90KzdyTmpsRXZ6TVNLbTlEVTk4b2NqVXhISk1EZ0xBQk4r?=
 =?utf-8?B?ZUE5ZHdrWDZhN2h6dmNXb1JMSUcwYWhjY1BMVVkvL29yTG53VGozTXZMYmZy?=
 =?utf-8?B?OUJ0K1JaRkdqZlJhREI4YlNrUzRMa28xYUwxUk5WWitGY0x1T1lNbkZoc0c1?=
 =?utf-8?B?ZVBoc0Z3am5vVFQwYlJUbTZWb0dKMmJUQzFmcUZ3THQ4UGFKcDZhWGkvNzRT?=
 =?utf-8?B?N05MUjJsQUhCQU5vR0hvK0FwdlFHYS96UjIrYnhQZ3BSVWtsSzBzd2NJUDFt?=
 =?utf-8?B?ZVNiMEJDbjZNTFJ4emNENDRsMEFLSWtRWnBxVE5jTFNueVpXNGlvMkh3REhO?=
 =?utf-8?B?TEhyV1hqQVhVaG5RRmp2SFJsN2hXaDM0OFljZkZkSG5Dd29JRk1vTEJPdTVo?=
 =?utf-8?B?V2hXUGlraFd5cGw5QWpISFVXM0VOL28yOS9lMWxEVkdxYTlBQzJPQWkrdFB3?=
 =?utf-8?B?WWJWWmJZakFaK3R2ZktBakdHUHNvYVdmM3dFYW1sbzc3NVZud0RScWJ4b3k0?=
 =?utf-8?B?R28zdGlyUnFQU2dpZHkrN1FsUUI5cllzdFQrZkZVcVdiOWNoNXU5anpJNTcz?=
 =?utf-8?B?Q3VBNjUrdHZ4V2IrSlRUY2U5cWt1eWsxQy96SjVrTWZ0d2lmdWZFTE96NjN2?=
 =?utf-8?B?QTBuRzNNL3BvMjR4aHFiTUJkcWsrNmJ2d0lhUnBDNzVrN1lFQUEzVmRLc2Nr?=
 =?utf-8?B?SkZaWkFtYW1UdElDWG9pbWlUVTRBbXRCOEppRmZINVkzN0MwUnFUQ3ZmTHVv?=
 =?utf-8?B?NHNOU2hOZHFtVitDT3Nuc0F1QjRDZjdDa1BQUER3QlhkNDFrM0grZkFjUEMw?=
 =?utf-8?B?dmtSTjdCQ0hZSEpmUVFHK0N5TWR1cHhQaFFsNlF5NVBYb05ZSnNIT1k1b3Rr?=
 =?utf-8?B?N2NrMDFaaUVhS01GVEtoKzVoOFdmTUIvRENWbDFaWnVRRkh5QmIzMC9DdUNX?=
 =?utf-8?B?VGRSajYrSGVQS1FpMlR5V1BIQmd1TldYWFlvTjJpYThXaFg3Yjd1ZWRtSGhS?=
 =?utf-8?B?YTlWa29qZ3A0YS9LMUxUdWFoNkF3RlFocUFiMHhFb0RrWnE1VkVEaWVOd2E4?=
 =?utf-8?B?ZlpRWnZrNldyTDV5Y2Q2MUFLbWxaZUlKdGpuZz09?=
x-microsoft-antispam-prvs: <DB8PR05MB605819179F6B7D9B4916D717BE4E0@DB8PR05MB6058.eurprd05.prod.outlook.com>
x-forefront-prvs: 0971922F40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(376002)(346002)(366004)(39860400002)(136003)(199004)(189003)(1730700003)(36756003)(6512007)(53546011)(6506007)(7736002)(99286004)(106356001)(14454004)(81166006)(81156014)(76176011)(2351001)(68736007)(229853002)(93886005)(25786009)(105586002)(316002)(58126008)(8936002)(66066001)(11346002)(446003)(305945005)(2616005)(5640700003)(2501003)(476003)(486006)(6486002)(53936002)(54906003)(118296001)(6116002)(107886003)(4326008)(6246003)(6436002)(26005)(86362001)(6916009)(71190400001)(14444005)(256004)(3846002)(71200400001)(5660300002)(2906002)(186003)(97736004)(8676002)(102836004)(478600001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR05MB6058;H:DB8PR05MB5898.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oIoSjd/SLFNI1TRVOMeD1m2x96HQ6Gj+NXro+16InYMWw6o9vJpUMBGvvQkriJ1cBqsfbuLZ8DddBK3ZjofaGu3nPgxY95DBlJBPJBsb12PXmujd8OSjiPBrQM5TLAUnQAjtw9jDA/iHAMU2MLaMHP76Mwq/JMdgmhK1gZdyylzOH968vQ2iW4JHUskb52NHdNNyQ6Nn/TCin+KCghu93XTSkpH5+4NQaOIpEkhqS31yRdHcXpxUKIJAN6fbiUq7O4qphWyV9g1p4Pk4VoGoN/KRwBffmZ4RpQXGSuwSWxhbyhtI6w+3QmP+9eIkFlaUEBIZHn3Un2VNnosseq2SFuvAFMwcnR+NKpV+Y/hXwKsHVGH7rEnIHIQxkBFhOKG0FMQysnmRzu9whKluklzW1H6bPqkQfFfNbaQJj/pqCSc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DFDFCF76ABAAD4F931B881A62DB37F9@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46cee5bc-4d9d-4e09-cc05-08d6a4260490
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2019 00:27:31.0994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR05MB6058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTAzLTA1IGF0IDE5OjAzIC0wODAwLCBEYXZpZCBNaWxsZXIgd3JvdGU6DQo+
IEZyb206IFNhZWVkIE1haGFtZWVkIDxzYWVlZG1AbWVsbGFub3guY29tPg0KPiBEYXRlOiBUdWUs
IDUgTWFyIDIwMTkgMjI6MjE6MzkgKzAwMDANCj4gDQo+ID4gT24gTW9uLCAyMDE5LTAzLTA0IGF0
IDA4OjI2ICswMjAwLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+ID4gPiBPbiBTdW4sIE1hciAw
MywgMjAxOSBhdCAwMzoyMDo1N1BNICswMDAwLCBSb2kgRGF5YW4gd3JvdGU6DQo+ID4gPiA+IE9u
IDAyLzAzLzIwMTkgMjE6MzksIEd1c3Rhdm8gQS4gUi4gU2lsdmEgd3JvdGU6DQo+ID4gPiA+ID4g
UmVtb3ZlIHJlZHVuZGFudCBhc3NpZ25tZW50IHRvIHR1bl9lbnRyb3B5LT5lbmFibGVkLg0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IEFkZGVzc2VzLUNvdmVyaXR5LUlEOiAxNDc3MzI4ICgiVW51c2Vk
IHZhbHVlIikNCj4gPiA+ID4gPiBGaXhlczogOTc0MTdmNjE4MmY4ICgibmV0L21seDVlOiBGaXgg
R1JFIGtleSBieSBjb250cm9sbGluZw0KPiA+ID4gPiA+IHBvcnQNCj4gPiA+ID4gPiB0dW5uZWwg
ZW50cm9weSBjYWxjdWxhdGlvbiIpDQo+ID4gPiA+IA0KPiA+ID4gPiB0aGUgY29tbWl0IGRvZXNu
J3QgZml4IGFueSByZWFsIGlzc3VlIGJ1dCBpcyBtb3JlIG9mIGEgY2xlYW51cC4NCj4gPiA+ID4g
c28gSSdtIG5vdCBzdXJlIGlmIGZpeGVzIGxpbmUgaXMgcmVsZXZhbnQgb3Igbm90Lg0KPiA+ID4g
PiBiZXNpZGUgdGhhdCBsb29rcyBvay4NCj4gPiA+IA0KPiA+ID4gSXQgZG9lc24ndCBtYXR0ZXIg
aWYgaXQgaXMgcmVhbCBpc3N1ZSBvciBub3QsIHRoZSBjb2RlIGlzIHdyb25nDQo+ID4gPiBhbmQN
Cj4gPiA+IHNob3VsZCBiZSBmaXhlZC4gVGhpcyBhbG9uZSBpcyBlbm91Z2ggdG8gc2VlIHRoZSBG
aXhlcyBsaW5lLg0KPiA+ID4gDQo+ID4gPiBUaGFua3MsDQo+ID4gPiBBY2tlZC1ieTogTGVvbiBS
b21hbm92c2t5IDxsZW9ucm9AbWVsbGFub3guY29tPg0KPiA+IA0KPiA+IEFja2VkLWJ5OiBTYWVl
ZCBNYWhhbWVlZCA8c2FlZWRtQG1lbGxhbm94LmNvbT4NCj4gPiBEYXZlLCBEbyB5b3UgdGhpbmsg
c3VjaCBwYXRjaCBzaG91bGQgZ28gdG8gbmV0LCBvciBkbyB5b3Ugd2FudCBtZQ0KPiA+IHRvDQo+
ID4gc2VuZCBpdCBpbiBteSBuZXh0IHB1bGwgcmVxdWVzdCB0byBuZXQtbmV4dCwgb25jZSBpdCBp
cyBvcGVuIG9mDQo+ID4gY291cnNlDQo+ID4gPw0KPiANCj4gVGhpcyBmZWVscyBtb3JlIGxpa2Ug
bmV0LW5leHQgc3R1ZmYgdG8gbWUsIHRoYW5rcyBmb3IgYXNraW5nLg0KDQpBcHBsaWVkIHRvIG5l
dC1uZXh0LW1seDUsIHdpbGwgYmUgc2VudCBpbiB0aGUgbmV4dCBwdWxsIHJlcXVlc3Qgd2hlbg0K
bmV0LW5leHQgcmVvcGVucywgVGhhbmtzIQ0KDQo=
