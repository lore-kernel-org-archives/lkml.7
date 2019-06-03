Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99976C28CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6939F27606
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="W1xxz90G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfFCI3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:29:06 -0400
Received: from mail-eopbgr1410135.outbound.protection.outlook.com ([40.107.141.135]:48594
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbfFCI3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MShOU7pT+Jq70LuMCGd6y31UVrBU9aihjHLIb3msv48=;
 b=W1xxz90GdH+E3tJ09IrvKFeZeviZbB99y41ygBwlee2UVXiwmuveZRQH+t9w6v31XKLkzKW7MsRSOAv1+MqxAm8VsWE6e6y8WWJ2s6AEzsE7YvYS87eqbZ664XJ3JJdtyavKFBiTjHyywlV7IwLxugUhbpbhUVriSWc5/Y+QtoA=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.160.138) by
 TY1PR01MB1753.jpnprd01.prod.outlook.com (52.133.160.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Mon, 3 Jun 2019 08:29:02 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::14c:9d37:bcf0:1752]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::14c:9d37:bcf0:1752%3]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 08:29:02 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Gareth Williams <gareth.williams.jx@renesas.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] dt-bindings: clock: renesas,r9a06g032-sysctrl:
 Document power Domains
Thread-Topic: [PATCH v3 1/2] dt-bindings: clock: renesas,r9a06g032-sysctrl:
 Document power Domains
Thread-Index: AQHVEkXZL3OHYFrWsEu2221+eWtk7qaAKXeAgAl4K4A=
Date:   Mon, 3 Jun 2019 08:29:01 +0000
Message-ID: <TY1PR01MB1769FB150E0258A8AC76CDB5F5140@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1558711904-27278-1-git-send-email-gareth.williams.jx@renesas.com>
 <1558711904-27278-2-git-send-email-gareth.williams.jx@renesas.com>
 <CAMuHMdV2jmY2u1-Z6cRR1OQcfW8U0HM_ac-xn1gO9nPf41iD+A@mail.gmail.com>
In-Reply-To: <CAMuHMdV2jmY2u1-Z6cRR1OQcfW8U0HM_ac-xn1gO9nPf41iD+A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7797cb6-4786-43c1-70a9-08d6e7fd88a1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TY1PR01MB1753;
x-ms-traffictypediagnostic: TY1PR01MB1753:
x-microsoft-antispam-prvs: <TY1PR01MB17531FCA4D7C70087B66F586F5140@TY1PR01MB1753.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(346002)(376002)(396003)(39860400002)(136003)(189003)(199004)(8936002)(26005)(110136005)(8676002)(81156014)(81166006)(6436002)(316002)(305945005)(229853002)(14444005)(186003)(54906003)(68736007)(86362001)(256004)(14454004)(99286004)(102836004)(53546011)(6506007)(7736002)(5660300002)(7696005)(6116002)(3846002)(76176011)(52536014)(71190400001)(55016002)(4326008)(71200400001)(9686003)(6636002)(6246003)(74316002)(53936002)(66066001)(478600001)(476003)(486006)(66556008)(66476007)(33656002)(446003)(11346002)(73956011)(2906002)(44832011)(66946007)(25786009)(64756008)(66446008)(76116006)(142933001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1753;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jE1oHoHPt4PgI6djFLRRm5XkKP6Unw6Hxtdfi3/Wj4qIadg93Fu0DsGjdzGK45jf9OmBKojB0TiwmV29nSCzKDnrzNDlHVHsP3/FPOFVv1l7j55aJ35kEAeRbJ2GDSowNXLiEAFvHy0/HJis//dmHXBNPKRIp5sltQQdQ57u0woWu/+co0LHAIc5kHFlcF6s2b8Kc8uGGo+dB/aaFm7SW0Ggb2xyD1KrJfs/ahjBThrBlYfkvjIbK2GL6Yph4NX2+rkK250kGTMi61A/Qz8DTyhg1eGpQHQR+j1aVpIuDO/gLHuWmxy8oh8UtlN0KKDK3AlqqRU9EIVWAYq9Ub7l89Pc57Q+IergerOyM/9S1ty98O/J5/+rvazr4i4Z+wlHyE8mHw+40XAlIILE5mlghrTalSp1qqDuIevUfGkzcrY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7797cb6-4786-43c1-70a9-08d6e7fd88a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 08:29:02.2578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: phil.edworthy@renesas.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1753
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIDI4IE1heSAyMDE5IDA4OjI5IEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90
ZToNCj4gT24gRnJpLCBNYXkgMjQsIDIwMTkgYXQgNTozMiBQTSBHYXJldGggV2lsbGlhbXMgd3Jv
dGU6DQo+ID4gVGhlIGRyaXZlciBpcyBnYWluaW5nIHBvd2VyIGRvbWFpbiBzdXBwb3J0LCBzbyBh
ZGQgdGhlIG5ldyBwcm9wZXJ0eSB0bw0KPiA+IHRoZSBEVCBiaW5kaW5nIGFuZCB1cGRhdGUgdGhl
IGV4YW1wbGVzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogR2FyZXRoIFdpbGxpYW1zIDxnYXJl
dGgud2lsbGlhbXMuanhAcmVuZXNhcy5jb20+DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2gh
DQo+IA0KPiA+IC0tLQ0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Ns
b2NrL3JlbmVzYXMscjlhMDZnMDMyLXN5c2N0cmwudHgNCj4gPiB0DQo+ID4gKysrIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL3JlbmVzYXMscjlhMDZnMDMyLQ0KPiBz
eXNjdHINCj4gPiArKysgbC50eHQNCj4gQEAgLTQwLDQgKzQyLDUgQEAgRXhhbXBsZXMNCj4gPiAg
ICAgICAgICAgICAgICAgcmVnLWlvLXdpZHRoID0gPDQ+Ow0KPiA+ICAgICAgICAgICAgICAgICBj
bG9ja3MgPSA8JnN5c2N0cmwgUjlBMDZHMDMyX0NMS19VQVJUMD47DQo+ID4gICAgICAgICAgICAg
ICAgIGNsb2NrLW5hbWVzID0gImJhdWRjbGsiOw0KPiA+ICsgICAgICAgICAgICAgICBwb3dlci1k
b21haW5zID0gPCZzeXNjdHJsPjsNCj4gDQo+IFRoaXMgaXMgYW4gaW50ZXJlc3RpbmcgZXhhbXBs
ZTogYWNjb3JkaW5nIHRvIHRoZSBkcml2ZXIsDQo+IFI5QTA2RzAzMl9DTEtfVUFSVDAsIGlzIG5v
dCBjbG9jayB1c2VkIGZvciBwb3dlciBtYW5hZ2VtZW50Pw0KPiANCj4gT2gsIHRoZSByZWFsIHVh
cnQwIG5vZGUgaW4gYXJjaC9hcm0vYm9vdC9kdHMvcjlhMDZnMDMyLmR0c2kgdXNlcw0KPiANCj4g
ICAgIGNsb2NrcyA9IDwmc3lzY3RybCBSOUEwNkcwMzJfQ0xLX1VBUlQwPiwgPCZzeXNjdHJsDQo+
IFI5QTA2RzAzMl9IQ0xLX1VBUlQwPjsNCj4gICAgIGNsb2NrLW5hbWVzID0gImJhdWRjbGsiLCAi
YXBiX3BjbGsiOw0KPiANCj4gVGhhdCBkb2VzIG1ha2Ugc2Vuc2UuLi4NCk5vdGUgdGhhdCB0aGUg
U3lub3BzeXMgRFcgdWFydCBkcml2ZXIgYWxyZWFkeSBnZXRzIHRoZSAiYXBiX3BjbGsiIGNsb2Nr
LCBzbw0Kd2UgZG9u4oCZdCBhY3R1YWxseSBuZWVkIHRvIHVzZSBjbG9jayBkb21haW5zIHRvIGVu
YWJsZSB0aGlzIGNsb2NrLg0KDQpUaGlzIGlzIGFsc28gdHJ1ZSBmb3IgbWFueSBvZiB0aGUgcGVy
aXBoZXJhbCBkcml2ZXJzIHVzZWQgb24gcnpuMSAoU3lub3BzeXMNCmdwaW8gY29udHJvbGxlciwg
aTJjIGNvbnRyb2xsZXIsIGdtYWMsIGRtYWMsIEFyYXNhbiBzZGlvIGNvbnRyb2xsZXIpLiBUaGUN
CmNvbW1pdCB0byBhZGQgdGhpcyBjbG9jayB0byB0aGUgaTJjIGNvbnRyb2xsZXIgZHJpdmVyIGlz
IG15IGZhdWx0LCBhcyBJIHdhcw0KZm9sbG93aW5nIHRoZSBwYXR0ZXJuIG9mIHRoZSBvdGhlcnMu
DQoNCk9mIHRoZSBmZXcgZHJpdmVycyB0aGF0IGRvbid0IGFscmVhZHkgZ2V0IHRoZSBoY2xrL3Bj
bGsgdXNlZCB0byBhY2Nlc3MgdGhlDQpwZXJpcGhlcmFscyBpcyB0aGUgU3lub3BzeXMgc3BpIGNv
bnRyb2xsZXIgKHRob3VnaCB0aGF0IGN1cnJlbnRseSBkb2VzbuKAmXQNCnN1cHBvcnQgcnVudGlt
ZSBQTSkgYW5kIHRoZSBVU0IgSG9zdCBjb250cm9sbGVyLg0KDQpCUg0KUGhpbA0KIA0KPiBXaXRo
IHRoZSBhYm92ZSBmaXhlZDoNCj4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2Vl
cnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVy
aG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51
eC0NCj4gbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNo
bmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQNCj4gd2hlbiBJJ20gdGFs
a2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcg
bGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRv
cnZhbGRzDQo=
