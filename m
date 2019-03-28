Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9A6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9D120700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="HZ7Ld4jG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfC1MGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:06:41 -0400
Received: from mail-eopbgr800071.outbound.protection.outlook.com ([40.107.80.71]:12672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725779AbfC1MGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImCBTi+dhTIv62Qy3LcioLsnPYfuikG6gElkLl4DGeA=;
 b=HZ7Ld4jGbEyHOiKdXuOTwFEhasDZiy1YHHcW5NeUuonh9R1gj0N5z/CEsXFTII+pbeXSKqQ0If4wrXtrrkx5teOA9QpzBx42TW56bTLOXaIezj60jqGCI1zp1AgPelAO8oMg328TMq8EDbonv3TSP1tBylLeDQk1H4QzwHSjRFM=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6672.namprd05.prod.outlook.com (20.178.249.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.14; Thu, 28 Mar 2019 12:06:37 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::91e:292d:e304:78ad]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::91e:292d:e304:78ad%7]) with mapi id 15.20.1771.006; Thu, 28 Mar 2019
 12:06:37 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Hellstrom <thellstrom@vmware.com>,
        Juergen Gross <jgross@suse.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        Alok Kataria <akataria@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: [PATCH] MAINTAINERS: Update PARAVIRT_OPS_INTERFACE and
 VMWARE_HYPERVISOR_INTERFACE
Thread-Topic: [PATCH] MAINTAINERS: Update PARAVIRT_OPS_INTERFACE and
 VMWARE_HYPERVISOR_INTERFACE
Thread-Index: AQHU5V6x65YKxfvgAEi42RvFneYuzg==
Date:   Thu, 28 Mar 2019 12:06:37 +0000
Message-ID: <20190328120558.29897-1-thellstrom@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0003.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:d0::13) To MN2PR05MB6141.namprd05.prod.outlook.com
 (2603:10b6:208:c7::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [155.4.205.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45a58666-9bd7-489e-a135-08d6b375d3e0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MN2PR05MB6672;
x-ms-traffictypediagnostic: MN2PR05MB6672:
x-microsoft-antispam-prvs: <MN2PR05MB66722CDEECCBCF23D3E0D04EA1590@MN2PR05MB6672.namprd05.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(366004)(39850400004)(199004)(189003)(14454004)(66066001)(186003)(8676002)(68736007)(86362001)(81156014)(36756003)(81166006)(52116002)(71190400001)(26005)(3846002)(6436002)(6116002)(6916009)(1076003)(71200400001)(50226002)(6486002)(5660300002)(6346003)(8936002)(305945005)(107886003)(99286004)(54906003)(476003)(2501003)(6512007)(25786009)(53936002)(4326008)(5640700003)(6506007)(478600001)(106356001)(256004)(2906002)(486006)(105586002)(2616005)(7736002)(386003)(97736004)(316002)(102836004)(2351001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6672;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8ONg6HUAGZ4YCmMFtlv/3QnDt3R/iIvujvBPN5N+WOwV1kzR5bylMjzVCak3ev+IBr01cPhIefaXYuzySnkWxNC/l8cQbfFhNKSLsnqwUNfSoSxC8MBM/mSmOl0oj5TgxZ6hgzoe1tfLvrU5N9nNtqCD8Sg/wfj64UGn04C6flhFSz67RDYGhbN1/u7KvM7BoE+qquM/UwSA39Z5DKgOEP1hq2rouFOLOaRCZSDl1lxB+x29+pdVbv5zhusBqKZFJP2PMIdQtMKlvFynwhh8PlIf9A0STU7fo5Nb6tuiurTlB2eOsX3BmiMbCdh1tD2YvyW1cHqVSthOWUwJE/m34zicRH/cOuLlRtfHF83uqRy+hYeURbZgSeE3YO+tnAr9Nzk/mqfGj50j28jxn5k2t1rZ6LifJyu+kf0FWMvzU5M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <601AB622D4A05F48918C23567434C532@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a58666-9bd7-489e-a135-08d6b375d3e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 12:06:37.0255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6672
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWxvayBLYXRhcmlhIHdpbGwgYmUgaGFuZGluZyBvdmVyIFZNd2FyZSdzIG1haW50YWluZXJzaGlw
IG9mIHRoZXNlDQppbnRlcmZhY2VzIHRvIFRob21hcyBIZWxsc3Ryw7ZtLCB3aXRoIHB2LWRyaXZl
cnMgYXMgYmFja3VwIGNvbnRhY3QuDQoNCkNjOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5j
b20+DQpDYzogdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcNCkNjOiB4
ODZAa2VybmVsLm9yZw0KQ2M6IHRnbHhAbGludXRyb25peC5kZQ0KQ2M6IG1pbmdvQHJlZGhhdC5j
b20NCkNjOiBocGFAenl0b3IuY29tDQpDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
Q2M6IEFsb2sgS2F0YXJpYSA8YWthdGFyaWFAdm13YXJlLmNvbT4NCkNjOiA8cHYtZHJpdmVyc0B2
bXdhcmUuY29tPg0KU2lnbmVkLW9mZi1ieTogVGhvbWFzIEhlbGxzdHJvbSA8dGhlbGxzdHJvbUB2
bXdhcmUuY29tPg0KQWNrZWQtYnk6IEFsb2sgS2F0YXJpYSA8YWthdGFyaWFAdm13YXJlLmNvbT4N
Ci0tLQ0KIE1BSU5UQUlORVJTIHwgNiArKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlO
VEFJTkVSUw0KaW5kZXggM2U1YTVkMjYzZjI5Li4xNjBiMjA4YjkzZDYgMTAwNjQ0DQotLS0gYS9N
QUlOVEFJTkVSUw0KKysrIGIvTUFJTlRBSU5FUlMNCkBAIC0xMTcxMSw3ICsxMTcxMSw4IEBAIEY6
CURvY3VtZW50YXRpb24vcGFycG9ydCoudHh0DQogDQogUEFSQVZJUlRfT1BTIElOVEVSRkFDRQ0K
IE06CUp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCi1NOglBbG9rIEthdGFyaWEgPGFr
YXRhcmlhQHZtd2FyZS5jb20+DQorTToJVGhvbWFzIEhlbGxzdHJvbSA8dGhlbGxzdHJvbUB2bXdh
cmUuY29tPg0KK006CSJWTXdhcmUsIEluYy4iIDxwdi1kcml2ZXJzQHZtd2FyZS5jb20+DQogTDoJ
dmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcNCiBTOglTdXBwb3J0ZWQN
CiBGOglEb2N1bWVudGF0aW9uL3ZpcnR1YWwvcGFyYXZpcnRfb3BzLnR4dA0KQEAgLTE2NjIwLDcg
KzE2NjIxLDggQEAgUzoJTWFpbnRhaW5lZA0KIEY6CWRyaXZlcnMvbWlzYy92bXdfYmFsbG9vbi5j
DQogDQogVk1XQVJFIEhZUEVSVklTT1IgSU5URVJGQUNFDQotTToJQWxvayBLYXRhcmlhIDxha2F0
YXJpYUB2bXdhcmUuY29tPg0KK006CVRob21hcyBIZWxsc3Ryb20gPHRoZWxsc3Ryb21Adm13YXJl
LmNvbT4NCitNOgkiVk13YXJlLCBJbmMuIiA8cHYtZHJpdmVyc0B2bXdhcmUuY29tPg0KIEw6CXZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnDQogUzoJU3VwcG9ydGVkDQog
RjoJYXJjaC94ODYva2VybmVsL2NwdS92bXdhcmUuYw0KLS0gDQoyLjIwLjENCg0K
