Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C00C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C0A205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gU2OMo+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfCKG5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:57:42 -0400
Received: from mail-eopbgr30044.outbound.protection.outlook.com ([40.107.3.44]:31879
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725831AbfCKG5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gag4V+YAjDKMtlP/QeZ4u9nbB8lTHF48DQNkMN/T2qw=;
 b=gU2OMo+rotzkNEZlTQcQDERPXyeKl7svXL1kX16RdR2y6yxWJlufamAPR2R4kh9sLKHedJ+qGIYzFFgvbyTg2f/MFD2yEye45LVknWTb5z7gfl/tm2hPLt0hnUaU8pnNSQauzVkBJiK6SChDbnoIjJVcJUC6eKBBiqxKgqRl9kY=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1PR04MB5198.eurprd04.prod.outlook.com (20.177.51.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 06:56:56 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::c44:db60:6fde:37ec]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::c44:db60:6fde:37ec%4]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 06:56:56 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>, Andy Tang <andy.tang@nxp.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
Subject: RE: [v6 1/3] dt-bindings: ahci-fsl-qoriq: add lx2160a chip name to
 the list
Thread-Topic: [v6 1/3] dt-bindings: ahci-fsl-qoriq: add lx2160a chip name to
 the list
Thread-Index: AQHUyPr4d9+OZ641x0+1xJ07A41VIqXr5uGAgBo0mXA=
Date:   Mon, 11 Mar 2019 06:56:56 +0000
Message-ID: <VI1PR04MB44312525A43E259CE9CC45F9ED480@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20190220085607.31582-1-peng.ma@nxp.com>
 <20190222143931.GA17132@bogus>
In-Reply-To: <20190222143931.GA17132@bogus>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 975771d9-08ce-4b12-b52f-08d6a5eec033
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5198;
x-ms-traffictypediagnostic: VI1PR04MB5198:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtWSTFQUjA0TUI1MTk4OzIzOlZPZER1NUp1WlplVHVJV2ZiWG5nL3BuV0lE?=
 =?gb2312?B?YmRPKzJHSE9lQituZ2J1WG41bzJNeGxObDYyZklrSnJDYUNITjZrN09qODY3?=
 =?gb2312?B?M29RYmlTRDREZzB4eDhhS25lZjFibS84QXRtOFRaZlJNQkxlNkovb001SWxz?=
 =?gb2312?B?MDBUbHNONFJmVDZjaXBmelQ0emZnbytmRGJMMHNScVVzNWdHUGVwTk9VNnVX?=
 =?gb2312?B?ZTc3bnhGTkxvN3hVZUVnOG1wdkV3aWhWQzM4L3ozODJXTlRYOC94U1FNd21n?=
 =?gb2312?B?dVVXQi9lZk94eHc3R1ozWWEzYk13TUczT3FvdUM0WDIxb2tlaVltUU1XYnMr?=
 =?gb2312?B?UHQwdElFOW16OEtNVFZjeWdBdlRDZDljeUZudWRjc0RweE0wQjNGV3AyRzMw?=
 =?gb2312?B?UXVtYm9NMUFhOUhPY3lOVm8rZjBCOWtsOG1YZURuUHRpWmxTUFhMSzBqY1k1?=
 =?gb2312?B?TXpXZkF0WExkOFV0aitQaDJ6VVFUQk5qNmQ2aG5QaWNpTW5GVkpvWU5FSlRi?=
 =?gb2312?B?QXVjVmVZR1hnd3BoNEs2K0VXNHVCYWxZVnlDanJsc0U1ZG1VekZwTWRYNHJI?=
 =?gb2312?B?QmFVOGNVRXVQWkZNNTBDTloyWTdEWnhlUkNyajkwNVZMMDd4TTc2SWk3OEpG?=
 =?gb2312?B?b0JUTnpxeUpSNFM3bTlXOFlUNGt6S3l6cHZRSFJBMHYzcFBGMkxEcDk4MDl2?=
 =?gb2312?B?cWwwcUliMFNRR3pkZHhnaStFek8zdTJ3V2g1cmx3d0VpbVI2Rkt0QWp4UGlX?=
 =?gb2312?B?RVhnWUc2cXJlTmdlMU54WnpySDZqZmVyMUk0b3hHUzhVS0orWjZhNjVRMXM0?=
 =?gb2312?B?LzRFekFINVNMd2ptaTc2bkdoa2gyS1YrUjQ1RXBWQnFZVVByTWUwNHN6ekF5?=
 =?gb2312?B?ZVRLa1gzNERvT2VhOGtiZDZycGlvUlR1Z29PRnFSTlBMZFd5TUh0UzE5T1p4?=
 =?gb2312?B?NFlML3laL0dLS2ZvUURXV050SncyYnkwNEJsNnlXYUQxQlNxdzJwbXFiOUZR?=
 =?gb2312?B?Q01RZVRYaXRFbDdSVzFWWlJVek1hUWEvbW9sN054U0NHSHFQNFl0WGFNemsy?=
 =?gb2312?B?Sm9tcGgyVUFDL2xBNHF1ZDI2V212cXduODJXNEFZZCtaZjEyOVJ2cFc2SkNR?=
 =?gb2312?B?UWhIZlB1bHY5RUdPcS9iMTBIOStUdTdDKzEvN2F6V1pXSnRORHlKZjN2VDNW?=
 =?gb2312?B?dHJ4V0E4dG1XRFNKU2F4M1NMNzhyRVNPUFVPTkxHZkRYczFFd2trcitTSjh1?=
 =?gb2312?B?QmdRNnBvTGNZV2FhaXliNTF5b2Q1alY4azNLQ1gvcXgrVWRuenRBQy9tblR1?=
 =?gb2312?B?NDJ4algzYXV1YjlzbUh0R0JkOFVrQzNtdVhwalQ0d2lCeEttQ2dzaWYrWExm?=
 =?gb2312?B?eWxaZmdKdmFVTkJLb2Y5VXlzMFFUUnl2d0h1RVVYZVpjMUxkYnVnblFJb3Zv?=
 =?gb2312?B?VVIwOW4vRzZFZWFEOW50OWhYOHFOZ2NpUjhiaEg0L1ZROVRhN3pGdmJ4MmRi?=
 =?gb2312?B?U01ON1F5T0M5b3JQcHlSZW0wbWlaaWVHM1JzSXNWUU85SnBlR0VEUmFMRStE?=
 =?gb2312?B?MDhuZTkyZHYyZjdidUpTMHo3RzhIT1NMMGdSb3hnc01jOXQrSFY0R2ZCQUFi?=
 =?gb2312?B?djNYSmtCdHBJSUN3NlVZTW8wWGEvaC85WnhRVm9oZ0VFSDFiV2E4R0ZXRTJH?=
 =?gb2312?B?SlFhYldZS1d0QVpldlFSUzFCOXFQK3ZIbklzbnVGSkl2R2Q4OVU3M3hGeWFS?=
 =?gb2312?B?UURwK0FJWGhGdFJhempvUT09?=
x-microsoft-antispam-prvs: <VI1PR04MB519857785653DEA6ED1AF58EED480@VI1PR04MB5198.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(396003)(366004)(376002)(13464003)(199004)(189003)(97736004)(305945005)(105586002)(2906002)(106356001)(44832011)(486006)(6116002)(53936002)(3846002)(476003)(11346002)(446003)(7736002)(256004)(66066001)(26005)(186003)(71200400001)(71190400001)(14454004)(33656002)(8936002)(74316002)(6246003)(81156014)(478600001)(4326008)(81166006)(5660300002)(76176011)(55016002)(6306002)(9686003)(68736007)(7696005)(7416002)(316002)(6436002)(99286004)(52536013)(6916009)(229853002)(54906003)(86362001)(102836004)(6506007)(25786009)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5198;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GLrfXkfMgbOKjYruTr+Ts1HXPqTP6AGzLG2o8j/M7cA86KSfJqlKOhlBOx7V9/yN4vvmgFwPuTBa4EMWy44ujmMVVMk51eJ1zhNoRynsIea8QZXOHnSpncx+Yium72VqmIHh2GFvlpz9O/nWFZ7/BYQ8NQlrc64ggM2Kj/DDplgx/uhZ1Q+nbJ4dRwjO3SR6KrI6/VT97inkrT7SMNQZAMtqNPV/qw7ZHyLkdNSMPh1AOLEry/MvHIYl+853EPOuK4PEcn69GM5tHEE4Licjf9dsiv4rZyICGBxjPas5/KkpHt9Rw30lUSEIv6jOFP2ghcha/RhxfWCxtqFtwQ8vi0qM1h6t18iMASVI+6ZR9V2q7i5K9zF7cRxhUsJpytNHgc7xVglj0PtO+S4T3FXBIOa/KfHZ0tD05l5g38eGlR0=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975771d9-08ce-4b12-b52f-08d6a5eec033
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 06:56:56.3726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMsIEkgZG9uJ3QgdW5kZXJzdGFuZCB3
aGF0IHlvdSBzYWlkLg0KVGhpcyBwYXRjaCBpcyBvbmUgb2YgdGhlIHNlcmllcyBwYXRjaHMoaHR0
cDovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbGludXgtaWRlL2xpc3QvP3Nlcmllcz05
MzA5OSZhcmNoaXZlPWJvdGgmc3RhdGU9KikgZm9yIHJldmlldy4NClRoZXJlIGlzIG5vdCBjaGFu
Z2VkIGZvciA2dGggdmVyc2lvbiBvZiB0aGlzIHBhdGNoLg0KDQpCZXN0IFJlZ2FyZHMsDQpQZW5n
DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFJvYiBIZXJyaW5nIDxyb2Jo
QGtlcm5lbC5vcmc+DQo+U2VudDogMjAxOcTqMtTCMjLI1SAyMjo0MA0KPlRvOiBQZW5nIE1hIDxw
ZW5nLm1hQG54cC5jb20+DQo+Q2M6IGF4Ym9lQGtlcm5lbC5kazsgcm9iaCtkdEBrZXJuZWwub3Jn
OyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj5zaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8gTGkgPGxl
b3lhbmcubGlAbnhwLmNvbT47IEFuZHkgVGFuZw0KPjxhbmR5LnRhbmdAbnhwLmNvbT47IGxpbnV4
LWlkZUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPmxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgTWlhbg0KPllvdXNhZiBLYXVrYWIgPHlvdXNhZi5rYXVrYWJAc3VzZS5jb20+OyBQZW5n
IE1hIDxwZW5nLm1hQG54cC5jb20+DQo+U3ViamVjdDogUmU6IFt2NiAxLzNdIGR0LWJpbmRpbmdz
OiBhaGNpLWZzbC1xb3JpcTogYWRkIGx4MjE2MGEgY2hpcCBuYW1lIHRvIHRoZQ0KPmxpc3QNCj4N
Cj5PbiBXZWQsIDIwIEZlYiAyMDE5IDA4OjU2OjA1ICswMDAwLCBQZW5nIE1hIHdyb3RlOg0KPj4g
QWRkIGx4MjE2MGEgY29tcGF0aWJsZSB0byBiaW5kaW5ncyBkb2N1bWVudGF0aW9uLg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IFBlbmcgTWEgPHBlbmcubWFAbnhwLmNvbT4NCj4+IC0tLQ0KPj4gY2hh
bmdlZCBmb3IgVjY6DQo+PiAJLSBubyBjaGFuZ2VkDQo+Pg0KPj4gIC4uLi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2F0YS9haGNpLWZzbC1xb3JpcS50eHQgICAgIHwgICAgMiArLQ0KPj4gIDEgZmlsZXMg
Y2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQ0KPj4NCj4NCj5QbGVhc2Ug
YWRkIEFja2VkLWJ5L1Jldmlld2VkLWJ5IHRhZ3Mgd2hlbiBwb3N0aW5nIG5ldyB2ZXJzaW9ucy4g
SG93ZXZlciwNCj50aGVyZSdzIG5vIG5lZWQgdG8gcmVwb3N0IHBhdGNoZXMgKm9ubHkqIHRvIGFk
ZCB0aGUgdGFncy4gVGhlIHVwc3RyZWFtDQo+bWFpbnRhaW5lciB3aWxsIGRvIHRoYXQgZm9yIGFj
a3MgcmVjZWl2ZWQgb24gdGhlIHZlcnNpb24gdGhleSBhcHBseS4NCj4NCj5JZiBhIHRhZyB3YXMg
bm90IGFkZGVkIG9uIHB1cnBvc2UsIHBsZWFzZSBzdGF0ZSB3aHkgYW5kIHdoYXQgY2hhbmdlZC4N
Cg==
