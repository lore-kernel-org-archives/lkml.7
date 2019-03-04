Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA21FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7686320643
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="488N3gLT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfCDLfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 06:35:40 -0500
Received: from mail-eopbgr800042.outbound.protection.outlook.com ([40.107.80.42]:23845
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726090AbfCDLfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 06:35:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/yjYLeF4ssvjCRCy+y67eLIyxc0NFbWX1pIHZ3aKKg=;
 b=488N3gLTmPR4FOarNCfDckT/mKjXrTvsjdOk8kwncFjNw3qgGj2/fUX4G3fQL40+zrh0089BHcHqEbJ+Eb9PTJqoaJcJuLLzByNfj4x10vO2hfOGBQGMxeeZAYGJLg/ys/j7pn2QYBzDdNRR6FKAdFcj0rXQMR60m2fkmh+Mvrw=
Received: from BYAPR02MB4710.namprd02.prod.outlook.com (52.135.232.23) by
 BYAPR02MB4773.namprd02.prod.outlook.com (52.135.232.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Mon, 4 Mar 2019 11:35:28 +0000
Received: from BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::b572:d2a1:b4dd:9162]) by BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::b572:d2a1:b4dd:9162%2]) with mapi id 15.20.1665.019; Mon, 4 Mar 2019
 11:35:28 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jolly Shah <JOLLYS@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Subject: RE: [PATCH v3 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga
 driver
Thread-Topic: [PATCH v3 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga
 driver
Thread-Index: AQHUsOdKmglIsGXrYUShdUJ415kWF6W53/kAgAEjAjCAMXYnAIAPHL/w
Date:   Mon, 4 Mar 2019 11:35:28 +0000
Message-ID: <BYAPR02MB4710216D63D98A56ABD99E67C2710@BYAPR02MB4710.namprd02.prod.outlook.com>
References: <20190121173835.21173-1-nava.manne@xilinx.com>
 <20190121173835.21173-7-nava.manne@xilinx.com> <20190121154928.GA32129@bogus>
 <BYAPR02MB4710D1404CF2816599623363C2980@BYAPR02MB4710.namprd02.prod.outlook.com>
 <CAL_JsqKy0DB+nt+q307d2HHuuf1OCdCe-Ro-5covdTibBwQw8A@mail.gmail.com>
In-Reply-To: <CAL_JsqKy0DB+nt+q307d2HHuuf1OCdCe-Ro-5covdTibBwQw8A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=navam@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8b4387a-a9e9-406a-8985-08d6a09580b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB4773;
x-ms-traffictypediagnostic: BYAPR02MB4773:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtCWUFQUjAyTUI0NzczOzIzOkVTdmNiQXgxT0puS1llenVpNzdKTlAwYzh0?=
 =?utf-8?B?QmNGSVJpUFZXUlpLcFoxL3ZEWmdiaUxwRnpGMGZsSXVSVTQ2UHNqbEE1Mmtt?=
 =?utf-8?B?RTVxR09oeWdlNnhtQ3poaHVYRDhEaGEzMDk1SG9uWWxXaUI2dG1hTzIzeEdZ?=
 =?utf-8?B?M2FRdTBCRjgvYkpwVWFkM25rOWxPOXlIazNmbXRmSmRuWkJleW1CSUpMQXBw?=
 =?utf-8?B?UUpyUWRiaC9Qa1QyT1hmc3E5cGhWSnRnQ2VyRDJSWm5aRDM5dEdLa1hzZjVR?=
 =?utf-8?B?YVBpcWZnYWRiSlc3NGlqdUROVTZ5NnZOZTBqTUdiWDJZd3FDS2tmTmhBay9N?=
 =?utf-8?B?dndDVmFHK01ORTByR0V0V0E5UE94MnE1SnA5QWVHWGdPWlAwS3llK2lSREpq?=
 =?utf-8?B?RHIzc09Qd0FQTDMyRHgyVkl4SGR0b2I1R0djL1ZBZUF2Y2UzSitiS3BMQ0hw?=
 =?utf-8?B?Z29iMXFkT0N1cWRaYnpqSjlnWC9wT0xNV1h2TGVCcGs1Q3VkOHVNWU5sbmNI?=
 =?utf-8?B?MytiYTYxeG5XZmNRUXB2SDhDOCsyeERKOFBGY1F5KzI1aE15YUYra01GOG5M?=
 =?utf-8?B?K1dCWVhvZ21COUZ6WVpIZUo4T2U2UlJwaFNqRWpFQXhabnBLeDdNWFVhUHNq?=
 =?utf-8?B?ejVTNzBqZG9pOVpDa1JWcGUyWkozQjNVejV3UE9rZUx1N1dESWRHRE9kZG0w?=
 =?utf-8?B?QVE4YWFaWnorZ04wcitNWEJzT1ZxVUNoVGhoNmVHMHZkbForakhJZENkUlFr?=
 =?utf-8?B?WVZaeHo1QVFUNk9GdWp6MjJJZ2ptalpqTXRwVzZERm5jcjZEeWptQzE0eUp2?=
 =?utf-8?B?dWdPMktXNWxBV05WQjF5emhHRHAweWRtREdyQzZwSmxJZFQ3RXR0NU9SZlBD?=
 =?utf-8?B?N1FpLzBCWlIzanVxUzJEaS9ObG4vV0svNzM2ZVdwQWpKMzd5ZHBVUGVMcW5G?=
 =?utf-8?B?WmZNY2ZFMDFJQ3crRVJWWnl3Z1VkYkNYQU4wOFE5WUxYS2xXWEZkaE1EUkdN?=
 =?utf-8?B?OUtnRU5vR2RZRkhJQXdBa0xLNmlxSFFEdWUwRGF6bXF5RFhJL2xmcGhFWGla?=
 =?utf-8?B?enpEYmlHNC9kNXM1Q0NEWTJZUHUxVFBhZmdFaW8wcjRXREY2THJ0Ym52UWlF?=
 =?utf-8?B?aEVlOWUxSTAyWWxBa2hxWWVwckxXOHlGVVhpbTN3K21mOHN0VDNyUEVFMHdi?=
 =?utf-8?B?UGI5TDEwZE1QOFdFL3oyaVVuQzBadnFYY21LMll0M2N5M0lhUWVUUitLNG5B?=
 =?utf-8?B?SUxneGxkcmt0bFo0Z3RMakwxRGFid284NDJoL1EvdkJqR3RhM2VoZkprS3FY?=
 =?utf-8?B?T3hPMWlDZzd1SFBjWWJoS3JVaFdYOHVGWWF1TjlLUkpXdzlGOFdEeTR1clhH?=
 =?utf-8?B?UE5WRS9OMXpSeTRIa2EwMVZOSVJKMmtZaTJqVU9tVHlUZXovdXM2dkNoeHRL?=
 =?utf-8?B?cStmUTIvRFdtUHZJY1l6U0poUlFLRVkvL2dJYm9aenRmTThTbVJGTHBBZXdR?=
 =?utf-8?B?bWx1RGsvUXV5TGdpRVFsVTgwSy9kQlMxdmdZa1JIMXhyNWlQYnhvVHJjSlNM?=
 =?utf-8?B?eDlWc1dLNHNIdmxoZGJUcjFBZ0QyNFdXdWI1UUtLYWY0eUpSZVljakYxWStI?=
 =?utf-8?B?V3RjeVVOajBZVmZjSFIvSzZvTXI1ZEt6K05vdFkxdHdqTkRxeFVrSEt6a3Fz?=
 =?utf-8?Q?HsZZ55rR012veIsidpy8Pgv5cI91jsbhRHbJBjS?=
x-microsoft-antispam-prvs: <BYAPR02MB4773BFB981B7D945273DC9BAC2710@BYAPR02MB4773.namprd02.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(366004)(396003)(39860400002)(13464003)(189003)(199004)(11346002)(97736004)(2906002)(52536013)(71190400001)(66066001)(478600001)(446003)(229853002)(256004)(53936002)(9686003)(14454004)(86362001)(71200400001)(68736007)(6436002)(55016002)(316002)(33656002)(106356001)(105586002)(486006)(53546011)(93886005)(26005)(186003)(6506007)(74316002)(305945005)(54906003)(6116002)(7696005)(7736002)(3846002)(6246003)(4326008)(6916009)(99286004)(25786009)(5660300002)(476003)(76176011)(81156014)(8936002)(102836004)(81166006)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4773;H:BYAPR02MB4710.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: P/QLXDaywAw8P0bKeddeiKwLfwhjJnRzbcnCHDB272FWNqff+zrJngDi9Al27iQPin13/hfKMd/YP1nO2GX4jAJ50mrbx3nWdXhLAHqfsGtYyolhaVUeq1JYAR8MV+Hg/yhEyAjhLoJMgVzEsL+lN5AAnVpOce7q0/QVJm4cI2fOz6BeG9SkmqHa0gI5uJirzaO7KP+bkOqpZ4PNRSus3yznf23WDeU+MMxFXKPNnZCLhm2Ww51KIXPdysU4vBSZFWEFZcPyY0nM++GDKC6pQPhYa2Vns0WWOXWNyRya8FEAGHooPTuCrh4AenN/R5SzDZf8pjNZl0KSjsYShaRx2yCGv9Ve6pJcRx1KJlpVZDZx4+mB7X2SJ+zcRET7ZXDhslPDAfC0A3qhD88rih1QPlxfmgKYKpV6HfRzp8NfT1o=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b4387a-a9e9-406a-8985-08d6a09580b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 11:35:28.7428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQogVGhhbmtzIGZvciBwcm92aWRpbmcgdGhlIHJldmlldyBjb21tZW50cy4uDQpQ
bGVhc2UgZmluZCBteSByZXNwb25zZSBpbmxpbmUuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgW21haWx0bzpyb2JoQGtlcm5lbC5vcmddDQo+IFNl
bnQ6IFNhdHVyZGF5LCBGZWJydWFyeSAyMywgMjAxOSAyOjAxIEFNDQo+IFRvOiBOYXZhIGtpc2hv
cmUgTWFubmUgPG5hdmFtQHhpbGlueC5jb20+DQo+IENjOiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsg
TWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+OyBSYWphbiBWYWphDQo+IDxSQUpBTlZA
eGlsaW54LmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgt
DQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBK
b2xseSBTaGFoDQo+IDxKT0xMWVNAeGlsaW54LmNvbT47IGNoaW5uaWtpc2hvcmUzNjlAZ21haWwu
Y29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgNi82XSBkdC1iaW5kaW5nczogZnBnYTogQWRk
IGJpbmRpbmdzIGZvciBaeW5xTVAgZnBnYQ0KPiBkcml2ZXINCj4gDQo+IE9uIFdlZCwgSmFuIDIz
LCAyMDE5IGF0IDI6NDYgUE0gTmF2YSBraXNob3JlIE1hbm5lIDxuYXZhbUB4aWxpbnguY29tPg0K
PiB3cm90ZToNCj4gPg0KPiA+IEhpIFJvYiwNCj4gPg0KPiA+DQo+ID4NCj4gPiBUaGFua3MgZm9y
IHByb3ZpZGluZyB0aGUgY29tbWVudHMuLi4NCj4gDQo+IFBsZWFzZSBmaXggeW91ciBtYWlsZXIg
dG8gc2VuZCBwbGFpbiB0ZXh0IGVtYWlscyB0byBtYWlsIGxpc3RzLg0KPiANClRoYW5rcyBmb3Ig
cG9pbnRpbmcgaXQuLg0KDQo+IA0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
Pg0KPiA+ID4gRnJvbTogUm9iIEhlcnJpbmcgW21haWx0bzpyb2JoQGtlcm5lbC5vcmddDQo+ID4N
Cj4gPiA+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAyMSwgMjAxOSA5OjE5IFBNDQo+ID4NCj4gPiA+
IFRvOiBOYXZhIGtpc2hvcmUgTWFubmUgPG5hdmFtQHhpbGlueC5jb20+DQo+ID4NCj4gPiA+IENj
OiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+
OyBSYWphbg0KPiA+ID4gVmFqYQ0KPiA+DQo+ID4gPiA8UkFKQU5WQHhpbGlueC5jb20+OyBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiA+DQo+ID4gPiBrZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgSm9sbHkgU2hh
aA0KPiA+DQo+ID4gPiA8Sk9MTFlTQHhpbGlueC5jb20+OyBjaGlubmlraXNob3JlMzY5QGdtYWls
LmNvbQ0KPiA+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDYvNl0gZHQtYmluZGluZ3M6
IGZwZ2E6IEFkZCBiaW5kaW5ncyBmb3INCj4gPiA+IFp5bnFNUCBmcGdhDQo+ID4NCj4gPiA+IGRy
aXZlcg0KPiA+DQo+ID4gPg0KPiA+DQo+ID4gPiBPbiBNb24sIEphbiAyMSwgMjAxOSBhdCAxMTow
ODozNVBNICswNTMwLCBOYXZhIGtpc2hvcmUgTWFubmUgd3JvdGU6DQo+ID4NCj4gPiA+ID4gQWRk
IGRvY3VtZW50YXRpb24gdG8gZGVzY3JpYmUgWGlsaW54IFp5bnFNUCBmcGdhIGRyaXZlciBiaW5k
aW5ncy4NCj4gPg0KPiA+ID4gPg0KPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE5hdmEga2lz
aG9yZSBNYW5uZSA8bmF2YS5tYW5uZUB4aWxpbnguY29tPg0KPiA+DQo+ID4gPiA+IC0tLQ0KPiA+
DQo+ID4gPiA+IENoYW5nZXMgZm9yIHYzOg0KPiA+DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgIC1SZW1vdmVkIFBDQVAgYXMgYSBjaGlsZCBub2RlIHRvIHRoZSBGVw0KPiA+ID4gPiBh
bmQgQ3JlYXRlZA0KPiA+DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGFuIGluZGVw
ZW5kZW50IG5vZGUgc2luY2UgUENBUCBkcml2ZXIgaXMgYQ0KPiA+ID4gPiBjb25zdW1lcg0KPiA+
DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIG5vdCBhIHByb3ZpZGVyLg0KPiA+DQo+
ID4gPiA+DQo+ID4NCj4gPiA+ID4gIC4uLi9iaW5kaW5ncy9mcGdhL3hsbngsenlucW1wLXBjYXAt
ZnBnYS50eHQgICAgICAgICB8IDEzICsrKysrKysrKysrKysNCj4gPg0KPiA+ID4gPiAgMSBmaWxl
IGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykNCj4gPg0KPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0DQo+ID4NCj4gPiA+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2Ev
eGxueCx6eW5xbXAtcGNhcC1mcGdhLnR4dA0KPiA+DQo+ID4gPiA+DQo+ID4NCj4gPiA+ID4gZGlm
ZiAtLWdpdA0KPiA+DQo+ID4gPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2ZwZ2EveGxueCx6eW5xbXAtcGNhcC1mcGdhLnR4dA0KPiA+DQo+ID4gPiA+IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2EveGxueCx6eW5xbXAtcGNhcC1mcGdhLnR4dA0K
PiA+DQo+ID4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4NCj4gPiA+ID4gaW5kZXggMDAw
MDAwMDAwMDAwLi4xZjZmNTg4NzIzMTENCj4gPg0KPiA+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4N
Cj4gPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2EveGxu
eCx6eW5xbXAtcGNhcC1mcGdhDQo+ID4gPiA+ICsrKyAudHh0DQo+ID4NCj4gPiA+ID4gQEAgLTAs
MCArMSwxMyBAQA0KPiA+DQo+ID4gPiA+ICtEZXZpY2UgVHJlZSB6eW5xbXAtZnBnYSBiaW5kaW5n
cyBmb3IgdGhlIFp5bnEgVWx0cmFzY2FsZSsgTVBTb0MNCj4gPg0KPiA+ID4gPiArY29udHJvbGxl
ZCB1c2luZyBaeW5xTVAgU29DIGZpcm13YXJlIGludGVyZmFjZSBGb3IgQml0c3RyZWFtDQo+ID4N
Cj4gPiA+ID4gK2NvbmZpZ3VyYXRpb24gb24gWnlucU1wIFNvYyB1c2VzIHByb2Nlc3NvciBjb25m
aWd1cmF0aW9uDQo+ID4NCj4gPiA+ID4gK3BvcnQoUENBUCkgdG8gY29uZmlndXJlIHRoZSBwcm9n
cmFtbWFibGUgbG9naWMoUEwpIHRocm91Z2ggUFMgYnkNCj4gPg0KPiA+ID4gPiArdXNpbmcgRlcg
aW50ZXJmYWNlLg0KPiA+DQo+ID4gPiA+ICsNCj4gPg0KPiA+ID4gPiArUmVxdWlyZWQgcHJvcGVy
dGllczoNCj4gPg0KPiA+ID4gPiArLSBjb21wYXRpYmxlOiBzaG91bGQgY29udGFpbiAieGxueCx6
eW5xbXAtcGNhcC1mcGdhIg0KPiA+DQo+ID4gPiA+ICsNCj4gPg0KPiA+ID4gPiArRXhhbXBsZToN
Cj4gPg0KPiA+ID4gPiArICAgICAgenlucW1wX3BjYXA6IHBjYXAgew0KPiA+DQo+ID4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gInhsbngsenlucW1wLXBjYXAtZnBnYSI7
DQo+ID4NCj4gPiA+ID4gKyAgICAgIH07DQo+ID4NCj4gPiA+DQo+ID4NCj4gPiA+IFRoZXJlJ3Mg
bm8gbmVlZCBmb3IgYSBEVCBub2RlLiBKdXN0IG1ha2UgdGhlIGZpcndhcmUgZHJpdmVyIGNyZWF0
ZSBhDQo+ID4gPiBwbGF0Zm9ybQ0KPiA+DQo+ID4gPiBkZXZpY2UgZm9yIHBjYXAuDQo+ID4NCj4g
PiA+DQo+ID4NCj4gPg0KPiA+DQo+ID4gVGhpcyBkcml2ZXIgYmVpbmcgdXNlZCBieSB0aGUgRlBH
QSBtYW5hZ2VyIGZyYW1ld29yayhmcGdhLXJlZ2lvbikgdG8gYXBwbHkNCj4gb3ZlcmxheSdzIHNv
IHRoaXMgbm9kZSBpcyBuZWVkZWQgQUZBSUsuDQo+IA0KPiBUaGUgYmluZGluZyBzYXlzIG5vdGhp
bmcgYWJvdXQgY2hpbGQgbm9kZXMgYW5kIHdoYXQgdGhleSBhcmUuIFBsZWFzZSBkZWZpbmUNCj4g
dGhhdC4NCj4NCkRvIHlvdSBtZWFuIEkgbmVlZCB0byBhZGQgdGhlIGV4YW1wbGUgdXNhZ2Ugb2Yg
dGhlIHBjYXAgbm9kZSBsaWtlIGFzIGJlbG93IGluIHRoZSBiaW5kaW5nIGRvYz8NCg0KRGV2aWNl
IFRyZWUgRXhhbXBsZSBmb3IgRnVsbCBSZWNvbmZpZ3VyYXRpb24NCj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09DQoNCkxpdmUgRGV2aWNlIFRyZWUgY29udGFpbnM6
DQoNCiAgICAgICAgenlucW1wX3BjYXA6IHBjYXAgew0KICAgICAgICAgICAgICAgIGNvbXBhdGli
bGUgPSAieGxueCx6eW5xbXAtcGNhcC1mcGdhIjsNCiAgICAgICAgfTsNCg0KICAgICAgICBmcGdh
X3JlZ2lvbjA6IGZwZ2EtcmVnaW9uMCB7DQogICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJm
cGdhLXJlZ2lvbiI7DQogICAgICAgICAgICAgICAgZnBnYS1tZ3IgPSA8Jnp5bnFtcF9wY2FwPjsN
CiAgICAgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwweDE+Ow0KICAgICAgICAgICAgICAg
ICNzaXplLWNlbGxzID0gPDB4MT47DQogICAgICAgICAgICAgICAgcmFuZ2VzOw0KICAgICAgICB9
Ow0KDQpEVCBPdmVybGF5IGNvbnRhaW5zOg0KL2R0cy12MS8gL3BsdWdpbi87DQovIHsNCmZyYWdt
ZW50QDAgew0KICAgICAgICB0YXJnZXQgPSA8JmZwZ2FfcmVnaW9uMD47DQogICAgICAgICNhZGRy
ZXNzLWNlbGxzID0gPDE+Ow0KICAgICAgICAjc2l6ZS1jZWxscyA9IDwxPjsNCiAgICAgICAgX19v
dmVybGF5X18gew0KICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KICAgICAg
ICAgICAgICAgICNzaXplLWNlbGxzID0gPDE+Ow0KDQogICAgICAgICAgICAgICAgZmlybXdhcmUt
bmFtZSA9ICJ6eW5xbXAtZ3Bpby5iaW4iOw0KDQogICAgICAgICAgICAgICAgZ3BpbzE6IGdwaW9A
NDAwMDAwMDAgew0KICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJ4bG54LHhw
cy1ncGlvLTEuMDAuYSI7DQogICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHg0MDAwMDAw
MCAweDEwMDAwPjsNCiAgICAgICAgICAgICAgICAgICAgICAgIGdwaW8tY29udHJvbGxlcjsNCiAg
ICAgICAgICAgICAgICAgICAgICAgICNncGlvLWNlbGxzID0gPDB4Mj47DQogICAgICAgICAgICAg
ICAgICAgICAgICB4bG54LGdwaW8td2lkdGg9IDwweDY+Ow0KICAgICAgICAgICAgICAgIH07DQog
ICAgICAgIH07DQp9Ow0KIA0KUGxlYXNlIGNvcnJlY3QgbWUgaWYgbXkgdW5kZXJzdGFuZGluZyBp
cyB3cm9uZy4NCg0KUmVnYXJkcywNCk5hdmFraXNob3JlLg0K
