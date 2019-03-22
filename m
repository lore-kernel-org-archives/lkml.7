Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C07C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B984C218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="WKIWKfId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfCVKvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:51:17 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.2]:23758 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726667AbfCVKvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:51:17 -0400
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-west-1.aws.symcld.net id 51/46-18573-B1EB49C5; Fri, 22 Mar 2019 10:51:07 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTbUxTVxjHe+5LezGUHEpdHxsxscmIMlsp03i
  dUfl4k8WoX4whbHiRu7amFNJbAmyJomYzooIZRbFacMjUFQWtBoGIL1UTMQgbUhEyZjs6ERQl
  0mSZrrLeXnzZt//z/H/neTk5hyE1B1V6Rih3CU4Hbzco51HW5YqVRv01d17WX77P2NMDdxDbP
  xog2cbbfTQbDm5kfXWdFBvyDhOsf+whzVa9/oVkH3SdULI/D/1GsLMzEZr9vvu2io1d8VPs08
  u6nBTuXMM5xHV6RlWc37dfyV1q3sV1dswQ3MUXHQRXE8viZvyLuInYNLkpKZe2OQqKy7fR1q6
  Xw1TJPl15T/VhZSUKfVKF5jEUbiNh6J+IUgo0+EcCHk9Ok3IwiuD8wRBVhZIYJTZDw/OXSDK0
  uAfBT63tiSMkvkfCg+o3SKLS8CY4++Rt4oQWb4a7sUYk6zLoaZEZCn8K47faVJJW468gdv04k
  tsdoSHaOZCAkvBaiDbfSEAIp0N0dwspaRLrYCTSSEgaMIbmq/2krOfDxNhbWubzYd/1KZWcXw
  b3hyJI1gY4/chDyzodBhoPzOU3wMWm9sTOgEcQ9I1cm4My4VHtYHxNJq7tUD24TU4vhD036+e
  QVzTsHkzMo8HbYdp7f67vIvAdClNyzV9JmPl7Akl1SLwU2rqWy7ssBveBsOowWuL5aDXPB8rz
  EeVJXFcq9ByLUCcR5UNsgdNmsbqKeJvdaM7KMprN2Ubz6hXG7OyVJv5bI28SSo1lgugymk18m
  WgSK4q22wtNDsHlR/E3WVgSCHegvjOWAFrAEIb56obL7jxNSkFxYYWVF635zlK7IAbQQoYxgN
  pyNe6lOgWLUP6NzR5/2O9sYJINWrVCstViCV8k2iyydQ99ztxoCntJZurmuJfUUI5ih6DXqWs
  kFEuotdTxvtC7TzKA0vVpaqRQKDTJJYKzyOb6vz+JdAwypKkvSFWSbQ7X+36T8VGI+CgF7lpp
  FBf/wdJXIsKhXdvaP9ukTd3a0R6qqOG7xg/VOU9171y15lkwJKSltw739mbvbTuas/679Rruz
  +7eN/rMjH+3rFkdCT90/ZBB1xamzLor2ejxenvGVLAsWFmX5/062EK8GvmjPrfvy+f2gGLsyD
  pqw47fLxw788W6s9EdJ4u3Tvt9V17niPlT+w2UaOXNmaRT5P8DtLmyAx8EAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-4.tower-262.messagelabs.com!1553251865!3717327!1
X-Originating-IP: [104.47.0.53]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6722 invoked from network); 22 Mar 2019 10:51:06 -0000
Received: from mail-he1eur01lp2053.outbound.protection.outlook.com (HELO EUR01-HE1-obe.outbound.protection.outlook.com) (104.47.0.53)
  by server-4.tower-262.messagelabs.com with AES256-SHA256 encrypted SMTP; 22 Mar 2019 10:51:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BxtLsi2vcpGzVZwhYVFvAz65vQBxbCu9dE24I43Fic=;
 b=WKIWKfIdUCGFFM8iXjWNnzMCgJg4VS6+SM/AZFmsiQ9VMdNSc/N8+TgiYCfiaJnaNX2uhevbKX4obIEzhpyxSq09E6Zr9GFwgrvP6fkt/684Rgp3EHoD7VXcqgzQ0u97sfmmD5UW9PSLgV8gwmWqCAzvZSAZrTOeYL01i9uPu7Q=
Received: from DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM (20.177.121.154) by
 DB7PR10MB2428.EURPRD10.PROD.OUTLOOK.COM (20.177.121.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Fri, 22 Mar 2019 10:50:56 +0000
Received: from DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f8d2:d5b6:cca:1bcf]) by DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f8d2:d5b6:cca:1bcf%5]) with mapi id 15.20.1730.017; Fri, 22 Mar 2019
 10:50:56 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        =?utf-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     Andrew Lunn <andrew@lunn.ch>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-ARM-KERNEL <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH] ARM: dts: imx6qdl-sabresd: change phy-mode to use
 rgmii-id
Thread-Topic: [PATCH] ARM: dts: imx6qdl-sabresd: change phy-mode to use
 rgmii-id
Thread-Index: AQHU3xVPNB22JzULbU6dt2e6ipsQ4KYUb2uAgAARkNCAAD7fAIABBhKAgAArH4CAAOlGAIAADYMAgAAENgCAAAJzAIAAhSkAgAAEzOA=
Date:   Fri, 22 Mar 2019 10:50:56 +0000
Message-ID: <DB7PR10MB2348358D285E2560F5B5E699FE430@DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM>
References: <20190320120604.7D99B3FBE9@swsrvapps-01.diasemi.com>
 <CAOMZO5AHzQJzz3vd5MzYgSSxzPjU9xan1dFh9473BXeiRCOzzg@mail.gmail.com>
 <VI1PR10MB2352C3A55BE8FABAF3B02681FE410@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <CAOMZO5By8=j7gZRAdf2-h-5ak-Qo34rqwDL4+HA_97cMXTAnEQ@mail.gmail.com>
 <20190321084240.fveqkhfrbtg7qr4q@fsr-ub1664-175>
 <CAOMZO5Cz0A19P9E61dy79BFF+V2WsAjobqQ1g9TeiJSCY2Nt4A@mail.gmail.com>
 <20190322011155.GO12513@dragon>
 <CAOMZO5CBjG_xZWjZof_VOKaLLOCxFz3g7Gz1uTVzD=D5GeQb4g@mail.gmail.com>
 <20190322021521.GY12513@dragon>
 <CAOMZO5CRRg9XD9VovcO5+fdM1DBp12P33T9xgW=cEvTES8yDPA@mail.gmail.com>
 <db0a3a96-d836-f7bd-4773-81fcb7984835@ysoft.com>
In-Reply-To: <db0a3a96-d836-f7bd-4773-81fcb7984835@ysoft.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad3cc648-68eb-48ff-cc86-08d6aeb4433c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DB7PR10MB2428;
x-ms-traffictypediagnostic: DB7PR10MB2428:
x-microsoft-antispam-prvs: <DB7PR10MB24280421D2F33AD18E0933E9F5430@DB7PR10MB2428.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(106356001)(186003)(81166006)(316002)(8676002)(105586002)(68736007)(14454004)(52536014)(71190400001)(3846002)(54906003)(110136005)(71200400001)(53936002)(2906002)(102836004)(26005)(6506007)(66066001)(76176011)(97736004)(5660300002)(107886003)(7696005)(53546011)(81156014)(6246003)(446003)(99286004)(476003)(7736002)(6436002)(229853002)(8936002)(256004)(305945005)(6116002)(4326008)(25786009)(9686003)(55016002)(74316002)(86362001)(93886005)(478600001)(7416002)(33656002)(486006)(11346002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR10MB2428;H:DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 72r0R9Llcnlc2smxZ6yzM8FfCIKFfnDFEE5p0vXV9xIJ+EGBoTKunwV+pa0JyBHyT296oZhOnoffZRo4PeteJQtQYxXWukXdu/Qeui+99QhrK1+GBkpPtBVglAueQqwmo5i8zVSFPwqvi7gdQNqCL3WWugajWSc5tHiP2uEa9A/ub4DtIvTthxIhw3Dp4+KYZRGFR8W7Jwo6n1IZ+vOrxWiK0nG9Wus8IHvAZDkAQSDOw8FCJJU5D1tRybM4BL8JN64OfFhOMQiZOOaEabEckAX9tao3scD8VuM7HfBK0XSnaOM/Y66qHOjigSBywCUy8Zot57YK18zVjaFjR+Q9OTTnJEiEO8ux4GpoYI9e1jYvKT4QKEDhH0HsYMVqvW/XQERu3o//S6BFx2hfj+ZNb5LriT7JENjq5ECUej5zQLU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3cc648-68eb-48ff-cc86-08d6aeb4433c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 10:50:56.2956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2428
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVyZSBhcmUgbXkgdGhvdWdodHMuIA0KDQpPbiAyMiBNYXJjaCAyMDE5IDEwOjIxLCBNaWNoYWwg
Vm9rw6HEjSB3cm90ZToNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBBUk06IGR0czogaW14NnFk
bC1zYWJyZXNkOiBjaGFuZ2UgcGh5LW1vZGUgdG8gdXNlIHJnbWlpLWlkDQo+IA0KPiBPbiAyMi4g
MDMuIDE5IDM6MjQsIEZhYmlvIEVzdGV2YW0gd3JvdGU6DQo+ID4gT24gVGh1LCBNYXIgMjEsIDIw
MTkgYXQgMTE6MTUgUE0gU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPiB3cm90ZToNCj4g
Pg0KPiA+Pj4gVW5mb3J0dW5hdGVseSwganVzdCBieSBsb29raW5nIGF0IHRoZSBkdHMgZmlsZXMg
d2UgZG8gbm90IGtub3cgaWYgYQ0KPiA+Pj4gYm9hcmQgdXNlcyBhbiBBUjgwM3ggUEhZIG9yIG5v
dCwgc28gSSBhbSBhZnJhaWQgd2UgY2FuIG5vdCBkbyBhbg0KPiA+Pj4gYXV0b21hdGljIGNvbnZl
cnNpb24uDQo+ID4+DQo+ID4+IEF0IGxlYXN0IGZvciB0aG9zZSB3ZSBhbHJlYWR5IGtub3c/DQo+
ID4NCj4gPiBZZXMsIEkgY2FuIGhlbHAgcHJlcGFyaW5nIGEgcGF0Y2ggdGhhdCBmaXhlcyB0aGUg
aS5NWCBib2FyZHMgd2Uga25vdw0KPiA+IHVzZSBBUjgwMzEgUEhZLg0KPiANCj4gQUZBQ1QgdGhp
cyBpc3N1ZSBpcyBub3QgQVI4MDN4IHNwZWNpZmljLiBJIHdhcyBoaXQgYnkgdGhlIHNhbWUgcHJv
YmxlbQ0KPiB3aXRoIFFDQTgzM3ggc3dpdGNoIG9uIGlteDZkbC15YXBwNC4gVGhvdWdoLCB3ZSBh
cmUgY3VycmVudGx5IHRoZSBvbmx5DQo+IHBsYXRmb3JtIGluIHRyZWUgdXNpbmcgdGhpcyBjaGlw
IGFuZCBTaGF3biBhbHJlYWR5IGhhcyB0aGUgZml4IGluIGhpcyB0cmVlLg0KPiANCj4gSSBhbSBu
b3QgYXdhcmUgb2YgYW55IG90aGVyIFBIWSBkcml2ZXJzIHRoYXQgbXkgY2F1c2UgcHJvYmxlbXMu
DQo+IA0KPiAkIGdpdCBsb2cgLS1vbmVsaW5lIHY1LjAuLnY1LjEtcmMxIC0tZ3JlcD1SR01JSSAt
LWF1dGhvcj1WaW5vZCAtLSBkcml2ZXJzL25ldC8NCj4gNmQ0Y2QwNDFmMGFmIG5ldDogcGh5OiBh
dDgwM3g6IGRpc2FibGUgZGVsYXkgb25seSBmb3IgUkdNSUkgbW9kZQ0KPiBhOTY4YjVlOWQ1ODcg
bmV0OiBkc2E6IHFjYThrOiBFbmFibGUgZGVsYXkgZm9yIFJHTUlJX0lEIG1vZGUNCj4gNWVjZGQ3
N2M2MWM4IG5ldDogZHNhOiBxY2E4azogZGlzYWJsZSBkZWxheSBmb3IgUkdNSUkgbW9kZQ0KPiBj
ZDI4ZDFkNmU1MmUgbmV0OiBwaHk6IGF0ODAzeDogRGlzYWJsZSBwaHkgZGVsYXkgZm9yIFJHTUlJ
IG1vZGUNCg0KSWYgdGhpcyBpcyBtb3JlIHdpZGVzcHJlYWQsIGFzIE1pY2hhbCBwb2ludHMgb3V0
LCB0aGlzIG1pZ2h0IGFmZmVjdCB0aGUgd2F5DQp0aGUgZml4IGlzIGFwcHJvYWNoIHRoZW4/DQoN
Ck9uIDIxIE1hcmNoIDIwMTkgMTI6NDMgTHVjYXMgU3RhY2ggd3JvdGU6DQoNCj4gPiBTbyB5ZXMs
IHdlIGN1cnJlbnRseSBoYXZlIGxvdHMgb2YgYnJva2VuIGR0YidzIGluIG1haW5saW5lIGFuZCBJ
IGFtDQo+ID4gd29uZGVyaW5nIHdoYXQgaXMgdGhlIHByb3BlciBmaXggaGVyZS4NClsuLi5dDQo+
IGJ1dCBpZiB0aGUgRFQgaXMgY2xlYXJseSBicm9rZW4gYW5kIGZpeGluZyBpdCBpbiBhIGJhY2t3
YXJkDQo+IGNvbXBhdGlibGUgd2F5IGlzIG5vdCByZWFsbHkgZmVhc2libGUsIEkgd291bGQgYXJn
dWUgdGhhdCB3ZSBzaG91bGQNCj4gdHJlYXQgYSBEVCBidWcgbGlrZSBhbnkgb3RoZXIgYnVnLg0K
DQpUaGVyZSBpcyBhIHdheSBvZiBkb2luZyB0aGlzIHRvIHByZXNlcnZlIGJhY2t3YXJkcyBjb21w
YXRpYmlsaXR5IEkgdGhpbmsuDQpNYXliZSBkZXByZWNhdGluZyB0aGUgcHJldmlvdXMgRFRTIHBo
eS1tb2RlIGFuZCByZXBsYWNpbmcgaXQgd2l0aCBhIG5ldyBvbmUsDQpwaHktbW9kZS12MiBpbnN0
ZWFkPw0KDQpBdCB0aGUgbW9tZW50LCB0aGVyZSBpcyBvbmx5IGEgd2VhayBsaW5rIGJldHdlZW4g
RFRTIGFuZCB0aGUgZHJpdmVyIGluIHRoZSBrZXJuZWwNCndoaWNoICBtYWtlcyBmaW5kaW5nIHRo
ZSBlcnJvciBkaWZmaWN1bHQuIEFsc28sIGl0IHNlZW1zIHRoYXQgcGFydGx5LCB0aGUgZGlyZWN0
aW9uIG9mDQpjaGFuZ2UgaXMgY2F1c2VkIGJ5IHNvZnR3YXJlIHdoaWNoIGlzIHB1c2hpbmcgYWx0
ZXJhdGlvbnMgaW4gdGhlIERUUyAtLSBhbmQgbm90IHRoZQ0Kb3RoZXIgd2F5IHJvdW5kLg0KDQpS
ZWdhcmRzLA0KU3RldmUNCg==
