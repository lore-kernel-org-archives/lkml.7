Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7F5C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1329E218BC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfGEKgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 06:36:16 -0400
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:40887 "EHLO
        m9a0002g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726116AbfGEKgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 06:36:16 -0400
X-Greylist: delayed 1291 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jul 2019 06:34:58 EDT
Received: FROM m9a0002g.houston.softwaregrp.com (15.121.0.190) BY m9a0002g.houston.softwaregrp.com WITH ESMTP;
 Fri,  5 Jul 2019 10:35:00 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 5 Jul 2019 10:13:19 +0000
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (15.124.72.12) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 5 Jul 2019 10:13:19 +0000
Received: from CY4PR1801MB1909.namprd18.prod.outlook.com (10.171.255.24) by
 CY4PR1801MB1813.namprd18.prod.outlook.com (10.165.88.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Fri, 5 Jul 2019 10:13:17 +0000
Received: from CY4PR1801MB1909.namprd18.prod.outlook.com
 ([fe80::1d84:4a66:a3f4:97f8]) by CY4PR1801MB1909.namprd18.prod.outlook.com
 ([fe80::1d84:4a66:a3f4:97f8%3]) with mapi id 15.20.2032.022; Fri, 5 Jul 2019
 10:13:17 +0000
From:   Matthias Brugger <mbrugger@suse.com>
To:     CK Hu <ck.hu@mediatek.com>, Ulrich Hecht <uli@fpond.eu>
CC:     Mark Rutland <mark.rutland@arm.com>,
        MichaelTurquette <mturquette@baylibre.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ulrich Hecht <ulrich.hecht+renesas@gmail.com>,
        LaurentPinchart <laurent.pinchart@ideasonboard.com>,
        RandyDunlap <rdunlap@infradead.org>,
        "matthias.bgg@kernel.org" <matthias.bgg@kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/FREESCALE IMX /MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 08/12] dt-bindings: mediatek: Change the binding for
 mmsys clocks
Thread-Topic: [PATCH v5 08/12] dt-bindings: mediatek: Change the binding for
 mmsys clocks
Thread-Index: AQHVL8EGuRsY17jXTEOvyv41Lq4Xp6a6MMOsgABrtViAAKf5pIAAkIgA
Date:   Fri, 5 Jul 2019 10:13:17 +0000
Message-ID: <acd26dd8-7933-7ef5-0ba2-be8a7aa5ef99@suse.com>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
 <20181116125449.23581-9-matthias.bgg@kernel.org>
 <20181116231522.GA18006@bogus>
 <2a23e407-4cd4-2e2b-97a5-4e2bb96846e0@gmail.com>
 <CAL_JsqKJQwfDJbpmwW+oCxiDkSp5+6mG-uoURmCQVEMP_jFOEg@mail.gmail.com>
 <154281878765.88331.10581984256202566195@swboyd.mtv.corp.google.com>
 <458178ac-c0fc-9671-7fc8-ed2d6f61424c@suse.com>
 <154356023767.88331.18401188808548429052@swboyd.mtv.corp.google.com>
 <a229bfc7-683f-5b0d-7b71-54f934de6214@suse.com>
 <1561953318.25914.9.camel@mtksdaap41>
 <84d1c444-d6cb-9537-1bf5-b4e736443239@gmail.com>
 <100944512.353257.1562254420397@webmail.strato.com>
 <1562290530.10428.6.camel@mtksdaap41>
In-Reply-To: <1562290530.10428.6.camel@mtksdaap41>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB6PR0501CA0041.eurprd05.prod.outlook.com
 (2603:10a6:4:67::27) To CY4PR1801MB1909.namprd18.prod.outlook.com
 (2603:10b6:910:7a::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mbrugger@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [95.169.228.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecaa8f01-9a45-4160-1306-08d7013165ed
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR1801MB1813;
x-ms-traffictypediagnostic: CY4PR1801MB1813:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <CY4PR1801MB18133416B6CA7541E8852069BAF50@CY4PR1801MB1813.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(189003)(199004)(229853002)(8936002)(25786009)(31696002)(4326008)(71200400001)(81166006)(8676002)(7416002)(31686004)(86362001)(102836004)(71190400001)(68736007)(3846002)(186003)(256004)(81156014)(6116002)(26005)(6306002)(305945005)(110136005)(6436002)(486006)(53936002)(386003)(6506007)(99286004)(76176011)(6512007)(53546011)(5660300002)(2906002)(52116002)(6246003)(966005)(66476007)(316002)(66946007)(73956011)(2616005)(14454004)(11346002)(476003)(446003)(7736002)(6486002)(54906003)(66066001)(66556008)(36756003)(478600001)(64756008)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1801MB1813;H:CY4PR1801MB1909.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LqON9FAWXUbVHrdbY/czW9gyOUR9u5Fw1xhw3HMa9TpqikbV0p1fbFzeDHA7UdRFSTzMVggvqKykqD7tBa6Zy9R2o165AuOgh8wXinChBf3wSdhYQkyWA4QHVdcGexJF9rAFIG1vUYPJSF1qZPhar9GU4K/nJzaKKtm47U+42yl68lRey7vPv/iaRxsKCbY/4huPDPQ2NHyd0cjP141yJceMKITMXsx5T1M7I5eOi7DlGF+w1x59Q8mo8m/13xb/RsL7DDX0WTIn2ALsZjZ4LIl80MSKoZfh1M0GbD1mjQsIwt47jNN6e8VvnuQBpvcr6aBLZh03L4mHYNHvl+c3tQADRakQsVaNMae0+XftpVA8TnuB7p1s1v4Tbi66qKoZ8XE4nZH8sFvFTqhr5/3LJ9TzaXFVbWeXJKfauQPOWds=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AF2F788BE05D147BD5CCEB781B442D7@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ecaa8f01-9a45-4160-1306-08d7013165ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 10:13:17.6512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mbrugger@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1801MB1813
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA1LzA3LzIwMTkgMDM6MzUsIENLIEh1IHdyb3RlOg0KPiBIaSwgVWxpOg0KPiANCj4g
T24gVGh1LCAyMDE5LTA3LTA0IGF0IDE3OjMzICswMjAwLCBVbHJpY2ggSGVjaHQgd3JvdGU6DQo+
Pj4gT24gSnVseSA0LCAyMDE5IGF0IDExOjA4IEFNIE1hdHRoaWFzIEJydWdnZXIgPG1hdHRoaWFz
LmJnZ0BnbWFpbC5jb20+IHdyb3RlOg0KPj4+IFlvdSBhcmUgcmlnaHQsIGl0IHRvb2sgZmFyIHRv
byBsb25nIGZvciBtZSB0byByZXNwb25kIHdpdGggYSBuZXcgdmVyc2lvbiBvZiB0aGUNCj4+PiBz
ZXJpZXMuIFRoZSBwcm9ibGVtIEkgZmFjZSBpcywgdGhhdCBJIHVzZSBteSBtdDgxNzMgYmFzZWQg
Y2hyb21lYm9vayBmb3INCj4+PiB0ZXN0aW5nLiBJdCBuZWVkcyBzb21lIGRvd25zdHJlYW0gcGF0
Y2hlcyBhbmQgYnJva2Ugc29tZXdoZXJlIGJldHdlZW4gbXkgbGFzdA0KPj4+IGVtYWlsIGFuZCBh
IGZldyBtb250aCBhZ28uDQo+Pg0KPj4gSWYgdGhhdCBDaHJvbWVib29rIGlzIGFuIEFjZXIgUjEz
IGFuZCB5b3UgbmVlZCBhIHdvcmtpbmcga2VybmVsLCB5b3UgbWF5IHdhbnQgdG8gaGF2ZSBhIGxv
b2sgYXQgaHR0cHM6Ly9naXRodWIuY29tL3VsaS9rZXJuZWwvdHJlZS9lbG0td29ya2luZy01LjIg
Lg0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHNhbXBsZSBjb2RlLCBhbmQgeW91ciBpbXBsZW1lbnRh
dGlvbiBpcyBkaWZmZXJlbnQgdGhhbg0KPiBNYXR0aGlhcycgdmVyc2lvbi4gSW4geW91ciB2ZXJz
aW9uLCBtbXN5cyBpcyBhIHNpbmdsZSBkZXZpY2Ugd2hpY2ggaGFzDQo+IGNsb2NrIGZ1bmN0aW9u
IGFuZCBkaXNwbGF5IGZ1bmN0aW9uLCB0aGUgY2xvY2sgZnVuY3Rpb24gaXMgcGxhY2VkIGluDQo+
IGNsb2NrIGRyaXZlciBmb2xkZXIgYW5kIGRpc3BsYXkgZnVuY3Rpb24gaXMgcGxhY2VkIGluIGRy
bSBkcml2ZXIgZm9sZGVyLg0KPiBJbiBNYXR0aGlhcycgdmVyc2lvbiwgY2xvY2sgZnVuY3Rpb24g
aXMgYSBzdWIgZGV2aWNlIG9mIG1tc3lzLiBJJ3ZlIG5vDQo+IGlkZWEgb2Ygd2hpY2ggb25lIGlz
IGJldHRlci4gSSB3b3VsZCBnZXQgbW9yZSBpbmZvcm1hdGlvbiB0byBtYWtlIGJldHRlcg0KPiBk
ZWNpc2lvbi4NCj4gDQoNCkZyb20gdGhlIGRpc2N1c3Npb24gd2UgaGFkIGhlcmUgYW5kIHRoZSBs
YXN0IGNvbW1lbnRzIGZyb20gU3RlcGhlbiBJIHRoaW4gd2hhdA0Kd2Ugc2hvdWxkIGRvIGlzOg0K
LSBjcmVhdGUgYSBwbGF0Zm9ybSBkcml2ZXIgZm9yIHRoZSBtbXN5cyBjbG9jayBwYXJ0LCBpbiB0
aGUgZHJpdmVycy9jbGsvbWVkaWF0ZWsvLi4uDQotIHRoZSBEUk0gZHJpdmVyIGNyZWF0ZXMgYSBw
bGF0Zm9ybSBkZXZpY2Ugd2hpY2ggd2lsbCBwcm9iZSB0aGUgY2xvY2sgZHJpdmVyLg0KDQpUaGlz
IHdheSB5b3Ugd29uJ3QgbmVlZCB0byBjaGFuZ2UgYW55IGNvbXBhdGlibGUuDQoNCllvdSB3aWxs
IGhhdmUgdG8gcmUtcmVhZCB0aGUgZGlzY3Vzc2lvbnMgaW4gdGhlIGRpZmZlcmVudCB2ZXJzaW9u
cyBvZiB0aGlzIHNlcmllcy4NCk15IGZpcnN0IGFwcHJvYWNoIHdhcyB0byB1c2EgYSBtZmQgZHJp
dmVyIGZvciBtbXN5cywgd2hpY2ggd2FzIHJlamVjdGVkLg0KVGhlIGxhc3QgYXBwcm9hY2ggd2Fz
IHRvIGNyZWF0ZSBhIERUUyBzdWIgbm9kZSwgYWxzbyByZWplY3RlZCA6KQ0KDQpSZWdhcmRzLA0K
TWF0dGhpYXMNCg0KPiBSZWdhcmRzLA0KPiBDSw0KPiANCj4+DQo+PiBDVQ0KPj4gVWxpDQo+Pg0K
Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+IExp
bnV4LW1lZGlhdGVrIG1haWxpbmcgbGlzdA0KPj4gTGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFk
ZWFkLm9yZw0KPj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1tZWRpYXRlaw0KPiANCj4gDQo+IA0K
