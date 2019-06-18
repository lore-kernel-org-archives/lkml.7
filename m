Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC17C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EBD20863
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbfFRRnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 13:43:51 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:8868 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729605AbfFRRnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 13:43:50 -0400
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5IHaCN7030473;
        Tue, 18 Jun 2019 17:43:28 GMT
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2t73mh8e0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jun 2019 17:43:28 +0000
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5009.houston.hpe.com (Postfix) with ESMTPS id BF52E81;
        Tue, 18 Jun 2019 17:43:27 +0000 (UTC)
Received: from G9W8668.americas.hpqcorp.net (16.220.49.27) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 18 Jun 2019 17:43:27 +0000
Received: from G4W10205.americas.hpqcorp.net (2002:10cf:520f::10cf:520f) by
 G9W8668.americas.hpqcorp.net (2002:10dc:311b::10dc:311b) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 18 Jun 2019 17:43:27 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (15.241.52.13) by
 G4W10205.americas.hpqcorp.net (16.207.82.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 18 Jun 2019 17:43:26 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM (10.169.7.147) by
 AT5PR8401MB0692.NAMPRD84.PROD.OUTLOOK.COM (10.169.7.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Tue, 18 Jun 2019 17:43:26 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::207d:29e:1463:8c27]) by AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::207d:29e:1463:8c27%9]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 17:43:25 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "dgilbert@interlog.com" <dgilbert@interlog.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        "James Bottomley" <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>
CC:     SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH v1] scsi: Don't select SCSI_PROC_FS by default
Thread-Topic: [PATCH v1] scsi: Don't select SCSI_PROC_FS by default
Thread-Index: AQHVIScKm7Kg6yo9GUK+VQsBdEvLtqagYAwAgAA5NACAADAbgIAA7X1A
Date:   Tue, 18 Jun 2019 17:43:25 +0000
Message-ID: <AT5PR8401MB11695CC7286B2D2F98FB9EADABEA0@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <2de15293-b9be-4d41-bc67-a69417f27f7a@free.fr>
 <621306ee-7ab6-9cd2-e934-94b3d6d731fc@acm.org>
 <fb2d2e74-6725-4bf2-cf6c-63c0a2a10f4f@interlog.com>
 <da579578-349e-1320-0867-14fde659733e@acm.org>
In-Reply-To: <da579578-349e-1320-0867-14fde659733e@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [15.211.195.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 495716e5-b85b-44c4-9479-08d6f4147771
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AT5PR8401MB0692;
x-ms-traffictypediagnostic: AT5PR8401MB0692:
x-microsoft-antispam-prvs: <AT5PR8401MB069223132C4A0D2C323D1090ABEA0@AT5PR8401MB0692.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(396003)(366004)(13464003)(54534003)(199004)(189003)(256004)(102836004)(68736007)(74316002)(71200400001)(229853002)(11346002)(71190400001)(14454004)(2501003)(5660300002)(86362001)(446003)(186003)(486006)(478600001)(73956011)(6436002)(33656002)(66946007)(66476007)(64756008)(476003)(66556008)(66446008)(76116006)(52536014)(55016002)(8676002)(110136005)(54906003)(316002)(9686003)(3846002)(66066001)(6506007)(76176011)(2906002)(25786009)(5024004)(6116002)(26005)(53546011)(81156014)(4326008)(6246003)(305945005)(7696005)(81166006)(99286004)(7736002)(8936002)(53936002)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0692;H:AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a+zEW0s600WKB5ECZrxjQH4qSH9lQfBsvQWA7aV+Vv1apUfg0xRWA8tiWGMZ5i3nMvBpGkGoVdXw0TlxLuOabAAmbRskDk4GJThUN5l0ZyzifsBhqBAU3m0MjGG6G8Qu8hz0SqUWYNApYrnGZnyha/jXhvSrk80/neEtlfWq5SMZsrwN9QZBTmwKNC7ZNL66mFE+2m9U01MrpSQpbYOMrpshEWFJ4wtJSnLawcIC3d4PQSaZmqpcIKPU52m+mtFM2VFaPhv0CAW44C8VsW+nU2K5OuaBP6Nqb6cucABKSjQKRgVqqn4Ueu5KdUYqaXP7814CIeCW0lbpMm/NOjhBZmkd6hGqnNF4trovQ3qADyMirSzEA++W0WO7aFZHxwNHlUwRolj7VMtws8N9sCugSm7pLhb2DfnYK8LD+hPR5pI=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-Network-Message-Id: 495716e5-b85b-44c4-9479-08d6f4147771
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 17:43:25.8478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: elliott@hpe.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0692
X-OriginatorOrg: hpe.com
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-18_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906180141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgta2VybmVsLW93
bmVyQHZnZXIua2VybmVsLm9yZyBbbWFpbHRvOmxpbnV4LWtlcm5lbC1vd25lckB2Z2VyLmtlcm5l
bC5vcmddIE9uIEJlaGFsZiBPZiBCYXJ0DQo+IFZhbiBBc3NjaGUNCj4gU2VudDogTW9uZGF5LCBK
dW5lIDE3LCAyMDE5IDEwOjI4IFBNDQo+IFRvOiBkZ2lsYmVydEBpbnRlcmxvZy5jb207IE1hcmMg
R29uemFsZXogPG1hcmMudy5nb256YWxlekBmcmVlLmZyPjsgSmFtZXMgQm90dG9tbGV5DQo+IDxq
ZWpiQGxpbnV4LmlibS5jb20+OyBNYXJ0aW4gUGV0ZXJzZW4gPG1hcnRpbi5wZXRlcnNlbkBvcmFj
bGUuY29tPg0KPiBDYzogU0NTSSA8bGludXgtc2NzaUB2Z2VyLmtlcm5lbC5vcmc+OyBMS01MIDxs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgQ2hyaXN0b3BoIEhlbGx3aWcNCj4gPGhjaEBs
c3QuZGU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIHNjc2k6IERvbid0IHNlbGVjdCBTQ1NJ
X1BST0NfRlMgYnkgZGVmYXVsdA0KPiANCj4gT24gNi8xNy8xOSA1OjM1IFBNLCBEb3VnbGFzIEdp
bGJlcnQgd3JvdGU6DQo+ID4gRm9yIHNnM191dGlsczoNCj4gPg0KPiA+ICQgZmluZCAuIC1uYW1l
ICcqLmMnIC1leGVjIGdyZXAgIi9wcm9jL3Njc2kiIHt9IFw7IC1wcmludA0KPiA+IHN0YXRpYyBj
b25zdCBjaGFyICogcHJvY19hbGxvd19kaW8gPSAiL3Byb2Mvc2NzaS9zZy9hbGxvd19kaW8iOw0K
PiA+IC4vc3JjL3NnX3JlYWQuYw0KPiA+IHN0YXRpYyBjb25zdCBjaGFyICogcHJvY19hbGxvd19k
aW8gPSAiL3Byb2Mvc2NzaS9zZy9hbGxvd19kaW8iOw0KPiA+IC4vc3JjL3NncF9kZC5jDQo+ID4g
c3RhdGljIGNvbnN0IGNoYXIgKiBwcm9jX2FsbG93X2RpbyA9ICIvcHJvYy9zY3NpL3NnL2FsbG93
X2RpbyI7DQo+ID4gLi9zcmMvc2dtX2RkLmMNCj4gPiBzdGF0aWMgY29uc3QgY2hhciAqIHByb2Nf
YWxsb3dfZGlvID0gIi9wcm9jL3Njc2kvc2cvYWxsb3dfZGlvIjsNCj4gPiAuL3NyYy9zZ19kZC5j
DQo+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiJ2VjaG8gMSA+IC9wcm9jL3Nj
c2kvc2cvYWxsb3dfZGlvJ1xuIiwgcV9sZW4sDQo+ID4gZGlyaW9fY291bnQpOw0KPiA+IC4vdGVz
dGluZy9zZ190c3RfYmlkaS5jDQo+ID4gc3RhdGljIGNvbnN0IGNoYXIgKiBwcm9jX2FsbG93X2Rp
byA9ICIvcHJvYy9zY3NpL3NnL2FsbG93X2RpbyI7DQo+ID4gLi9leGFtcGxlcy9zZ3FfZGQuYw0K
PiA+DQo+ID4gVGhhdCBpcyA2IChub3QgMzgpIGJ5IG15IGNvdW50Lg0KPiANCj4gSGkgRG91ZywN
Cj4gDQo+IFRoaXMgaXMgdGhlIGNvbW1hbmQgSSByYW46DQo+IA0KPiAkIGdpdCBncmVwIC9wcm9j
L3Njc2kgfCB3YyAtbA0KPiAzOA0KPiANCj4gSSB0aGluayB5b3VyIHF1ZXJ5IGV4Y2x1ZGVzIHNj
cmlwdHMvcmVzY2FuLXNjc2ktYnVzLnNoLg0KPiANCj4gQmFydC4NCg0KSGVyZSdzIHRoZSBmdWxs
IGxpc3QgdG8gZW5zdXJlIHRoZSBkaXNjdXNzaW9uIGRvZXNuJ3Qgb3Zlcmxvb2sgYW55dGhpbmc6
DQoNCnNnM191dGlscy0xLjQ0JCBncmVwIC1SIC9wcm9jL3Njc2kgLg0KLi9zcmMvc2dfcmVhZC5j
OnN0YXRpYyBjb25zdCBjaGFyICogcHJvY19hbGxvd19kaW8gPSAiL3Byb2Mvc2NzaS9zZy9hbGxv
d19kaW8iOw0KLi9zcmMvc2dwX2RkLmM6c3RhdGljIGNvbnN0IGNoYXIgKiBwcm9jX2FsbG93X2Rp
byA9ICIvcHJvYy9zY3NpL3NnL2FsbG93X2RpbyI7DQouL3NyYy9zZ21fZGQuYzpzdGF0aWMgY29u
c3QgY2hhciAqIHByb2NfYWxsb3dfZGlvID0gIi9wcm9jL3Njc2kvc2cvYWxsb3dfZGlvIjsNCi4v
c3JjL3NnX2RkLmM6c3RhdGljIGNvbnN0IGNoYXIgKiBwcm9jX2FsbG93X2RpbyA9ICIvcHJvYy9z
Y3NpL3NnL2FsbG93X2RpbyI7DQouL3NjcmlwdHMvcmVzY2FuLXNjc2ktYnVzLnNoOiMgUmV0dXJu
IGhvc3RzLiAvcHJvYy9zY3NpL0hPU1RBREFQVEVSLz8gbXVzdCBleGlzdA0KLi9zY3JpcHRzL3Jl
c2Nhbi1zY3NpLWJ1cy5zaDogIGZvciBkcml2ZXJkaXIgaW4gL3Byb2Mvc2NzaS8qOyBkbw0KLi9z
Y3JpcHRzL3Jlc2Nhbi1zY3NpLWJ1cy5zaDogICAgZHJpdmVyPSR7ZHJpdmVyZGlyIy9wcm9jL3Nj
c2kvfQ0KLi9zY3JpcHRzL3Jlc2Nhbi1zY3NpLWJ1cy5zaDogICAgICBuYW1lPSR7aG9zdGRpciMv
cHJvYy9zY3NpLyovfQ0KLi9zY3JpcHRzL3Jlc2Nhbi1zY3NpLWJ1cy5zaDojIEdldCAvcHJvYy9z
Y3NpL3Njc2kgaW5mbyBmb3IgZGV2aWNlICRob3N0OiRjaGFubmVsOiRpZDokbHVuDQouL3Njcmlw
dHMvcmVzY2FuLXNjc2ktYnVzLnNoOiAgICBTQ1NJU1RSPSQoZ3JlcCAtQSAiJExOIiAtZSAiJGdy
ZXBzdHIiIC9wcm9jL3Njc2kvc2NzaSkNCi4vc2NyaXB0cy9yZXNjYW4tc2NzaS1idXMuc2g6ICAg
IERSVj1gZ3JlcCAnQXR0YWNoZWQgZHJpdmVyczonIC9wcm9jL3Njc2kvc2NzaSAyPi9kZXYvbnVs
bGANCi4vc2NyaXB0cy9yZXNjYW4tc2NzaS1idXMuc2g6ICAgICAgZWNobyAic2NzaSByZXBvcnQt
ZGV2cyAxIiA+L3Byb2Mvc2NzaS9zY3NpDQouL3NjcmlwdHMvcmVzY2FuLXNjc2ktYnVzLnNoOiAg
ICAgIERSVj1gZ3JlcCAnQXR0YWNoZWQgZHJpdmVyczonIC9wcm9jL3Njc2kvc2NzaSAyPi9kZXYv
bnVsbGANCi4vc2NyaXB0cy9yZXNjYW4tc2NzaS1idXMuc2g6ICAgICAgZWNobyAic2NzaSByZXBv
cnQtZGV2cyAwIiA+L3Byb2Mvc2NzaS9zY3NpDQouL3NjcmlwdHMvcmVzY2FuLXNjc2ktYnVzLnNo
OiMgT3V0cHV0cyBkZXNjcmlwdGlvbiBmcm9tIC9wcm9jL3Njc2kvc2NzaSAodW5sZXNzIGFyZyBw
YXNzZWQpDQouL3NjcmlwdHMvcmVzY2FuLXNjc2ktYnVzLnNoOiAgICAgICAgZWNobyAic2NzaSBy
ZW1vdmUtc2luZ2xlLWRldmljZSAkZGV2bnIiID4gL3Byb2Mvc2NzaS9zY3NpDQouL3NjcmlwdHMv
cmVzY2FuLXNjc2ktYnVzLnNoOiAgICAgICAgICBlY2hvICJzY3NpIGFkZC1zaW5nbGUtZGV2aWNl
ICRkZXZuciIgPiAvcHJvYy9zY3NpL3Njc2kNCi4vc2NyaXB0cy9yZXNjYW4tc2NzaS1idXMuc2g6
ICAgICAgZWNobyAic2NzaSBhZGQtc2luZ2xlLWRldmljZSAkZGV2bnIiID4gL3Byb2Mvc2NzaS9z
Y3NpDQouL3NjcmlwdHMvcmVzY2FuLXNjc2ktYnVzLnNoOiAgICAgIGVjaG8gInNjc2kgYWRkLXNp
bmdsZS1kZXZpY2UgJGRldm5yIiA+IC9wcm9jL3Njc2kvc2NzaQ0KLi9zY3JpcHRzL3Jlc2Nhbi1z
Y3NpLWJ1cy5zaDogICAgICBlY2hvICJzY3NpIGFkZC1zaW5nbGUtZGV2aWNlICRob3N0ICRjaGFu
bmVsICRpZCAkU0NBTl9XSUxEX0NBUkQiID4gL3Byb2Mvc2NzaS9zY3NpDQouL3NjcmlwdHMvcmVz
Y2FuLXNjc2ktYnVzLnNoOmlmIHRlc3QgISAtZCAvc3lzL2NsYXNzL3Njc2lfaG9zdC8gLWEgISAt
ZCAvcHJvYy9zY3NpLzsgdGhlbg0KLi9DaGFuZ2VMb2c6ICAgIC9wcm9jL3Njc2kvc2cvYWxsb3df
ZGlvIGlzICcwJw0KLi9DaGFuZ2VMb2c6ICAtIGNoYW5nZSBzZ19kZWJ1ZyB0byBjYWxsIHN5c3Rl
bSgiY2F0IC9wcm9jL3Njc2kvc2cvZGVidWciKTsNCi4vc3VzZS9zZzNfdXRpbHMuY2hhbmdlczog
ICogU3VwcG9ydCBzeXN0ZW1zIHdpdGhvdXQgL3Byb2Mvc2NzaQ0KLi9leGFtcGxlcy9zZ3FfZGQu
YzpzdGF0aWMgY29uc3QgY2hhciAqIHByb2NfYWxsb3dfZGlvID0gIi9wcm9jL3Njc2kvc2cvYWxs
b3dfZGlvIjsNCi4vZG9jL3NnX3JlYWQuODpJZiBkaXJlY3QgSU8gaXMgc2VsZWN0ZWQgYW5kIC9w
cm9jL3Njc2kvc2cvYWxsb3dfZGlvDQouL2RvYy9zZ19yZWFkLjg6ImVjaG8gMSA+IC9wcm9jL3Nj
c2kvc2cvYWxsb3dfZGlvIi4gQW4gYWx0ZXJuYXRlIHdheSB0byBhdm9pZCB0aGUNCi4vZG9jL3Nn
X21hcC44Om9ic2VydmluZyB0aGUgb3V0cHV0IG9mIHRoZSBjb21tYW5kOiAiY2F0IC9wcm9jL3Nj
c2kvc2NzaSIuDQouL2RvYy9zZ3BfZGQuODphdCBjb21wbGV0aW9uLiBJZiBkaXJlY3QgSU8gaXMg
c2VsZWN0ZWQgYW5kIC9wcm9jL3Njc2kvc2cvYWxsb3dfZGlvDQouL2RvYy9zZ3BfZGQuODp0aGlz
IGF0IGNvbXBsZXRpb24uIElmIGRpcmVjdCBJTyBpcyBzZWxlY3RlZCBhbmQgL3Byb2Mvc2NzaS9z
Zy9hbGxvd19kaW8NCi4vZG9jL3NncF9kZC44Om1hcHBpbmcgdG8gU0NTSSBibG9jayBkZXZpY2Vz
IHNob3VsZCBiZSBjaGVja2VkIHdpdGggJ2NhdCAvcHJvYy9zY3NpL3Njc2knDQouL2RvYy9zZ19k
ZC44Om5vdGVzIHRoaXMgYXQgY29tcGxldGlvbi4gSWYgZGlyZWN0IElPIGlzIHNlbGVjdGVkIGFu
ZCAvcHJvYy9zY3NpL3NnL2FsbG93X2Rpbw0KLi9kb2Mvc2dfZGQuODp0aGlzIGF0IGNvbXBsZXRp
b24uIElmIGRpcmVjdCBJTyBpcyBzZWxlY3RlZCBhbmQgL3Byb2Mvc2NzaS9zZy9hbGxvd19kaW8N
Ci4vZG9jL3NnX2RkLjg6d2l0aCAnZWNobyAxID4gL3Byb2Mvc2NzaS9zZy9hbGxvd19kaW8nLg0K
Li9kb2Mvc2dfZGQuODptYXBwaW5nIHRvIFNDU0kgYmxvY2sgZGV2aWNlcyBzaG91bGQgYmUgY2hl
Y2tlZCB3aXRoICdjYXQgL3Byb2Mvc2NzaS9zY3NpJywNCg0KDQo=
