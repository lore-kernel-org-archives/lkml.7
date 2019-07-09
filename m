Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F955C73C50
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7805321743
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="YxK5nvwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfGIOax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 10:30:53 -0400
Received: from mail-eopbgr820070.outbound.protection.outlook.com ([40.107.82.70]:23444
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbfGIOaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 10:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector2-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5kXz/TDx50JmJqbayTh22GtX37DqyJRiduBewcxWFk=;
 b=YxK5nvwgKuK6csd6ZTEQoFRwyhbfSPRc8pSNYkwIpauJP7j/xcWbhAtfEeMXWYlwry6GTOrHUh+XnwVQMcX1S15+J4Q2vwif531TYTAAb9y4ziFpdj9coNX8uJv6tRlJGTpA3j6fElqOje3BJe4ZdLk5SCbC6gGhD+KD8sHmqec=
Received: from CY4PR06MB3479.namprd06.prod.outlook.com (10.175.117.23) by
 CY4PR06MB2936.namprd06.prod.outlook.com (10.175.119.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 9 Jul 2019 14:30:50 +0000
Received: from CY4PR06MB3479.namprd06.prod.outlook.com
 ([fe80::80e9:7afd:2cd6:2b5e]) by CY4PR06MB3479.namprd06.prod.outlook.com
 ([fe80::80e9:7afd:2cd6:2b5e%2]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 14:30:50 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "trondmy@gmail.com" <trondmy@gmail.com>
CC:     "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the nfs tree
Thread-Topic: linux-next: Signed-off-by missing for commits in the nfs tree
Thread-Index: AQHVNQsFB+2A7QSwYk6bgSS4kIsvN6a/rFuAgAKvXYA=
Date:   Tue, 9 Jul 2019 14:30:50 +0000
Message-ID: <ed6656ad172920882862e5571b6c237a31974bc3.camel@netapp.com>
References: <20190708072858.566aa564@canb.auug.org.au>
         <CAABAsM7jKzWPNoe63LU33tVfn7a88ZP9yzp4Bb1BN2TDWMxgjQ@mail.gmail.com>
In-Reply-To: <CAABAsM7jKzWPNoe63LU33tVfn7a88ZP9yzp4Bb1BN2TDWMxgjQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.3 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [23.28.75.121]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a73c665e-b2c5-4525-5c67-08d7047a0abf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR06MB2936;
x-ms-traffictypediagnostic: CY4PR06MB2936:
x-microsoft-antispam-prvs: <CY4PR06MB29368548250B4727485C856BF8F10@CY4PR06MB2936.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(53754006)(189003)(199004)(316002)(6486002)(3846002)(229853002)(4326008)(36756003)(11346002)(81156014)(6116002)(118296001)(6512007)(2906002)(2501003)(54906003)(53936002)(6246003)(58126008)(66066001)(256004)(110136005)(478600001)(66476007)(102836004)(446003)(7736002)(4744005)(25786009)(26005)(486006)(6506007)(73956011)(76176011)(64756008)(99286004)(5024004)(66946007)(91956017)(5660300002)(71190400001)(68736007)(8676002)(8936002)(2616005)(305945005)(71200400001)(76116006)(66556008)(81166006)(14444005)(6436002)(86362001)(66446008)(186003)(14454004)(72206003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR06MB2936;H:CY4PR06MB3479.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SlGF0jFSIg3uGr0HHnmxE+dRSE/d7OH5dYj3cgKIBZUWtV5rhlCbJvGN0q+67DhHCqVMm4XvkXmiRN8kbRqeXomjIPedpkFGRGh4xe8sNd8hfsKyMT14s/tT11NZCY7x7slz1nAfoqwGjKYmzKvaz4TvZiO4Zid3rqclyrOPg5wWLVouT54rfaq8YyXYKe8BRZjZEY8q1W+A2bsfFw+Kvi63j7P5mOUCsuXO/Xw928h+JWl7ie4wTBcqM6DSf+rVLeabuq5X7Zs+QKI0YbLixZsSJwOAO0m2RpTFwJoy/6m47wGi11yWl6AJcMyqP+z52OUIrE95niWt0WQx6DDM+ZmKyuAWwp0e9qTp0fxa74eGNNQj2LSKpg9RhMVwBVeMNulNbIoSGMtbyxVqUZjJjjVBfosbhJxdLbYatGOPxBc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C4DFE6A396FFB4194F62D96FF93D397@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73c665e-b2c5-4525-5c67-08d7047a0abf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 14:30:50.7627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bjschuma@netapp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR06MB2936
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDE5LTA3LTA3IGF0IDE3OjMwIC0wNDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE5ldEFwcCBTZWN1cml0eSBXQVJOSU5HOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBE
byBub3QgY2xpY2sNCj4gbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29n
bml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93DQo+IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiAN
Cj4gDQo+IA0KPiBPbiBTdW4sIDcgSnVsIDIwMTkgYXQgMTc6MjksIFN0ZXBoZW4gUm90aHdlbGwg
PHNmckBjYW5iLmF1dWcub3JnLmF1Pg0KPiB3cm90ZToNCj4gPiBIaSBhbGwsDQo+ID4gDQo+ID4g
Q29tbWl0cw0KPiA+IA0KPiA+ICAgZmU5YWQxOTdiZDhhICgieHBydHJkbWE6IFJlbW92ZSB0aGUg
UlBDUkRNQV9SRVFfRl9QRU5ESU5HIGZsYWciKQ0KPiA+ICAgMDhkNzIwYmNkODIyICgieHBydHJk
bWE6IEZpeCBvY2Nhc2lvbmFsIHRyYW5zcG9ydCBkZWFkbG9jayIpDQo+ID4gICBiZWI4NDM3Mzll
YTAgKCJ4cHJ0cmRtYTogUmVwbGFjZSB1c2Ugb2YgeGRyX3N0cmVhbV9wb3MgaW4NCj4gPiBycGNy
ZG1hX21hcnNoYWxfcmVxIikNCj4gPiANCj4gPiBhcmUgbWlzc2luZyBhIFNpZ25lZC1vZmYtYnkg
ZnJvbSB0aGVpciBjb21taXR0ZXIuDQo+ID4gDQo+IA0KPiBBbm5hPw0KDQpMb29rcyBsaWtlIEkg
bWlzc2VkIHRoZSAiLXMiIGZsYWcgdG8gYGdpdC1hbWAgd2hlbiBJIHdhcyBhcHBseWluZw0KdGhl
c2UuIEkganVzdCBmaXhlZCBpdCBsb2NhbGx5LCBkbyB5b3Ugd2FudCBtZSB0byBzZW5kIHlvdSBh
IG5ldyBwdWxsDQpyZXF1ZXN0Pw0KDQpBbm5hDQo=
