Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD9BC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B46216C4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfEHVOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 17:14:30 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:57522 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728184AbfEHVOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 17:14:30 -0400
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x48L6IAq016497;
        Wed, 8 May 2019 21:14:24 GMT
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2sc4cg0ywd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 May 2019 21:14:24 +0000
Received: from G2W6310.americas.hpqcorp.net (g2w6310.austin.hp.com [16.197.64.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5009.houston.hpe.com (Postfix) with ESMTPS id E54FF55;
        Wed,  8 May 2019 21:14:23 +0000 (UTC)
Received: from G1W8107.americas.hpqcorp.net (2002:10c1:483b::10c1:483b) by
 G2W6310.americas.hpqcorp.net (2002:10c5:4034::10c5:4034) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Wed, 8 May 2019 21:14:23 +0000
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (15.241.52.11) by
 G1W8107.americas.hpqcorp.net (16.193.72.59) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Wed, 8 May 2019 21:14:23 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM (10.169.7.147) by
 AT5PR8401MB0994.NAMPRD84.PROD.OUTLOOK.COM (10.169.7.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Wed, 8 May 2019 21:14:22 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2884:44eb:25bf:b376]) by AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2884:44eb:25bf:b376%12]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 21:14:22 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Antonio Borneo <borneo.antonio@gmail.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] checkpatch: add command-line option for TAB size
Thread-Topic: [PATCH v2] checkpatch: add command-line option for TAB size
Thread-Index: AQHVBcWriY3MaJeieUiO1bGoukwj0aZhuPkw
Date:   Wed, 8 May 2019 21:14:21 +0000
Message-ID: <AT5PR8401MB1169149078CDB1274A259703AB320@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <20190508174356.13952-1-borneo.antonio@gmail.com>
In-Reply-To: <20190508174356.13952-1-borneo.antonio@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [15.211.195.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cd07ff7-d776-4472-c019-08d6d3fa2417
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AT5PR8401MB0994;
x-ms-traffictypediagnostic: AT5PR8401MB0994:
x-microsoft-antispam-prvs: <AT5PR8401MB09945890234DBDB9CD2E101EAB320@AT5PR8401MB0994.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(39860400002)(396003)(13464003)(199004)(189003)(53546011)(478600001)(316002)(6506007)(7696005)(71200400001)(476003)(55016002)(486006)(3846002)(26005)(4326008)(229853002)(6116002)(25786009)(86362001)(68736007)(9686003)(2906002)(11346002)(110136005)(446003)(66946007)(73956011)(66556008)(76116006)(64756008)(52536014)(66446008)(8676002)(71190400001)(256004)(76176011)(99286004)(6246003)(14454004)(8936002)(305945005)(7736002)(33656002)(102836004)(186003)(6436002)(53936002)(74316002)(81166006)(81156014)(5660300002)(66066001)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0994;H:AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V79YYC9ZmgZE9yyvArmaX9ntxsqRjf9SNXi3yGuV6hMTFwe7m0GGAi5JC5eEieeMYqqlJYWTspC/qDlXqYCqrHqOn/TmEUBbZ9E9UnY7wpQL+VwSU+Nnjt5MchH3TvB1cehVAA/ezYWBlke/ZRz7iLIAnAD5pqnZPcYfIgNGK3MbABWPei/xboUnecO6su2n3NcNSJxB7y2p24PNGyPYqgr1Q+CyHrjXWtE0zWES+QPnpor4VaQ7E5RIKK3AJzB4kO+fiZJ9EMTaUOBVBQAEtJMeIZuRKoMrw8fF0fCF3qYT+aHYsx3L2aXSVGjdOLyvhcd8y3JCy0dqbWErAFfv29j5iWVtg2rU9p8Beh2JHYQfnzN1I6RX5PBsQBVQ8sRVH6ud6gAk2XwKGthc+b0XKE2iSacOZkQDpoMcx65u7A8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd07ff7-d776-4472-c019-08d6d3fa2417
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 21:14:21.8843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0994
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-08_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905080128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgta2VybmVsLW93
bmVyQHZnZXIua2VybmVsLm9yZyBbbWFpbHRvOmxpbnV4LWtlcm5lbC1vd25lckB2Z2VyLmtlcm5l
bC5vcmddIE9uIEJlaGFsZiBPZg0KPiBBbnRvbmlvIEJvcm5lbw0KPiBTZW50OiBXZWRuZXNkYXks
IE1heSA4LCAyMDE5IDEyOjQ0IFBNDQo+IFN1YmplY3Q6IFtQQVRDSCB2Ml0gY2hlY2twYXRjaDog
YWRkIGNvbW1hbmQtbGluZSBvcHRpb24gZm9yIFRBQiBzaXplDQouLi4NCj4gQWRkIGEgY29tbWFu
ZC1saW5lIG9wdGlvbiAiLS10YWItc2l6ZSIgdG8gbGV0IHRoZSB1c2VyIHNlbGVjdCBhDQo+IFRB
QiBzaXplIHZhbHVlIG90aGVyIHRoYW4gOC4NCj4gVGhpcyBtYWtlcyBlYXN5IHRvIHJldXNlIHRo
aXMgc2NyaXB0IGJ5IG90aGVyIHByb2plY3RzIHdpdGgNCj4gZGlmZmVyZW50IHJlcXVpcmVtZW50
cyBpbiB0aGVpciBjb2Rpbmcgc3R5bGUgKGUuZy4gT3Blbk9DRCBbMV0NCj4gcmVxdWlyZXMgVEFC
IHNpemUgb2YgNCBjaGFyYWN0ZXJzIFsyXSkuDQouLi4NCj4gKyAgLS10YWItc2l6ZT1uICAgICAg
ICAgICAgICAgc2V0IHRoZSBudW1iZXIgb2Ygc3BhY2VzIGZvciB0YWIgKGRlZmF1bHQgOCkNCi4u
Lg0KPiArCSd0YWItc2l6ZT1pJwk9PiBcJHRhYnNpemUsDQouLi4NCj4gLQkJCWZvciAoOyAoJG4g
JSA4KSAhPSAwOyAkbisrKSB7DQo+ICsJCQlmb3IgKDsgKCRuICUgJHRhYnNpemUpICE9IDA7ICRu
KyspIHsNCi4uLg0KPiAtCQkJaWYgKCRpbmRlbnQgJSA4KSB7DQo+ICsJCQlpZiAoJGluZGVudCAl
ICR0YWJzaXplKSB7DQo+IC0JCQkJCSJcdCIgeCAoJHBvcyAvIDgpIC4NCj4gLQkJCQkJIiAiICB4
ICgkcG9zICUgOCk7DQo+ICsJCQkJCSJcdCIgeCAoJHBvcyAvICR0YWJzaXplKSAuDQo+ICsJCQkJ
CSIgIiAgeCAoJHBvcyAlICR0YWJzaXplKTsNCi4uLg0KPiAtCQkJICAgICgoJHNpbmRlbnQgJSA4
KSAhPSAwIHx8DQo+ICsJCQkgICAgKCgkc2luZGVudCAlICR0YWJzaXplKSAhPSAwIHx8DQouLi4N
Cj4gLQkJCSAgICAgKCRzaW5kZW50ID4gJGluZGVudCArIDgpKSkgew0KPiArCQkJICAgICAoJHNp
bmRlbnQgPiAkaW5kZW50ICsgJHRhYnNpemUpKSkgew0KDQpDaGVja2luZyBmb3IgMCBiZWZvcmUg
dXNpbmcgdGhlIHZhbHVlIGluIGRpdmlzaW9uIGFuZCBtb2R1bG8NCm9wZXJhdGlvbnMgd291bGQg
YmUgcHJ1ZGVudC4NCg0K
